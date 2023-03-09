pragma solidity >=0.7.0 <0.9.0;

contract Lending { 
    struct individualInvestor {
        address payable InvestorAddress;
        attachedInfratructure attachedInf;
        uint totalAmountInvested;
        uint ownedEquityPerc; 
    }

    struct contractor {
        address payable contractorAddress;
        attachedInfratructure attachedInf;
    }

    struct attachedInfratructure {
        individualInvestor[] investors; 
        contractor[] contractors;
        uint totalInvestmentPrincipleValue;
        uint totalRevenueGeneratedFromInf;
        uint withdrawableFunds; 
        uint withdrawedFunds; 
        uint currentFunds; 
        uint totalTokensReleased;

    }
    constructor()  {
            address owner = msg.sender;
        }


    function deposit(address walletAddress) payable public {}

    function sellEquity(uint percToSell) public{}

    function buyEQuity(uint percToBuy) public {}

    function checkEquityValue() public returns(uint) {}

    function withdrawFunds(uint amountToWithdraw) public {}
    
    function getTotalREvenueGenerated() public {}

    function getTotalInvestmentPrincipleValue() public {}

    function getAllInvestors() public{}

    function getAllContractors() public{}





}