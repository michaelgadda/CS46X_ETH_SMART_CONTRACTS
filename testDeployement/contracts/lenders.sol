pragma solidity ^0.8.9;

contract Lending {
    address public owner;
    address payable public lender;
    address payable public lendee;
    uint256 public loanAmount;
    uint256 public loanAmountLeft;
    uint256 public totalReceivedAmount;
    uint256 public totalInterest;
    uint256 public principleLoanPayed;
    uint256 public interestPayed;
    uint256 public interestRate;
    uint256 public loanPeriod;
    uint256 public loanInstallmentPeriod;
    uint256 public loanStart;
    uint256 public loanEnd;
    bool public loanRepaid;
    bool public interestRepaid;
    uint256 public lateFee;
    uint256 public gracePeriod;
    uint256 public defaultAmount;
    uint256 public installmentAmount;
    uint256 public previousLoanInstallmentDate; 
    uint256 public daysBetweenInstallments;
    uint256 public interestLeft;
    bool private lenderDeposit; 
    bool private lenderWithdrawal;
    bool private lendeeDeposit;
    bool private lendeeWithdrawal;

    event LoanCreated(address payable lender, address payable lendee, uint256 loanAmount, uint256 interestRate, uint256 loanPeriod, uint256 loanInstallmentPeriod, uint256 installmentAmount);
    event Lended(address payable lendee, address payable lender, uint256 loanAmount);
    event InstallmentRepaid(address payable lender, address payable lendee, uint256 loanAmountLeft, uint256 totalReceivedAmount, uint256 principleLoanPayed, bool LoanRepaid);
    event LoanLate(address payable lender, address payable lendee);
    event LoanDefaulted(address payable lender, address payable lendee);
    event LoanRepaidInFull(address payable lender, address payable lendee, uint256 interestPayed, uint256 principleLoanPayed);
    event InterestRepaid(address payable lender, address payable lendee, uint256 interestLeft, uint256 InterestRepaid, uint256 totalReceivedAmount);


    constructor()  {
        owner = msg.sender;

    }

    //unfortunateley there is no real way to do continuous payments based off of time, at least not natively, however I added some code in here that will be used as a pretend
    //monthly payment plan -- loanInstallmentPeriod, loanInstallmentAmount

    function createLoan(address payable _lendee, address payable _lender, uint256 _loanAmount, uint256 _interestRate, uint256 _loanPeriod, uint256 _loanInstallmentPeriod) public {
        require(msg.sender == lender);
        require(_loanAmount > 0);
        require(_interestRate > 0 && _interestRate <= 100);
        require(_loanPeriod > 0);
        lendee = _lendee;
        lender = _lender;
        loanAmount = _loanAmount;
        interestRate = _interestRate;
        loanPeriod = _loanPeriod;
        loanInstallmentPeriod = _loanInstallmentPeriod;
        installmentAmount = _loanAmount/_loanInstallmentPeriod;
        loanStart = block.timestamp;
        loanEnd = block.timestamp + loanPeriod;
        totalInterest = loanAmount*interestRate/100;
        interestLeft = totalInterest;
        loanAmountLeft = _loanAmount;
        totalReceivedAmount = 0;
        principleLoanPayed = 0;
        interestPayed = 0;
        previousLoanInstallmentDate = block.timestamp;
        lenderDeposit = true; 
        emit LoanCreated(lender, lendee, loanAmount, interestRate, loanPeriod, loanInstallmentPeriod, installmentAmount);
    }

    function deposit(address walletAddress) payable public {}



    function lendLoan() public payable {
        require(msg.sender == lender);
        require(msg.value >= loanAmount);
        require(lenderDeposit == true);
        this.deposit(address(this));
        //equire(msg.value == loanAmount);
        lendee.transfer(loanAmount);
        emit Lended(lendee, lender, loanAmount);
        }
    

    function repayInstallment() public payable {
        require(msg.sender == lendee);
        require(msg.value >= installmentAmount);
        uint256 currTimeBwInstallments = block.timestamp - previousLoanInstallmentDate; 
        if (currTimeBwInstallments > daysBetweenInstallments * 1 days) {
            this.deposit(address(this));
            require(msg.value >= installmentAmount + lateFee);
            lender.transfer(installmentAmount + lateFee);
            loanAmountLeft = loanAmountLeft - msg.value;
            totalReceivedAmount += msg.value  + lateFee; 
            principleLoanPayed += msg.value;
            previousLoanInstallmentDate = block.timestamp;
            emit LoanLate(lender, lendee);
        } else if (currTimeBwInstallments - daysBetweenInstallments * 1 days > daysBetweenInstallments || block.timestamp > loanEnd) {
            emit LoanDefaulted(lender, lendee);
            this.defaultLoan();
            selfdestruct(lender);
        } else {
            this.deposit(address(this));
            lender.transfer(installmentAmount);
        }
        if (loanAmountLeft == 0 || interestLeft == 0) {
            loanRepaid = true;
            selfdestruct(lender);
            emit LoanRepaidInFull(lender, lendee, interestPayed, principleLoanPayed);
        }
        emit InstallmentRepaid(lender, lendee, loanAmountLeft, totalReceivedAmount, principleLoanPayed, loanRepaid);
        
    }

    function repayInterest() public payable {
        require(msg.sender == lendee);
        require(msg.value >= 0);
        if (block.timestamp > loanEnd) {
            this.defaultLoan();
            emit LoanDefaulted(lender, lendee);
            selfdestruct(lender);
        } else if (msg.value <= interestLeft) {
            this.deposit(address(this));
            lender.transfer(msg.value);
            interestPayed += msg.value; 
            interestLeft -= msg.value;
            totalReceivedAmount += msg.value;
        } 
        if (loanAmountLeft == 0 || interestLeft == 0) {
            loanRepaid = true;
            emit LoanRepaidInFull(lender, lendee, interestPayed, principleLoanPayed);
            selfdestruct(lender);
        }
        emit InterestRepaid(lender, lendee, interestLeft, interestPayed, totalReceivedAmount);
        
    }

    function balanceOf() public view returns(uint) {
        return address(this).balance;
    }


    //TODO
    function repayCustAmountLoan() public payable {
        require(msg.sender == lendee);
        require(msg.value >= 0);
        this.deposit(address(this));
        lender.transfer(msg.value);
        

            //emit LoanRepaid(lender, lendee);
        }
        
    

    function defaultLoan() public {
        //require(msg.sender == lender);
        //require(block.timestamp > loanEnd + gracePeriod);
        require(!loanRepaid);
        //lendee.transfer(defaultAmount);
        //possibly want to add some collateral or something that would be transferred.. something..
        emit LoanDefaulted(lender, lendee);
    }
}