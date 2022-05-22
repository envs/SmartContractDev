import { Contract, ethers } from "ethers";
import { Ballot } from "../../typechain";
import * as ballotJson from "../../artifacts/contracts/Ballot.sol/Ballot.json";

// This key is already public on Herong's Tutorial Examples - v1.03, by Dr. Herong Yang
const EXPOSED_KEY = "8da4ef21b864d2cc526dbdb2a120bd2874c36c9d0a1fb7f8c63d7f7a8b41de8f";

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

    if (process.argv.length < 3) throw new Error("Ballot address missing");
    const ballotAddress = process.argv[2];
    console.log(`Attaching ballot contract interface to address ${ballotAddress}`);

    const ballotContract = new Contract(ballotAddress, ballotJson.abi, signer) as Ballot;
    let i = 0;
    while (true) {
        try {
            const proposal = await ballotContract.proposals(i);
            console.log(`Proposal ${i + 1}: ${ethers.utils.parseBytes32String(proposal.name)}`);
            i++;
        } catch (err) {
            console.log("End of proposals");
            break;
        }
    }

}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });