import { createApp } from "vue";
import { router, vuetify } from "./providers";
import App from "./App.vue";

const app = createApp(App);

app.use(router).use(vuetify).mount("#app");
