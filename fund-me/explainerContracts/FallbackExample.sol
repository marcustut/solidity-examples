// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FallbackExample {
    uint256 public result;

    // A special function that will be triggered every time the contract receive ETH
    receive() external payable {
        result = 1;
    }

    // A special function that will be triggered every time if user's calldata is invalid
    fallback() external payable {
        result = 2;
    }
}

// Explainer from: https://solidity-by-example.org/fallback/
// Ether is sent to contract
//      is msg.data empty?
//          /   \
//         yes  no
//         /     \
//    receive()?  fallback()
//     /   \
//   yes   no
//  /        \
//receive()  fallback()
