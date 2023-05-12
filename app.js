let web3;
let contractInstance;
const contractABI = [
    {
        "inputs": [],
        "stateMutability": "nonpayable",
        "type": "constructor"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "address payable",
                "name": "lender",
                "type": "address"
            },
            {
                "indexed": false,
                "internalType": "address payable",
                "name": "lendee",
                "type": "address"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "loanAmountLeft",
                "type": "uint256"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "totalReceivedAmount",
                "type": "uint256"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "principleLoanPayed",
                "type": "uint256"
            },
            {
                "indexed": false,
                "internalType": "bool",
                "name": "LoanRepaid",
                "type": "bool"
            }
        ],
        "name": "InstallmentRepaid",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "address payable",
                "name": "lender",
                "type": "address"
            },
            {
                "indexed": false,
                "internalType": "address payable",
                "name": "lendee",
                "type": "address"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "interestLeft",
                "type": "uint256"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "InterestRepaid",
                "type": "uint256"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "totalReceivedAmount",
                "type": "uint256"
            }
        ],
        "name": "InterestRepaid",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "address payable",
                "name": "lendee",
                "type": "address"
            },
            {
                "indexed": false,
                "internalType": "address payable",
                "name": "lender",
                "type": "address"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "loanAmount",
                "type": "uint256"
            }
        ],
        "name": "Lended",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "string",
                "name": "message",
                "type": "string"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "loanId",
                "type": "uint256"
            },
            {
                "indexed": false,
                "internalType": "address payable",
                "name": "lender",
                "type": "address"
            },
            {
                "indexed": false,
                "internalType": "address payable",
                "name": "lendee",
                "type": "address"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "loanAmount",
                "type": "uint256"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "interestRate",
                "type": "uint256"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "loanPeriod",
                "type": "uint256"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "loanInstallmentPeriod",
                "type": "uint256"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "installmentAmount",
                "type": "uint256"
            }
        ],
        "name": "LoanCreated",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "address payable",
                "name": "lender",
                "type": "address"
            },
            {
                "indexed": false,
                "internalType": "address payable",
                "name": "lendee",
                "type": "address"
            }
        ],
        "name": "LoanDefaulted",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "address payable",
                "name": "lender",
                "type": "address"
            },
            {
                "indexed": false,
                "internalType": "address payable",
                "name": "lendee",
                "type": "address"
            }
        ],
        "name": "LoanLate",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "address payable",
                "name": "lender",
                "type": "address"
            },
            {
                "indexed": false,
                "internalType": "address payable",
                "name": "lendee",
                "type": "address"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "interestPayed",
                "type": "uint256"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "principleLoanPayed",
                "type": "uint256"
            }
        ],
        "name": "LoanRepaidInFull",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "loanId",
                "type": "uint256"
            },
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "amountLeft",
                "type": "uint256"
            }
        ],
        "name": "amountLeft",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "string",
                "name": "basicString",
                "type": "string"
            }
        ],
        "name": "basicString",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "uint256",
                "name": "blank",
                "type": "uint256"
            }
        ],
        "name": "emitUint",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "string",
                "name": "message",
                "type": "string"
            },
            {
                "indexed": false,
                "internalType": "uint256[]",
                "name": "_loanIds",
                "type": "uint256[]"
            },
            {
                "indexed": false,
                "internalType": "uint256[]",
                "name": "loanIds",
                "type": "uint256[]"
            }
        ],
        "name": "myActiveLoans",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "internalType": "string",
                "name": "message",
                "type": "string"
            },
            {
                "indexed": false,
                "internalType": "address",
                "name": "scAddress",
                "type": "address"
            }
        ],
        "name": "thisSCAddress",
        "type": "event"
    },
    {
        "inputs": [],
        "name": "balanceOf",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "loanId",
                "type": "uint256"
            }
        ],
        "name": "checkPaidBalance",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address payable",
                "name": "_lendee",
                "type": "address"
            },
            {
                "internalType": "address payable",
                "name": "_lender",
                "type": "address"
            },
            {
                "internalType": "uint256",
                "name": "_loanAmount",
                "type": "uint256"
            },
            {
                "internalType": "uint256",
                "name": "_interestRate",
                "type": "uint256"
            },
            {
                "internalType": "uint256",
                "name": "_loanPeriod",
                "type": "uint256"
            },
            {
                "internalType": "uint256",
                "name": "_loanInstallmentPeriod",
                "type": "uint256"
            }
        ],
        "name": "createLoan",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "loanId",
                "type": "uint256"
            }
        ],
        "name": "defaultLoan",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "walletAddress",
                "type": "address"
            }
        ],
        "name": "deposit",
        "outputs": [],
        "stateMutability": "payable",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "getMyActiveLoans",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "getThisSmartContractAddress",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "loanId",
                "type": "uint256"
            }
        ],
        "name": "lendLoan",
        "outputs": [],
        "stateMutability": "payable",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "owner",
        "outputs": [
            {
                "internalType": "address",
                "name": "",
                "type": "address"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "loanId",
                "type": "uint256"
            }
        ],
        "name": "remainingInterestBalance",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "loanId",
                "type": "uint256"
            }
        ],
        "name": "remainingLoanBalance",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "loanId",
                "type": "uint256"
            }
        ],
        "name": "remainingTimeForLoan",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "loanId",
                "type": "uint256"
            }
        ],
        "name": "repayCustAmountLoan",
        "outputs": [],
        "stateMutability": "payable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "loanId",
                "type": "uint256"
            }
        ],
        "name": "repayInstallment",
        "outputs": [],
        "stateMutability": "payable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "loanId",
                "type": "uint256"
            }
        ],
        "name": "repayInterest",
        "outputs": [],
        "stateMutability": "payable",
        "type": "function"
    }
];
const contractAddress = '0x898ae2b5209F99d405804146F9fbf882716247D0';

