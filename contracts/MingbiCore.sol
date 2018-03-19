pragma solidity ^0.4.18;

import "./MingbiAction.sol";

contract MingbiCore is MingbiAction {
    function MingbiCore() public {
        ownerAddress = msg.sender;
        currentPrice = 0.1 ether;
        factor = 0.1 ether;
    }
}
