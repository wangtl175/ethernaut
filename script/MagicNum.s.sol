// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

import {MagicNum} from "../src/MagicNum.sol";

contract MagicNumScript is Script {
    function run() public {
        vm.startBroadcast();

        MagicNum magicNum = MagicNum(0xf056eeD7F934EA6C9e8B9Db0d341854b3cD16Dc7);
        magicNum.setSolver(0x74ADFF533eC399BfFd0e5b021B3fc9155cAE0664);

        console.log("solver %s", magicNum.solver());

        vm.stopBroadcast();
    }
}