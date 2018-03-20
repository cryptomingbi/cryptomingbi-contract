pragma solidity ^0.4.21;

import "./MingbiAction.sol";

contract MingbiCore is MingbiAction {
    function MingbiCore() public {
        ownerAddress = msg.sender;
        currentPrice = 0.001 ether;
        factor = 0.1 ether;
    }
}
