// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


library PriceConverter {
    function getPrice() public view returns(uint256){
        //ABI
        // 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (,int256 price,,,)  = priceFeed.latestRoundData(); // this will give ETH in terms of usd //1600.0000000
        return uint256(price * 1e10); // 1**10 = 10000000000 //converting price to 18decimal point to match msg.value
      

    }

    function getVersion() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();

    }


    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountUsd;
    }
}
