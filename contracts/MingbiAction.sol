pragma solidity ^0.4.18;

import "./MingbiOwnership.sol";

contract MingbiAction is MingbiOwnership {
    uint currentPrice;
    uint factor;

    function breed() payable external {
        if (msg.value < currentPrice) revert();
        currentPrice = currentPrice.add(factor);
        _createMingbi(msg.sender);
    }

    function burn(uint _coinId, string data) external onlyOwnerOf(_coinId){
        Mingbi storage mingbi = mingbies[_coinId];
        // Can't double burnt a mingbi
        if (mingbi.burner == 0x0) revert();
        burnt += 1;
        currentPrice = currentPrice.sub(factor);
        mingbi.data = data;
        mingbi.burner = msg.sender;
        _transfer(msg.sender, 0x0, _coinId);
    }

    function changeFactor(uint f) external onlyOwner {
        factor = f;
    }
}
