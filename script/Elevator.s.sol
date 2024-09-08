// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {Elevator} from "../src/Elevator.sol";
import {HackerBuilding} from "../src/HackerBuilding.sol";

contract ElevatorScript is Script {
    function run(Elevator elevator, HackerBuilding building) public {
        vm.startBroadcast();
        building.goTo(elevator, 15);
        console.log("elevator floor %d, top %d", elevator.floor(), elevator.top());
        vm.stopBroadcast();
    }

    function developHackerBuilding() public returns (HackerBuilding) {
        vm.startBroadcast();
        HackerBuilding building = new HackerBuilding();
        vm.stopBroadcast();

        console.log("HackerBuilding developed on %s", address(building));

        return building;
    }

    function developAndRun(address elevatorAddress) public {
        HackerBuilding building = developHackerBuilding();
        Elevator elevator = Elevator(elevatorAddress);
        run(elevator, building);
    }
}