// SPDX-License-Identifier: GPL
pragma solidity ^0.8.0;

contract Bet3 {
    struct Bet {
        string title;
        string optionA;
        string optionB;
        uint betEntry; // amount of money to enter the bet
        uint betEndTime; // amount of time to place a bet - in seconds
        address[] bettors; 
        uint finalizationTime; // time when the bet will be finalized - in seconds
        mapping(address => string) placedBets;
        mapping(string => uint) validationVotes; // track the votes for the winner option
        bool finalized;
    }

    event BetCreated(
        bytes32 indexed betId,
        string title,
        string optionA,
        string optionB,
        uint betEntry,
        uint betEndTime,
        uint finalizationTime
    );

    event BetPlaced(
        bytes32 indexed betId,
        address indexed bettor,
        string option
    );

    event BetFinalized(
        bytes32 indexed betId,
        string winningOption
    );

    mapping(bytes32 => Bet) public bets; // use keccak256 to create betId

    uint public constant autoFinalizePeriod = 24 hours;

    function getBettors(bytes32 _betId) public view returns (address[] memory) {
        return bets[_betId].bettors;
    }

    function getTotalPrize(bytes32 _betId) public view returns (uint) {
        return bets[_betId].bettors.length * bets[_betId].betEntry;
    }

    function createBet(
        string memory _title,
        string memory _optionA,
        string memory _optionB,
        uint _betEntry,
        uint _joinDuration
    ) public returns (bytes32) {
        bytes32 betId = keccak256(
            abi.encodePacked(msg.sender, _title, block.timestamp)
        );
        Bet storage newBet = bets[betId];

        newBet.title = _title;
        newBet.optionA = _optionA;
        newBet.optionB = _optionB;
        newBet.betEntry = _betEntry;
        newBet.betEndTime = block.timestamp + _joinDuration;
        newBet.finalizationTime =
            block.timestamp +
            _joinDuration +
            autoFinalizePeriod;

        emit BetCreated(
            betId,
            _title,
            _optionA,
            _optionB,
            _betEntry,
            newBet.betEndTime,
            newBet.finalizationTime
        );

        return betId;
    }

    function distributeFundsIfNoConsensus(bytes32 _betId) external {
        require(
            block.timestamp > bets[_betId].finalizationTime,
            "Finalization time not reached"
        );

        // ensure that the bet has not been finalized already
        require(!bets[_betId].finalized, "Bet already finalized");

        // distribute the pool equally among all bettors
        for (uint i = 0; i < bets[_betId].bettors.length; i++) {
            payable(bets[_betId].bettors[i]).transfer(bets[_betId].betEntry);
        }

        setAsFinalized(_betId, "");
    }

    function placeBet(bytes32 _betId, string memory _option) external payable {
        require(
            bets[_betId].betEndTime > block.timestamp,
            "Betting time ended"
        );
        require(msg.value == bets[_betId].betEntry, "Incorrect bet amount");
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
        bets[_betId].bettors.push(msg.sender);

        emit BetPlaced(_betId, msg.sender, _option);
    }

    function finalizeBet(
        bytes32 _betId,
        string memory _winningOption
    ) external {
        require(
            block.timestamp > bets[_betId].betEndTime &&
                block.timestamp < bets[_betId].finalizationTime,
            "Not in finalization time"
        );
        require(!bets[_betId].finalized, "Bet already finalized");
        require(
            !compare(bets[_betId].placedBets[msg.sender], ""),
            "You didn't place a bet on this"
        );

        bets[_betId].validationVotes[_winningOption]++;
        if (
            bets[_betId].validationVotes[_winningOption] >
            (bets[_betId].bettors.length / 2)
        ) {
            distributeFunds(_betId, _winningOption);
        }
    }

    function distributeFunds(
        bytes32 _betId,
        string memory _winningOption
    ) private {
        address[] memory winners = new address[](bets[_betId].bettors.length);
        uint winnersCount = 0;

        // count the number of winners
        for (uint i = 0; i < bets[_betId].bettors.length; i++) {
            if (
                compare(
                    bets[_betId].placedBets[bets[_betId].bettors[i]],
                    _winningOption
                )
            ) {
                winners[i] = bets[_betId].bettors[i];
                winnersCount++;
            }
        }

        // distribute the prize among the winners
        uint winnerShare = getTotalPrize(_betId) / winnersCount;
        for (uint i = 0; i < winners.length; i++) {
            if (winners[i] != address(0)) {
                payable(winners[i]).transfer(winnerShare);
            }
        }

        setAsFinalized(_betId, _winningOption);
    }

    function setAsFinalized(bytes32 _betId, string memory _winningOption) private {
        bets[_betId].finalized = true;

        emit BetFinalized(_betId, _winningOption);
    }

    function compare(
        string memory str1,
        string memory str2
    ) internal pure returns (bool) {
        return
            keccak256(abi.encodePacked(str1)) ==
            keccak256(abi.encodePacked(str2));
    }
}
