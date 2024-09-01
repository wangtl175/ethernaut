// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {ForceAttack} from "../src/ForceAttack.sol";

contract ForceScript is Script {
    ForceAttack public attack;

    function setUp() public {
        attack = ForceAttack(0x9d236D3E2c3105D73A303A95c4937511642EaE8d);
    }

    function run() public {
        address force = 0xED7a0A55c24FA9281f47B8682342597436e11E2D;
        vm.startBroadcast();

        attack.forceSend{value: 1 wei}(force);

        console.log("balance %d", force.balance);

        vm.stopBroadcast();
    }
}