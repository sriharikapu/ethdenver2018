pragma solidity ^0.4.19;

import "./ProjectRegistry.sol";

contract Escrow {

  ProjectRegistry projectRegistry;
  mapping( bytes32 => uint256 ) projectBalances;
  mapping( address => uint256 ) paidBalances;
 
  uint256 totalBalance;

  // Governance contract
  address governor;

  function Escrow( ) public {
  }

  function setGovernor( address _governor ) public {
    governor = _governor;
  }

  function setProjectRegistry( address _registry ) public {
    projectRegistry = ProjectRegistry(_registry);
  } 

  function depositProjectFunds( bytes32 projectKey ) public payable {

    // uint128 cost = ProjectRegistry.getRecord.call( projectKey )[ 5 ];
    // uint8 status = ProjectRegistry.getRecord.call( projectKey )[ 6 ];

    // require( msg.value <= cost );
    // require( status == 0 );

    // totalBalance = totalBalance + msg.value;

  }

}