// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Lending {
    address public owner;

    struct individualInvestor {
        address payable InvestorAddress;
        attachedInfratructure attachedInf;
        uint256 totalAmountInvested;
        uint256 ownedEquityPerc;
    }

    struct contractor {
        address payable contractorAddress;
        attachedInfratructure attachedInf;
    }

    struct attachedInfratructure {
        individualInvestor[] investors;
        contractor[] contractors;
        //infrastructureId;
        uint256 totalInvestmentPrincipleValue;
        uint256 totalRevenueGeneratedFromInf;
        uint256 withdrawableFunds;
        uint256 withdrawedFunds;
        uint256 currentFunds;
        uint256 totalTokensReleased;
    }

    constructor() {
        owner = msg.sender;
    }

    function deposit(address walletAddress) public payable {}

    function sellEquity(uint256 percToSell) public {}

    function buyEquity(uint256 percToBuy) public {}

    function checkEquityValue() public returns (uint256) {}

    function withdrawFunds(uint256 amountToWithdraw) public {}

    function getTotalREvenueGenerated() public {}

    function getTotalInvestmentPrincipleValue() public {}

    function getAllInvestors() public {}

    function getAllContractors() public {}
}
