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

contract BlockToken is IERC20 {
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    uint256 private _totalSupply;
    uint8 private _decimals;
    string private _name;
    string private _symbol;


    constructor(uint256 initialSupply) {
        _name = "BlockGATok";
        _symbol = "BGT";
        _decimals = 18;

        _mint(msg.sender, initialSupply * 10 ** decimals());

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
    // function owner() public view returns (address) {
    //     return _owner;
    // }

    function totalSupply() public override view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view virtual override returns (uint256) {
        return balances[account];
    }
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = msg.sender;
        _buyToken(owner, to, amount);
        return true;
    }


    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner;
        _approve(owner, spender, amount);
        return true;
    }

    function allowance(address owner_, address spender) public view virtual override returns (uint256) {
        return _allowances[owner_][spender];
    }

    function transferFrom(address from,address to,uint256 amount) public virtual override returns (bool) {
        _buyToken(from, to, amount);
        return true;
    }
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _totalSupply += amount;
        balances[account] += amount;
        emit Transfer(address(0), account, amount);
    }
    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }


    function _buyToken(address owner, address receiver, uint256 amount) public payable returns (bool) {
        require(owner != address(0), "ERC20: transfer owner the zero address");
        require(receiver != address(0), "ERC20: transfer receiver the zero address");
        uint256 fromBalance = balances[owner];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            balances[owner] = fromBalance - amount;
        }
        balances[receiver] = balances[receiver] + amount;
        balances[receiver] += amount;
        _totalSupply += amount;
        emit Transfer(owner, receiver, amount);
        
        return true;
    }
}