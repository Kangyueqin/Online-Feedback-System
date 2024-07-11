<template>
  <head>
    <title>haha</title>
  </head>
  <el-container>
    <!-- header -->
    <el-header>
      <h2 class="title">Dashboard</h2>
      <div class="button-container" style="color: gray;">
        <el-button link @click="handleLogout()">
      <div style="width: 100px;"f>{{getName}}</div>
          <el-icon><SwitchButton /></el-icon>Log out</el-button
        >
      </div>
    </el-header>

    <el-container>
      <!-- aside -->
      <el-aside :width="isCollapse ? '65px' : '150px'">
        <div class="menubutton-container">
          <el-button @click="showMenu" class="menubutton">
            <el-icon><grid /></el-icon
          ></el-button>
        </div>

        <el-menu
          :default-active="selectedYear"
          class="el-menu-vertical-demo"
          :collapse="isCollapse"
          :collapse-transition="false"
        >
          <el-menu-item-group>
            <div>
              <el-menu-item :index="'0'" @click="showModules(0)">
                <el-icon><Folder /></el-icon>
                <template #title>ALL</template>
              </el-menu-item>
            </div>
            <div v-for="yearModules in modulesByYear" :key="yearModules.year">
              <!-- 以年份作为菜单 -->
              <el-menu-item
                :index="yearModules.year"
                @click="showModules(yearModules.year)"
              >
                <el-icon><Folder /></el-icon>
                <template #title>
                  {{ yearModules.year }}
                </template>
              </el-menu-item>
            </div>
          </el-menu-item-group>
        </el-menu>
      </el-aside>
      <!-- main -->
      <el-main class="card-container">
        <div class="module-container"
          v-for="yearModules in modulesByYear"
          :key="yearModules.year"
          v-show="selectedYear === 0 || selectedYear === yearModules.year"
        >
          <el-row :gutter="0">
            <el-col
              :xs="24"
              :sm="8"
              :md="6"
              :lg="6"
              :xl="6"
              v-for="module in yearModules.modules"
              :key="module.code"
            >
              <el-card
                shadow="always"
                class="box-card"
                @click="jumpTo(module.code)"
                @mouseenter="cardSelected(module.code)"
                :class="{ selected: selectedIndex === module.code }"
              >
                <template #header>
                  <span class="card-header">{{ module.code }}</span>
                </template>
                <div class="card-content">
                  {{ module.name }}
                </div>
              </el-card>
            </el-col>
          </el-row>
        </div>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
import store from "../Store";
import router from "../Router";
export default {
  data() {
    return {
      // 控制菜单收起/打开
      isCollapse: false,
      // 菜单视图的显示, 0 表示全部
      selectedYear: 0,
      // 被选定的卡片index
      selectedIndex: 0,
    };
  },
  watch: {
    modulesByYear(newmodulesByYear) {
      if (newmodulesByYear.length > 0) {
        // 设置当前目录为最新年份
        const latestYearModule = newmodulesByYear[0];
        this.selectedYear = latestYearModule.year;
      }
    },
  },
  computed: {
    modulesByYear() {
      console.log("get module: ", store.getters.getModules);
      // 创建一个浅拷贝以避免数组reverse导致的无限递归
      const reverseModules = [...store.getters.getModules].sort(
        (a, b) => b.year - a.year
      );
      return reverseModules;
    },
    getName() {
      return store.state.loginStore.userName;
    }
  },
  methods: {
    showMenu() {
      if (this.isCollapse) {
        this.isCollapse = false;
      } else {
        this.isCollapse = true;
      }
    },
    // 修改selectedYear来控制模块显示
    showModules(changeToYear) {
      this.selectedYear = changeToYear;
      console.log("sY: ", this.selectedYear);
    },
    // 卡片点击跳转
    jumpTo(moduleCode) {
      router.push({
        name: "Assignment information",
        params: { code: moduleCode },
      });
    },
    // 卡片被选中效果
    cardSelected(index) {
      this.selectedIndex = index;
    },
    handleLogout() {
      this.$store.dispatch('logout');
    },
  },
  created() {
    let roleInfo = store.state.loginStore.userRole;
    let userName = store.state.loginStore.userName;
    console.log("axios get module", roleInfo, userName);
    store
      .dispatch("getModulesData", { roleInfo, userName })
      .then((response) => {
        // 登陆成功提示;
        console.log('haha',store.state.loginStore.firstLogin);
        if (store.state.loginStore.firstLogin === 'true') {
          this.$message({ message: "Login successful!", type: "success" });
          console.log('message');
          store.dispatch("loginMessage")
        }
      })
      .catch((e) => {
        console.log(e.response.status);
        if (e.response.status === 500) {
          this.$notifyFailed("Please check your network");
        }
      });
  },
};
</script>

<style>
html,
body {
  height: 100%;
  margin: 0;
}

body > .el-container {
  display: flex;
  flex-direction: column; /* 确保这是一个纵向布局 */
  min-height: 100vh; /* 使用视口高度确保填满整个屏幕 */
}
.el-header {
  background-color: rgb(146, 175, 188);
  color: #333;
  text-align: center;
  line-height: 60px;
  display: flex; /* 启用 flex 布局 */
  justify-content: space-between; /* 子元素分布在两端 */
}

.title {
  display: flex;
  color: #d8edfd;
  font-weight: bold;
}

.button-container {
  display: flex;
  margin-left: auto;
  justify-content: flex-end; /* 水平方向靠右 */
  align-self: flex-end; /* 垂直方向靠底 */
}

.el-aside {
  background-color: #d0d7df;
  color: #333;
  text-align: center;
  line-height: 60px;
  display: flex;
  flex-direction: column; /* 设置侧边栏为纵向排列 */
}

.el-menu {
  background-color: #d0d7df;
}
.menubutton-container {
  display: flex;
  height: 30px; /* 指定一个明确的高度 */
}

.menubutton {
  height: 100%;
  width: 100%;
  padding: 0%;
}
.el-main {
  background-color: #e9edf0;
  color: #333;
  text-align: center;
  line-height: 160px;
}

/* card */

.module-container {
  border-bottom: 1px solid #ccc; /* 底部边框，1像素粗细，灰色 */
  margin: 5px;
}

.card-container {
  align-items: stretch;
  gap: 15px; /* 可以根据需要调整间距 */
}

.box-card {
  width: 200px;
  height: 250px;
  margin-bottom: 10px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 20px;
}

.card-content {
  word-wrap: break-word;
  overflow-wrap: break-word;
  line-height: 200%;
}

/* 被选中的卡片加一层描边 */
.selected {
  border: 2px solid #409eff;
}

.el-icon {
  margin-right: 4px;
}
</style>
