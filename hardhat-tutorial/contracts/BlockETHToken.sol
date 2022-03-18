 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract BlockETHToken {

    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowance;

    string public name;
    string public symbol;
    uint256 public totalSupply;
    uint256 private tokensPerEth = 1000;

    // Events - fire events on state changes etc
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor() {
        name = "BlockETHToken";
        symbol = "BET";
        totalSupply = 1000000; 
        balances[msg.sender] = totalSupply;
    }
 
    function transfer(address _to, uint256 _amount) external returns (bool sucess) {
        require(balances[msg.sender] >= _amount);
        _transfer(msg.sender, _to, _amount);
        return true;
    }

    function buyToken(address _reciever, uint256 _amount) external payable returns (bool sucess) {
        require(balances[msg.sender] >= _amount * tokensPerEth);
        balances[_reciever] = balances[_reciever] + (_amount* tokensPerEth);
        _transfer(msg.sender, _reciever, _amount* tokensPerEth);
        return true;
    }

    function _transfer(address _from, address _to, uint256 _amount) internal {
        require(_to != address(0));
        balances[_from] = balances[_from] - (_amount);
        balances[_to] = balances[_to] + (_amount);
        emit Transfer(_from, _to, _amount);
    }
}