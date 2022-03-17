// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import the openzepplin contracts
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// ArtItem is  ERC721 signifies that the contract we are creating imports ERC721 and follows ERC721 contract from openzeppelin
contract ArtItem is ERC721 {

    constructor() ERC721("ArtItem", "ITM") {
        // mint an NFT to yourself
        _mint(msg.sender, 1);
    }
     function _baseURI() internal pure override returns (string memory) {
         return string[] = "";
     }
}