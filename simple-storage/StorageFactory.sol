// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./SimpleStorage.sol";

/// @title A factory for the SimpleStorage contract
/// @author Marcus Lee
contract StorageFactory {
    // An array of SimpleStorage contract
    SimpleStorage[] public simpleStorages;

    /// @notice Create a new SimpleStorage contract
    /// @dev instantiate a new SimpleStorage contract and append it
    /// to the state variable `simpleStorages`
    function createSimpleStorageContract() public {
        simpleStorages.push(new SimpleStorage());
    }

    /// @notice Store a favorite number for a specified SimpleStorage contract
    /// @dev index into state variable `simpleStorages` and store the given favorite number
    /// @param _simpleStorageIndex index of the SimpleStorage contract
    /// @param _simpleStorageNumber favorite number to store
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber)
        public
    {
        simpleStorages[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    /// @notice Get the favorite number for a specified SimpleStorage contract
    /// @dev index into state variable `simpleStorages` and retrieve its favorite number
    /// @param _simpleStorageIndex index of the SimpleStorage contract
    /// @return favoriteNumber the favorite number retrieved from the contract
    function sfGet(uint256 _simpleStorageIndex) public view returns (uint256) {
        return simpleStorages[_simpleStorageIndex].retrieve();
    }
}
