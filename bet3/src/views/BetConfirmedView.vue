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

export default {
  name: "BetConfirmedView",
  components: { BetInfo, TheHeader, InlineSvg, PrizePool },
  data() {
    return {
      betAmount: this.$store.state.bet.amount,
      totalPool: this.$store.state.totalPool,
      userChoice: this.$store.state.userChoice,
    };
  },
  methods: {},
  computed: {},
  mounted() {},
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
