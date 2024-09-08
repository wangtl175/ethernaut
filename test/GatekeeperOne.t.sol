// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {GatekeeperOne} from "../src/GatekeeperOne.sol";
import {GatekeeperOneAttack} from "../src/GatekeeperOneAttack.sol";

contract GatekeeperOneTest is Test {
    /*
    没有好的思路计算gas的消耗
    而且线下测试和线上提交时，消耗的gas不一样，attack.enter返回结果不一样
    */

    function testGatekeeperOne() public {
        address player = 0xaCab087f7f0977c31d68E8BAe117069a90Dc6574;
        bytes8 gateKey = 0x1122334400006574;

        console.log("%x %x", uint32(uint64(gateKey)), uint16(uint160(player)));

        GatekeeperOne gatekeeper = new GatekeeperOne();
        GatekeeperOneAttack attack = new GatekeeperOneAttack();

        vm.deal(player, 10 ether);
        vm.startPrank(player, player);  // 第一个参数设置msg.sender, 第二个参数设置tx.origin
        uint256 i = attack.enter(gatekeeper, gateKey);
        vm.stopPrank();

        console.log("entrant %s, i %d", gatekeeper.entrant(), i);
    }
}