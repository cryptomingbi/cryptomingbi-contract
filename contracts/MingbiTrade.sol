pragma solidity ^0.4.21;

import "./MingbiCore.sol";

contract MingbiTrade {
    address core_addr;
    mapping(uint256 => address) public mingbiToOwner;
    mapping(uint256 => uint256) public mingbiToPrice;
    uint256[] mingbies;

    function MingbiTrade() public {
        // Ropsten
        // core_addr = 0x2037a5581B4E975Ae0927C710b7E099425081FBB;
        // Main Net
        core_addr = 0x399468D1dC0d219CB9812B1e1a64acdf9B677a0a;
    }

    function _remove_token(uint256 id) internal {
        delete mingbiToOwner[id];
        delete mingbiToPrice[id];

        uint256 i = id;
        while (i < mingbies.length - 1) {
            mingbies[i] = mingbies[i + 1];
            i++;
        }
        mingbies.length--;
    }

    function _find_token(uint256 id) view internal returns(uint256) {
        for (uint i = 0; i < mingbies.length; i++) {
            if (mingbies[i] == id) {
                return i;
            }
        }
        revert();
    }

    function _add_token(uint256 id, uint256 price, address owner) internal {
        mingbiToOwner[id] = owner;
        mingbiToPrice[id] = price;
        mingbies.push(id);
    }

    function sell(uint256 id, uint256 price) external {
        MingbiCore core = MingbiCore(core_addr);
        core.transferFrom(msg.sender, this, id);
        _add_token(id, price, msg.sender);
    }

    function revoke(uint256 id) external {
        require(msg.sender == mingbiToOwner[id]);
        MingbiCore core = MingbiCore(core_addr);
        core.transfer(msg.sender, id);
        _remove_token(id);
    }

    function buy(uint256 id) external payable {
        require(msg.value >= mingbiToPrice[id]);
        MingbiCore core = MingbiCore(core_addr);
        core.transfer(msg.sender, id);
        mingbiToOwner[id].transfer(msg.value);
        _remove_token(id);
    }

    function list() view external returns (uint256[] ids, uint256[] prices, address[] owners) {
        uint256[] memory resultPrices = new uint256[](mingbies.length);
        address[] memory resultOwners = new address[](mingbies.length);

        for (uint i = 0; i < mingbies.length; i++) {
            resultPrices[i] = mingbiToPrice[mingbies[i]];
            resultOwners[i] = mingbiToOwner[mingbies[i]];
        }
        return (mingbies, resultPrices, resultOwners);
    }
}
