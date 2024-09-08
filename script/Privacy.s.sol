// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {Privacy} from "../src/Privacy.sol";

contract PrivacyScript is Script {
    function run() public {
        Privacy privacy = Privacy(0xb28122989a9D47ddeAe19552B149f675186387a2);
        bytes32 data2 = 0x3136b39c831718cf5c66c320860e00ca9a6038e462ac6f2680d3c2ece289f69f;

        vm.startBroadcast();
        privacy.unlock(bytes16(data2));
        console.log("privacy lock %d", privacy.locked());
        vm.stopBroadcast();
    }
}