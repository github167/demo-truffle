Goto: https://www.katacoda.com/scenario-examples/courses/environment-usages/nodejs

1. truffle
```
curl -LSfs https://raw.githubusercontent.com/github167/demo-truffle/SimplePonzi/init.sh | sh
cd ethereum-games
truffle develope
```
2. SimplePonzi
```
migrate -f 6 --to 6

//instance = await SimplePonzi.deployed()
accounts = await web3.eth.getAccounts()
web3.eth.sendTransaction({ from: accounts[0], to: SimplePonzi.address, value: 1e18 })
web3.eth.getBalance(accounts[0]) // first check
web3.eth.sendTransaction({ from: accounts[1], to: SimplePonzi.address, value: 1e17 }) // error
web3.eth.sendTransaction({ from: accounts[1], to: SimplePonzi.address, value: 2e18 })
web3.eth.getBalance(accounts[0]) // second check
```
copy the contract address, and paste to the line 4 of app.js
```
sed -i "s/const address = ''/const address= 'contract_address'/" app.js
node app.js
```
3. GrandualPonzi
```
migrate -f 7 --to 7

//instance = await SimplePonzi.deployed()
accounts = await web3.eth.getAccounts()
web3.eth.sendTransaction({ from: accounts[0], to: SimplePonzi.address, value: 1e18 })
web3.eth.getBalance(accounts[0]) // first check
web3.eth.sendTransaction({ from: accounts[1], to: SimplePonzi.address, value: 1e17 }) // error
web3.eth.sendTransaction({ from: accounts[1], to: SimplePonzi.address, value: 2e18 })
web3.eth.getBalance(accounts[0]) // second check
```
