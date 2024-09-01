// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {Vault} from "../src/Vault.sol";

contract VaultScript is Script {
    function run() public {
        vm.startBroadcast();
        Vault vault = Vault(0x88A51342C02FF7d27FA31C94497F752dFB693DDf);
        vault.unlock(bytes32(0x412076657279207374726f6e67207365637265742070617373776f7264203a29));
        console.log("locked %d", vault.locked());
        vm.stopBroadcast();
    }
}