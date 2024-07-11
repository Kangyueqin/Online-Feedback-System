<template>
  <el-form
    :rules="rules"
    :model="loginForm"
    class="login-container"
    label-position="left"
    label-width="0px"
    v-loading="loading"
  >
    <h3 class="login_title">Sign in</h3>
    <el-form-item prop="username" required>
      <el-input
        type="text"
        v-model="loginForm.username"
        auto-complete="off"
        placeholder="account"
      ></el-input>
    </el-form-item>
    <el-form-item prop="password" required>
      <el-input
        type="password"
        v-model="loginForm.password"
        auto-complete="off"
        placeholder="password"
      ></el-input>
    </el-form-item>
    <el-button type="primary" @click="submitClick"> Login </el-button>
  </el-form>
</template>

<script>
// Spring security无法解析JSON格式的请求
import axios from "axios";
axios.defaults.headers.post["Content-Type"] =
  "application/x-www-form-urlencoded";
export default {
  data() {
    return {
      rules: {
        account: [
          { required: true, message: "enter your username", trigger: "change" },
        ],
        password: [
          { required: true, message: "enter your password", trigger: "change" },
        ],
      },
      checked: true,
      loginForm: {
        username: this.$store.state.loginStore.userName,
        password: "",
      },
      loading: false,
    };
  },
  methods: {
    submitClick: function () {
      var _this = this;
      this.loading = true;
      this.$postRequest("/login", {
        username: this.loginForm.username,
        password: this.loginForm.password,
      })
        .then((resp) => {
          _this.loading = false;
          if (resp && resp.status == 200) {
            const data = resp.data;
            const userRole = resp.data.userRole[0].authority.toLowerCase();
            const userName = resp.data.userName;
            _this.$store.dispatch("login", resp.data);
            localStorage.setItem("isAuthenticated", "ture");
            localStorage.setItem(
              "userRole",
              userRole
            );
            localStorage.setItem("userName", userName);
            _this.$router.push({path: `/${userRole}/home`});
          }
        })
        .catch((e) => {
          this.loading = false;
          console.error("login failure");
          if (e.response.status === 401) {
            this.$notifyFailed("Wrong username or password");
          }
        });
    },
  },
};
</script>

<style>
.login-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
}
</style>
