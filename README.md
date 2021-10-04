Goto: https://www.katacoda.com/scenario-examples/courses/environment-usages/nodejs

1. launch granche-cli
```
npx ganache-cli -a 2 -i 1337
```

2. install (open a new terminal)
```
curl -LSfs https://raw.githubusercontent.com/github167/demo-truffle/tornado-core/init.sh | sh
cd tornado-core
cp .env.example .env
```

3.1 download keys, or...
```
npm run download
```

3.2 generate keys, or...
```
npm run build
```

3.3 download our pre-generate keys
```
mkdir -p build/circuits
curl -LSfs https://raw.githubusercontent.com/github167/demo-truffle/tornado-core/withdraw.json > build/circuits/withdraw.json
curl -LSfs https://raw.githubusercontent.com/github167/demo-truffle/tornado-core/withdraw_proving_key.json > build/circuits/withdraw_proving_key.json
curl -LSfs https://raw.githubusercontent.com/github167/demo-truffle/tornado-core/withdraw_verification_key.json > build/circuits/withdraw_verification_key.json
curl -LSfs https://raw.githubusercontent.com/github167/demo-truffle/tornado-core/withdraw_proving_key.bin > build/circuits/withdraw_proving_key.bin
curl -LSfs https://raw.githubusercontent.com/github167/demo-truffle/tornado-core/Verifier.sol > build/circuits/Verifier.sol
```

4. run test
```
npm run build:contract
npm run migrate:dev

node abc.js test
```
