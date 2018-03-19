pragma solidity ^0.4.18;

import "./MingbiAccessControl.sol";

contract MingbiBase is MingbiAccessControl {

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    struct Mingbi {
        // The timestamp from the block when this mingbi came into existence.
        address burner;
        string data;
    }

    // An array containing all existing mingbi
    Mingbi[] mingbies;
    mapping (uint => address) public mingbiToOwner;
    mapping (address => uint) ownerMingbiCount;

    function _transfer(address _from, address _to, uint256 _tokenId) internal {
        emit Transfer(_from, _to, _tokenId);
    }

    function _createMingbi(address _owner) internal returns (uint) {
        Mingbi memory _mingbi = Mingbi({
            data: "",
            burner: 0x0
        });

        uint256 newMingbiId = mingbies.push(_mingbi);
        _transfer(0, _owner, newMingbiId);
        return newMingbiId;
    }
}
