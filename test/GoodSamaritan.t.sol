// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

import "../src/GoodSamaritan.sol";

contract GoodSamaritanTest is Test {
    function testGoodSamaritan() public {
        GoodSamaritan goodSamaritan = new GoodSamaritan();
        GoodSamaritanAttack attack = new GoodSamaritanAttack();

        attack.requestDonation(goodSamaritan);

        console.log(goodSamaritan.coin().balances(address(goodSamaritan.wallet())));
        assert(0 == goodSamaritan.coin().balances(address(goodSamaritan.wallet())));
    }
}