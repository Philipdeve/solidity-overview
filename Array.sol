// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.8;

contract simpleStorage{
    uint256 favoriteNumber; // this is also a view function

    //mapping is like a dictionary i.e is a data structure where a key is mapped to a value
    mapping(string => uint256) public nameToFavNumber;

    // People public person = People({favoriteNumber: 22, name: "Philip"}); for single list 
    struct People{
        uint256 favoriteNumber;
        string name;
    }

    People[] public people;
    
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        People memory newPerson = People(_favoriteNumber, _name);
        people.push(newPerson);
        nameToFavNumber[_name] = _favoriteNumber;
    }
  
}
