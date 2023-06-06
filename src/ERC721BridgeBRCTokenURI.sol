// SPDX-License-Identifier: MIT
pragma solidity >=0.8.17;

import {ERC721BridgeBRC} from "./ERC721BridgeBRC.sol";

contract ERC721BridgeBRCTokenURI is ERC721BridgeBRC {
    mapping(uint256 => uint256) private originalNFTTokenId;
    uint256 public registCount = _startTokenId();

    function _startTokenId() internal pure virtual returns (uint256) {
        return 1;
    }

    function _updateMapping(
        uint256 tokenId,
        uint256 _originalTokenId
    ) internal virtual {
        originalNFTTokenId[tokenId] = _originalTokenId;
    }

    /**
     * @dev Returns `true` if this contract has original NFT. Regist Original contract to call this function.
     */
    function originalTokenId(
        uint256 tokenId
    ) public view virtual returns (uint256) {
        return originalNFTTokenId[tokenId];
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes memory data
    ) public virtual override returns (bytes4) {
        originalNFTTokenId[registCount] = tokenId;
        registCount++;
        return super.onERC721Received(operator, from, tokenId, data);
    }
}