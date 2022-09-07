# Solidity Bug (and hardhat too)

## INSTALL

```bash
pnpm i
```

## test against geth

somewhere:

```bash
docker-compose up
```

this will run geth

then execute this to give the test account some ETH

```
pnpm execute localhost scripts/fundingFromCoinbase.ts

```

Finally execute the tests, you can execute them again

```bash
pnpm hardhat test --network localhost
```

## test against hardhat

ALl test fails with hardhat, it run out of gas, even if gasLimit is higher than gas used for same tests by geth above

```
pnpm hardhat test
```

## What is the bug ?

So if you look in [src/Test.sol](src/Test.sol) you ll see 2 function that does the same things. They should work, but they fails when the data passed in is relatively big. they always return "0x0000000000000000000000000000000000000000" as address of the contract created.

WHat is weird though is that if I had a log call before returning, it start working, see it for yourself, comment out line 22 and 39 and see the tests all pass

### Hardhat

If you execute the test on hardhat the failing test keep failing. it seems hardhat network has different gas behavior than geth
