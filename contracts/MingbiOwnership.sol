pragma solidity ^0.4.17;

import "./interfaces/ERC721Draft.sol";
import "./interfaces/MingbiBase.sol";

contract MingbiOwnership is ERC721, MingbiBase {
  /// @notice Name and symbol of the non fungible token, as defined in ERC721.
  string public name = "CryptoMingbi";
  string public symbol = "CM";

  // bool public implementsERC721 = true;
  function implementsERC721() public pure returns (bool) {
    return true;
  }
}
