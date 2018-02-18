var Governor = artifacts.require("Governor.sol");

contract( 'Governor', function(accounts){

  it("should initialize with percentage", function(){

    var benefit = 80;
    var contract;

    return Governor.deployed().then(function(instance){
      contract = instance;
      return instance.setBenefitPercentage( benefit );
    })
    .then( function(){
      return contract.communityBenefitPercentage.call();
    })
    .then( function( value ){

      assert.equal( benefit, value.toNumber() );
    })
  })

})