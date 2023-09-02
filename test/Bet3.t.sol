// SPDX-License-Identifier: GPL
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";
import {Bet3} from "../src/Bet3.sol";

interface CheatCodes {
   function addr(uint256) external returns (address);
}

contract Bet3Test is Test {
    Bet3 public bet3;
    address public owner;
    address public better1;
    address public better2;
    uint eth = 10**18;


    CheatCodes cheats = CheatCodes(HEVM_ADDRESS);

    function setUp() public {
        bet3 = new Bet3();

        owner = address(this);
        better1 = cheats.addr(1);
        vm.deal(better1, 20 ether);
        better2 = cheats.addr(2);
        vm.deal(better2, 20 ether);
    }

    function test_createBet() public {
        string memory _title = "Who will win the match?";
        bytes32 id = bet3.createBet(
            _title,
            "France",
            "Germany",
            1000,
            60,
            180,
            360
        );

        (string memory expectedTitle,,,,,,,) = bet3.bets(id);

        assertEq(expectedTitle, _title);
    }

    function test_placeBet() public {
        bytes32 id = bet3.createBet(
            "Who will win the match?",
            "France",
            "Germany",
            10 * eth,
            60,
            180,
            360
        );

        bet3.placeBet{value: 10 ether}(id, "France");
        vm.prank(better1);
        bet3.placeBet{value: 10 ether}(id, "Germany");
        vm.prank(better2);
        bet3.placeBet{value: 10 ether}(id, "Germany");

        address[] memory betters = bet3.getBetters(id);

        assertEq(betters.length, 3);
    }

    //TODO: bet time ended, incorrect bet amount, invalid option, already betted
}
