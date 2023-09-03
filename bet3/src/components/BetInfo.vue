<template>
  <div class="bet-info">
    <div class="img-logo-container">
      <img alt="missing.png" class="img-logo" src="@/assets/ball.png" />
    </div>
    <div class="bet-text">
      <div class="bet-name">{{ betName }}</div>
      <div class="bet-time">
        <inline-svg :src="require('../assets/clock.svg')" />
        <slot>
          {{ betTime }}
          mins to finish
        </slot>
      </div>
    </div>
  </div>
</template>

<script>
import InlineSvg from "vue-inline-svg";
import { mapState } from "vuex";
import { ethers } from "ethers";

export default {
  components: { InlineSvg },
  computed: {
    ...mapState({
      bet: (state) => state.bet,
    }),
    betName() {
      return this.bet.name;
    },
    betTime() {
      return parseInt(ethers.utils.formatEther(this.bet.time));
    },
  },
};
</script>

<style lang="scss" scoped>
.bet-info {
  display: flex;
  gap: 20px;
  margin-top: 10px;

  .img-logo-container {
    align-items: center;
    border: 1px solid #364152;
    border-radius: 50%;
    background: #364152;
    display: flex;
    height: 48px;
    justify-content: center;
    width: 48px;

    .img-logo {
      height: 24px;
      width: 24px;
    }
  }

  .bet-name {
    color: #fff;
    font-size: 20px;
    font-style: normal;
    font-weight: 600;
    line-height: normal;
    letter-spacing: -0.4px;
    text-align: left;
  }

  .bet-time {
    color: #17b26a;
    display: flex;
    font-size: 14px;
    font-style: normal;
    font-weight: 400;
    gap: 4px;
    line-height: normal;
    letter-spacing: -0.28px;
    margin-top: 4px;
    text-align: left;
  }
}
</style>
