// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/Contract.sol";

contract TestContract is Test {
    MackCoin c;

    function setUp() public {
        c = new MackCoin();
    }

    function testMint() public{
        c.mint(address(this),200);
        assertEq(c.balanceOf(address(this)) , uint256(200) , "ok");
    }

    function testTransfer() public{
        // here we are going to use vm.prank
        c.mint(address(this),200);
        c.transfer(0xfEC066D16cD26a1C839D659Ad692328012CFeaFd,100);

        assertEq(c.balanceOf(address(this)) , uint256(100) , "OK");
        assertEq(c.balanceOf(0xfEC066D16cD26a1C839D659Ad692328012CFeaFd) , uint256(100) , "OK");

        // now the second guy will transfer the money back for that we are going to use vm.prank

        vm.prank(0xfEC066D16cD26a1C839D659Ad692328012CFeaFd);
        // after adding the prank jo agli line mai ham address(this) likh rahe hote hain 
        // wo address uss bande ka hota hai jiska address vm.pank pe likha hua ho and 
        // aab wo transfer karega jahan se usko paise aaye the usmai 
        c.transfer(address(this),100);
        assertEq(c.balanceOf(address(this)) , 200);
        assertEq(c.balanceOf(0xfEC066D16cD26a1C839D659Ad692328012CFeaFd) , 0);
    }

    function testApprovals()public{
        c.mint(address(this),200);
        c.approve(0xfEC066D16cD26a1C839D659Ad692328012CFeaFd , 30);

        vm.prank(0xfEC066D16cD26a1C839D659Ad692328012CFeaFd);
        c.transferFrom(address(this),0xfEC066D16cD26a1C839D659Ad692328012CFeaFd,10);
        assertEq(c.balanceOf(0xfEC066D16cD26a1C839D659Ad692328012CFeaFd),10 , "ok");
        assertEq(c.allowance(address(this),0xfEC066D16cD26a1C839D659Ad692328012CFeaFd) ,20);
    }

}
