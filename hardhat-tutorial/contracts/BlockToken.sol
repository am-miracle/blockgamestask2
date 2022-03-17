// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

  import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BlockToken is ERC20 {

    constructor() ERC20("Block ETH Token", "BET") {
        _mint(msg.sender, 1000000 * 10 ** 18);
    }

      // token price for ETH
  uint256 public tokensPerEth = 1000;

  // Event that log buy operation
  event BuyTokens(address receiver, uint256 amountOfETH, uint256 amountOfTokens);

  function buyTokens() public payable returns (uint256 tokenAmount) {
    require(msg.value > 0, "Send ETH to buy some tokens");
    uint256 amountToBuy = msg.value * tokensPerEth;
    // emit the event
    emit BuyTokens(msg.sender, msg.value, amountToBuy);

    return amountToBuy;
  }
    
}