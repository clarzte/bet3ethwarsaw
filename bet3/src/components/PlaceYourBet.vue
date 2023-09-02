<template>
  <div v-if="init" class="place-your-bet">
    <span class="text"> Place your bet </span>
    <div class="buttons-container">
      <BaseBtn class="btn primary-btn" @click="chooseOption(option1)">
        {{ option1 }}
        <span class="number-of-bets">3 Bets</span>
      </BaseBtn>
      <BaseBtn class="btn primary-btn" @click="chooseOption(option2)">
        {{ option2 }}
        <span class="number-of-bets">2 Bets</span>
      </BaseBtn>
    </div>
  </div>
</template>

<script>
import BaseBtn from "@/components/BaseBtn.vue";
import { mapState } from "vuex";

export default {
  name: "PlaceYourBet",
  components: {
    BaseBtn,
  },
  props: {},
  data() {
    return {
      init: false,
      option1: "",
      option2: "",
    };
  },
  watch: {
    bet() {
      this.init = true;
      this.option1 = this.bet.options[0].name;
      this.option2 = this.bet.options[1].name;
    },
  },
  computed: {
    ...mapState({
      bet: (state) => state.bet,
    }),
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
@import "../assets/scss/application.scss";

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
