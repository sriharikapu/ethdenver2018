var ProjectRegistry = artifacts.require("ProjectRegistry.sol");

contract( 'ProjectRegistry', function(accounts){

  it("should keep track of total revenue / cost", async function(){

    var instance = await ProjectRegistry.deployed();

    var key = "1";
    var description = "Project Workspace0x";
    var worker = 0x0;
    var revenue = 100;
    var cost = 80;
    var status = 0;

    await instance.register( key, description, worker, revenue, cost, status );

    var count = await instance.numRecords.call()

    assert.equal( count, 1 )

    var totalRevenue = await instance.sumRevenue.call( );

    assert.equal( totalRevenue.toNumber(), revenue )

  })

})