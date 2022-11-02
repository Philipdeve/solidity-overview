// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MIN_USD = 5 * 1e18; // 1 * 10 ** 18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(
            msg.value.getConversionRate() >= MIN_USD,
            "Insufficient Ether to fund"
        );
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        //reset the array
        funders = new address[](0);
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }(""); // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        require(callSuccess, "Call failed");
    }

    // Modifier to check that the caller is the owner of
    // the contract.
    modifier onlyOwner() {
        require(msg.sender == i_owner, "Not owner");
        // Underscore is a special character only used inside
        // a function modifier and it tells Solidity to
        // execute the rest of the code.
        _;
    }

    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }
}
