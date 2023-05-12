// Import the web3 library
const Web3 = require('web3');

// Create a new instance of the Web3 provider with a URL for the Ethereum network you want to connect to
const provider = new Web3.providers.HttpProvider('https://mainnet.infura.io');

// Create a new instance of the Web3 library using the provider
const web3 = new Web3(provider);

// Load the ABI for the Lending contract
const lendingABI = require('./lendingABI.json');

// Define the address of the deployed Lending contract on the Ethereum network
const lendingAddress = '?';

// Create a new instance of the Lending contract using the ABI and address
const lendingContract = new web3.eth.Contract(lendingABI, lendingAddress);

// Call a function on the Lending contract using the `call` method
lendingContract.methods.checkEquityValue().call()
  .then((equityValue) => {
    console.log(`Equity value is ${equityValue}`);
  })
  .catch((error) => {
    console.error(error);
  });

