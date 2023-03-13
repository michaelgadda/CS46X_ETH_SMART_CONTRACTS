// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
import "";

///node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract PPP is ERC20 {

   constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol){
       _mint(msg.sender, 1000000 * 10 ** 18);

   }
}