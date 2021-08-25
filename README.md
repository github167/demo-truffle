Goto: https://www.katacoda.com/scenario-examples/courses/environment-usages/nodejs

1. truffle
```
curl -LSfs https://raw.githubusercontent.com/github167/demo-truffle/metacoin/init.sh | sh

cd metacoin
truffle develope
migrate
instance = await MetaCoin.deployed()
accounts = await web3.eth.getAccounts()
instance.getBalance(accounts[0])
instance.getBalance(accounts[1])
instance.sendCoin(accounts[1], 13, {from: accounts[0]})
instance.getBalance(accounts[0])
instance.getBalance(accounts[1])
```
