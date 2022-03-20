 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


interface IERC20 {

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);


}

contract AnderToK is IERC20 {
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    uint256 private _totalSupply;
    uint8 private _decimals;
    string private _name;
    string private _symbol;
    address private _owner;


    constructor(uint256 initialSupply) {
        _name = "AnderToK";
        _symbol = "ANT";
        _decimals = 18;
        _owner = msg.sender;
        _mint(msg.sender, initialSupply * 10 ** 18);

    }
    function name() public view virtual returns (string memory) {
        return _name;
    }
    function symbol() public view virtual returns (string memory) {
        return _symbol;
    }
    function decimals() public view virtual returns (uint8) {
        return _decimals;
    }
    function owner() public view mustBeOwner(msg.sender) returns (address) {
        return _owner;
    }

    function totalSupply() public override view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view virtual override returns (uint256) {
        return balances[account];
    }
    function transfer(address _to, uint256 _value) public virtual override returns (bool) {
        require(balances[msg.sender] <= _value, "AnderToken Token: Insufficient funds");
        _transfer(msg.sender, _to, _value);
        return true;
    }
    function transferFrom(address _from,address _to,uint256 _value) public virtual override returns (bool) {
        require(_allowances[_from][msg.sender] >= _value, "AnderTok Token: Allowance is not enough");

        _allowances[_from][msg.sender] += _value;
        _transfer(_from, _to, _value);
        return true;
    }


    function approve(address _spender, uint256 amount) public virtual override returns (bool) {
        _allowances[msg.sender][_spender] = amount;
        emit Approval(msg.sender, _spender, amount);
        return true;
    }

    function allowance(address account, address spender) public view virtual override returns (uint256) {
        return _allowances[account][spender];
    }
    function mint(address _to, uint256 _value) public virtual returns (bool) {
        _mint(_to, _value);
        return true;
    }

    function _transfer(address _from,address _to, uint256 _value) private {
        balances[_from] -= _value;
        balances[_to] += _value;
        emit Transfer(_from, _to, _value);
    }
    function _mint(address _to, uint256 _value) private {
        balances[_to] += _value;
        _totalSupply += _value;
        emit Transfer(address(0), _to, _value);
    }
    function _approve(address account, address spender, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[account][spender] = amount;
        emit Approval(account, spender, amount);
    }


    function _buyToken(address account, address receiver, uint256 amount) public payable returns (bool) {
        require(account != address(0), "ERC20: transfer account the zero address");
        require(receiver != address(0), "ERC20: transfer receiver the zero address");
        uint256 fromBalance = balances[account];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            balances[account] = fromBalance - amount;
        }
        balances[receiver] = balances[receiver] + amount;
        balances[receiver] += amount;
        _totalSupply += amount;
        emit Transfer(account, receiver, amount);
        
        return true;
    }

    modifier mustBeOwner(address _account) {
        require(_owner == _account, "AnderTok Token: caller must be owner");
        _;
    }
}