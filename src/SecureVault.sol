

 pragma solidity ^0.8.20;

 contract SecureVault {

     mapping(address => uint256) public balances;

     function deposit() external payable {
         require(msg.value > 0, "Amount must be positive");
         balances[msg.sender] += msg.value;
     }

     function withdraw() external {
         uint256 amount = balances[msg.sender];

         require(amount > 0, "No funds");

         balances[msg.sender] = 0;

         (bool success, ) = payable(msg.sender).call{
             value: amount
         }("");

         require(success, "Transfer failed");
     }
 }
