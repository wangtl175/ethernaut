// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {GatekeeperTwo} from "../src/GatekeeperTwo.sol";
import {GatekeeperTwoAttack} from "../src/GatekeeperTwoAttack.sol";

/*
assembly {
    x := extcodesize(caller())
}

当调用者是非合约地址，或者实在合约的构造函数中调用时，x==0
https://ethereum.stackexchange.com/questions/15641/how-does-a-contract-find-out-if-another-address-is-a-contract
*/

contract GatekeeperTwoTest is Test {
    function testGatekeeperTwo() public {
        address player = makeAddr("player");

        vm.startPrank(player, player);
        GatekeeperTwo gatekeeper = new GatekeeperTwo();
        GatekeeperTwoAttack attack = new GatekeeperTwoAttack(gatekeeper);
        vm.stopPrank();

        console.log(gatekeeper.entrant());
        assert(gatekeeper.entrant() == player);
    }
}