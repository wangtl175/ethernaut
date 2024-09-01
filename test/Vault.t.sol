// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {Vault} from "../src/Vault.sol";

contract VaultTest is Test {
    Vault public vault;

    function setUp() public {
        vault = Vault(0x88A51342C02FF7d27FA31C94497F752dFB693DDf);
    }

    function testVault() public {
        /*
        虽然数据是private，但链上的状态都是公开的

        创建实例的交易https://sepolia.etherscan.io/tx/0x9aa9f09a53fa632706cd303324410e87150a1953deef9e2d6d338aa60830ab1f/advanced#statechange

        查看0x88A51342C02FF7d27FA31C94497F752dFB693DDf的状态变化，即可知道password为0x412076657279207374726f6e67207365637265742070617373776f7264203a29

        */

        console.log("locked %d", vault.locked());

        vault.unlock(bytes32(0x412076657279207374726f6e67207365637265742070617373776f7264203a29));

        console.log("locked %d", vault.locked());

        assert(vault.locked() == false);
    }
}