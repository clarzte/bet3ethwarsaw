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
  },
  getters: {},
  mutations: {
    SET_BET(state, bet) {
      state.bet = bet;
    },
  },
  actions: {},
  modules: {},
});
