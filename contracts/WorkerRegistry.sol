pragma solidity ^0.4.19;

// This is the base contract that your contract WorkerRegistry extends from.
contract BaseRegistry {

    // The owner of this registry.
    address public owner = msg.sender;

    uint public creationTime = now;

    // This struct keeps all data for a Record.
    struct Record {
        // Keeps the address of this record creator.
        address owner;
        // Keeps the time when this record was created.
        uint time;
        // Keeps the index of the keys array for fast lookup
        uint keysIndex;
        bytes32 first_name;
        bytes32 last_name;
        string resume;
    }

    // This mapping keeps the records of this Registry.
    mapping(bytes32 => Record) records;

    // Keeps the total numbers of records in this Registry.
    uint public numRecords;

    // Keeps a list of all keys to interate the records.
    bytes32[] public keys;


    modifier onlyOwner {
        if (msg.sender == owner) 
        _;
    }



    // This is the function that actually insert a record. 
    function register(bytes32 key, bytes32 first_name, bytes32 last_name, string resume) {
        if (records[key].time == 0) {
            records[key].time = now;
            records[key].owner = msg.sender;
            records[key].keysIndex = keys.length;
            keys.length++;
            keys[keys.length - 1] = key;
            records[key].first_name = first_name;
            records[key].last_name = last_name;
            records[key].resume = resume;
            numRecords++;
        } else {
            throw;
        }
    }

    // Updates the values of the given record.
    function update(bytes32 key, bytes32 first_name, bytes32 last_name, string resume) {
        // Only the owner can update his record.
        if (records[key].owner == msg.sender) {
            records[key].first_name = first_name;
            records[key].last_name = last_name;
            records[key].resume = resume;
        }
    }

    // Unregister a given record
    function unregister(bytes32 key) {
        if (records[key].owner == msg.sender) {
            uint keysIndex = records[key].keysIndex;
            delete records[key];
            numRecords--;
            keys[keysIndex] = keys[keys.length - 1];
            records[keys[keysIndex]].keysIndex = keysIndex;
            keys.length--;
        }
    }

    // Transfer ownership of a given record.
    function transfer(bytes32 key, address newOwner) {
        if (records[key].owner == msg.sender) {
            records[key].owner = newOwner;
        } else {
            throw;
        }
    }

    // Tells whether a given key is registered.
    function isRegistered(bytes32 key) returns(bool) {
        return records[key].time != 0;
    }

    function getRecordAtIndex(uint rindex) returns(bytes32 key, address owner, uint time, bytes32 first_name, bytes32 last_name, string resume) {
        Record record = records[keys[rindex]];
        key = keys[rindex];
        owner = record.owner;
        time = record.time;
        first_name = record.first_name;
        last_name = record.last_name;
        resume = record.resume;
    }

    function getRecord(bytes32 key) returns(address owner, uint time, bytes32 first_name, bytes32 last_name, string resume) {
        Record record = records[key];
        owner = record.owner;
        time = record.time;
        first_name = record.first_name;
        last_name = record.last_name;
        resume = record.resume;
    }

    // Returns the owner of the given record. The owner could also be get
    // by using the function getRecord but in that case all record attributes 
    // are returned.
    function getOwner(bytes32 key) returns(address) {
        return records[key].owner;
    }

    // Returns the registration time of the given record. The time could also
    // be get by using the function getRecord but in that case all record attributes
    // are returned.
    function getTime(bytes32 key) returns(uint) {
        return records[key].time;
    }

    function kill() onlyOwner {
        suicide(owner);
    }
}

contract WorkerRegistry is BaseRegistry {}
