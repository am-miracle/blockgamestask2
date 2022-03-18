 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract BlockETHToken {

    string public name;
    string public symbol;
    uint256 public totalSupply_;
    uint256 public tokensPerEth = 1000;

    // Keep track balances and allowances approved
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor() {
        name = "BlockETHToken";
        symbol = "BET";
        totalSupply_ = 1000000 * 10 ** 18; 
        balanceOf[msg.sender] = totalSupply_;
    }
 
    function transfer(address _to, uint256 _value) external returns (bool success) {
        require(balanceOf[msg.sender] >= _value);
        _transfer(msg.sender, _to, _value);
        return true;
    }

    function buyToken(address _reciever, uint256 _value) external payable returns (bool success) {
        require(balanceOf[msg.sender] >= _value * tokensPerEth);
        balanceOf[_reciever] = balanceOf[_reciever] + (_value * tokensPerEth);
        _transfer(msg.sender, _reciever, _value * tokensPerEth);
        return true;
    }

    function _transfer(address _from, address _to, uint256 _value) internal {
        require(_to != address(0));
        balanceOf[_from] = balanceOf[_from] - (_value);
        balanceOf[_to] = balanceOf[_to] + (_value);
        emit Transfer(_from, _to, _value);
    }
}