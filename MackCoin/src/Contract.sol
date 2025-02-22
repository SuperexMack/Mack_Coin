// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MackCoin is ERC20 { 
   address public owner;
   constructor() ERC20("MackCoin" , "MACK"){
    owner = msg.sender;
   }
   
   function mint(address to , uint256 amount) public{
    require(msg.sender == owner , "You are not allowed to do it || You are not the owner");
    _mint(to,amount);
   }
}
