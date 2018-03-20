pragma solidity ^0.4.18;

import "./MingbiAccessControl.sol";
import "./SafeMath.sol";

contract MingbiBase is MingbiAccessControl {
    using SafeMath for uint256;

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    struct Mingbi {
        // The timestamp from the block when this mingbi came into existence.
        address burner;
        string data;
    }

    // An array containing all existing mingbi
    Mingbi[] mingbies;
    uint256 burnt;
    mapping (uint => address) public mingbiToOwner;
    mapping (address => uint) ownerMingbiCount;
    mapping (uint => address) mingbiApprovals;

    function _transfer(address _from, address _to, uint256 _tokenId) internal {
        mingbiToOwner[_tokenId] = _to;
        ownerMingbiCount[_to] = ownerMingbiCount[_to].add(1);
        if (_from != address(0)) {
            ownerMingbiCount[_from] = ownerMingbiCount[_from].sub(1);
            delete mingbiApprovals[_tokenId];
        }
        emit Transfer(_from, _to, _tokenId);
    }

    function _createMingbi(address _owner) internal returns (uint) {
        Mingbi memory _mingbi = Mingbi({
            data: "",
            burner: address(0)
        });

        uint256 newMingbiId = mingbies.push(_mingbi);
        _transfer(0, _owner, newMingbiId);
        ownerMingbiCount[msg.sender]++;
        return newMingbiId;
    }

    function getMingbiByOwner(address _owner) external view returns(uint[]) {
        uint[] memory result = new uint[](ownerMingbiCount[_owner]);
        uint counter = 0;
        for (uint i = 0; i < mingbies.length; i++) {
            if (mingbiToOwner[i] == _owner) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    function getMingbiBurnt() external view returns(uint[]) {
        uint[] memory result = new uint[](burnt);
        uint counter = 0;
        for (uint i = 0; i < mingbies.length; i++) {
            if (mingbies[i].burner != address(0)) {
                result[counter] = i;
                counter++;
            }
        }
        return result;
    }

    function getMingbiDetail(uint index) external view returns(address, address, string) {
        // returns owner, burner, data
        return (mingbiToOwner[index], mingbies[index].burner, mingbies[index].data);
    }
}
