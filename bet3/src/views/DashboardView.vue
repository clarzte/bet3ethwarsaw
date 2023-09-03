<template>
  <div id="dashboard-view">
    <div class="nav">
      <div class="left">Bet3</div>
      <div class="right mnt-amount">{{ balance }} MNT</div>
    </div>
    <div class="content">
      <div v-if="bets.length" class="active-bets-container">
        <div class="label">Active bets</div>
        <div
          v-for="bet in bets"
          class="active-bet-card"
          :key="bet.id"
          @click="$router.push(`/bet/${bet.betId}`)"
        >
          <div class="card">
            <div class="text">
              <div class="status">Ongoing</div>
              <span class="title">
                {{ bet.title }}
              </span>
            </div>
            <inline-svg :src="require('../assets/arrow-right.svg')" />
          </div>
          <hr />
          <div class="footer">
            <div class="members">{{ bet.bettorsCount }} Participants</div>
            <div class="prize">
              Prize:
              <span class="amount">
                {{ getTotalPrize(bet.totalPrize) }} $MNT
              </span>
            </div>
          </div>
        </div>
      </div>
      <template v-if="!bets.length">
        <div class="text">You haven’t participate in any bet yet.</div>
        <BaseBtn class="bet-btn" @click="$router.push('/create-bet')">
          Create a Bet
        </BaseBtn>
      </template>
    </div>
    <div class="footer">
      <div
        class="home"
        :class="{ active: activeMenu === 'home' }"
        @click="activeMenu = 'home'"
      >
        <inline-svg :src="star" />
        <span>Home</span>
      </div>
      <div class="float-bet-btn-container">
        <BaseBtn class="float-bet-btn" @click="$router.push('/create-bet')">
          +
        </BaseBtn>
        <span>Create a Bet</span>
      </div>
      <div
        class="explore"
        @click="activeMenu = 'explore'"
        :class="{ active: activeMenu === 'explore' }"
      >
        <inline-svg :src="search" />
        <span>Explore</span>
      </div>
    </div>
  </div>
</template>

<script>
import BaseBtn from "@/components/BaseBtn.vue";
import InlineSvg from "vue-inline-svg";
import { readContract, getAccount, fetchBalance } from "@wagmi/core";
import bet3 from "@/abi/bet3.json";
import { mapState } from "vuex";
import { ethers } from "ethers";

export default {
  name: "DashboardView",
  components: { BaseBtn, InlineSvg },
  data() {
    return {
      balance: null,
      activeMenu: "home",
      star: require("../assets/star.svg"),
      search: require("../assets/search.svg"),
    };
  },
  computed: {
    ...mapState({
      bets: (state) => state.bets,
    }),
  },
  async created() {
    const address = getAccount().address;
    const balance = await fetchBalance({ address });
    this.balance = (+balance.formatted).toFixed(2);
    const getBets = async () => {
      try {
        let bets = await readContract({
          address: "0x8F48AAac0F6fb31DC2e359471fC176c0C42DF305",
          abi: bet3,
          functionName: "getAllBets",
          args: [false],
        });
        bets = bets.slice(-2);
        this.$store.commit("SET_BETS", bets);
      } catch (e) {
        console.error(e);
      }
    };

    setInterval(getBets, 5000);
    getBets();
  },
  methods: {
    getTotalPrize(totalPrize) {
      return ethers.utils.formatEther(totalPrize);
    },
  },
};
</script>

<style lang="scss" scoped>
#dashboard-view {
  display: grid;
  grid-template-rows: auto 1fr auto;
  grid-template-columns: 100%;
  height: calc(100% - 32px);
  padding: 16px;
  .nav {
    align-items: center;
    border-bottom: 1.5px solid white;
    color: white;
    display: flex;
    justify-content: space-between;
    padding: 16px 24px;

    .left {
      font-size: 22px;
      font-weight: 600;
      letter-spacing: -0.44px;
    }
    .right {
      border-radius: 50px;
      border: 1.5px solid white;
      font-size: 16px;
      font-weight: 600;
      letter-spacing: -0.32px;
      padding: 8px 30px;
    }
  }

  .content {
    align-self: center;
    color: white;

    .active-bets-container {
      .label {
        text-align: left;
        color: #fff;
        font-size: 10px;
        font-style: normal;
        font-weight: 600;
        line-height: normal;
        letter-spacing: -0.2px;
        margin-bottom: 10px;
        text-transform: uppercase;
      }

      .active-bet-card {
        border-radius: 16px;
        background: #121926;
        text-align: left;
        padding: 16px;
        margin-bottom: 10px;

        .card {
          align-items: center;
          display: flex;
          justify-content: space-between;

          .status {
            color: #47cd89;
            font-size: 12px;
            font-style: normal;
            font-weight: 600;
            line-height: normal;
            letter-spacing: -0.24px;
          }
          .title {
            font-size: 16px;
            font-style: normal;
            font-weight: 600;
            line-height: normal;
            letter-spacing: -0.32px;
          }
        }

        .footer {
          background: #121926;
          border-radius: 16px;
          display: flex;
          justify-content: space-between;

          .members {
            color: #697586;
            font-size: 14px;
            font-style: normal;
            font-weight: 400;
            line-height: normal;
            letter-spacing: -0.28px;
          }

          .prize {
            color: #697586;
            font-size: 14px;
            font-style: normal;
            font-weight: 400;
            line-height: normal;
            letter-spacing: -0.28px;

            .amount {
              color: #fff;
              font-size: 14px;
              font-style: normal;
              font-weight: 400;
              line-height: normal;
              letter-spacing: -0.28px;
            }
          }
        }
      }
    }

    .text {
      font-size: 16px;
      font-style: normal;
      font-weight: 600;
      line-height: normal;
      letter-spacing: -0.32px;
      margin-bottom: 16px;
    }

    .bet-btn {
      border: none;
      border-radius: 29px;
      background: #6172f3;
      color: white;
      padding: 18px 52px;

      :deep(.text) {
        font-size: 16px;
        font-style: normal;
        font-weight: 600;
        line-height: normal;
        letter-spacing: -0.32px;
      }
    }
  }
  .footer {
    align-items: center;
    background: #0d121c;
    display: flex;
    justify-content: space-around;

    .home {
      align-items: center;
      flex-direction: column;
      display: flex;
      color: white;
      position: relative;
      top: -6px;

      &.active {
        color: #007aff;
        span {
          color: #007aff;
        }
      }

      span {
        color: #999;
        text-align: center;
        font-size: 10px;
        font-weight: 510;
      }
    }

    .float-bet-btn-container {
      align-items: center;
      flex-direction: column;
      display: flex;
      position: relative;
      top: -25px;

      .float-bet-btn {
        background: #6172f3;
        border: none;
        border-radius: 100%;
        color: white;
        font-size: 29px;
        font-weight: 510;
        height: 55px;
        width: 55px;
      }

      span {
        color: #999;
        text-align: center;
        font-size: 10px;
        font-weight: 510;
        position: relative;
        top: 3px;
      }
    }

    .explore {
      align-items: center;
      display: flex;
      flex-direction: column;
      color: white;
      position: relative;
      top: -6px;

      &.active {
        color: #007aff;
        span {
          color: #007aff;
        }
      }

      span {
        color: #999;
        text-align: center;
        font-size: 10px;
        font-style: normal;
        font-weight: 510;
        line-height: normal;
      }
    }
  }

  hr {
    background: #364152;
    border: none;
    height: 1px;
  }
}
</style>
