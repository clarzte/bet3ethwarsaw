<template>
  <div v-if="bet" id="bet-details-view">
    <the-header>
      <template #right>
        <div class="header-right">
          <inline-svg :src="require('../assets/users.svg')" />
          <span class="participants">Participants</span>
        </div>
      </template>
    </the-header>
    <bet-info />
    <div class="content">
      <PrizePool>
        <template #amount> {{ totalPool }} </template>
      </PrizePool>
    </div>
    <div class="footer">
      <PlaceYourBet />
    </div>
  </div>
</template>

<script>
import TheHeader from "@/components/TheHeader.vue";
import InlineSvg from "vue-inline-svg";
import PrizePool from "@/components/PrizePool.vue";
import PlaceYourBet from "@/components/PlaceYourBet.vue";
import BetInfo from "@/components/BetInfo.vue";
import { readContract } from "@wagmi/core";
import bet3 from "@/abi/bet3.json";
import { ethers } from "ethers";
import { mapState } from "vuex";
export default {
  name: "BetDetailView",
  components: {
    BetInfo,
    PrizePool,
    TheHeader,
    InlineSvg,
    PlaceYourBet,
  },
  data() {
    return {
      bet: null,
      betName: this.$store.state.bet.name,
      betTime: this.$store.state.bet.time,
      totalPool: this.$store.state.totalPool,
    };
  },
  computed: {
    ...mapState({
      bets: (state) => state.bets,
    }),
  },
  async created() {
    const newBet = this.bets.find((bet) => bet.betId === this.$route.params.id);
    console.log(newBet);
    const bet = await readContract({
      address: "0x6Be57E047566598e263AFf571B51DD7b3Fa3493a",
      abi: bet3,
      functionName: "bets",
      args: [this.$route.params.id],
    });
    const betObject = {
      name: bet[0],
      options: [
        {
          name: bet[1],
          votes: 0,
        },
        {
          name: bet[2],
          votes: 0,
        },
      ],
      amount: bet[3],
      time: bet[4],
      finalizationTime: bet[5],
    };
    this.bet = betObject;
    this.$store.commit("SET_BET", betObject);
    // this.$store.commit("SET_BET", newBet);
    this.betName = bet[0];
    const totalPool = await readContract({
      address: "0x6Be57E047566598e263AFf571B51DD7b3Fa3493a",
      abi: bet3,
      functionName: "getTotalPrize",
      args: [this.$route.params.id],
    });
    this.totalPool = parseInt(ethers.utils.formatEther(totalPool));
    this.$store.commit("SET_TOTAL_POOL", totalPool);
  },
};
</script>

<style lang="scss" scoped>
#bet-details-view {
  color: white;
  display: grid;
  grid-template-columns: 100%;
  grid-template-rows: min-content min-content 1fr;
  height: calc(100% - 32px);
  padding: 16px;

  .header-right {
    align-items: center;
    display: flex;
    color: #4b5565;

    .participants {
      color: white;
      font-size: 14px;
      font-style: normal;
      font-weight: 400;
      line-height: normal;
      letter-spacing: -0.28px;
      margin-left: 8px;
    }
  }

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
  .content {
    align-self: center;
  }
}
</style>
