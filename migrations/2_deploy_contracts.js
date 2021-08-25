const Bear = artifacts.require("Bear");

module.exports = function(deployer) {
  deployer.deploy(Bear);
};
