pragma solidity ^0.4.17;

contract MingbiBase {

  event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
  struct Mingbi {
    // The timestamp from the block when this mingbi came into existence.
    uint64 birthTime;
    string data;
  }

  // An array containing all existing mingbi
  Mingbi[] mingbies;

  function _transfer(address _from, address _to, uint256 _tokenId) internal {
    Transfer(_from, _to, _tokenId);
  }

  function _createMingbi(address _owner) internal returns (uint) {
    Mingbi memory _mingbi = Mingbi({
      birthTime: uint64(now),
      data: ""
    });

    uint256 newMingbiId = mingbies.push(_mingbi);
    _transfer(0, _owner, newMingbiId);
    return newMingbiId;
  }
}
