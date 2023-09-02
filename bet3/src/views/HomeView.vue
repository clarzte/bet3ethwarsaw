<template>
  <div class="home">
    <div class="logo-with-text">
      <img alt="Vue logo" src="../assets/logo.png" class="logo" />
      <h1 class="title">
        Bet with your friends <br />
        and earn rewards
      </h1>
    </div>
    <BaseBtn
      ref="walletConnectBtn"
      class="login-btn"
      text="Log in with your Wallet"
    />
  </div>
</template>

<script>
// @ is an alias to /src
import BaseBtn from "@/components/BaseBtn.vue";
import {
  EthereumClient,
  w3mConnectors,
  w3mProvider,
} from "@web3modal/ethereum";
import { Web3Modal } from "@web3modal/html";
import { configureChains, createConfig } from "@wagmi/core";
import { mantleTestnet } from "@wagmi/core/chains";

export default {
  name: "HomeView",
  components: { BaseBtn },
  mounted() {
    const chains = [mantleTestnet];
    const projectId = "745309525617c3053ad47f1817bef8a1";
    const { publicClient } = configureChains(chains, [
      w3mProvider({ projectId }),
    ]);
    const wagmiConfig = createConfig({
      autoConnect: true,
      connectors: w3mConnectors({ projectId, chains }),
      publicClient,
    });
    const ethereumClient = new EthereumClient(wagmiConfig, chains);
    // eslint-disable-next-line no-unused-vars
    const web3modal = new Web3Modal(
      { projectId, themeMode: "dark" },
      ethereumClient
    );
    this.$refs["walletConnectBtn"].$el.addEventListener("click", () => {
      web3modal.openModal();
    });
  },
};
</script>

<style scoped lang="scss">
.home {
  display: grid;
  grid-template-columns: 1fr;
  grid-template-rows: 1fr;
  height: calc(100% - 32px);
  padding: 16px;

  .logo-with-text {
    align-self: center;
    .logo {
      display: flex;
      justify-self: flex-start;
      width: 83px;
      height: 83px;
    }
    .title {
      font-size: 32px;
      font-weight: 600;
      line-height: normal;
      letter-spacing: -0.64px;
      color: white;
      text-align: left;
    }
  }

  .login-btn {
    background: transparent;
    border-radius: 50px;
    border: 2px solid white;
    color: white;
    padding: 11px;

    :deep(.text) {
      font-size: 16px;
      font-style: normal;
      font-weight: 600;
      line-height: normal;
      letter-spacing: -0.32px;
    }
  }
}
</style>
