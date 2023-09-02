<template>
  <div id="create-bet-view">
    <the-header> Create new Bet </the-header>
    <div class="content">
      <bet-name @setBetName="bet.name = $event" />
      <hr />
      <div class="bet-options">
        <div class="label">Bet Options</div>
        <template v-for="(option, index) in bet.options">
          <div class="bet-option-input-container" :key="index">
            <input
              class="bet-option-input"
              v-model="option.name"
              :placeholder="`Option ${index + 1}`"
            />
          </div>
        </template>
        <BaseBtn
          v-if="bet.options.length < 2"
          class="add-bet-option-btn"
          @click="addBetOption"
        >
          <span>Add bet option</span>
        </BaseBtn>
      </div>
      <hr />
      <div class="bet-amount">
        <div class="type-of-bet-container">
          <span class="label">Bet Amount</span>
          <div class="type-of-bet">
            <div
              class="fixed-bet"
              :class="{ active: bet.type === 'fixed' }"
              @click="bet.type = 'fixed'"
            >
              <span>Fixed</span>
            </div>
            <div
              class="open-bet"
              :class="{ active: bet.type === 'open' }"
              @click="bet.type = 'open'"
            >
              <span>Open</span>
            </div>
          </div>
        </div>
        <div class="bet-amount-input-container">
          <input
            class="bet-amount-input"
            placeholder="ENTER BET AMOUNT"
            type="number"
            v-model="bet.amount"
          />
          <span class="currency"> MNT </span>
        </div>
      </div>
      <hr />
      <div class="bet-time-container">
        <div class="label">Time for betting</div>
        <div class="bet-time-input-container">
          <input class="bet-time-input" type="number" v-model="bet.time" />
          <span class="time"> mins </span>
        </div>
      </div>
      <hr />
      <div class="info-about-bet-container">
        <span class="validation-info">
          VALIDATION WILL HAPPEN AFTER THE BETS FINISH
        </span>
        <span class="auto-finalize-info"> AUTO FINALIZE IN 24H </span>
      </div>
    </div>
    <div class="footer">
      <BaseBtn
        :disabled="!canCreateBet"
        :class="{ disabled: !canCreateBet }"
        class="create-bet-btn"
        @click="createBet"
      >
        Create Bet
      </BaseBtn>
    </div>
  </div>
</template>

<script>
import BaseBtn from "@/components/BaseBtn.vue";
import TheHeader from "@/components/TheHeader.vue";
import BetName from "@/components/BetName.vue";
import { writeContract } from "@wagmi/core";
import { readContract } from "@wagmi/core";
import bet3 from "@/abi/bet3.json";

export default {
  name: "CreateBetView",
  components: {
    BetName,
    TheHeader,
    BaseBtn,
  },
  data() {
    return {
      bet: {
        amount: "",
        name: "",
        options: [],
        time: "30",
        type: "fixed",
      },
    };
  },
  computed: {
    canCreateBet() {
      return (
        this.bet.amount.length &&
        this.bet.name.length &&
        this.bet.time.length &&
        this.bet.options.length > 1
      );
    },
  },
  methods: {
    addBetOption() {
      this.bet.options.push({
        name: "",
      });
    },
    async writeContract() {
      const { hash } = await writeContract({
        abi: bet3,
        address: "0x3e75f922937F4DBD8c2dfBBC0B14e322391C6f11",
        functionName: "autoFinalizePeriod",
      });
      console.log("Hash: ", hash);
    },
    async readContract() {
      const data = await readContract({
        address: "0x3e75f922937F4DBD8c2dfBBC0B14e322391C6f11",
        abi: bet3,
        functionName: "autoFinalizePeriod",
      });
      console.log("Data: ", data);
    },
    async createBet() {
      this.$store.commit("SET_BET", this.bet);
      await this.writeContract();
      await this.$router.push("/bet-created");
    },
  },
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

  .content {
    margin-top: 16px;

    .bet-options {
      margin-top: 16px;
      margin-bottom: 24px;

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
      display: flex;
      flex-direction: column;
      margin-top: 24px;
      margin-bottom: 24px;

      .label {
        font-size: 10px;
        font-style: normal;
        font-weight: 600;
        line-height: normal;
        letter-spacing: -0.2px;
        text-transform: uppercase;
      }

      .type-of-bet-container {
        align-items: center;
        display: flex;
        justify-content: space-between;
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

      .bet-amount-input-container {
        align-items: center;
        border: 1px solid #364152;
        border-radius: 16px;
        display: flex;
        margin-top: 16px;
        padding: 12px;

        .bet-amount-input {
          background: transparent;
          border: none;
          color: white;
          height: 24px;
          outline: none;
          width: 100%;
        }

        .currency {
          font-size: 12px;
          font-style: normal;
          font-weight: 600;
          line-height: 18px; /* 150% */
        }
      }
    }

    .bet-time-container {
      align-items: center;
      display: flex;
      justify-content: space-between;
      margin-top: 20px;
      margin-bottom: 24px;

      .label {
        font-size: 10px;
        font-style: normal;
        font-weight: 600;
        line-height: normal;
        letter-spacing: -0.2px;
        text-transform: uppercase;
      }

      .bet-time-input-container {
        border: 1px solid #364152;
        border-radius: 16px;
        padding: 12px;
        width: 40%;

        .bet-time-input {
          background: transparent;
          border: none;
          color: white;
          height: 24px;
          outline: none;
          width: 60%;
        }

        .time {
          font-size: 12px;
          font-style: normal;
          font-weight: 600;
          line-height: 18px; /* 150% */
          text-transform: uppercase;
        }
      }
    }

    .info-about-bet-container {
      align-items: flex-start;
      display: flex;
      flex-direction: column;
      gap: 8px;
      margin-top: 20px;

      .validation-info {
        font-size: 10px;
        font-style: normal;
        font-weight: 600;
        line-height: normal;
        letter-spacing: -0.2px;
      }

      .auto-finalize-info {
        font-size: 10px;
        font-style: normal;
        font-weight: 600;
        line-height: normal;
        letter-spacing: -0.2px;
        opacity: 0.4;
      }
    }

    hr {
      background: #364152;
      border: none;
      height: 1px;
    }
  }

  .footer {
    align-self: flex-end;

    .create-bet-btn {
      background: white;
      border-radius: 99px;
      border: none;
      padding: 13px 32px;
      width: 100%;

      &.disabled {
        opacity: 0.4;
      }
    }
  }
}
</style>
