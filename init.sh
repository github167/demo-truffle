npm install -g truffle
git clone https://github.com/alincode/king-sandbox
cd king-sandbox
truffle init -y
npm install web3
cat << EOF > truffle-config.js
module.exports = {
  networks: {
    develop: {
     host: "127.0.0.1",     // Localhost (default: none)
     port: 7545,            // Standard Ethereum port (default: none)
     network_id: "*",       // Any network (default: none)
    },
  },
  compilers: {
    solc: {
      version: "0.4.25",    // Fetch exact version from solc-bin (default: truffle's version)
    }
  }
};
EOF

cat << EOF > contracts/KingOfEther.sol
pragma solidity ^0.4.25;
pragma experimental ABIEncoderV2;

contract KingOfEther {

  // 出價最高的金額
  uint public amount;

  // 活動開始與結束時間
  uint public startAt;
  uint public endAt;

  // 管理者
  address owner;
  // 現任國王
  address currentKing;

  // 狀態
  State private state;
  enum State { Started, Ended }

  address[] kingIndexs;
  mapping (address => King) public kings;

  // 通知有新任國王上任
  event NoticeNewKing(address addr, uint amount, string name);

  struct King {
    address addr;
    uint amount;
    string name;
    uint createdAt;
    uint withdrawalAmount;
  }

  modifier onlyOwner() { require(msg.sender == owner); _; }
  modifier onlyTimeout() { require(now > endAt); _; }
  modifier overMinimumPrice() { require(msg.value != 0 && msg.value >= 0.1 ether); _; }
  modifier candidate(uint sendAmount) { require(available(sendAmount)); _; }

  constructor(uint afterFewDay) {
    owner = msg.sender;
    state = State.Started;
    startAt = now;
    endAt = now + afterFewDay * 1 days;
  }

  function available(uint sendAmount) private view returns (bool) {
    if(state == State.Ended) return false;
    if(now > endAt) return false;
    if(kingIndexs.length == 0) return true;
    if(currentKing == msg.sender) return false;
    if(sendAmount + 0.1 ether > kings[currentKing].amount) return true;
    return false;
  }

  // 篡位
  function replaceKing(string _name) payable overMinimumPrice candidate(msg.value) public {
    if(kingIndexs.length > 0) {
      kings[currentKing].withdrawalAmount += msg.value - 0.05 ether;
    }
    kingIndexs.push(msg.sender);
    kings[msg.sender] = King(msg.sender, msg.value, _name, now, 0);
    currentKing = msg.sender;
    emit NoticeNewKing(msg.sender, msg.value, _name);
  }

  function kingInfo() public view returns (King) {
    return kings[currentKing];
  }

  // 提領管理費
  function ownerWithdrawal() payable onlyOwner onlyTimeout public {
    owner.transfer(this.balance);
    state = State.Ended;
  }

  // 被篡位的人，可以拿走篡位的人的錢，但要先扣除管理費。
  function playerWithdrawal() payable public {
    require(kings[msg.sender].withdrawalAmount > 0);
    uint amount = kings[msg.sender].withdrawalAmount;
    kings[msg.sender].withdrawalAmount = 0;
    msg.sender.transfer(amount);
  }
}
EOF

cat << EOF > migrations/2_KingOfEth.js
const KingOfEther = artifacts.require("KingOfEther");

module.exports = function (deployer) {
  deployer.deploy(KingOfEther, 10);
};
EOF

cat << 'EOF' > src/abc.js
const Web3 = require('web3');

if (typeof web3 !== 'undefined') {
  //web3 = new Web3(web3.currentProvider);
  web3 = new Web3("http://127.0.0.1:7545");
} else {
  web3 = new Web3("http://127.0.0.1:7545");
}

const ABI = require('./abi.json');
const DEFAULT_ADDRESS = '0x2D30342261CC08b1E968B13479cEf64877aA7b91';
const contractAddress = DEFAULT_ADDRESS;
const myContract = new web3.eth.Contract(ABI, contractAddress);

// ===== utils =====
function getNetworkName(networkId) {
  if (networkId == 1) return "Main";
  else if (networkId == 3) return "Ropsten";
  else if (networkId == 42) return "Kovan";
  else if (networkId == 4) return "Rinkeby";
  else return "";
}

// ===== listening smart contract event =====

// Generate filter options
const options = {
  // filter: {
  //   _from: process.env.WALLET_FROM,
  //   _to: process.env.WALLET_TO,
  //   _value: process.env.AMOUNT
  // },
  fromBlock: 'latest'
}

myContract.events.NoticeNewKing(options, async (error, event) => {
  if (error) {
    console.log(error)
    return
  }
  console.log('event:', event);
  const ether = web3.utils.fromWei(event.returnValues.amount, "ether");
  console.log("Event king name: "+event.returnValues.name);
  console.log("Event ether: "+ether);
  return
})

// ===== Click Event =====

function replaceKing() {
  let account = web3.eth.defaultAccount;
  console.log('account: ', account);
  myContract.methods.replaceKing(inputName.value).send({
    from: account,
    value: web3.utils.toWei(inputAmount.value, "ether")
  }, (err, data) => {
    if (err) return console.error(err);
    console.log('>>> replaceKing ok.');
  });
}

function playerWithdrawal() {
  let account = web3.eth.defaultAccount;
  myContract.methods.playerWithdrawal().send({
    from: account
  }, (err, data) => {
    if (err) return console.error(err);
    console.log('>>> playerWithdrawal ok.');
  });
}

// ===== Preload =====

function start() {
  console.log('=== start ===');
  getNetworkId({});
}

function getNetworkId(result) {
  console.log('>>> 1');
  web3.eth.net.getId(function (err, networkId) {
    result.networkId = networkId;
    getAccounts(result);
  });
}

function getAccounts(result) {
  console.log('>>> 2');
  web3.eth.getAccounts(function (err, addresses) {
    const address = addresses[0];
    web3.eth.defaultAccount = address;
    result.account = address;
    getKingInfo(result);
  });
}

function getKingInfo(result) {
  console.log('>>> 3');
  console.log(result);
  myContract.methods.kingInfo().call((err, data) => {
    if (err) return console.error(err);
console.log(data);
    if (data.amount != "0") {
      const ether = web3.utils.fromWei(data.amount, "ether");
	  console.log("king name: "+data.name);
      console.log("ether: "+ether);
    }
  })
}

if (typeof web3 !== 'undefined') start();

EOF