async function init() {
    const getAddressButton = document.getElementById('getAddressButton');
    const scAddress = document.getElementById('scAddress');

    //For Create Loan
    const createLoanButton = document.getElementById('createLoanButton');
    createLoanButton.addEventListener('click', createLoan);

    //For Get MyActiveLoans
    const getMyActiveLoansButton = document.getElementById('getMyActiveLoansButton');
    const myActiveLoans = document.getElementById('myActiveLoans');
    getMyActiveLoansButton.addEventListener('click', () => getMyActiveLoans(myActiveLoans));


    //For LendLoan
    const lendLoanButton = document.getElementById('lendLoanButton');
    const loanIdInput = document.getElementById('loanId');
    const lendLoanResult = document.getElementById('lendLoanResult');
    lendLoanButton.addEventListener('click', async () => {
        const loanId = parseInt(loanIdInput.value);
        if (!isNaN(loanId)) {
            await lendLoan(loanId);
            lendLoanResult.innerHTML = 'Loan lended successfully!';
        } else {
            lendLoanResult.innerHTML = 'Invalid loan ID. Please enter a valid loan ID.';
        }
    });



    if (window.ethereum) {
        web3 = new Web3(window.ethereum);
        try {
            await window.ethereum.enable();
        } catch (error) {
            console.error("User denied account access");
        }
    } else if (window.web3) {
        web3 = new Web3(window.web3.currentProvider);
    } else {
        console.error("No web3 provider detected");
        return;
    }

    contractInstance = new web3.eth.Contract(contractABI, contractAddress);

    getAddressButton.addEventListener('click', getSmartContractAddress);

    listenForEvents();

    async function getSmartContractAddress() {
        const accounts = await web3.eth.getAccounts();
        scAddress.innerHTML = 'getting message.';
        
        // Reference the "getThisSmartContractAddress" function from smart contract
        const getThisSmartContractAddressFunction = contractInstance.methods.getThisSmartContractAddress();

        // Call the "getThisSmartContractAddress" function
        try {
            const receipt = await getThisSmartContractAddressFunction.send({ from: accounts[0] });
            console.log('Transaction receipt:', receipt);

            // Check if the event is present in the transaction receipt
            if (receipt.events.thisSCAddress) {
                scAddress.innerHTML = `Smart Contract Address: ${receipt.events.thisSCAddress.returnValues[1]}`;
            } else {
                scAddress.innerHTML = 'Error: Event not found in the transaction receipt.';
            }
        } catch (error) {
            console.error(error);
            scAddress.innerHTML = 'Error: Failed to get smart contract address.';
        }
    }
}

