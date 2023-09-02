<template>
  <div class="place-your-bet">
    <span class="text"> Place your bet </span>
    <div class="buttons-container">
      <BaseBtn class="btn" @click="chooseOption(option1)">
        {{ option1 }}
        <span class="number-of-bets">3 Bets</span>
      </BaseBtn>
      <BaseBtn class="btn" @click="chooseOption(option2)">
        {{ option2 }}
        <span class="number-of-bets">2 Bets</span>
      </BaseBtn>
    </div>
  </div>
</template>

<script>
import BaseBtn from "@/components/BaseBtn.vue";
export default {
  name: "PlaceYourBet",
  components: {
    BaseBtn,
  },
  props: {},
  data() {
    return {
      option1: this.$store.state.bet.options[0].name,
      option2: this.$store.state.bet.options[1].name,
    };
  },
  methods: {
    chooseOption(option) {
      this.$store.commit("SET_USER_CHOICE", option);
      this.$router.push(`/bet/${this.$route.params.id}/confirm`);
    },
  },
};
</script>

<style lang="scss" scoped>
.place-your-bet {
  .text {
    font-size: 14px;
    font-style: normal;
    font-weight: 400;
    line-height: 20px; /* 142.857% */
    text-transform: uppercase;
  }

  .buttons-container {
    border: none;
    display: flex;
    flex-direction: column;
    gap: 12px;
    margin-top: 16px;

    .btn {
      background: white;
      border: none;
      border-radius: 99px;
      font-size: 16px;
      font-style: normal;
      font-weight: 600;
      line-height: normal;
      letter-spacing: -0.32px;
      padding: 11px 32px;

      .number-of-bets {
        font-size: 16px;
        font-style: normal;
        font-weight: 400;
        line-height: normal;
        letter-spacing: -0.32px;
        opacity: 0.4;
      }
    }
  }
}
</style>
