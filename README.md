Goto: https://www.katacoda.com/scenario-examples/courses/environment-usages/nodejs

1. launch granche-cli
```
npx ganache-cli -a 2 -i 1337
```

2. install (open a new terminal)
```
curl -LSfs https://raw.githubusercontent.com/github167/demo-truffle/tornado-core/init.sh | sh
cd tornado-core
```

3. run test
```
cp .env.example .env
npm run download
npm run build:contract
npm run migrate:dev


node cli.js test
```
