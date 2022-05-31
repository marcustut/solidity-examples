// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./SimpleStorage.sol";

/// @title An extension from SimpleStorage contract
/// @author Marcus Lee
contract ExtraStorage is SimpleStorage {
    /// @notice Store a favorite number to the ExtraStorage contract
    /// @dev override the `store` function from SimpleStorage
    /// @param _favoriteNumber the number to store as favorite number
    function store(uint256 _favoriteNumber) public override {
        favoriteNumber = _favoriteNumber + 5;
    }
}
