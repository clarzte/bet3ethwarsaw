// import router from "@/router";
export const useWeb3Modal = () => {
  // router.push("/welcome");
  // const chains = [goerli];
  // const projectId = "745309525617c3053ad47f1817bef8a1";
  // const explorerAllowList = [
  //   // metamask
  //   "c57ca95b47569778a828d19178114f4db188b89b763c899ba0be274e97267d96",
  // ];

  // const { provider } = configureChains(chains, [w3mProvider({ projectId })]);
  // const wagmiClient = createClient({
  //   autoConnect: true,
  //   connectors: w3mConnectors({ projectId, version: 1, chains }),
  //   provider,
  // });
  // const ethereumClient = new EthereumClient(wagmiClient, chains);
  // const web3modal = new Web3Modal(
  //   {
  //     projectId,
  //     explorerAllowList,
  //   },
  //   ethereumClient
  // );

  // web3modal.subscribeModal(() => {
  //   const address = getAccount().address;
  //   if (!address) {
  //     return;
  //   }
  //
  //   router.push("/welcome");
  // });

  return {
    // web3modal,
  };
};
