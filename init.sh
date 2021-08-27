# https://ithelp.ithome.com.tw/articles/10203977
mkdir work work/src work/static
cd work
npm init -y
npm install web3 nanohtml morphdom csjs-inject budo

cat << EOF > static/01.html
<!doctype html>
<html>
<head>
  <meta charset="utf-8">
</head>
<body>
  <script src="01.js"></script>
</body>
</html>
EOF

cat << 'EOF' > src/01.js
// 匯入模組
const Web3 = require('web3');
const html = require('nanohtml');
const csjs = require('csjs-inject');
const morphdom = require('morphdom');

// 初始化 web3.js
const INFURA_API_KEY = 'bfa0ceaaf2024fbba3222253de7795a4';
if (typeof web3 !== 'undefined') {
  //web3 = new Web3(web3.currentProvider);
  web3 =:q new Web3(`https://mainnet.infura.io/v3/${INFURA_API_KEY}`);
} else {
  web3 = new Web3(`https://mainnet.infura.io/v3/${INFURA_API_KEY}`);
}


// 設定 css inject
const css = csjs `
  .box {
  }
  .input {
    margin: 10px;
    width: 500px;
    font-size: 20px;
  }
  .button {
    margin-top: 10px;
    font-size: 20px;
    width: 180px;
    background-color: #4CAF50;
    color: white;
  }
  .result {
    margin: 10px;
  }
  img {
    border: 1px solid #ddd;
    border-radius: 4px;
    padding: 5px;
    width: 150px;
  }
`

const address = '0x06012c8cf97BEaD5deAe237070F9587f8E7A266d';

// ==== DOM element ===

const inputAccount = html `<input class=${css.input} type="text" value=${address} placeholder="輸入你要查詢的帳戶"/>`;
const resultElement = html `<div></div>`

// ===== Event =====

function queryBalance(event) {
  web3.eth.getBalance(inputAccount.value, (err, balance) => {
    let number = Math.round(web3.utils.fromWei(balance, 'ether') * 100) / 100;
    const newElement = html `<div class="${css.result}">結果：${number} Ether</div>`
    morphdom(resultElement, newElement);
  });
}

// ===== render ===== 

function render() {
  document.body.appendChild(html `
  <div class=${css.box} id="app">
    ${inputAccount}
    <button class=${css.button} onclick=${queryBalance}>查詢 Ether 金額</button>
    ${resultElement}
  </div>
 `)
}

render();
EOF

budo src/01.js:bundle.js --live --open --dir ./static
