// SPDX-License-Identifier: GPL
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {Bet3} from "../src/Bet3.sol";

interface CheatCodes {
   function addr(uint256) external returns (address);
}

contract Bet3Test is Test {
    Bet3 public bet3;
    address public owner;
    address public bettor1;
    address public bettor2;
    uint eth = 10**18;
    uint blockNum = 1680616584;


    CheatCodes cheats = CheatCodes(HEVM_ADDRESS);

    function setUp() public {
        bet3 = new Bet3();

        owner = address(this);
        bettor1 = cheats.addr(1);
        vm.deal(bettor1, 20 ether);
        bettor2 = cheats.addr(2);
        vm.deal(bettor2, 20 ether);
    }

    modifier startAt() {
        vm.warp(blockNum);
        _;
    }

    function test_createBet() public {
        string memory _title = "Who will win the match?";
        bytes32 id = bet3.createBet(
            _title,
            "France",
            "Germany",
            1000,
            60
        );

        (string memory expectedTitle,,,,,,) = bet3.bets(id);

        assertEq(expectedTitle, _title);
    }

    function test_placeBet() public {
        bytes32 id = bet3.createBet(
            "Who will win the match?",
            "France",
            "Germany",
            10 * eth,
            60
        );

        bet3.placeBet{value: 10 ether}(id, "France");
        vm.prank(bettor1);
        bet3.placeBet{value: 10 ether}(id, "Germany");
        vm.prank(bettor2);
        bet3.placeBet{value: 10 ether}(id, "Germany");

        address[] memory betters = bet3.getBettors(id);

        assertEq(betters.length, 3);
    }

    function test_placeBetIncorrectBetEntry() public {
        bytes32 id = bet3.createBet(
            "Who will win the match?",
            "France",
            "Germany",
            10 * eth,
            60
        );

        vm.expectRevert("Incorrect bet amount");
        bet3.placeBet{value: 9 ether}(id, "France");
    }

    function test_placeBetInvalidOption() public {
        bytes32 id = bet3.createBet(
            "Who will win the match?",
            "France",
            "Germany",
            10 * eth,
            60
        );

        vm.expectRevert("Invalid option");
        bet3.placeBet{value: 10 ether}(id, "Spain");
    }

    function test_placeBetAlreadyBetted() public {
        bytes32 id = bet3.createBet(
            "Who will win the match?",
            "France",
            "Germany",
            10 * eth,
            60
        );

        bet3.placeBet{value: 10 ether}(id, "France");
        vm.expectRevert("You already placed a bet");
        bet3.placeBet{value: 10 ether}(id, "France");
    }

    function test_placeBetJoinEnded() public startAt {
        bytes32 id = bet3.createBet(
            "Who will win the match?",
            "France",
            "Germany",
            10 * eth,
            60
        );

        bet3.placeBet{value: 10 ether}(id, "France");
        vm.warp(blockNum + 61 seconds);
        vm.prank(bettor1);
        vm.expectRevert("Betting time ended");
        bet3.placeBet{value: 10 ether}(id, "Germany");
    }

    function test_distibuteFunds() public startAt {
        bytes32 id = bet3.createBet(
            "Who will win the match?",
            "France",
            "Germany",
            10 * eth,
            60
        );

        bet3.placeBet{value: 10 ether}(id, "France");
        vm.prank(bettor1);
        bet3.placeBet{value: 10 ether}(id, "France");
        vm.prank(bettor2);
        bet3.placeBet{value: 10 ether}(id, "Germany");

        uint oldBalance = address(bettor2).balance;

        vm.warp(blockNum + 61 seconds);

        vm.prank(bettor1);
        bet3.finalizeBet(id, "Germany");
        vm.prank(bettor2);
        bet3.finalizeBet(id, "Germany");

        (,,,,,,bool finalized) = bet3.bets(id);

        assertEq(address(bettor2).balance, oldBalance + bet3.getTotalPrize(id));
        assertTrue(finalized);
    }

    function test_getTotalPrize() public {
        bytes32 id = bet3.createBet(
            "Who will win the match?",
            "France",
            "Germany",
            10 * eth,
            60
        );

        bet3.placeBet{value: 10 ether}(id, "France");
        vm.prank(bettor1);
        bet3.placeBet{value: 10 ether}(id, "France");
        vm.prank(bettor2);
        bet3.placeBet{value: 10 ether}(id, "Germany");

        uint totalPrize = bet3.getTotalPrize(id);

        assertEq(totalPrize, 30 ether);
    }

    function test_distributeFundsIfNoConsensus() public startAt() {
        bytes32 id = bet3.createBet(
            "Who will win the match?",
            "France",
            "Germany",
            10 * eth,
            60
        );

        uint bettor1OldBalance = address(bettor1).balance;
        uint bettor2OldBalance = address(bettor2).balance;

        bet3.placeBet{value: 10 ether}(id, "France");
        vm.prank(bettor1);
        bet3.placeBet{value: 10 ether}(id, "France");
        vm.prank(bettor2);
        bet3.placeBet{value: 10 ether}(id, "Germany");
        vm.warp(blockNum + 61 seconds + 24 hours);
        bet3.distributeFundsIfNoConsensus(id);

        (,,,,,,bool finalized) = bet3.bets(id);

        assertEq(address(bettor1).balance, bettor1OldBalance);
        assertEq(address(bettor2).balance, bettor2OldBalance);
        assertTrue(finalized);
    }

    function test_distributeFundsIfNoConsensusErrror() public startAt() {
        bytes32 id = bet3.createBet(
            "Who will win the match?",
            "France",
            "Germany",
            10 * eth,
            60
        );

        vm.expectRevert("Finalization time not reached");
        bet3.distributeFundsIfNoConsensus(id);
    }
}
