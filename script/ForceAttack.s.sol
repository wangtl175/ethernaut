// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {ForceAttack} from "../src/ForceAttack.sol";

contract ForceScript is Script {
    function run() public {
        vm.startBroadcast();
        ForceAttack attack = new ForceAttack();

        console.log("ForceAttack developed on %s", address(attack));
        vm.stopBroadcast();
    }
}