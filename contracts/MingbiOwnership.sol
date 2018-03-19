pragma solidity ^0.4.17;

import "./interfaces/MingbiBase.sol";
import "./interfaces/ERC721Draft.sol";

contract MingbiOwnership is ERC721, MingbiBase {
    /// @notice Name and symbol of the non fungible token, as defined in ERC721.
    string public name = "CryptoMingbi";
    string public symbol = "CM";

    // bool public implementsERC721 = true;
    function implementsERC721() public pure returns (bool) {
        return true;
    }

    function ownerOf(uint256 _tokenId) public view returns (address _owner) {
        return mingbiToOwner[_tokenId];
    }

    modifier onlyOwnerOf(uint _tokenId) {
        require(msg.sender == mingbiToOwner[_tokenId]);
        _;
    }
}
