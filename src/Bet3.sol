// SPDX-License-Identifier: GPL
pragma solidity ^0.8.0;

contract Bet3 {
    struct Bet {
        string title;
        string optionA;
        string optionB;
        uint betAmount;
        uint betEndTime; //seconds
        uint winningOptionDeadline;
        uint finalizationTime;
        address[] betters;
        mapping(address => string) placedBets;
        mapping(string => uint) validationVotes; // track the votes for the winner option
        bool finalized;
    }

    mapping(bytes32 => Bet) public bets; // use keccak256 to create betId

    function getBetters(bytes32 _betId) public view returns (address[] memory) {
        return bets[_betId].betters;
    }

    function createBet(
        string memory _title,
        string memory _optionA,
        string memory _optionB,
        uint _betAmount,
        uint _joinDuration,
        uint _finalizationDuration,
        uint _winningOptionTimeframe
    ) public returns (bytes32) {
        bytes32 betId = keccak256(
            abi.encodePacked(msg.sender, _title, block.timestamp)
        );
        Bet storage newBet = bets[betId];

        newBet.title = _title;
        newBet.optionA = _optionA;
        newBet.optionB = _optionB;
        newBet.betAmount = _betAmount;
        newBet.betEndTime = block.timestamp + _joinDuration;
        newBet.finalizationTime = block.timestamp + _finalizationDuration;
        newBet.winningOptionDeadline =
            block.timestamp +
            _finalizationDuration +
            _winningOptionTimeframe;

        return betId;
    }

    function distributeFundsIfNoConsensus(bytes32 _betId) external {
        require(
            block.timestamp > bets[_betId].winningOptionDeadline,
            "Winning option not decided yet"
        );

        // ensure that the bet has not been finalized already
        require(!bets[_betId].finalized, "Bet already finalized");

        // calculate the number of betters and the total pool
        uint numBetters = bets[_betId].betters.length;
        uint totalPool = bets[_betId].betAmount * numBetters;

        // distribute the pool equally among all betters
        for (uint i = 0; i < numBetters; i++) {
            payable(bets[_betId].betters[i]).transfer(totalPool / numBetters);
        }

        bets[_betId].finalized = true;
    }

    function placeBet(bytes32 _betId, string memory _option) external payable {
        require(
            bets[_betId].betEndTime > block.timestamp,
            "Betting time ended"
        );
        require(msg.value == bets[_betId].betAmount, "Incorrect bet amount");
        require(
            compare(_option, bets[_betId].optionA) ||
                compare(_option, bets[_betId].optionB),
            "Invalid option"
        );
        require(!bets[_betId].finalized, "Bet already finalized");
        require(
            compare(bets[_betId].placedBets[msg.sender], ""),
            "You already placed a bet"
        );

        bets[_betId].placedBets[msg.sender] = _option;
        bets[_betId].betters.push(msg.sender);
    }

    function finalizeBet(bytes32 _betId, string memory _winningOption) public {
        require(
            block.timestamp > bets[_betId].betEndTime &&
                block.timestamp < bets[_betId].finalizationTime,
            "Not in finalization time"
        );
        require(!bets[_betId].finalized, "Bet already finalized");
        require(
            compare(bets[_betId].placedBets[msg.sender], ""),
            "You didn't place a bet on this"
        );

        bets[_betId].validationVotes[_winningOption]++;
        if (
            bets[_betId].validationVotes[_winningOption] >
            bets[_betId].betters.length / 2
        ) {
            distributeFunds(_betId, _winningOption);
        }
    }

    function distributeFunds(
        bytes32 _betId,
        string memory _winningOption
    ) private {
        uint totalPool = bets[_betId].betAmount * bets[_betId].betters.length;
        address[] memory winners;

        // count the number of winners
        for (uint i = 0; i < bets[_betId].betters.length; i++) {
            if (
                compare(
                    bets[_betId].placedBets[bets[_betId].betters[i]],
                    _winningOption
                )
            ) {
                winners[0] = bets[_betId].betters[i];
            }
        }

        // distribute the pool among the winners
        uint winnerShare = totalPool / winners.length;
        for (uint i = 0; i < winners.length; i++) {
            payable(winners[i]).transfer(winnerShare);
        }

        bets[_betId].finalized = true;
    }

    function compare(
        string memory str1,
        string memory str2
    ) public pure returns (bool) {
        return
            keccak256(abi.encodePacked(str1)) ==
            keccak256(abi.encodePacked(str2));
    }
}
