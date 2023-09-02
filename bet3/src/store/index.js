import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    bet: {
      amount: "",
      name: "",
      options: [],
      time: "",
      type: "",
    },
    userChoice: "",
  },
  getters: {},
  mutations: {
    SET_BET(state, bet) {
      state.bet = bet;
    },
    SET_USER_CHOICE(state, userChoice) {
      state.userChoice = userChoice;
    },
  },
  actions: {},
  modules: {},
});
