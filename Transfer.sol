// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.28;

contract Transfer{

    mapping (address=> uint) balance;
    function addbalance(uint _toadd)public returns(uint){
        balance[msg.sender] += _toadd;
        return balance[msg.sender];  }
    

    function getbalance()public view returns(uint){
        return balance[msg.sender]; }

    
    function transfer(address recipent, uint amount)public {
        require(balance[msg.sender]>= amount,"Balance not Sufficient");
        require(msg.sender != recipent);

        uint prebalance = balance[msg.sender];

        _transfer(msg.sender, recipent, amount);
        assert(balance[msg.sender] == prebalance - amount); } 
    
     function _transfer(address from, address to, uint amount)private {
        balance[from] -= amount;
        balance[to] += amount;   } 
            

}
