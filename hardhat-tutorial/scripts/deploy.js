const { ethers } = require("hardhat");
require("dotenv").config({ path: ".env" });
// const { METADATA_URL } = require("../constants");

async function main() {
  /*
  A ContractFactory in ethers.js is an abstraction used to deploy new smart contracts,
  so BlockTokenContract here is a factory for instances of our BlockToken contract.
  */
  const blockTokenContract = await ethers.getContractFactory("AnderToK");
  const nftContract = await ethers.getContractFactory("ArtItem");

  // URL from where we can extract the metadata for a Crypto Dev NFT
  // const metadataURL = METADATA_URL;

  // deploy the contract
  const deployedBlockTokenContract = await blockTokenContract.deploy(1000000);
  const deployedNFTContract = await nftContract.deploy();

  // print the address of the deployed contract
  console.log("AnderToK Contract Address:", deployedBlockTokenContract.address);
  console.log("NFT Contract Address:", deployedNFTContract.address);
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });