<template>
  <div class="prize-pool">
    <div class="price-pool-box">
      <slot name="price-pool-box"> Price Pool </slot>
    </div>
    <div class="amount">
      <slot name="amount" />
      <div class="currency">MNT</div>
    </div>
    <div v-if="showTypeOfBet" class="type-of-bet">Fixed Bet 450 MNT</div>
    <slot name="additional-info" />
  </div>
</template>

<script>
export default {
  name: "PrizePool",
  props: {
    showTypeOfBet: { type: Boolean, default: true },
  },
  data() {
    return {};
  },
};
</script>

<style lang="scss" scoped>
.prize-pool {
  align-items: center;
  display: flex;
  flex-direction: column;

  .price-pool-box {
    border: 1px solid rgba(255, 255, 255, 0.2);
    border-radius: 10px;
    font-size: 15px;
    font-style: normal;
    font-weight: 600;
    line-height: normal;
    letter-spacing: -0.3px;
    padding: 10px;
    text-transform: uppercase;
    width: fit-content;
  }

  .amount {
    font-size: 80px;
    font-style: normal;
    font-weight: 600;
    line-height: normal;
    letter-spacing: -1.6px;
    position: relative;
    left: -21px;

    .currency {
      font-size: 20px;
      font-style: normal;
      font-weight: 600;
      line-height: normal;
      letter-spacing: -0.4px;
      position: absolute;
      right: -50px;
      top: 54%;
    }
  }

  .type-of-bet {
    font-size: 16px;
    font-style: normal;
    font-weight: 400;
    line-height: normal;
    letter-spacing: -0.32px;
    opacity: 0.6;
  }
}
</style>
