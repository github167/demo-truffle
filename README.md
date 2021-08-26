Goto: https://www.katacoda.com/scenario-examples/courses/environment-usages/nodejs

1. truffle
```
curl -LSfs https://raw.githubusercontent.com/github167/demo-truffle/web3/init.sh | sh
cd web3_token
truffle develope
migrate --reset

```
copy the contract address, and paste to the line 4 of app.js
```
sed -i "s/const address = ''/const address= 'contract_address'/" app.js
node app.js
```
