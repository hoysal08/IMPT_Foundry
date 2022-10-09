// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.12;

import "forge-std/Test.sol";
import "../src/IMPT.sol";

contract IMPTTest is Test {
    
    event Transfer(address  from, address  to, uint256 value);
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

     function testinitialState() public {
        // assert if the corrent name was used
        assertEq(impt.name(), name);
        // assert if the correct symbol was used
        assertEq(impt.symbol(), symbol);
        //assert if the owner is set right
        assertEq(impt.owner(),owner);
    }
    function testincorrect_contructoraurguments() public{
        accounts=[address(1),address(2),address(3),address(4),address(5),address(6),address(7),address(8),address(9),address(10)];
        amounts=[100,200,300,400,500,600,700,800,900];
        vm.expectRevert("Invalid params length");
        impt=new IMPT(name,symbol,address(this),accounts,amounts);
    }
     function testoverbound_contructoraurguments() public{
        accounts=[address(1),address(2),address(3),address(4),address(5),address(6),address(7),address(8),address(9),address(10),address(11),address(12),address(13),address(14),address(15),address(16),address(17),address(18),address(19),address(20),address(21)];
        amounts=[100,200,300,400,500,600,700,800,900,1000,100,200,300,400,500,600,700,800,900,1000,100];
        vm.expectRevert("Invalid recipients length");
        impt=new IMPT(name,symbol,address(this),accounts,amounts);
    }
    function testbalanceof_initialmint() public{
        for(uint i=0;i<10;i++)
        {

        uint balanceineth=impt.balanceOf(accounts[i]);
        balanceineth=balanceineth/(10**impt.decimals());
        assertEq(balanceineth,amounts[i]);
        }
    }
    function testvalid_totalsupply() public{
        uint balanceineth;
        for(uint i=0;i<10;i++)
        {
        balanceineth+=impt.balanceOf(accounts[i]);
        }
        balanceineth=balanceineth/(10**impt.decimals());
        assertEq(balanceineth,impt.totalSupply()/(10**impt.decimals()));
    }

    function testbasic_transfer( uint transferamt) public {
        //uint transferamt=10;
        vm.assume(transferamt<=amounts[1]);
        uint intial_balance=impt.balanceOf(accounts[1]);
        vm.prank(accounts[1]);
        impt.transfer(address(11), transferamt);
        uint final_balance=impt.balanceOf(accounts[1]);
        assertEq(final_balance,intial_balance-transferamt);
        uint new_balance=impt.balanceOf(address(11));
        assertEq(new_balance,transferamt);
    }
    /*function testtransfer_event()public {
         uint transferamt=10;
        vm.prank(accounts[1]);
        vm.expectEmit(true, true, false, false);
        emit Transfer(accounts[1], address(11),transferamt);
        impt.transfer(address(11), transferamt);
    }*/
    function testapprove_transfer() public{
        uint approveamt=10;
        vm.prank(accounts[1]);
        impt.approve(address(11), approveamt);
        uint allowed_amount=impt.allowance(accounts[1],address(11));
        assertEq(approveamt,allowed_amount);
        vm.prank(address(11));
        impt.transferFrom(accounts[1],address(12),approveamt);
        assertEq(impt.balanceOf(address(11)), 0);
    }
     function testapprove_transferuperbound() public{
        uint approveamt=10;
        vm.prank(accounts[1]);
        impt.approve(address(11), approveamt);
        uint allowed_amount=impt.allowance(accounts[1],address(11));
        assertEq(approveamt,allowed_amount);
        vm.prank(address(11));
        vm.expectRevert("ERC20: insufficient allowance");
        impt.transferFrom(accounts[1],address(12),approveamt+1);
        assertEq(impt.balanceOf(address(11)), 0);
    }
    function testwhen_paused() public{
        uint transferamt=10;
        vm.prank(owner);
        impt.pause();
        vm.prank(accounts[1]);
        vm.expectRevert("Pausable: paused");
        impt.transfer(address(11), transferamt);
    }
    function testwhen_unpaused() public{
        uint transferamt=10;
        vm.prank(owner);
        impt.pause();
        impt.unpause();
        vm.prank(accounts[1]);
        impt.transfer(address(11), transferamt);
        assertEq(impt.balanceOf(address(11)), transferamt);
    }

    
}
