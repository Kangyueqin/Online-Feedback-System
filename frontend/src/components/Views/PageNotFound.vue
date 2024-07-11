<template>
  <div class="message">
    <el-result
      icon="error"
      title="Page not found"
      sub-title="Click the button to go back to home"
    >
      <template #extra>
        <el-button type="primary" @click="backToHome">Back</el-button>
      </template>
    </el-result>
  </div>
</template>

<script>
export default {
  data() {
    return {};
  },
  methods: {
    backToHome() {
      const role = this.$store.state.loginStore.userRole;
      this.$router.push(`/${role}/home`);
    },
  },
  created() {
    const role = this.$store.state.loginStore.userRole;
    this.$message({
      message: `Page not found!`,
      type: "error",
    });
  },
};
</script>

<style>
.message{
    display: flex;
}
</style>
