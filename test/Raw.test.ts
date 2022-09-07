import {expect} from './chai-setup';
import {setup} from './setup';
import {example} from './data';

describe('Raw', function () {
	it('works', async function () {
		const state = await setup();
		const data = '0x' + '615870600E6000396158706000F3' + '0xFFFF'.slice(2);
		await expect(
			state.users[0].signer.sendTransaction({
				data
			})
		).to.not.throw;
	});

	it('works with real data', async function () {
		const state = await setup();
		const data = '0x' + '615870600E6000396158706000F3' + example.slice(2);
		await expect(
			state.users[0].signer.sendTransaction({
				data
			})
		).to.not.throw;
	});
});
