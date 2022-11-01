// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import "./PriceConverter.sol";

contract FundMe{

    using PriceConverter for uint256;

    uint256 public minUsd = 5 * 1e18 ; // 1 * 10 ** 18; 
    
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable {
        require(getConversionRate(msg.value) >= minUsd, "Insufficient Ether to fund");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;  
    }

    function withdraw() public onlyOwner {
        for (uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        //reset the array
        funders = new address[](0);

        // // transfer
        // payable(msg.sender).transfer(address(this).balance);
        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");
        // call
        // (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        // require(callSuccess, "Call failed");
    }


}