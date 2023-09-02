import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    bets: [],
    bet: {
      amount: "",
      name: "",
      options: [],
      time: "",
      type: "",
    },
    userChoice: "",
    totalPool: 1450,
  },
  getters: {},
  mutations: {
    SET_BET(state, bet) {
      state.bet = bet;
    },
    SET_BETS(state, bets) {
      state.bets = bets;
    },
    SET_USER_CHOICE(state, userChoice) {
      state.userChoice = userChoice;
    },
    SET_TOTAL_POOL(state, totalPool) {
      state.totalPool = totalPool;
    },
    ADD_VOTE(state, index) {
      state.bet.options[index].votes++;
    },
  },
  actions: {},
  modules: {},
});
