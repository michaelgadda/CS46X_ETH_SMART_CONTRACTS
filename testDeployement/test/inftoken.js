const {expect } = require("chai");
const { ethers } = require("hardhat");
const hre = require("hardhat");
//const { EDIT_DISTANCE_THRESHOLD } = require("hardhat/internal/constants");

describe("Inf Token Contract", function(){
    //global variables 
    let Token;
    let INFToken; 
    let owner; 
    let addr1;
    let addr2;
    let tokenCap = 100000000;

beforeEach(async function() {
    Token = await ethers.getContractFactory("INFToken");
    [owner,addr1,addr2] = await hre.ethers.getSigners();

    INFToken = await Token.deploy(tokenCap - 500000, tokenCap);
})

describe("Deployment", function() {

it("Should be correct owner", async function() {
    expect(await INFToken.owner()).to.equal(owner.address);
});

it("Should assign the total supply of tokens to the owner", async function () {
    const ownerBalance = await INFToken.balanceOf(owner.address);
    expect(await INFToken.totalSupply()).to.equal(ownerBalance);
  });

  it("Should set the max capped supply to the argument provided during deployment", async function () {
    const cap = await INFToken.cap();
    expect(Number(hre.ethers.utils.formatEther(cap))).to.equal(tokenCap);
  });
});

describe("Transactions", function () {
    it("Should transfer tokens between accounts", async function () {
      // Transfer 50 tokens from owner to addr1
      await INFToken.transfer(addr1.address, 50);
      const addr1Balance = await INFToken.balanceOf(addr1.address);
      expect(addr1Balance).to.equal(50);

      // Transfer 50 tokens from addr1 to addr2
      // We use .connect(signer) to send a transaction from another account
      await INFToken.connect(addr1).transfer(addr2.address, 50);
      const addr2Balance = await INFToken.balanceOf(addr2.address);
      expect(addr2Balance).to.equal(50);
    });

    it("Should fail if sender doesn't have enough tokens", async function () {
      const initialOwnerBalance = await INFToken.balanceOf(owner.address);
      // Try to send 1 token from addr1 (0 tokens) to owner (1000000 tokens).
      // `require` will evaluate false and revert the transaction.
      await expect(
        INFToken.connect(addr1).transfer(owner.address, 1)
      ).to.be.revertedWith("ERC20: transfer amount exceeds balance");

      // Owner balance shouldn't have changed.
      expect(await INFToken.balanceOf(owner.address)).to.equal(
        initialOwnerBalance
      );
    });

    it("Should update balances after transfers", async function () {
      const initialOwnerBalance = await INFToken.balanceOf(owner.address);

      // Transfer 100 tokens from owner to addr1.
      await INFToken.transfer(addr1.address, 100);

      // Transfer another 50 tokens from owner to addr2.
      await INFToken.transfer(addr2.address, 50);

      // Check balances.
      const finalOwnerBalance = await INFToken.balanceOf(owner.address);
      expect(finalOwnerBalance).to.equal(initialOwnerBalance.sub(150));

      const addr1Balance = await INFToken.balanceOf(addr1.address);
      expect(addr1Balance).to.equal(100);

      const addr2Balance = await INFToken.balanceOf(addr2.address);
      expect(addr2Balance).to.equal(50);
    });
  });
  
  }); 

