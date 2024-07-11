<template>
  <div id="app">
    <router-view />
  </div>
</template>

<script>
// store是单例的
import { useStore } from "vuex";

/*引入全局样式*/
import "./css/global.scss";

export default {
  name: "App",
  created() {
    const store = useStore();
    // get state data in sessionStorage during page loading
    if (sessionStorage.getItem("store")) {
      store.replaceState(
        Object.assign(
          {},
          store.state,
          JSON.parse(sessionStorage.getItem("store"))
        )
      );
    }
    // store state data in sessionStorage during page refresh
    // beforeunload event is triggered first when the page is refreshed
    window.addEventListener("beforeunload", () => {
      sessionStorage.setItem("store", JSON.stringify(store.state));
    });
  },
};
</script>

<style>

#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  display: flex;
  justify-content: center;
}

</style>
