import Vue from "vue";
import VueRouter from "vue-router";
import HomeView from "../views/HomeView.vue";

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "home",
    component: HomeView,
  },
  {
    path: "/about",
    name: "about",
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () =>
      import(/* webpackChunkName: "about" */ "../views/AboutView.vue"),
  },
  {
    path: "/dashboard",
    name: "dashboard",
    component: () => import("../views/DashboardView.vue"),
  },
  {
    path: "/create-bet",
    name: "create-bet",
    component: () => import("../views/CreateBetView.vue"),
  },
  {
    path: "/bet-created",
    name: "bet-created",
    component: () => import("../views/BetCreatedView.vue"),
  },
  {
    path: "/bet/:id",
    name: "bet-detail",
    component: () => import("../views/BetDetailsView.vue"),
    meta: { requiresAuth: true },
  },
  {
    path: "/bet/:id/confirm",
    name: "bet-confirm",
    component: () => import("../views/BetConfirmView.vue"),
  },
  {
    path: "/bet/:id/confirmed",
    name: "bet-confirmed",
    component: () => import("../views/BetConfirmedView.vue"),
  },
  {
    path: "/bet/:id/ended",
    name: "bet-ended",
    component: () => import("../views/BetEndedView.vue"),
  },
];

const router = new VueRouter({
  mode: "history",
  base: process.env.BASE_URL,
  routes,
});

// router.beforeEach((to) => {
//   const loggedIn = localStorage.getItem("address");
//   // instead of having to check every route record with
//   // to.matched.some(record => record.meta.requiresAuth)
//   if (to.meta.requiresAuth && !loggedIn) {
//     // this route requires auth, check if logged in
//     // if not, redirect to login page.
//     return {
//       path: "/",
//       // save the location we were at to come back later
//       query: { redirect: to.fullPath },
//     };
//   }
// });

export default router;
