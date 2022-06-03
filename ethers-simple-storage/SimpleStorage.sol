// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

/// @title A contract that stores data which acts as a simple storage on the blockchain
/// @author Marcus Lee
contract SimpleStorage {
    // This get initialized to zero
    uint256 public favoriteNumber;

    // A structure to describe a Person
    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    // An array of Person
    Person[] public people;

    // A hashmap that maps a person's name to his/her favorite number.
    mapping(string => uint256) public nameToFavoriteNumber;

    /// @notice Store a favorite number on the SimpleStorage contract
    /// @dev stores the number in the state variable `favoriteNumber`
    /// @param _favoriteNumber a positive number
    function store(uint256 _favoriteNumber) public virtual {
        favoriteNumber = _favoriteNumber;
    }

    /// @notice Retrieve the favorite number from the SimpleStorage contract
    /// @dev get the value of state variable `favoriteNumber`
    /// @return favoriteNumber the state variable `favoriteNumber`
    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }

    /// @notice Add a given person to the SimpleStorage contract
    /// @dev construct a Person and append it to the state variable `people`
    /// @param _name name of a given person
    /// @param _favoriteNumber favorite number of a given person
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        people.push(Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
