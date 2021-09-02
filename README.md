Goto: https://www.katacoda.com/scenario-examples/courses/environment-usages/nodejs

1. truffle
```
curl -LSfs https://raw.githubusercontent.com/github167/demo-truffle/greeting/init.sh | sh
cd king-sandbox
truffle develope
migrate --reset

```
copy the contract address, and paste to the line 11 of abc.js
```
sed -i "s/const DEFAULT_ADDRESS = ''/const DEFAULT_ADDRESS = 'contract_address'/" src/abc.js
node abc.js
```
