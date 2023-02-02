// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

contract Storage {
    infrastructure[] infStructArray; 
    individualUser[] userStructArray; 

    struct individualUser {
        address payable userWallet; 
        string  userFirstName;
        string  userLastName;
        uint userType; //different users have to pay different amounts
        uint totalInfrastructureUsage; //would need a way of knowing how much they have used the infrastructure
        uint totalPayed; 
    }

    struct infrastructure {
        address payable infWallet; 
        string  infName;
        uint member_type1_cost; 
        uint member_type2_cost;
        uint member_type3_cost; 
        uint totalRevenue; 
        uint totalVisist;  
    }

    constructor()  {
        owner = msg.sender;

    }


    function deposit(address walletAddress) payable public {}

    function addInfStructure(address payable infWallet, string memory infName, uint member_type1_cost, uint member_type2_cost, uint member_type3_cost) {
        infrastructure newInf; 
        newInf.infWallet = infWallet; 
        newInf.infName = infName; 
        newInf.member_type1_cost = member_type1_cost;
        newInf.member_type2_cost = member_type2_cost; 
        newInf.member_type3_cost = member_type3_cost; 
        infStructArray.push(newInf);
    }

    function addUser(); //todo

    //TODO; need to sift through structs to find the infrsatureu and user that are in teh database
    function payInfrustuctureWallet(address payable infAddress) public payable {
        require(msg.sender == X );
        require(msg.value >= X);
        require(lenderDeposit == true);
        this.deposit(address(this));
        //equire(msg.value == loanAmount);
        X.transfer(X);
        emit Lended(lendee, lender, loanAmount);
        }
}