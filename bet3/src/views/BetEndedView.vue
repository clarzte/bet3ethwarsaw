<template>
  <div id="bet-ended-view">
    <TheHeader></TheHeader>
    <BetInfo> Waiting for results ({{ numberOfVotes }}/5) </BetInfo>
    <div class="content">
      <AppTimer :elapsed="timeElapsed" :limit="timeLimit" />
      <span class="vote"> Please, now you need to vote who won this bet </span>
      <div class="buttons-container">
        <BaseBtn
          :disabled="isUserVote"
          class="btn primary-btn"
          @click="vote('option1')"
        >
          {{ option1 }}
          <span class="dot">·</span>
          <span class="number-of-votes"> {{ option1Votes }} votes </span>
        </BaseBtn>
        <BaseBtn :disabled="isUserVote" class="btn primary-btn" @click="vote">
          {{ option2 }}
          <span class="dot">·</span>
          <span class="number-of-votes"> {{ option2Votes }} votes </span>
        </BaseBtn>
      </div>
    </div>
    <div class="footer">
      <inline-svg :src="require('../assets/info-circle.svg')" />
      3/5 Participants must confirm who won this bet
    </div>
  </div>
</template>

<script>
import TheHeader from "@/components/TheHeader.vue";
import BetInfo from "@/components/BetInfo.vue";
import AppTimer from "@/components/AppTimer.vue";
import BaseBtn from "@/components/BaseBtn.vue";
import InlineSvg from "vue-inline-svg";
import {
  prepareWriteContract,
  waitForTransaction,
  watchContractEvent,
  writeContract,
} from "@wagmi/core";
import bet3 from "@/abi/bet3.json";
export default {
  name: "BetEndedView",
  components: {
    BaseBtn,
    BetInfo,
    TheHeader,
    AppTimer,
    InlineSvg,
  },
  data() {
    return {
      option1: this.$store.state.bet.options[0].name,
      option1Votes: this.$store.state.bet.options[0].votes,
      option2: this.$store.state.bet.options[1].name,
      option2Votes: this.$store.state.bet.options[1].votes,
      timeLimit: 86400,
      timeElapsed: 0,
      timeInterval: undefined,
      isUserVote: false,
    };
  },
  computed: {
    numberOfVotes() {
      return this.option1Votes + this.option2Votes;
    },
  },
  created() {
    watchContractEvent(
      {
        address: "0x3e75f922937F4DBD8c2dfBBC0B14e322391C6f11",
        abi: bet3,
        eventName: "BetFinalized",
      },
      (data) => {
        this.$store.commit("SET_BET_FINALIZED_CONTRACT_RESPONSE", data);
      }
    );
  },
  methods: {
    startTimer() {
      this.timerInterval = setInterval(() => {
        // Stop counting when there is no more time left
        if (++this.timeElapsed === this.timeLimit) {
          clearInterval(this.timerInterval);
        }
      }, 1000);
    },
    vote(option) {
      if (option === "option1") {
        this.option1Votes++;
        this.$store.commit("ADD_VOTE", 0);
      }
      if (option === "option2") {
        this.option2Votes++;
        this.$store.commit("ADD_VOTE", 1);
      }
      this.isUserVote = true;
      try {
        this.writeContract();
      } catch (e) {
        console.error(e);
      }
    },
    async writeContract() {
      const config = await prepareWriteContract({
        address: "0x3e75f922937F4DBD8c2dfBBC0B14e322391C6f11",
        abi: bet3,
        functionName: "finalizeBet",
        args: [
          this.$store.state.betCreatedContractResponse[0].args.betId,
          this.$store.state.userChoice,
        ],
      });
      const { hash } = await writeContract(config);
      const wait = await waitForTransaction({
        hash: hash,
        onSettled(data, error) {
          const response = data ? data.logs[0].count : [];
          console.log("Settled", response);
          console.log("Error", error);
        },
      });
      console.log(wait);
    },
  },
  mounted() {
    this.startTimer();
  },
};
</script>

<style lang="scss" scoped>
@import "../assets/scss/application.scss";
@import "../assets/scss/shared.scss";

#bet-ended-view {
  @extend %page-shared !optional;
  grid-template-rows: min-content min-content 1fr;

  :deep(.bet-time) {
    color: #fdb022;
  }

  .content {
    align-self: center;
    position: relative;
    top: -20px;

    :deep(.root) {
      left: 10px;
    }

    .vote {
      font-size: 16px;
      font-style: normal;
      font-weight: 400;
      line-height: 24px; /* 150% */
    }

    .dot {
      margin-left: 12px;
      margin-right: 4px;
      opacity: 0.4;
    }

    .number-of-votes {
      font-size: 16px;
      font-style: normal;
      font-weight: 400;
      line-height: normal;
      letter-spacing: -0.32px;
      margin-left: 8px;
      opacity: 0.4;
      white-space: pre;
    }

    .buttons-container {
      .btn:first-child {
        margin-top: 12px;
        margin-bottom: 12px;
      }
    }
  }

  .footer {
    color: #697586;
    display: flex;
    font-size: 14px;
    font-style: normal;
    font-weight: 400;
    gap: 8px;
    line-height: normal;
    letter-spacing: -0.28px;
  }
}
</style>
