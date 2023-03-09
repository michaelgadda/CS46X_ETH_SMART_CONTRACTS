// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

 import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
 import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
 import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract INFToken is ERC20Capped {
    address payable public owner;
    constructor(uint256 initialSupply, uint256 cap) ERC20("INFToken", "INF") ERC20Capped(cap * (10 ** decimals())) {
        owner = payable(msg.sender);
        _mint(msg.sender, initialSupply * (10 ** decimals()));
        
    }
}
