<template>
  <div id="bet-created-view">
    <the-header> Bet Created </the-header>
    <div class="content">
      <lottie-vue-player
        :src="`https://lottie.host/d0ca9303-deca-41b2-8611-f3fdb8558a79/Cu3VIVd8up.json`"
        :player-controls="false"
        autoplay
        backgroundColor="transparent"
        player-size="hide"
        minimizable
        style="width: 100%; height: 400px"
      >
      </lottie-vue-player>
      <div class="congrats">
        Congrats! You’ve just created <br />
        your bet
      </div>
      <div class="friends-info">
        Now you just need to invite your friends to your bet and start betting!
      </div>
      <bet-name disabled :initial-bet-name="betName" />
    </div>
    <div class="footer">
      <div class="buttons-container">
        <BaseBtn class="invite-friends">Invite friends</BaseBtn>
        <BaseBtn class="skip" @click="$router.push('/bet/1')">
          Skip this step
        </BaseBtn>
      </div>
    </div>
  </div>
</template>

<script>
import TheHeader from "@/components/TheHeader.vue";
import BetName from "@/components/BetName.vue";
import BaseBtn from "@/components/BaseBtn.vue";
export default {
  name: "BetCreatedView",
  components: {
    BaseBtn,
    BetName,
    TheHeader,
  },
  data() {
    return {
      betName: this.$store.state.bet.name,
    };
  },
};
</script>

<style lang="scss" scoped>
#bet-created-view {
  color: white;
  display: grid;
  grid-template-columns: 100%;
  grid-template-rows: min-content 1fr auto;
  height: calc(100% - 32px);
  padding: 16px;

  .content {
    align-self: center;
    padding: 0 16px;
    position: relative;
    top: 100px;

    .congrats {
      font-size: 20px;
      font-style: normal;
      font-weight: 500;
      line-height: 30px; /* 150% */
    }

    .friends-info {
      margin-bottom: 24px;
      color: #697586;
      font-size: 16px;
      font-style: normal;
      font-weight: 400;
      line-height: normal;
      letter-spacing: -0.32px;
    }
  }

  .footer {
    align-self: flex-end;
    .buttons-container {
      display: flex;
      flex-direction: column;

      .invite-friends {
        border: none;
        border-radius: 99px;
        background: white;
        font-size: 16px;
        font-style: normal;
        font-weight: 400;
        line-height: normal;
        letter-spacing: -0.32px;
        padding: 15px 32px;
      }

      .skip {
        background: transparent;
        border: none;
        color: #697586;
        font-size: 16px;
        font-style: normal;
        font-weight: 400;
        line-height: normal;
        letter-spacing: -0.32px;
        padding: 15px 32px;
      }
    }
  }
}
</style>

<style>
.vue-lottie-player {
  background: transparent;
  position: absolute;
  height: 400px !important;
  left: 0;
  top: -150px;
  pointer-events: none;
}
</style>
