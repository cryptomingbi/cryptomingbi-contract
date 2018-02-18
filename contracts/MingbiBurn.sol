pragma solidity ^0.4.17;

contract MingbiBurn {
  function burn() public {
    selfdestruct(address(this));
  }
}
