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
      <BaseBtn class="confirm">
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
