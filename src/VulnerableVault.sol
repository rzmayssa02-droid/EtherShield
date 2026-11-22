
 pragma solidity ^0.8.20;

 contract VulnerableVault {

     mapping(address => uint256) public balances;

     function deposit() external payable {
         require(msg.value > 0, "Amount must be positive");
         balances[msg.sender] += msg.value;
     }
 }
