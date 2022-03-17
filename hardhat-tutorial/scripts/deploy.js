const { ethers } = require("hardhat");
require("dotenv").config({ path: ".env" });

async function main() {
  /*
  A ContractFactory in ethers.js is an abstraction used to deploy new smart contracts,
  so BlockTokenContract here is a factory for instances of our CryptoDevs contract.
  */
  const blockTokenContract = await ethers.getContractFactory("BlockToken");
  const nftContract = await ethers.getContractFactory("ArtItem");

  // deploy the contract
  const deployedBlockTokenContract = await blockTokenContract.deploy();
  const deployedNFTContract = await nftContract.deploy();

  // print the address of the deployed contract
  console.log("BlockToken Contract Address:", deployedBlockTokenContract.address);
  console.log("NFT Contract Address:", deployedNFTContract.address);
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });