npm install -g circom
npm install -g snarkjs
npm install -g yarn
git clone https://github.com/chnejohnson/simple-tornado
cd simple-tornado
yarn

mkdir -p ./build/circuits
mkdir -p ./build/contracts

# build hasher
yarn build:hasher

# build circuits
cd ./build/circuits
circom ../../circuits/withdraw.circom --r1cs circuit.r1cs --wasm circuit.wasm --sym circuit.sym
wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_15.ptau
snarkjs zkey new circuit.r1cs powersOfTau28_hez_final_15.ptau circuit_0000.zkey
echo mnbvc | snarkjs zkey contribute circuit_0000.zkey circuit_final.zkey

#build verification key
snarkjs zkey export verificationkey circuit_final.zkey verification_key.json
