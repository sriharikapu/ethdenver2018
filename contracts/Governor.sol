pragma solidity ^0.4.19;

contract Governor {

  // Out of 100
  uint8 public communityBenefitPercentage;

  function Governor( ) public {
  
  }

  function setBenefitPercentage( uint8 _benefit ) public {
    communityBenefitPercentage = _benefit;
  }
}