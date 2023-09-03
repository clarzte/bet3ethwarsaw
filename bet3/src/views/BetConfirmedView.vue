<template>
  <div id="bet-confirmed-view">
    <the-header>
      <template #right>
        <div class="header-right">
          <inline-svg :src="require('../assets/users.svg')" />
          <span class="participants">Participants</span>
        </div>
      </template>
    </the-header>
    <BetInfo />
    <div class="content">
      <PrizePool :show-type-of-bet="false">
        <template #amount> {{ totalPool }} </template>
        <template #additional-info>
          <span>You betted on {{ userChoice }}</span>
        </template>
      </PrizePool>
    </div>
    <div class="footer">
      <inline-svg :src="require('../assets/clock.svg')" />
      Consensus will happen in 30mins
    </div>
  </div>
</template>

<script>
import InlineSvg from "vue-inline-svg";
import TheHeader from "@/components/TheHeader.vue";
import BetInfo from "@/components/BetInfo.vue";
import PrizePool from "@/components/PrizePool.vue";
import { readContract } from "@wagmi/core";
import bet3 from "@/abi/bet3.json";

export default {
  name: "BetConfirmedView",
  components: { BetInfo, TheHeader, InlineSvg, PrizePool },
  data() {
    return {
      betAmount: this.$store.state.bet.amount,
      betEnded: false,
      totalPool: 0,
      userChoice: this.$store.state.userChoice,
    };
  },
  watch: {
    betEnded() {
      this.$router.push(`/bet/${this.$route.params.id}/ended`);
    },
  },
  async created() {
    this.totalPool = await readContract({
      address: "0x6Be57E047566598e263AFf571B51DD7b3Fa3493a",
      abi: bet3,
      functionName: "getTotalPrize",
      args: [this.$route.params.id],
    });
    setTimeout(() => {
      this.betEnded = true;
    }, 5000);
  },
};
</script>

<style lang="scss" scoped>
@import "../assets/scss/shared.scss";

#bet-confirmed-view {
  @extend %page-shared !optional;
  grid-template-rows: min-content min-content 1fr;

  .header-right {
    align-items: center;
    display: flex;
    gap: 10px;
    justify-content: center;
  }

  .content {
    align-self: center;
  }

  .footer {
    align-items: center;
    color: #697586;
    display: flex;
    font-size: 14px;
    font-style: normal;
    font-weight: 400;
    gap: 10px;
    justify-content: center;
    line-height: normal;
    letter-spacing: -0.28px;
  }
}
</style>
