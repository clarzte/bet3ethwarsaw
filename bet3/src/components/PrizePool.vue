<template>
  <div class="prize-pool">
    <div class="price-pool-box">Prize pool</div>
    <div class="amount">
      1,450
      <div class="currency">MNT</div>
    </div>
    <div class="type-of-bet">Fixed Bet 450 MNT</div>
  </div>
</template>

<script>
export default {
  name: "PrizePool",
  props: {},
  data() {
    return {};
  },
  computed: {},
  methods: {},
  mounted() {},
  beforeDestroy() {},
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
      top: 50%;
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
