<template>
  <div id="dashboard-view">
    <div class="nav">
      <div class="left">Bet3</div>
      <div class="right mnt-amount">0 MNT</div>
    </div>
    <div class="content">
      <div class="text">You haven’t participate in any bet yet.</div>
      <BaseBtn class="bet-btn">Create a Bet</BaseBtn>
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
        <BaseBtn class="float-bet-btn">+</BaseBtn>
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

export default {
  name: "DashboardView",
  components: { BaseBtn, InlineSvg },
  data() {
    return {
      star: require("../assets/star.svg"),
      search: require("../assets/search.svg"),
      activeMenu: "home",
    };
  },
  methods: {},
};
</script>

<style lang="scss" scoped>
#dashboard-view {
  display: grid;
  grid-template-rows: auto 1fr auto;
  grid-template-columns: 100%;
  height: 100%;
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
}
</style>
