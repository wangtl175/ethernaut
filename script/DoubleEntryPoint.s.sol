// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

import {IForta, DetectionBot} from "../src/DoubleEntryPoint.sol";

contract DoubleEntryPointScript is Script {
    function run() public {
        vm.startBroadcast();

        IForta forta = IForta(0xc373EA0DEa8Eec74b535cDAf5F42c2d0aA574f97);
        DetectionBot detectionBot = new DetectionBot(forta);
        forta.setDetectionBot(address(detectionBot));

        console.log("develop detection bot %s", address(detectionBot));

        vm.stopBroadcast();
    }
}