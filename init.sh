npm install -g truffle
mkdir metacoin
cd metacoin
truffle unbox metacoin
truffle compile

cat << EOF > truffle-config.js
module.exports = {
  networks: {
    develop: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*"
    },
    test: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*"
    }
  }
};

EOF

truffle develope
