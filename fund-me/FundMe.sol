// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 50 * 1e18; // 1 * 10 ** 18

    address[] public funders;
    mapping(address => uint256) public addressToAmountFounded;

    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        // Value sent must be at least 1 ETH
        require(
            msg.value.getConversionRate() >= MINIMUM_USD,
            "Didn't send enough!"
        );
        funders.push(msg.sender);
        addressToAmountFounded[msg.sender] = msg.value;
    }

    function withdraw() public onlyOwner {
        // reset all funder's amount founded to zero
        for (uint256 i = 0; i < funders.length; i++) {
            addressToAmountFounded[funders[i]] = 0;
        }

        // reset the array
        funders = new address[](0);

        // withdraw the funds, for a detailed comparison,
        // @see https://solidity-by-example.org/sending-ether
        // Opt1. transfer (2300 gas, throws error)
        // payable(msg.sender).transfer(address(this).balance);
        // Opt2. send (2300 gas, returns bool)
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");
        // Opt3. call (forward all gas or set gas, returns bool)
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner() {
        // check conditions
        // require(msg.sender == i_owner, "Sender is not owner!");
        if (msg.sender != i_owner) revert NotOwner();
        // _ execute the original function code
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}
