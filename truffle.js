module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*", // Match any network id. You may need to replace * with your network Id
      from: "0xa4f388aa9cd3ba7847ee1108c7433bfd031bd3d4", // Add your unlocked account within the double quotes
      gas: 4444444
    }
  }
};
