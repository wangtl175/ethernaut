// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {TelephoneAttack} from "../src/TelephoneAttack.sol";

contract CoinFlipAttackScript is Script {
    function run() public {
        vm.startBroadcast();
        TelephoneAttack attack = new TelephoneAttack();

        console.log("develop contract on %s", address(attack));
        vm.stopBroadcast();
    }
}