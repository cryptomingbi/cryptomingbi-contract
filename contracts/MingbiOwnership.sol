pragma solidity ^0.4.18;

import "./MingbiBase.sol";
import "./ERC721Draft.sol";

contract MingbiOwnership is ERC721, MingbiBase {
    /// @notice Name and symbol of the non fungible token, as defined in ERC721.
    string public name = "CryptoMingbi";
    string public symbol = "CM";

    function implementsERC721() public pure returns (bool) {
        return true;
    }

    function totalSupply() public view returns (uint) {
        return mingbies.length;
    }

    function balanceOf(address _owner) public view returns (uint256 _balance) {
        return ownerMingbiCount[_owner];
    }

    function ownerOf(uint256 _tokenId) public view returns (address _owner) {
        return mingbiToOwner[_tokenId];
    }

    function transfer(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
        _transfer(msg.sender, _to, _tokenId);
    }

    function approve(address _to, uint256 _tokenId) public onlyOwnerOf(_tokenId) {
        mingbiApprovals[_tokenId] = _to;
        emit Approval(msg.sender, _to, _tokenId);
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public
    {
        require(_to != address(0));
        require(_to != address(this));
        require(mingbiApprovals[_tokenId] == msg.sender);
        require(mingbiToOwner[_tokenId] == _from);
        _transfer(_from, _to, _tokenId);
    }

    modifier onlyOwnerOf(uint _tokenId) {
        require(msg.sender == mingbiToOwner[_tokenId]);
        _;
    }
}
