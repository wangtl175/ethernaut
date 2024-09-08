// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import {HackerBuilding} from "../src/HackerBuilding.sol";
import {Elevator} from "../src/Elevator.sol";

contract ElevatorTest is Test {
    function testElevator() public {
        Elevator elevator = new Elevator();
        HackerBuilding building = new HackerBuilding();

        console.log("elevator floor %d, top %d", elevator.floor(), elevator.top());

        building.goTo(elevator, 15);

        console.log("elevator floor %d, top %d", elevator.floor(), elevator.top());
    }
}