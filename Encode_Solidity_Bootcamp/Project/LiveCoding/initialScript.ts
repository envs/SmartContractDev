import { ethers } from "ethers";
import { Ballot } from "../typechain";
import * as ballotJson from "../artifacts/contracts/Ballot.sol/Ballot.json";

const PROPOSALS = ["Proposal 1", "Proposal 2", "Proposal 3"];
// This key is already public on Herong's Tutorial Examples - v1.03, by Dr. Herong Yang
const EXPOSED_KEY = "8da4ef21b864d2cc526dbdb2a120bd2874c36c9d0a1fb7f8c63d7f7a8b41de8f";

const convertStringArrayToBytes32 = (array: string[]) => {
    const bytes32Array = [];
    for (let i = 0; i < array.length; i++) {
        bytes32Array.push(ethers.utils.formatBytes32String(array[i]));
    }
    return bytes32Array;
}

async function main() {

    const wallet = process.env.MNEMONIC && process.env.MNEMONIC.length > 0
        ? ethers.Wallet.fromMnemonic(process.env.MNEMONIC)
        : new ethers.Wallet(process.env.PRIVATE_KEY ?? EXPOSED_KEY);
    console.log(`Using address ${wallet.address}`);

    const provider = ethers.providers.getDefaultProvider("ropsten");
    const signer = wallet.connect(provider);

    const balanceBN = await signer.getBalance();
    const balance = Number(ethers.utils.formatEther(balanceBN));
    console.log(`Wallet balance ${balance}`);
    if (balance < 0.01) {
        throw new Error("Not enough ether");
    }
    console.log("Deploying Ballot contract...");

    const ballotFactory = new ethers.ContractFactory(ballotJson.abi, ballotJson.bytecode, signer);
    const ballotContract: Ballot = (await ballotFactory.deploy(convertStringArrayToBytes32(PROPOSALS))) as Ballot;
    console.log("Awaiting confirmations...");
    const deploymentTX = await ballotContract.deployed();
    console.log(deploymentTX);
    console.log("Completed");
    console.log(`Contract deployed at ${ballotContract.address}`);

    console.log("Proposals: ");
    for (let i = 0; i < PROPOSALS.length; i++) {
        const proposal = await ballotContract.proposals(i);
        console.log(`Proposal at ${i} is named ${ethers.utils.parseBytes32String(proposal[0])}`);
    }
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });