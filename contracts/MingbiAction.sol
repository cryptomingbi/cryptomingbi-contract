pragma solidity ^0.4.21;

import "./MingbiOwnership.sol";

contract MingbiAction is MingbiOwnership {
    uint256 currentPrice;
    uint256 factor;

    function breed() payable external {
        if (msg.value < currentPrice) revert();
        currentPrice = currentPrice.add(factor);
        _createMingbi(msg.sender);
    }

    function burn(uint _coinId, string data) external onlyOwnerOf(_coinId){
        Mingbi storage mingbi = mingbies[_coinId];
        // Can't double burnt a mingbi
        if (mingbi.burner != address(0)) revert();
        burnt += 1;
        currentPrice = currentPrice.sub(factor);
        mingbi.data = data;
        mingbi.burner = msg.sender;
        _transfer(msg.sender, address(0), _coinId);
    }

    function changeFactor(uint256 f) external onlyOwner {
        factor = f;
    }

    function getPrice() external view returns(uint256) {
        return currentPrice;
    }
}
