<template>
  <div id="create-bet-view">
    <div class="header">
      <div class="back">
        <inline-svg :src="back" @click="$router.go(-1)" />
      </div>
      <div class="title">Create new Bet</div>
    </div>
    <div class="content">
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
        />
      </div>
    </div>
  </div>
</template>

<script>
import InlineSvg from "vue-inline-svg";

export default {
  name: "CreateBetView",
  components: {
    InlineSvg,
  },
  data() {
    return {
      back: require("../assets/arrow-left.svg"),
      betName: "",
    };
  },
  methods: {},
  mounted() {},
};
</script>

<style lang="scss" scoped>
#create-bet-view {
  color: white;
  display: grid;
  grid-template-columns: 100%;
  grid-template-rows: min-content min-content;
  height: calc(100% - 32px);
  padding: 16px;

  .header {
    position: relative;
    .back {
      float: left;
    }
    .title {
      position: absolute;
      left: 50%;
      transform: translateX(-50%);
    }
  }

  .content {
    margin-top: 16px;

    .bet-name-input {
      border: 1px solid #364152;
      border-radius: 16px;
      display: flex;
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
  }
}
</style>
