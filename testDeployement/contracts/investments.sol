pragma solidity >=0.7.0 <0.9.0;

contract Lending {
    struct IndividualInvestor {
        address payable investorAddress;
        AttachedInfrastructure attachedInf;
        uint totalAmountInvested;
        uint ownedEquityPerc;
    }

    struct Contractor {
        address payable contractorAddress;
        AttachedInfrastructure attachedInf;
    }

    struct AttachedInfrastructure {
        IndividualInvestor[] investors;
        Contractor[] contractors;
        uint infrastructureId;
        uint totalInvestmentPrincipalValue;
        uint totalRevenueGeneratedFromInf;
        uint withdrawableFunds;
        uint withdrawnFunds;
        uint currentFunds;
        uint totalTokensReleased;
    }

    address private owner;
    AttachedInfrastructure private infrastructure;

    constructor() {
        owner = msg.sender;
    }

    function deposit() payable public {}

    function sellEquity(uint percToSell) public {}

    function buyEquity(uint percToBuy) public {}

    function checkEquityValue() public view returns (uint) {}

    function withdrawFunds(uint amountToWithdraw) public {
        require(amountToWithdraw <= infrastructure.withdrawableFunds, "Insufficient withdrawable funds");
        require(amountToWithdraw <= address(this).balance, "Contract does not have enough balance");
        
        infrastructure.withdrawableFunds -= amountToWithdraw;
        infrastructure.withdrawnFunds += amountToWithdraw;
        infrastructure.currentFunds -= amountToWithdraw;
        
        msg.sender.transfer(amountToWithdraw);
    }

    function getTotalRevenueGenerated() public view returns (uint) {
        return infrastructure.totalRevenueGeneratedFromInf;
    }

    function getTotalInvestmentPrincipalValue() public view returns (uint) {
        return infrastructure.totalInvestmentPrincipalValue;
    }

    function getAllInvestors() public view returns (IndividualInvestor[] memory) {
        return infrastructure.investors;
    }

    function getAllContractors() public view returns (Contractor[] memory) {
        return infrastructure.contractors;
    }
}
