// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

  import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BlockToken is ERC20 {
    mapping(address => uint256) private _balances;

    uint256 private _totalSupply;

    string private _name = "Block ETH Token";
    string private _symbol = "BET";
    uint256 public tokensPerEth = 1000;


    constructor(string memory name_, string memory symbol_) ERC20(name_, symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    function name() public view virtual override returns (string memory) {
        return _name;
    }

    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    function _mint(address account, uint256 amount) internal override virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }
    event BuyTokens(address receiver, uint256 amountOfETH, uint256 amountOfTokens);

    function buyTokens() public payable returns (uint256 tokenAmount) {
        require(msg.value > 0, "Send ETH to buy some tokens");
        uint256 amountToBuy = msg.value * tokensPerEth;
        // emit the event
        emit BuyTokens(msg.sender, msg.value, amountToBuy);

        return amountToBuy;
    }
    
}