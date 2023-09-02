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
      betAmount: this.$store.state.bet.amount,
      userChoice: this.$store.state.userChoice,
    };
  },
  methods: {
    confirm() {
      const totalPool = +this.$store.state.totalPool;
      this.$store.commit("SET_TOTAL_POOL", totalPool + +this.betAmount);
      this.$router.push(`/bet/${this.$route.params.id}/confirmed`);
    },
    async writeContract() {
      const amount = ethers.utils.parseEther(this.bet.amount).toString();
      console.log(amount);
      const config = await prepareWriteContract({
        address: "0x3e75f922937F4DBD8c2dfBBC0B14e322391C6f11",
        abi: bet3,
        functionName: "placeBet",
        args: [
          this.bet.name,
          this.bet.options[0].name,
          this.bet.options[1].name,
          amount,
          this.bet.time * 60,
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
    }
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
