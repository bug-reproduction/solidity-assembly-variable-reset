// SPDX-License-Identifier: AGPL-1.0
pragma solidity 0.8.16;

contract Test {
	event Debug(address deployedContract);

	function deployData(bytes calldata) external {
		address newContract;
		assembly {
			let len := calldataload(36)
			let p := mload(0x40)
			mstore(p, 0x61FFFF600E60003961FFFF6000F3000000000000000000000000000000000000)
			let lenByte1 := shr(8, len)
			let lenByte2 := and(len, 0xFF)
			mstore8(add(p, 1), lenByte1)
			mstore8(add(p, 2), lenByte2)
			mstore8(add(p, 9), lenByte1)
			mstore8(add(p, 10), lenByte2)
			calldatacopy(add(p, 14), 68, len)

			newContract := create(0, p, add(len, 14))
		}
		require(newContract != address(0), "CREATE_FAILS");
		emit Debug(newContract);
	}

	function deployDataWithLog1(bytes calldata) external {
		address newContract;
		assembly {
			let len := calldataload(36)
			let p := mload(0x40)
			mstore(p, 0x61FFFF600E60003961FFFF6000F3000000000000000000000000000000000000)
			let lenByte1 := shr(8, len)
			let lenByte2 := and(len, 0xFF)
			mstore8(add(p, 1), lenByte1)
			mstore8(add(p, 2), lenByte2)
			mstore8(add(p, 9), lenByte1)
			mstore8(add(p, 10), lenByte2)
			calldatacopy(add(p, 14), 68, len)

			newContract := create(0, p, add(len, 14))
			log1(p, add(len, 14), newContract) // need this line, no idea why, looks like some memory management issues
		}
		emit Debug(newContract);
	}

	function deployData2(bytes calldata data) external {
		bytes memory deployCode = bytes.concat(hex"61FFFF600E60003961FFFF6000F3", data);
		bytes1 lenByte1 = bytes1(uint8(data.length >> 8));
		bytes1 lenByte2 = bytes1(uint8(data.length & 0xFF));
		deployCode[1] = lenByte1;
		deployCode[9] = lenByte1;
		deployCode[2] = lenByte2;
		deployCode[10] = lenByte2;

		address newContract;
		assembly {
			newContract := create(0, add(deployCode, 32), mload(deployCode))
		}
		require(newContract != address(0), "CREATE_FAILS");
		emit Debug(newContract);
	}

	function deployData2WithLog1(bytes calldata data) external {
		bytes memory deployCode = bytes.concat(hex"61FFFF600E60003961FFFF6000F3", data);
		bytes1 lenByte1 = bytes1(uint8(data.length >> 8));
		bytes1 lenByte2 = bytes1(uint8(data.length & 0xFF));
		deployCode[1] = lenByte1;
		deployCode[9] = lenByte1;
		deployCode[2] = lenByte2;
		deployCode[10] = lenByte2;

		address newContract;
		assembly {
			newContract := create(0, add(deployCode, 32), mload(deployCode))
			log1(add(deployCode, 32), mload(deployCode), newContract) // need this line, no idea why, looks like some memory management issues
		}
		emit Debug(newContract);
	}
}
