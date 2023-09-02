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
      <div class="bet-options">
        <div class="label">Bet Options</div>
        <div v-for="(option, index) in betOptions" :key="index">
          <div class="bet-option-input-container">
            <input
              class="bet-option-input"
              v-model="option.name"
              :placeholder="`Option ${index + 1}`"
            />
          </div>
        </div>
        <BaseBtn class="add-bet-option-btn" @click="addBetOption">
          <span>Add bet option</span>
        </BaseBtn>
      </div>
      <div class="bet-amount">
        <span class="label">Bet Amount</span>
        <div class="type-of-bet">
          <div
            class="fixed-bet"
            :class="{ active: typeOfBet === 'fixed' }"
            @click="typeOfBet = 'fixed'"
          >
            <span>Fixed</span>
          </div>
          <div
            class="open-bet"
            :class="{ active: typeOfBet === 'open' }"
            @click="typeOfBet = 'open'"
          >
            <span>Open</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import InlineSvg from "vue-inline-svg";
import BaseBtn from "@/components/BaseBtn.vue";

export default {
  name: "CreateBetView",
  components: {
    BaseBtn,
    InlineSvg,
  },
  data() {
    return {
      back: require("../assets/arrow-left.svg"),
      betName: "",
      betOptions: [],
      typeOfBet: "fixed",
    };
  },
  methods: {
    addBetOption() {
      this.betOptions.push({
        name: "",
      });
    },
  },
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

    .bet-options {
      margin-top: 16px;

      .label {
        color: white;
        font-size: 10px;
        font-style: normal;
        font-weight: 600;
        line-height: normal;
        letter-spacing: -0.2px;
        text-align: left;
        text-transform: uppercase;
      }

      .bet-option-input-container {
        background: #4b5565;
        border: 1px solid #364152;
        border-radius: 16px;
        display: flex;
        padding: 5px;
        position: relative;
        margin-top: 8px;

        .bet-option-input {
          background: transparent;
          border: none;
          color: white;
          height: 24px;
          outline: none;
          text-align: center;
          width: 100%;
        }
      }

      .add-bet-option-btn {
        border: 1px solid #4b5565;
        border-radius: 99px;
        background: transparent;
        color: white;
        margin-top: 12px;
        padding: 9px 32px;
        width: 100%;
      }
    }

    .bet-amount {
      align-items: center;
      display: flex;
      justify-content: space-between;
      margin-top: 24px;

      .label {
        font-size: 10px;
        font-style: normal;
        font-weight: 600;
        line-height: normal;
        letter-spacing: -0.2px;
        text-transform: uppercase;
      }

      .type-of-bet {
        border: 1px solid #4b5565;
        border-radius: 99px;
        display: flex;
        font-size: 14px;

        .fixed-bet {
          border-radius: 99px 0 0 99px;
          color: white;
          padding: 6px 24px;

          &.active {
            background: white;
            color: black;
          }
        }

        .open-bet {
          border-radius: 0 99px 99px 0;
          color: white;
          padding: 6px 24px;

          &.active {
            background: white;
            color: black;
          }
        }
      }
    }
  }
}
</style>
