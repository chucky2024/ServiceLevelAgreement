import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const SLAContractModule = buildModule("SLAContractModule", (m) => {

    const agreement = m.contract("SLAContract");

    return { agreement };
});

export default SLAContractModule;
// contract address =  0xB1e18F4bb189f918cDAEB5a7480e9DB3D2D13FaC