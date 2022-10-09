// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {IMPT} from "src/IMPT.sol";

contract IMPTScript is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();
    }
}


/* 
string  name="IMPT Token";
    string  symbol="MTKN";
     address[] accounts;
     uint[] amounts;
      accounts=[address(1),address(2),address(3),address(4),address(5),address(6),address(7),address(8),address(9),address(10)];
      amounts=[100,200,300,400,500,600,700,800,900,100];
       vm.startBroadcast();
       new IMPT(name,symbol,accounts,amounts);
       vm.stopBroadcast();
*/



/* 
forge create --rpc-url http://localhost:8545 --private
-key 0x2a871d0798f97d79848a013d4936a73bf4cc922c825d33c1cf7073dff6d409c6 src/IMPT.sol:IMPT --constructor-
args "IMPT Token" "MTKN" 0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266 "[address(1),address(2),address(3),a
ddress(4),address(5),address(6),address(7),address(8),address(9),address(10)]" "[100,200,300,400,500,600
,700,800,900,100]"
*/