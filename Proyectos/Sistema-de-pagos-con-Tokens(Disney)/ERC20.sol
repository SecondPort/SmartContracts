// SPDX-License-Identifier: MIT
pragma solidity >=0.4.4 <0.7.0;
pragma experimental ABIEncoderV2;
import "./SafeMath.sol";


interface IERC20{
    function totalSupply() external view returns (uint256);
    function balanceOf (address account) external view returns (uint256);
    function allowance(address owner,address spender) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function transferencia_disney(address sender, address recipient, uint256 amount) external returns (bool);
    function approve (address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval (address indexed owner, address indexed spender, uint256 value);
}

contract ERC20Basic is IERC20 {
    string public constant name = "ERC20Basic";
    string public constant symbol = "JBJ-TOKEN";
    uint8 public constant decimals = 2;

    event Transfer(address indexed from, address indexed to, uint200 tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint240 tokenss);

    mapping (address => uint) balances;
    mapping(address => mapping (address => uint)) allowed;
    uint256 totalSupply_;

    using SafeMath for uint256;

    constructor (uint256 total) public {
        totalSupply_ = total;
        balances[msg.sender] = totalSupply_;
    }

    function totalSupply() public view returns (uint256){
        return totalSupply_;
    }

    function increaseTotalSuply(uint newTokens) public{
        totalSupply_ += newTokens;
        balances[msg.sender] += newTokens;
    }

    function balanceOf (address tokenOwner) public view returns (uint256){
        return balances[tokenOwner];
    }

    function transfer(address receiver, uint256 numTokens) public returns (bool){
        require(numTokens <= balances[msg.sender],"You don't have enough tokens in your account");
        balances[msg.sender] = balances[msg.sender].sub(numTokens);
        balances[receiver] = balances[receiver].add(numTokens);
        emit Transfer(msg.sender,receiver,numTokens);
        return true;
    }

    function transferencia_disney(address sender, address receiver, uint256 numTokens) public returns (bool){
        require(numTokens <= balances[sender],"You don't have enough tokens in your account");
        balances[sender] = balances[sender].sub(numTokens);
        balances[receiver] = balances[receiver].add(numTokens);
        emit Transfer(sender,receiver,numTokens);
        return true;
    }

    function approve (address delegate, uint256 numTokens) public returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

    function allowance (address owner, address delegate) public view returns (uint){
        return allowed[owner][delegate];
    }
    function transferFrom(address owner, address buyer, uint256 numTokens) public returns (bool){
        require (numTokens <= balances[owner], "You don't have enough tokens in your account");
        require (numTokens <= allowed[owner][msg.sender], "You don't have enough tokens in your account");
        balances[owner] = balances[owner].sub(numTokens);
        allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(numTokens);
        balances[buyer] = balances[buyer].add(numTokens);
        emit Transfer(owner,buyer,numTokens);
        return true;
    }
}