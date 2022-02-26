// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract PixelPortal {
    uint256 public totalPixels;

    event NewPixel(
        address indexed from,
        uint256 timestamp,
        string color1,
        string color2
    );

    struct Pixel {
        address pixeler;
        string color1;
        string color2;
        uint256 timestamp;
    }

    Pixel[] public pixels;

    mapping(address => uint256) public lastPixeliseAt;

    constructor() payable {
        console.log("Smart contract becoming smarter");
    }

    function pixelise(string memory _color1, string memory _color2) public {
        require(
            lastPixeliseAt[msg.sender] + 300 days < block.timestamp,
            "Wait 300 days"
        );
        lastPixeliseAt[msg.sender] = block.timestamp;

        totalPixels++;
        console.log("%s pixelise %s", msg.sender, _color1, _color2);

        pixels.push(Pixel(msg.sender, _color1, _color2, block.timestamp));

        emit NewPixel(msg.sender, block.timestamp, _color1, _color2);
    }

    function getAllPixels() public view returns (Pixel[] memory) {
        return pixels;
    }

    function getTotalPixels() public view returns (uint256) {
        return totalPixels;
    }
}
