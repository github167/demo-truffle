Goto: https://www.katacoda.com/scenario-examples/courses/environment-usages/nodejs

1. install
```
curl -LSfs https://raw.githubusercontent.com/github167/demo-truffle/tornado-cli/init.sh | sh
cd tornado-cli
```
Contract address (in config.js): https://etherscan.io/address/0x47CE0C6eD5B0Ce3d3A51fdb1C52DC66a7c3c2936#events
```
node abc.js --rpc https://mainnet.infura.io/v3/bfa0ceaaf2024fbba3222253de7795a4 run 13306000

node abc.js --rpc https://mainnet.infura.io/v3/bfa0ceaaf2024fbba3222253de7795a4 balance  0x47CE0C6eD5B0Ce3d3A51fdb1C52DC66a7c3c2936
```
