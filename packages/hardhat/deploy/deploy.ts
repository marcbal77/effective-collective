import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";
import { Contract } from "ethers";

/**
 * Restarts the demo run through the DistrictManager contract
 *
 * @param hre HardhatRuntimeEnvironment object.
 */
const deployDistrictManager: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {

  const redeploying = false;
  const memberAddresses = [
    "0xFcc8bAe83d38fD2BF0933a16D6a2c68FF4BFc0bd",
    "0x142Ab00310aaCB3E27bf06c5cB9eEbf6116b0E51",
    "0x854376e6D7A90FB712eE007F68B74a2C5878710E",
    "0x2cB11E4250A2AFC3018B74a9Ce618666ec1D56ff"
  ]

  const { deployer } = await hre.getNamedAccounts();
  const { deploy } = hre.deployments;

    if (redeploying) {
        const maybe = await deploy("DistrictManager", {
            from: deployer,
            // Contract constructor arguments
            args: [],
            log: true,
        });
        console.log(maybe);
    }
    else {
        // Get the deployed contract to interact with it after deploying.
        const districtManager = await hre.ethers.getContract<Contract>("DistrictManager", deployer);
        await districtManager.restartDemo(memberAddresses);
        console.log("Demo ready!", await districtManager.getProposals());
    }


};

export default deployDistrictManager;

// Tags are useful if you have multiple deploy files and oly want to run one of them.
// e.g. yarn deploy --tags YourContract
deployDistrictManager.tags = ["DistrictManager"];
 