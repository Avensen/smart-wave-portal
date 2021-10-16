const main = async () => {
    const [owner, randomPerson] = await hre.ethers.getSigners();
    const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();
    
    console.log('Contract deployed to:', waveContract.address);
    console.log('Contract deployed by:', owner.address);
    
    await waveContract.GetTotalWaves();

    await waveContract.Wave();
    
    await waveContract.GetTotalWaves();

    await waveContract.connect(randomPerson).Wave();

    await waveContract.GetTotalWaves();
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
