npm install -g truffle

git clone https://github.com/wissalHaji/DappTuto
cd DappTuto
npm install web3

cat << EOF > abi.json
[
    {
      "inputs": [],
      "name": "greeting",
      "outputs": [
        {
          "internalType": "string",
          "name": "",
          "type": "string"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [],
      "name": "sayHello",
      "outputs": [
        {
          "internalType": "string",
          "name": "",
          "type": "string"
        }
      ],
      "stateMutability": "view",
      "type": "function",
      "constant": true
    },
    {
      "inputs": [
        {
          "internalType": "string",
          "name": "_greeting",
          "type": "string"
        }
      ],
      "name": "updateGreeting",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    }
]

EOF

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
      version: "0.7.4",    // Fetch exact version from solc-bin (default: truffle's version)
    }
  }
};
EOF

cat << 'EOF' > abc.js
const Web3 = require('web3');
const getWeb3 = () => {
  return new Web3('http://localhost:7545')
};

const getContract = async (web3) => {
/*
  const data = await $.getJSON("./contracts/Greeting.json");
  const netId = await web3.eth.net.getId();
  const deployedNetwork = data.networks[netId];
  const greeting = new web3.eth.Contract(
    data.abi,
    deployedNetwork && deployedNetwork.address
  );
  */
  const ABI = require('./abi.json')
  const greeting = new web3.eth.Contract(
    ABI,
    '0xaef8D00830B5f99ABDb425B85A8E6b151E1B68a3'
  );
  return greeting;
};

const displayGreeting = async (greeting, contract) => {
  greeting = await contract.methods.sayHello().call();
  //$("h2").html(greeting);
  console.log("Greeting is : "+greeting);
};

const updateGreeting = async (greeting, contract, accounts) => {
/*
  let input;
  $("#input").on("change", (e) => {
    input = e.target.value;
  });
  $("#form").on("submit", async (e) => {
    e.preventDefault();
    await contract.methods
      .updateGreeting(input)
      .send({ from: accounts[0], gas: 40000 });
    displayGreeting(greeting, contract);
  });
*/
  await contract.methods
      .updateGreeting("hello3")
      .send({ from: accounts[0], gas: 40000 });
  displayGreeting(greeting, contract);
};

async function greetingApp() {
  const web3 = getWeb3();
  const accounts = await web3.eth.getAccounts();
  const contract = await getContract(web3);
  let greeting;

  displayGreeting(greeting, contract);
  updateGreeting(greeting, contract, accounts);
}

greetingApp();

EOF

cd client
npm install

cat << 'EOF' > src/utils.js
const getWeb3 = () => {
  return new Promise((resolve, reject) => {
    web3 = new Web3('http://localhost:7545')
    resolve(web3);
    });
};

const getContract = async (web3) => {
  const data = await $.getJSON("./contracts/Greeting.json");

  const netId = await web3.eth.net.getId();
  const deployedNetwork = data.networks[netId];
  const greeting = new web3.eth.Contract(
    data.abi,
    //deployedNetwork && deployedNetwork.address
	'0x8BEbBa689c02f83df4a817412a590c409073F35A'
  );
  return greeting;
};
EOF

cat << 'EOF' > src/index.js
const displayGreeting = async (greeting, contract) => {
  greeting = await contract.methods.sayHello().call();
  $("h2").html(greeting);
};

const updateGreeting = (greeting, contract, accounts) => {
  let input;
  $("#input").on("change", (e) => {
    input = e.target.value;
  });
  $("#form").on("submit", async (e) => {
    e.preventDefault();
    await contract.methods
      .updateGreeting(input)
      .send({ from: accounts[0], gas: 40000 });
    displayGreeting(greeting, contract);
  });
};

async function greetingApp() {
  const web3 = await getWeb3();
  const accounts = await web3.eth.getAccounts();
  const contract = await getContract(web3);
  let greeting;

  displayGreeting(greeting, contract);
  updateGreeting(greeting, contract, accounts);
}

greetingApp();

EOF


