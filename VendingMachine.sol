// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VendingMachine{
    uint soda;
    address payable public owner;
    mapping (address=>uint) public sodaPurchased;

    constructor(){
        soda=100;
        owner=payable (msg.sender);
    }
    function buy() public  payable {
        require(msg.value==1 ether,"You should have 1 ether");
        require(soda>0,"Out of stock");
        sodaPurchased[msg.sender]++;
        soda=soda-1;
    }

    function fillSoda(uint _soda) public {
        require(msg.sender==owner,"You are not the owner");
        soda=soda+ _soda;
    }

    function withdrawBalance() public payable  {
        require(msg.sender==owner,"You are not the owner");

        (bool success, ) = payable(owner).call{value: address(this).balance}("");
        require(success, "Transfer failed.");
    }
}
