// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {KingAttack} from "../src/KingAttack.sol";

contract KingAttackScript is Script {
    function run() public {
        vm.startBroadcast();
        KingAttack attack = new KingAttack();
        vm.stopBroadcast();
        console.log("develop attack contract on %s", address(attack));
    }
}