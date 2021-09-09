npm install -g truffle
git clone https://github.com/k26dr/ethereum-games
cd ethereum-games

cat << EOF > truffle.js
module.exports = {
    compilers: {
        solc: {
          version: "^0.4.13"
        }
    },
    networks: {
        develop: {
            host: "localhost",
            port: 7545,
            network_id: "*" // Match any network id
        },
    }
}
EOF

cat << 'EOF' > app.js
const Web3 = require('web3')
const rpcURL = 'http://localhost:7545'
const web3 = new Web3(rpcURL)
const address = '' // Paste the smart contract address here after you have deployed it
const abi = [
  {
    "constant": true,
    "inputs": [],
    "name": "currentInvestor",
    "outputs": [
      {
        "name": "",
        "type": "address"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "constant": true,
    "inputs": [],
    "name": "currentInvestment",
    "outputs": [
      {
        "name": "",
        "type": "uint256"
      }
    ],
    "payable": false,
    "stateMutability": "view",
    "type": "function"
  },
  {
    "payable": true,
    "stateMutability": "payable",
    "type": "fallback"
  }
]
const contract = new web3.eth.Contract(abi, address)

async function run() {
  let result, amount
  accounts = await web3.eth.getAccounts();
  owner = accounts[0];
  account1 = accounts[1];
  account2 = accounts[2];
  
  result = await web3.eth.getBalance(accounts[0]) // first check
  console.log("owner: "+result)  
  result = await web3.eth.getBalance(accounts[1]) // first check
  console.log("[1]: "+result)  
    
  result =  await web3.eth.sendTransaction({ from: accounts[0], to:address, value: 1e18 })
  console.log(result)
  
  result = await web3.eth.getBalance(accounts[0]) // first check
  console.log("owner after sending "+result);
    
  result = await web3.eth.sendTransaction({ from: accounts[1], to: address, value: 2e18 })
  console.log(result);
  
  result = await web3.eth.getBalance(accounts[0]) // first check
  console.log("owner final amount "+result);
}
run()
EOF


truffle develop
migrate -f 6 --to 6


//instance = await SimplePonzi.deployed()
accounts = await web3.eth.getAccounts()
web3.eth.sendTransaction({ from: accounts[0], to: SimplePonzi.address, value: 1e18 })
web3.eth.getBalance(accounts[0]) // first check
web3.eth.sendTransaction({ from: accounts[1], to: SimplePonzi.address, value: 1e17 }) // error
web3.eth.sendTransaction({ from: accounts[1], to: SimplePonzi.address, value: 2e18 })
web3.eth.getBalance(accounts[0]) // second check
