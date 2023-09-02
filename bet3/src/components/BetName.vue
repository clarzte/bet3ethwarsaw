<template>
  <div class="bet-name">
    <div class="bet-name-input">
      <div class="img-logo-container">
        <img alt="missing.png" class="img-logo" src="@/assets/ball.png" />
      </div>
      <span class="label">Bet Name</span>
      <input
        type="text"
        class="input"
        placeholder="Add your bet name"
        v-model="betName"
        :disabled="disabled"
      />
    </div>
  </div>
</template>

<script>
export default {
  name: "BetName",
  props: {
    disabled: { type: Boolean, default: false },
    initialBetName: { type: String, default: "" },
  },
  data() {
    return {
      betName: this.initialBetName,
    };
  },
  watch: {
    betName() {
      this.$emit("setBetName", this.betName);
    },
  },
};
</script>

<style scoped lang="scss">
.bet-name-input {
  border: 1px solid #364152;
  border-radius: 16px;
  display: flex;
  margin-bottom: 24px;
  padding: 12px;
  position: relative;

  .img-logo-container {
    align-items: center;
    border: 1px solid #364152;
    border-radius: 12px;
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

  .label {
    color: #697586;
    font-size: 12px;
    font-style: normal;
    font-weight: 600;
    line-height: 18px; /* 150% */
    margin-left: 12px;
  }

  .input {
    background: transparent;
    border: none;
    color: white;
    position: absolute;
    bottom: 14px;
    left: 70px;
    height: 24px;
    outline: none;
  }
}
</style>
