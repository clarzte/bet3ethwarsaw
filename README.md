# Bet3
![image](https://github.com/clarzte/bet3ethwarsaw/assets/596509/27dee3d3-0818-4c73-a3cf-a45d673934b8)
### How to run the app?
1. Go to /bet3 folder
2. Run `yarn -i`
3. Run `yarn serve`

### Technology stack
- foundry
- vuejs
- wagmi
- wallet connect
- pwa

### Build

```shell
$ forge build
```

### Test smart contract

```shell
$ forge test
```

### Deploy smart contract

```shell
$ forge script scripts/Bet3.s.sol --rpc-url $MANTLE_RPC_URL --broadcast -vvvv --legacy
```
