import Vue from "vue";
import App from "./App.vue";
import "./registerServiceWorker";
import router from "./router";
import store from "./store";
import LottieVuePlayer from "@lottiefiles/vue-lottie-player";

Vue.config.productionTip = false;

Vue.use(LottieVuePlayer);

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount("#app");
