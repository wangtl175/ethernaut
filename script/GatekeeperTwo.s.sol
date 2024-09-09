// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {GatekeeperTwo} from "../src/GatekeeperTwo.sol";
import {GatekeeperTwoAttack} from "../src/GatekeeperTwoAttack.sol";

contract GatekeeperTwoScript is Script {
    function run() public {
        vm.startBroadcast();
        GatekeeperTwo gatekeeper = GatekeeperTwo(0x8320bA1c2689E3d6Db59BE0aBB4035F3A817f7f4);
        GatekeeperTwoAttack attack = new GatekeeperTwoAttack(gatekeeper);
        vm.stopBroadcast();

        console.log("attack develop on %s, entrant %s", address(attack), gatekeeper.entrant());
    }
}