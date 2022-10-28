// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.8;

//a contract is like a class 
contract simpleStorage{
    uint256 public favoriteNumber; // this is also a view function
    
    function store(uint256 _favoriteNumber) public{
        favoriteNumber = _favoriteNumber;
        favoriteNumber = favoriteNumber + 100;
        retrieve();
    }

    //view, pure, can't update  the state of the blockchain
    function retrieve () public view returns (uint256){
        return favoriteNumber;
    }

    function add() public pure returns(uint256){
        return (1+1);
    }
}

// 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
// address public myAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;  example of an address data type in Solidity.