import {expect} from './chai-setup';
import {setup} from './setup';
import {example} from './data';
import {computeNextContractAddress} from '../utils/ethereum';

describe('Test', function () {
	it('works', async function () {
		const state = await setup();
		const expectedAddress = await computeNextContractAddress(state.Test);
		await expect(state.users[0].Test.deployData('0xFFFF')).to.emit(state.Test, 'Debug').withArgs(expectedAddress);
	});

	it('works with real data', async function () {
		const state = await setup();
		const expectedAddress = await computeNextContractAddress(state.Test);
		await expect(state.users[0].Test.deployData(example)).to.emit(state.Test, 'Debug').withArgs(expectedAddress);
	});

	it('works with real data and an extra useless log1', async function () {
		const state = await setup();
		const expectedAddress = await computeNextContractAddress(state.Test);
		await expect(state.users[0].Test.deployDataWithLog1(example))
			.to.emit(state.Test, 'Debug')
			.withArgs(expectedAddress);
	});

	it('alternative code works', async function () {
		const state = await setup();
		const expectedAddress = await computeNextContractAddress(state.Test);
		await expect(state.users[0].Test.deployData2('0xFFFF')).to.emit(state.Test, 'Debug').withArgs(expectedAddress);
	});

	it('alternative code works with real data', async function () {
		const state = await setup();
		const expectedAddress = await computeNextContractAddress(state.Test);
		await expect(state.users[0].Test.deployData2(example)).to.emit(state.Test, 'Debug').withArgs(expectedAddress);
	});

	it('alternative code works with real data and an extra useless log1', async function () {
		const state = await setup();
		const expectedAddress = await computeNextContractAddress(state.Test);
		await expect(state.users[0].Test.deployData2WithLog1(example))
			.to.emit(state.Test, 'Debug')
			.withArgs(expectedAddress);
	});
});
