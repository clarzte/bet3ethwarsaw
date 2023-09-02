<template>
  <div id="bet-created-view">
    <the-header> Bet Created </the-header>
    <div class="content">
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
        <BaseBtn class="skip">Skip this step</BaseBtn>
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
