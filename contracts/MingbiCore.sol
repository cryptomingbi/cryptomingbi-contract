pragma solidity ^0.4.17;

import "./MingbiAction.sol";

contract MingbiCore is MingbiAction {
    function MingbiCore() public {
        ownerAddress = msg.sender;
    }
}
