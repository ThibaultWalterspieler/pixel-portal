import { ethers } from "hardhat";

const main = async () => {
  const pixelContractFactory = await ethers.getContractFactory("PixelPortal");
  const pixelContract = await pixelContractFactory.deploy({
    value: ethers.utils.parseEther("0.1"),
  });
  await pixelContract.deployed();
  console.log("Contract added:", pixelContract.address);

  let contractBalance = await ethers.provider.getBalance(pixelContract.address);
  console.log("Contract balance:", ethers.utils.formatEther(contractBalance));

  const pixelTxn = await pixelContract.pixelise("000000", "fdff00");
  await pixelTxn.wait();

  const pixelTxn2 = await pixelContract.pixelise("fdff00", "feff00");
  await pixelTxn2.wait();

  contractBalance = await ethers.provider.getBalance(pixelContract.address);
  console.log("Contract balance:", ethers.utils.formatEther(contractBalance));

  const allPixels = await pixelContract.getAllPixels();
  console.log(allPixels);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
