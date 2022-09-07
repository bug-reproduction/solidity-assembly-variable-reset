import {ethers, deployments, getUnnamedAccounts} from 'hardhat';
import {setupUsers} from '../utils/users';
import {Test} from '../../typechain';

export const CommitmentHashZero = '0x000000000000000000000000000000000000000000000000';

export const setup = deployments.createFixture(async () => {
	await deployments.fixture(['Test']);
	const contracts = {
		Test: <Test>await ethers.getContract('Test')
	};
	const users = await setupUsers(await getUnnamedAccounts(), contracts);

	return {
		...contracts,
		users
	};
});

export type Setup = Awaited<ReturnType<typeof setup>>;
