Goto: https://www.katacoda.com/scenario-examples/courses/environment-usages/nodejs

1. truffle
```
curl -LSfs https://raw.githubusercontent.com/github167/demo-truffle/greeting/init.sh | sh
cd DappTuto
truffle develope
migrate --reset

```
copy the contract address, and paste to the line 19 of abc.js
```
node abc.js
```
For web (not test yet)
copy the contract address, and past to the line 16 of client/src/utils.js
```
./node_modules/.bin/lite-server
```
