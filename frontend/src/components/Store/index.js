import { createStore } from "vuex";
import axios from "axios";
import {
  mockAssignmentsData,
  mockModulesData,
  mockRubricsData,
} from "../Views/mockData";
import router from '@/components/Router/index.js'

const loginStore = {
  state() {
    return {
      isAuthenticated: localStorage.getItem("isAuthenticated") === "true",
      userName: localStorage.getItem("userName") || "",
      userRole: localStorage.getItem("userRole") || "",
      firstLogin: 'true',
    };
  },
  mutations: {
    login(state, data) {
      state.isAuthenticated = true;
      state.userName = data.userName;
      state.userRole = data.userRole[0].authority.toLowerCase();
      // 更新localStorage
      localStorage.setItem("isAuthenticated", state.isAuthenticated.toString());
      localStorage.setItem("userName", state.userName);
      localStorage.setItem("userRole", state.userRole);
    },
    logout(state) {
      state.isAuthenticated = false;
      state.userRole = "";
      state.firstLogin = 'true';
      // 清除localStorage
      localStorage.removeItem("isAuthenticated");
      localStorage.removeItem("userRole");
      localStorage.removeItem("firstLogin");
      console.log('router: ',this.$router);
      router.push('/login');
    },
    loginMessage(state){
      state.firstLogin = false;
    }
  },
  actions: {
    login({ commit }, data) {
      commit("login", data);
    },
    logout({ commit }) {
      commit("logout");
    },
    loginMessage({commit}){
      commit("loginMessage");
      console.log('cahnge');
    }
  },
};

// 更改获取到的模块的数据格式
function formattedModulesData(initModulesData) {
  /*
  [
    {
        "moduleCode": "COMP211",
        "moduleName": "Introduction to Computer Science",
        "year_start": 2021,
        "year_end": 2022
    }
]
   */
  // 累加器acc初始值是{}，根据start_year添加信息
  const groupByYear = initModulesData.reduce((acc, currentModule) => {
    if (!acc[currentModule.year_start]) {
      acc[currentModule.year_start] = [];
    }
    acc[currentModule.year_start].push({
      code: currentModule.moduleCode,
      name: currentModule.moduleName,
    });
    return acc;
  }, {});
  // 使用entries将临时对象拆开成[year, modules]
  const formattedData = Object.entries(groupByYear).map(([year, modules]) => {
    // 返回对应格式
    return {
      year: year,
      modules: modules,
    };
  });
  return formattedData;
}
const modulesStore = {
  state() {
    return {
      modules: [], // 存储模块数据，以年份为键
      assignments: [],
    };
  },
  mutations: {
    modules(state, data) {
      state.modules = data; // 获取模块年份列表
    },
    assignments(state, data) {
      state.assignments = data;
    },
  },
  actions: {
    getModulesData({ commit }, userInfo) {
      let roleInfo = userInfo.roleInfo;
      let userName = userInfo.userName;
      return axios
        .get(`/${roleInfo}/modules?id=${userName}`)
        .then((response) => {
          console.log("response: ", response.data);
          const formattedData = formattedModulesData(response.data);
          console.log("formatted: ", formattedData);
          commit("modules", formattedData);
        })
        .catch((e) => {
          console.error("Error fetching modules", e);
          throw e;
        });
    },
    getModulesDataSimulate({ commit }) {
      // 只关心起始年份
      const mockData = mockModulesData;
      commit("modules", mockData);
    },
    getAssDetail({ commit }, [roleInfo, code, id]) {
      return axios
        .get(`/${roleInfo}/assignments?moduleCode=${code}&id=${id}`)
        .then((response) => {
          const assignmentData = response.data;
          console.log("get assdata:", assignmentData);
          commit("assignments", assignmentData);
        })
        .catch((e) => {
          console.error("Error fetching assignments", e);
          throw e;
        });
    },
    getAssDetailSimulated({ commit }, code) {
      let mockData = [];
      if (code === "COMP105") {
        mockData = mockAssignmentsData.COMP105;
      } else {
        mockData = mockAssignmentsData.COMP101;
      }

      commit("assignments", mockData);
    },
    getRubricsDetail({ commit }, code) {},
    getRubricsDetailSimulated({ commit }, code) {
      const mockData = mockRubricsData;
      commit("rubrics", data);
    },
  },
  getters: {
    getModules(state) {
      console.log("return modules: ", state.modules);
      return state.modules;
    },
    // 整理后端数据，将数据按照年份分类
    getAssignment(state) {
      const now = new Date();
      const upcomingAss = [];
      const ongoingAss = [];
      const pastAss = [];

      state.assignments.forEach((assignment) => {
        // null 返回 false，反之true
        const startDate = assignment.startDate
          ? new Date(assignment.startDate)
          : null;
        const endDate = assignment.endDate
          ? new Date(assignment.endDate)
          : null;
        if (startDate && endDate) {
          if (startDate > now) {
            upcomingAss.push(assignment);
          } else if (startDate <= now && endDate >= now) {
            ongoingAss.push(assignment);
          } else if (endDate < now) {
            pastAss.push(assignment);
          }
        }
        // start或者end为null的情况
        else {
          if (!startDate && !endDate) {
            ongoingAss.push(assignment);
          } else if (startDate) {
            if (startDate < now) ongoingAss.push(assignment);
            else upcomingAss.push(assignment);
          } else if (endDate) {
            if (endDate < now) pastAss.push(assignment);
            else ongoingAss.push(assignment);
          }
        }
      });
      return { upcomingAss, ongoingAss, pastAss };
    },
  },
};

