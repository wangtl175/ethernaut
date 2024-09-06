// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {console} from "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {ReentranceAttack} from "../src/ReentranceAttack.sol";

contract ReentranceAttackScript is Script {
    function run() public {
        vm.startBroadcast();
        ReentranceAttack hacker = new ReentranceAttack();
        console.log("attack contract developed on %s", address(hacker));
        vm.stopBroadcast();
    }
}