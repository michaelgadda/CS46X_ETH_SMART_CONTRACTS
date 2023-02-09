pragma solidity >=0.7.0 <0.9.0;

contract Lending {
    loan[] private loans;
    lendee[] private lendees; 
    lender[] private lenders; 

    struct lender {
        address payable lenderAddress;
        uint256[] loanIds; 
    }

    struct lendee {
        address payable lendeeAddress;
        uint256[] loanIds; 
    }

    struct loan {
        uint256 loanId; 
        address  payable lender; 
        address  payable lendee; 
        uint256  loanAmount;
        uint256  loanAmountLeft;
        uint256  totalReceivedAmount;
        uint256  totalInterest;
        uint256  principleLoanPayed;
        uint256  interestPayed;
        uint256  interestRate;
        uint256  loanPeriod;
        uint256  loanInstallmentPeriod;
        uint256  loanStart;
        uint256  loanEnd;
        bool  loanRepaid;
        bool  interestRepaid;
        uint256  lateFee;
        uint256  gracePeriod;
        uint256  defaultAmount;
        uint256  installmentAmount;
        uint256  previousLoanInstallmentDate; 
        uint256  daysBetweenInstallments;
        uint256  interestLeft;
        }

        
    address public owner;
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
    function checkIfLenderExists(address payable lenderAddress){


    }

    function checkifLendeeExists(address payable lenderAddress){



    }

    function checkifLoanExists(uint loanId){



    }

    function addNewLenderToDataBase(address payable lenderAddress){


    }

    function addNewLendeeToDataBase(address payable lendeeAddress){


    }

    function checkIfLendeeHasAccessToLoan(address payable lendeeAddress){



    }

    function checkifLenderHasAccessToLoan(address payable lenderAddress){



    }


    function createLoan(address payable _lendee, address payable _lender, uint256 _loanAmount, uint256 _interestRate, uint256 _loanPeriod, uint256 _loanInstallmentPeriod) public {
        require(msg.sender == lender);
        require(_loanAmount > 0);
        require(_interestRate > 0 && _interestRate <= 100);
        require(_loanPeriod > 0);
        loan newLoan;
        newLoan.lendee = _lendee;
        newLoan.lender = _lender;
        newLoan.loanAmount = _loanAmount;
        newLoan.interestRate = _interestRate;
        newLoan.loanPeriod = _loanPeriod;
        newLoan.loanInstallmentPeriod = _loanInstallmentPeriod;
        newLoan.daysBetweenInstallments = _loanInstallmentPeriod;
        newLoan.installmentAmount = _loanAmount/_loanInstallmentPeriod;
        newLoan.loanStart = block.timestamp;
        newLoan.loanEnd = block.timestamp + _loanPeriod;
        newLoan.totalInterest = _loanAmount*_interestRate/100;
        newLoan.interestLeft = newLoan.totalInterest;
        newLoan.loanAmountLeft = _loanAmount;
        newLoan.totalReceivedAmount = 0;
        newLoan.principleLoanPayed = 0;
        newLoan.interestPayed = 0;
        newLoan.previousLoanInstallmentDate = block.timestamp;
        loans.push(newLoan)
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

    
    function remainingLoanBalance() public view returns(uint) {
        return loanAmountLeft;
    }

        
    function remainingInterestBalance() public view returns(uint) {
        return interestLeft;
    }

    
    function remainingTimeForCurrentInstallment() public view returns(uint) {
        return daysBetweenInstallments - ((block.timestamp - previousLoanInstallmentDate) * 1 days);
    }

    function remainingTimeForLoan() public view returns(uint) {
        return (loanEnd - block.timestamp) * 1 days;
    }

    
    function checkPaidBalance() public view returns(uint) {
        return totalReceivedAmount;
    }


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