function findCriterion(state, { rubricId, criterionId }) {
  const rubric = state.rubrics.find((r) => r.id === rubricId);
  if (rubric) {
    const criterion = rubric.criteria.find((c) => c.id === criterionId);
    if (criterion) {
      return criterion;
    } else console.error("could not find the corresponding criterion");
  } else console.error("could not find the corresponding rubric");
  return null;
}
// 存储教师和学生在assignment界面需要的数据
const assignmentStore = {
  state() {
    return {
      assignmentResults: [],
      assignmentFileList: [],
      rubrics: [], // 教师用，存储模块rubrics，包含criteria和小分，自动feedback
      comments: [], // 学生用以rubrics id为键存储comments
      assignmentInfo: {}, // 学生用， 存储作业信息（mark,submitdate等等）
    };
  },
  mutations: {
    assignmentInfo(state, data) {
      state.assignmentInfo = data;
    },
    assignmentResults(state, data) {
      state.assignmentResults = data;
    },
    assignmentFileList(state, data) {
      state.assignmentFileList = data;
    },
    rubrics(state, data) {
      state.rubrics = data;
    },
    deleteComment(state, { rubricId, criterionId, commentId }) {
      const criterion = findCriterion(state, { rubricId, criterionId });
      criterion["hasChanged"] = true;
      // 找到这个comments集合，滤除掉匹配的comment
      criterion.auto_comments = criterion.auto_comments.filter(
        (comment) => comment.id !== commentId
      );
      criterion.auto_comments.sort((a, b) => a.lower_bound - b.lower_bound);
    },
    addComment(state, { rubricId, criterionId, comment }) {
      const criterion = findCriterion(state, { rubricId, criterionId });
      criterion["hasChanged"] = true;
      criterion.auto_comments.push(comment);
      criterion.auto_comments.sort((a, b) => a.lower_bound - b.lower_bound);
    },
    editComment(
      state,
      { rubricId, criterionId, commentId, comment, generateBound }
    ) {
      const criterion = findCriterion(state, { rubricId, criterionId });
      criterion["hasChanged"] = true;
      const stateComment = criterion.auto_comments.find(
        (c) => c.id === commentId
      );
      if (stateComment) {
        stateComment.content = comment;
        stateComment.lower_bound = generateBound[0];
        stateComment.upper_bound = generateBound[1];
      }
      criterion.auto_comments.sort((a, b) => a.lower_bound - b.lower_bound);
    },
  },
  actions: {
    getAssignmentInfo({ commit }, [assId, stuId]) {
      return axios
        .get(`/assignment/overallInfo?assId=${assId}&stuId=${stuId}`)
        .then((response) => {
          let data = response.data;
          const [submitTime, deadline] = [
            new Date(data["submitTime"]),
            new Date(data["deadline"]),
          ];
          data["submitTime"] = submitTime.toLocaleString();
          data["deadline"] = deadline.toLocaleString();
          let delayTime = submitTime - deadline;
          // 将毫秒的插值转换为天数，不满一天算作一天
          if (delayTime > 0) {
            delayTime = Math.ceil(delayTime / (1000 * 60 * 60 * 24));
          } else delayTime = 0;
          data["delayTime"] = delayTime;
          data["penalty"] *= delayTime;
          commit("assignmentInfo", data);
        })
        .catch((e) => {
          console.log("error fetching assignment info", e);
          throw e;
        });
    },
    getAssignmentResults({ commit }, [assignmentId, userId]) {
      return axios
        .get(`/assignment/result?assId=${assignmentId}&stuId=${userId}`)
        .then((response) => {
          const data = response.data;
          commit("assignmentResults", data);
        })
        .catch((e) => {
          console.error("error fetching results", e);
          throw e;
        });
    },
    getAssignmentFileList({ commit }, [assId, stuId]) {
      return axios
        .get(`/assignment/getTargetFile?assId=${assId}&stuId=${stuId}`)
        .then((response) => {
          const data = response.data;
          commit("assignmentFileList", data);
        })
        .catch((e) => {
          console.error("error fetching assignment file list", e);
          throw e;
        });
    },
    getAssignmentRubrics({ commit }, [assignmentId, userId]) {
      return axios
        .get(`/assignment/rubrics?assId=${assignmentId}&teacherId=${userId}`)
        .then((response) => {
          const rubricData = response.data;
          commit("rubrics", rubricData);
        })
        .catch((e) => {
          console.error("error fetching rubrics", e);
          commit("rubrics",[])  // clean rubric list
          throw e;
        });
    },
    deleteComment({ commit }, { rubricId, criterionId, commentId }) {
      commit("deleteComment", { rubricId, criterionId, commentId });
      // 向服务器请求删除数据
    },
    editComment(
      { commit },
      { rubricId, criterionId, commentId, comment, generateBound }
    ) {
      commit("editComment", {
        rubricId,
        criterionId,
        commentId,
        comment,
        generateBound,
      });
    },
    createComment({ commit }, { rubricId, criterionId, comment }) {
      commit("addComment", { rubricId, criterionId, comment });
    },
    saveComments(state, [criterionId, commentList]) {
      // 发送被改动的数据到后端，同步
      console.log("get commentlist: ", [commentList, criterionId]);
      return axios
        .post(`/teacher/saveComments?criterionId=${criterionId}`, commentList, {
          headers: {
            "Content-Type": "application/json",
          },
        })
        .then((resp) => {
          console.log("successful");
        })
        .catch((e) => {
          console.error("error save comments", e);
          throw e;
        });
    },
  },
  getters: {
    getAssignmentInfo(state) {
      console.log("get info: ", state.assignmentInfo);
      return state.assignmentInfo;
    },
    getAssignmentResults(state) {
      return state.assignmentResults;
    },
    getAssignmentFileList(state){
      return state.assignmentFileList;
    },
    getAssignmentRubrics(state) {
      return state.rubrics;
    },
  },
};

const store = createStore({
  // 将store分模块注册
  modules: {
    loginStore: loginStore,
    modulesStore: modulesStore,
    assignmentStore: assignmentStore,
  },
});

export default store;
