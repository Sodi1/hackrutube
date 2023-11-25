import { createRouter, createWebHistory } from "vue-router";
import { MissingPage } from "@/pages";

const routes = [
  {
    path: "/",
    redirect: { name: "Home" },
    component: () => import("@/pages/layouts/BaseLayout.vue"),
    children: [
      {
        name: "Home",
        path: "/home",
        component: () => import("@/pages/HomePage.vue"),
      },
    ],
  },
  {
    path: "/:catchAll(.*)*",
    component: MissingPage,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes: routes,
});


export { router };
