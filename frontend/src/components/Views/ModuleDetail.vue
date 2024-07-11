<template>
  <el-container>
    <el-header class="header">
      <el-page-header @back="goBack">
        <template #breadcrumb>
          <el-breadcrumb :separator-icon="ArrowRight">
            <el-breadcrumb-item
              :to="{ path: `/${this.$store.state.loginStore.userRole}/home` }"
            >
              homepage
            </el-breadcrumb-item>
            <el-breadcrumb-item
              :to="{
                path: `/${this.$store.state.loginStore.userRole}/module/${accessedCode}`,
              }"
            >
              <a>{{ code }}</a>
            </el-breadcrumb-item>
            <el-breadcrumb-item v-show="!assignmentListVisible">
              {{ assignmentName }}
            </el-breadcrumb-item>
          </el-breadcrumb>
        </template>
        <template #content>
          <!-- 显示页面名称 -->
          <span class="text-large font-600 mr-3"> {{ this.$route.name }} </span>
        </template>
      </el-page-header>
      <div class="button-container" style="color: gray">
        <el-button link @click="handleLogout()">
          <div style="width: 100px">{{ getName }}</div>
          <el-icon><SwitchButton /></el-icon>Log out</el-button
        >
      </div>
    </el-header>
    <el-main class="main">
      <div class="assignmentList" v-show="assignmentListVisible">
        <el-collapse>
          <el-collapse-item
            title="Upcomming assignment"
            v-show="hasContent(upcomingAss)"
          >
            <!-- <div>{{ pastAss }}</div> -->
            <div v-for="assignment in upcomingAss">
              <el-card
                shadow="hover"
                @click="jumpTo(assignment.name, assignment.id)"
              >
                <div class="card-content">
                  {{ assignment.name }}
                </div>
              </el-card>
            </div>
          </el-collapse-item>
          <el-collapse-item
            title="Ongoing assignment"
            v-show="hasContent(ongoingAss)"
          >
            <!-- <div>{{ ongoingAss }}</div> -->
            <div v-for="assignment in ongoingAss">
              <el-card
                shadow="hover"
                @click="jumpTo(assignment.name, assignment.id)"
              >
                <div class="card-content">
                  {{ assignment.name }}
                </div>
              </el-card>
            </div>
          </el-collapse-item>
          <el-collapse-item
            title="Past assignment"
            v-show="hasContent(pastAss)"
          >
            <!-- <div>{{ upcomingAss }}</div> -->
            <div v-for="assignment in pastAss">
              <el-card
                shadow="hover"
                @click="jumpTo(assignment.name, assignment.id)"
              >
                <div class="card-content">
                  {{ assignment.name }}
                </div>
              </el-card>
            </div>
          </el-collapse-item>
        </el-collapse>
      </div>
      <div class="assignmentDetail">
        <router-view />
      </div>
    </el-main>
  </el-container>
</template>

<script>
export default {
  props: ["code"], // 接受名为code的路由参数作为prop
  data() {
    return {
      // 访问的课程代码
      accessedCode: "",
    };
  },
  computed: {
    getName() {
      return this.$store.state.loginStore.userName;
    },
    pastAss() {
      return this.$store.getters.getAssignment.pastAss;
    },
    ongoingAss() {
      return this.$store.getters.getAssignment.ongoingAss;
    },
    upcomingAss() {
      return this.$store.getters.getAssignment.upcomingAss;
    },
    assignmentListVisible() {
      if (this.$route.name === "Assignment information") {
        return true;
      } else return false;
    },
    assignmentName() {
      // 显示访问的ass的信息
      if (this.$route.params.assName) return this.$route.params.assName;
      else {
        return null;
      }
    },
  },
  methods: {
    goBack() {
      this.$router.go(-1);
    },
    jumpTo(assignmentName, assignmentId) {
      const storeUserRole = this.$store.state.loginStore.userRole;
      let pageName = "";
      if (storeUserRole === "teacher") {
        pageName = "Assignment criteria";
      } else if (storeUserRole === "student") {
        pageName = "Assignment detail";
      } else pageName = "Assignment criteria";
      this.$router.push({
        name: pageName,
        params: { assName: assignmentName },
        query: { assId: assignmentId },
      });
    },
    handleLogout() {
      localStorage.removeItem("isAuthenticated");
      this.$router.push("/home");
      // 清空local storage中的信息实现登出
      this.$postRequest("/logout", "")
        .then((resp) => {
          if (resp && resp.status == 200) {
          }
        })
        .catch((error) => {
          console.error("Logout failure", error);
        });
    },
    hasContent(array) {
      if (array.length === 0) return false;
      else return true;
    },
  },
  created() {
    let roleInfo = this.$store.state.loginStore.userRole;
    let id = this.$store.state.loginStore.userName;
    // 获取路由中的module code参数
    this.accessedCode = this.$route.params.code;
    console.log("accessCode:", this.accessedCode);
    // 请求ass信息列表
    this.$store
      .dispatch("getAssDetail", [roleInfo, this.accessedCode, id])
      .catch((e) => {
        console.log("e message", e);
        if (e.response.status === 403) {
          console.log("403");
          this.$router.push("/unauthorized");
        }
        this.$notifyFailed();
      });
    // this.$store.dispatch("getAssDetailSimulated", this.accessedCode);
  },
};
</script>

<style>
.header {
  background-color: rgb(146, 175, 188);
  text-align: center;
  line-height: 60px;
  display: flex;
  color: #d8edfd;
}

.el-breadcrumb__separator {
  margin: 0 9px;
  font-weight: 700;
  color: #5c73a7;
}
/* 调整卡片内容 */
.el-collapse-item__header {
  padding-left: 10px;
  background-color: #cdd4d6;
}
.card-content {
  text-align: left;
}
</style>