function listenForEvents() {
    contractInstance.events.thisSCAddress()
        .on('data', (event) => {
            console.log('Event received:', event);
            document.getElementById('scAddress').innerHTML = `Smart Contract Address: ${event.returnValues[1]}`;
        })
        .on('error', console.error);
}

async function createLoan() {
    const accounts = await web3.eth.getAccounts();
    const lendeeAddress = document.getElementById('lendeeAddress').value;
    const loanAmount = document.getElementById('loanAmount').value;
    const interestRate = document.getElementById('interestRate').value;
    const loanPeriod = document.getElementById('loanPeriod').value;
    const loanInstallmentPeriod = document.getElementById('loanInstallmentPeriod').value;

    try {
        const receipt = await contractInstance.methods.createLoan(
            lendeeAddress,
            accounts[0],
            web3.utils.toWei(loanAmount, 'ether'),
            interestRate,
            loanPeriod,
            loanInstallmentPeriod
        ).send({ from: accounts[0] });

        console.log('Transaction receipt:', receipt);
    } catch (error) {
        console.error(error);
    }
}


async function getMyActiveLoans(outputElement) {
    const accounts = await web3.eth.getAccounts();

    // Reference the "getMyActiveLoans" function from smart contract
    const getMyActiveLoansFunction = contractInstance.methods.getMyActiveLoans();

    // Call the "getMyActiveLoans" function
    try {
        const gasEstimate = await getMyActiveLoansFunction.estimateGas({ from: accounts[0] });
        const receipt = await getMyActiveLoansFunction.send({ from: accounts[0], gas: gasEstimate });
        console.log('Transaction receipt:', receipt);

        // Check if the event is present in the transaction receipt
        if (receipt.events.myActiveLoans) {
            const event = receipt.events.myActiveLoans.returnValues;
            outputElement.innerHTML = `
                <p>${event[0]}</p>
                <p>Lendee Loan IDs: ${event[1].toString()}</p>
                <p>Lender Loan IDs: ${event[2].toString()}</p>
            `;
        } else {
            outputElement.innerHTML = 'Error: Event not found in the transaction receipt.';
        }
    } catch (error) {
        console.error(error);
        outputElement.innerHTML = 'Error: Failed to get active loans.';
    }
}

async function lendLoan(loanId) {
    const accounts = await web3.eth.getAccounts();

    // Reference the "lendLoan" function from smart contract
    const lendLoanFunction = contractInstance.methods.lendLoan(loanId);

    // Call the "lendLoan" function
    try {
        const gasEstimate = await lendLoanFunction.estimateGas({ from: accounts[0], value: web3.utils.toWei('100', 'ether') });
        const receipt = await lendLoanFunction.send({ from: accounts[0], gas: gasEstimate, value: web3.utils.toWei('100', 'ether') });
        console.log('Transaction receipt:', receipt);

        // Check if the event is present in the transaction receipt
        if (receipt.events.Lended) {
            console.log('Loan Lended:', receipt.events.Lended.returnValues);
        } else {
            console.log('Error: Event not found in the transaction receipt.');
        }
    } catch (error) {
        console.error(error);
        console.log('Error: Failed to lend loan.');
    }
}


init();
