var WorkerRegistry = artifacts.require("WorkerRegistry.sol");

contract( 'WorkerRegistry', function(accounts){

  it("should add a worker", async function(){

    var id = "1";
    var first_name = "Michael";
    var last_name = "Nolivos";
    var resume = "Software developer";

    var instance = await WorkerRegistry.deployed();

    await instance.register( id, first_name, last_name, resume );

    var count = await instance.numRecords.call()

    assert.equal( count, 1 )

    var data = await instance.getRecord.call( id );

  })

})