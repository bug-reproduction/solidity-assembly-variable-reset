# Solidity Bug ? and hardhat too

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

Then execute the tests

```bash
pnpm hardhat test --network localhost
```

## test against hardhat

ALl test fails with hardhat, it run out of gas, even if gasLimit is higher than gas used for same tests by geth above

```
pnpm hardhat test
```
