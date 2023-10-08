// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;


contract Mycontract{
    address public head;
    address payable [] public funds;

    constructor() {
        head = msg.sender;
    }
    receive() external payable{
        funds.push(payable(msg.sender));
    }
    modifier onlyOwner {
        require (msg.sender == head , "you are not allowed to perform this operation.");
        _;
    }
    
    uint public _amount_allowed;
    function setWithdrawAmount (uint _amount) public onlyOwner {
        _amount_allowed= _amount;
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function WithdrawAllMoney(address payable _to) public onlyOwner {
        _to.transfer(getBalance());
    }
    
    function WithdrawMoney(address payable _to, uint value) public {
        require(value<= _amount_allowed, "you are not allowed to get this amount");
        _to.transfer(value);
    }


}
