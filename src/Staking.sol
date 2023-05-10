// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Staking {
    struct Investment {
        address payable investor;
        uint256 amount;
        uint256 lastPayout;
    }

    mapping(address => Investment) public investments;
    address payable[] public investors;

    function invest(address payable _investor, uint256 _amount) public {
        investments[_investor].investor = _investor;
        investments[_investor].amount = _amount;
        investments[_investor].lastPayout = block.timestamp;
        investors.push(_investor);
    }

    function calculatePayout(uint256 _amount, uint256 duration) internal pure returns (uint256) {
        return _amount / 1000;
    }

    function getUserBalance(address _owner) external view returns (uint256) {
        return address(_owner).balance;
    }

    function payout() public {
        for (uint256 i = 0; i < investors.length; i++) {
            address payable investor = investors[i];
            Investment storage investment = investments[investor];
            uint256 duration = block.timestamp - investment.lastPayout;
            uint256 payoutAmount = calculatePayout(investment.amount, duration);
            investor.transfer(payoutAmount);
            investment.lastPayout = block.timestamp;
        }
    }
}
