// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/helloworld.sol";

contract TestHelloWorld {
    function testSaysHelloWorld() public {
        HelloWorld helloWorld = new HelloWorld();

        Assert.equal(helloWorld.helloWorld(), "Hello, World!", "Hello world should say hello");
    }
}
