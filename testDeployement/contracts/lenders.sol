pragma solidity ^0.8.9;

contract Lending {
    address public lender;
    address public lendee;
    uint256 public loanAmount;
    uint256 public interestRate;
    uint256 public loanPeriod;
    uint256 public loanStart;
    uint256 public loanEnd;
    bool public loanRepaid;
    uint256 public lateFee;
    uint256 public gracePeriod;
    uint256 public defaultAmount;

    event LoanCreated(address lender, address lendee, uint256 loanAmount, uint256 interestRate, uint256 loanPeriod);
    event LoanRepaid(address lender, address lendee);
    event LoanLate(address lender, address lendee);
    event LoanDefaulted(address lender, address lendee);

    constructor() public {
        lender = msg.sender;
        gracePeriod = 1 days;
        lateFee = 1 ether;
        defaultAmount = 2 ether;
    }

    function createLoan(address _lendee, uint256 _loanAmount, uint256 _interestRate, uint256 _loanPeriod) public {
        require(msg.sender == lender);
        require(_loanAmount > 0);
        require(_interestRate > 0 && _interestRate <= 100);
        require(_loanPeriod > 0);
        lendee = _lendee;
        loanAmount = _loanAmount;
        interestRate = _interestRate;
        loanPeriod = _loanPeriod;
        loanStart = now;
        loanEnd = now + loanPeriod;
        emit LoanCreated(lender, lendee, loanAmount, interestRate, loanPeriod);
    }

    function repayLoan() public payable {
        require(msg.sender == lendee);
        require(msg.value >= loanAmount);
        if (now > loanEnd + gracePeriod) {
            require(msg.value >= loanAmount + lateFee);
            lender.transfer(loanAmount + lateFee);
            emit LoanLate(lender, lendee);
        } else {
            lender.transfer(loanAmount);
            emit LoanRepaid(lender, lendee);
        }
        loanRepaid = true;
    }

    function defaultLoan() public {
        require(msg.sender == lender);
        require(now > loanEnd + gracePeriod);
        require(!loanRepaid);
        lendee.transfer(defaultAmount);
        emit LoanDefaulted(lender, lendee);
    }
}