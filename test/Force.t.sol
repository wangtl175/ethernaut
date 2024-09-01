// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {Force} from "../src/Force.sol";
import {ForceAttack} from "../src/ForceAttack.sol";

contract ForceTest is Test {
    Force public force;
    ForceAttack public attack;

    function setUp() public {
        force = new Force();
        attack = new ForceAttack();
    }

    function testForce() public {
        address player = makeAddr("player");
        vm.deal(player, 1 ether);

        vm.prank(player);
        attack.forceSend{value: 1 wei}(address(force));

        console.log("force balance %d", address(force).balance);
        assert(address(force).balance > 0);
    }
}