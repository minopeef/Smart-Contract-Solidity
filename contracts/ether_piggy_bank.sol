// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract EtherPiggyBank{
    address public owner;
    // Note:- Everything which is payable can get the eth by clicking on it 
    constructor(){
        owner = msg.sender;
    }

    event Deposited(address indexed _owner, uint256 _amt);
    event Withdraw(address indexed _owner, uint256 _amt);
    event Transfered(address indexed _to, uint256 _amt);

    modifier onlyOwner() {
        require(msg.sender==owner, "Only owner can access this function");
        _;
    }

    // Receiving Ether through direct Value 
    receive() external payable { 
        emit Deposited(owner, msg.value);
    }

    // Everything which is payable can take money as a value 
    function deposit() external payable{
        require(msg.value > 0, "Deposit amount must be greater than zero"); // added for security)
        emit Deposited(owner, msg.value);
    }

    function getBalance() public view returns(uint256){
        return address(this).balance;
    }

    function withdraw(uint256 _amt) public onlyOwner {
        require(_amt > 0, "Amount must be greater than zero");
        uint256 amount = address(this).balance;
        require(amount >= _amt, "Insufficient Balance");

        (bool success, ) = payable(owner).call{value: _amt}("");
        require(success, "Transfer failed");
        emit Withdraw(owner, _amt);
    }

    function withdrawAll() public onlyOwner {
        uint256 amount = address(this).balance;
        require(amount > 0, "No Funds to Withdraw");

        (bool success, ) = payable(owner).call{value: amount}("");
        require(success, "Transfer failed");
        emit Withdraw(owner, amount);
    }

    function transferFunds(address to, uint256 _amt) public onlyOwner {
        require(to != address(0), "Invalid recipient address");
        require(_amt > 0, "Amount must be greater than zero");
        uint256 amountBal = address(this).balance;
        require(amountBal >= _amt, "Insufficient Balance");
        
        (bool success, ) = payable(to).call{value: _amt}("");
        require(success, "Transfer failed");
        emit Transfered(to, _amt);
    }
}