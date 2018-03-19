pragma solidity ^0.4.18;

import "./MingbiOwnership.sol";

contract MingbiAction is MingbiOwnership {
    uint currentPrice;
    uint factor;

    function breed() payable external {
        if (msg.value >= currentPrice) {
            currentPrice = currentPrice + factor;
            _createMingbi(msg.sender);
        } else {
            revert();
        }
    }

    function burn(uint _coinId, string data) external onlyOwnerOf(_coinId){
        Mingbi storage mingbi = mingbies[_coinId];
        currentPrice = currentPrice - factor;
        mingbi.data = data;
        mingbi.burner = msg.sender;
    }

    function changeFactor(uint f) external onlyOwner {
        factor = f;
    }
}
