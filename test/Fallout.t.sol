pragma solidity ^0.6.0;

pragma experimental ABIEncoderV2;

import {Test} from "forge-std/Test.sol";
import {Fallout} from "../src/Fallout.sol";

contract FalloutTest is Test {
    Fallout public fallout;
    address public player;

    function setUp() public {
        player = makeAddr("player");

        vm.deal(player, 1 ether);

        fallout = new Fallout();
    }

    function testFallout() public {
        vm.prank(player);
        fallout.Fal1out();

        assert(fallout.owner() == player);
//        assert(fallout.owner(), player);
    }
}