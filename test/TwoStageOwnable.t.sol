// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.12;

import "forge-std/Test.sol";
import "../src/IMPT.sol";

contract TwostageOwnableTest is Test {
  
    IMPT impt;
    string public name="IMPT Token";
    string public symbol="MTKN";
     
     address owner;
     address[] accounts;
     uint[] amounts;

     function setUp()public{
        accounts=[address(1),address(2),address(3),address(4),address(5),address(6),address(7),address(8),address(9),address(10)];
        amounts=[100,200,300,400,500,600,700,800,900,100];
        owner=address(this);
        impt=new IMPT(name,symbol,address(this),accounts,amounts);
     }

     function test_new_Owner()public{
        assertEq(impt.owner(),owner);
     }
     function test_nominatenew_owner() public{
        vm.prank(owner);
        impt.nominateNewOwner(address(11));
        assertEq(impt.nominatedOwner(),address(11));
     }
     function test_accept_newowner() public{
        vm.prank(owner);
        impt.nominateNewOwner(address(11));
        assertEq(impt.nominatedOwner(),address(11));
        vm.prank(address(11));
        impt.acceptOwnership();
        assertEq(impt.owner(),address(11));
     }
      function test_accept_notnominated() public{
        vm.prank(owner);
        impt.nominateNewOwner(address(11));
        assertEq(impt.nominatedOwner(),address(11));
        vm.prank(address(1));
        vm.expectRevert("Not nominated to ownership");
        impt.acceptOwnership();
     }
}