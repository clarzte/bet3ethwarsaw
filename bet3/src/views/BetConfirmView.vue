<template>
  <div id="bet-confirm-view">
    <the-header>
      <div class="header-title">Confirm your bet</div>
    </the-header>
    <div class="content">
      <PrizePool :show-type-of-bet="false">
        <template #price-pool-box>
          {{ userChoice }}
        </template>
        <template #amount>
          {{ betAmount }}
        </template>
      </PrizePool>
    </div>
    <div class="footer">
      <BaseBtn class="confirm" @click="confirm">
        <span>Place</span>
        <span class="amount">
          {{ betAmount }}
          MNT
        </span>
        <span>bet for</span>
        {{ userChoice }}
      </BaseBtn>
    </div>
  </div>
</template>

<script>
import BaseBtn from "@/components/BaseBtn.vue";
import TheHeader from "@/components/TheHeader.vue";
import PrizePool from "@/components/PrizePool.vue";
import bet3 from "@/abi/bet3.json";
import { ethers } from "ethers";
import {
  writeContract,
  waitForTransaction,
  prepareWriteContract,
  watchContractEvent,
} from "@wagmi/core";
export default {
  name: "BetConfirmView",
  components: {
    BaseBtn,
    TheHeader,
    PrizePool,
  },
  props: {},
  data() {
    return {
      betAmount: parseInt(
        ethers.utils.formatEther(this.$store.state.bet.amount)
      ),
      userChoice: this.$store.state.userChoice,
    };
  },
  created() {
    console.log(this.$store.state.bet.amount);
    watchContractEvent(
      {
        address: "0x8F48AAac0F6fb31DC2e359471fC176c0C42DF305",
        abi: bet3,
        eventName: "BetPlaced",
      },
      (data) => {
        this.$store.commit("SET_BET_PLACED_CONTRACT_RESPONSE", data);
      }
    );
  },
  methods: {
    async confirm() {
      // const totalPool = this.$store.state.totalPool;
      await this.writeContract();
      // this.$store.commit("SET_TOTAL_POOL", totalPool + this.betAmount);
      await this.$router.push(`/bet/${this.$route.params.id}/confirmed`);
    },
    async writeContract() {
      const amount = this.$store.state.bet.amount.toString();
      console.log(amount);
      const config = await prepareWriteContract({
        address: "0x8F48AAac0F6fb31DC2e359471fC176c0C42DF305",
        abi: bet3,
        functionName: "placeBet",
        args: [
          this.$route.params.id ||
            this.$store.state.betCreatedContractResponse[0].args.betId,
          this.$store.state.userChoice,
        ],
        value: amount,
      });
      const { hash } = await writeContract(config);
      const wait = await waitForTransaction({
        hash: hash,
        onSettled(data, error) {
          const response = data ? data.logs[0].count : [];
          console.log("Settled", response);
          console.log("Error", error);
        },
      });
      console.log(wait);
    },
  },
};
</script>

<style lang="scss" scoped>
#bet-confirm-view {
  background: #6172f3;
  color: white;
  display: grid;
  grid-template-columns: 100%;
  grid-template-rows: min-content 1fr auto;
  height: calc(100% - 32px);
  padding: 16px;

  .header-title {
    font-size: 15px;
    font-style: normal;
    font-weight: 600;
    line-height: normal;
    letter-spacing: -0.3px;
    text-transform: uppercase;
  }

  .content {
    align-self: center;
  }

  .footer {
    .confirm {
      background: white;
      border: none;
      border-radius: 99px;
      font-size: 16px;
      font-style: normal;
      font-weight: 400;
      line-height: normal;
      letter-spacing: -0.32px;
      padding: 15px 32px;
      width: 100%;

      .amount {
        font-weight: 600;
      }
    }
  }
}
</style>
