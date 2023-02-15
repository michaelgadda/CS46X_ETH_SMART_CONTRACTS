// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "hardhat/console.sol";
//import "../node_modules/hardhat/console.sol";
import "./ExampleExternalContract.sol";
import "./lenders.sol";


/**
* @title Staking Contract
* @notice A contract that allow users to pool ETH
*/
contract Staker {

  // External contract that will hold funds
  ExampleExternalContract public exampleExternalContract;
  Lenders public lenders;

  // Balances of the user's staked funds
  mapping(address => uint256) public balances;

  // Staking threshold
  uint256 public constant threshold = .01 ether;

  // Staking deadline
  uint256 public deadline = block.timestamp + 3 minutes;

  // Events
  event Stake(address indexed sender, uint256 amount);


  // Modifiers
  /**
  * @notice Modifier that require the deadline to be reached or not
  * @param requireReached Check if the deadline has reached or not
  */
  modifier deadlineReached( bool requireReached ) {
    uint256 timeRemaining = timeLeft();
    if( requireReached ) {
      require(timeRemaining == 0, "Deadline is not reached yet");
    } else {
      require(timeRemaining > 0, "Deadline is already reached");
    }
    _;
  }



  /**
  * @notice Modifier that require the external contract to not be completed
  */
  modifier stakeNotCompleted() {
    bool completed = exampleExternalContract.completed();
    require(!completed, "staking process already completed");
    _;
  }
  


  /**
  * @notice Contract Constructor
  * @param LendersAddress Address of the external contract that will hold funds
  */
  constructor(address LendersAddress) {
    Lenders = Lenders(LendersAddress);
  }



  function execute() public stakeNotCompleted deadlineReached(false) {
    uint256 contractBalance = address(this).balance;

    require(contractBalance >= threshold, "Threshold not reached"); // check if contract has reached set ETH threshold

    // --- TO-DO --->> TESTING: compability, communication between 
    //                 - STAKING/LENDERS/TOLL CONTRACTS 
    //
    // Execute external contract, transfer entire balance

    // (bool sent, bytes memory data) = exampleExternalContract.complete{value: contractBalance}();
    (bool sent,) = address(Lenders).call{value: contractBalance}(abi.encodeWithSignature("deposit()"));
    require(sent, "Lenders.deposit failed");
  }



  /**
  * @notice Stake method that update the user's balance
  */
  function stake() public payable deadlineReached(false) stakeNotCompleted {
    balances[msg.sender] += msg.value; // update user balance
    emit Stake(msg.sender, msg.value); // emit event to blockchain; this states funds are `verifiably` staked for the user
  }



  /**
  * @notice Allow users to withdraw balance from the contract only if deadline reached but staking threshold not completed
  */
  function withdraw() public deadlineReached(true) stakeNotCompleted {
    uint256 userBalance = balances[msg.sender];

    require(userBalance > 0, "You don't have balance to withdraw"); // check if the user has balance to withdraw

    balances[msg.sender] = 0; // reset user balance

    (bool sent,) = msg.sender.call{value: userBalance}(""); // transfer balance back to user
    require(sent, "Failed to send user balance back to the user");
  }



  /**
  * @notice Remaining time (seconds) until deadline is reached
  */
  function timeLeft() public view returns (uint256 timeleft) {
    if( block.timestamp >= deadline ) {
      return 0;
    } else {
      return deadline - block.timestamp;
    }
  }

}