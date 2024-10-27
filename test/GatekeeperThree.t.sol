// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

import "../src/GatekeeperThree.sol";

contract GatekeeperThreeTest is Test {
    function testGatekeeperThree() public {
        GatekeeperThree gatekeeper = new GatekeeperThree();
        GatekeeperThreeAttack attack = new GatekeeperThreeAttack(gatekeeper);

        address player = makeAddr("player");
        vm.deal(player, 1 ether);
        vm.warp(1730014716);

        vm.startPrank(player, player);

        address(attack).call{value: 0.0011 ether}(abi.encodeWithSignature("attack()"));

        console.log("player %s, entrant %s", player, gatekeeper.entrant());
        assert(gatekeeper.entrant() == player);

        vm.stopPrank();
    }
}