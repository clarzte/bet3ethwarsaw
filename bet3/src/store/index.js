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
    betCreatedContractResponse: null,
    betPlacedContractResponse: null,
    betFinalizedContractResponse: null,
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
    SET_BET_CREATED_CONTRACT_RESPONSE(state, betCreatedContractResponse) {
      state.betCreatedContractResponse = betCreatedContractResponse;
    },
    SET_BET_PLACED_CONTRACT_RESPONSE(state, betPlacedContractResponse) {
      state.betPlacedContractResponse = betPlacedContractResponse;
    },
    SET_BET_FINALIZED_CONTRACT_RESPONSE(state, betFinalizedContractResponse) {
      state.betFinalizedContractResponse = betFinalizedContractResponse;
    },
  },
  actions: {},
  modules: {},
});
