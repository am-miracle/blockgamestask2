// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import the openzepplin contracts
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

// ArtItem is  ERC721 signifies that the contract we are creating imports ERC721 and follows ERC721 contract from openzeppelin
contract ArtItem is ERC721 {

    constructor(string memory baseURI) ERC721("ArtItem", "ITM") {
        // mint an NFT to yourself
        _mint(msg.sender, 1);
        _baseTokenURI = baseURI;

    }
    //  function _baseURI() internal pure override returns (string memory) {
    //      return string[] = "";
    //  }
           /**
       * @dev _baseTokenURI for computing {tokenURI}. If set, the resulting URI for each
       * token will be the concatenation of the `baseURI` and the `tokenId`.
       */
      string _baseTokenURI;

      //  _price is the price of one ArtItem NFT
      uint256 public _price = 0.01 ether;

      // max number of ArtItem
      uint256 public maxTokenIds = 2;

      // total number of tokenIds minted
      uint256 public tokenIds;

    function mint() public payable {
        require(tokenIds < maxTokenIds, "Exceed maximum ArtItem supply");
        require(msg.value >= _price, "Ether sent is not correct");
        tokenIds += 1;
        _safeMint(msg.sender, tokenIds);
    }
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }
}