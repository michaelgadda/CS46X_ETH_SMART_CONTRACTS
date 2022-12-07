require("@nomicfoundation/hardhat-toolbox");
const dotenv = require("dotenv");
dotenv.config()
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  networks:{
    Goerli: {
      url: process.env.RPCURL,
      accounts: [process.env.MetaP_Key]
    },
  },
  Etherscan: {
    apiKey: process.env.ETHERSCAN_KEY
  }
};
