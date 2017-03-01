pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";

contract TestByReference {
    function testMemoryArrayReference() {
        uint[] memory original = new uint[](1);
        original[0] = 1;
        Assert.equal(original[0], 1, "should have set value");

        var copy = original;
        Assert.equal(copy[0], 1, "should be same as original");

        copy[0] = 2;
        Assert.equal(copy[0], 2, "should have changed");
        Assert.equal(original[0], 2, "should have changed original because of reference");
    }

    uint[] originalStorage;

    function testStorageArrayReference() {
        originalStorage = new uint[](1);
        originalStorage[0] = 1;
        Assert.equal(originalStorage[0], 1, "should have set value");

        var copy = originalStorage;
        Assert.equal(copy[0], 1, "should be same as original");

        copy[0] = 2;
        Assert.equal(copy[0], 2, "should have changed");
        Assert.equal(originalStorage[0], 2, "should have changed original because of reference");

        // After cleanup
        originalStorage[0] = 0;
        originalStorage.length = 0;
    }

    struct NumberStruct {
        uint number;
    }
    NumberStruct numberStructStorage;

    function testStorageStructReference() {
        numberStructStorage = NumberStruct({
            number: 1
        });
        Assert.equal(numberStructStorage.number, 1, "should have set value");

        var copy = numberStructStorage;
        Assert.equal(copy.number, 1, "should have set value");

        copy.number = 2;
        Assert.equal(copy.number, 2, "should have changed");
        Assert.equal(numberStructStorage.number, 2, "should have changed original because of reference");

        // After cleanup
        numberStructStorage.number = 0;
    }

    function testMemoryStructReference() {
        NumberStruct memory numberStruct = NumberStruct({
            number: 1
        });
        Assert.equal(numberStruct.number, 1, "should have set value");

        var copy = numberStruct;
        Assert.equal(copy.number, 1, "should have set value");

        copy.number = 2;
        Assert.equal(copy.number, 2, "should have changed");
        Assert.equal(numberStruct.number, 2, "should have changed original because of reference");

        // After cleanup
        numberStruct.number = 0;
    }
}
