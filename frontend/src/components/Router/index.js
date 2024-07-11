import { createRouter, createWebHistory } from "vue-router";
import Login from "@/components/Views/Login.vue";
import Home from "../Views/Home.vue";
import ModuleDetail from "../Views/ModuleDetail.vue";
import AssignmentStudent from "../Views/AssignmentStudent.vue";
import AssignmentTeacher from "../Views/AssignmentTeacher.vue";
import UnAuthenrized from "../Views/UnAuthenrized.vue";
import PageNotFound from "../Views/PageNotFound.vue";

document.title = 'Online feedback system'

const routes = [
  { path: "/login", component: Login},
  { path: "/:role/home", component: Home, name: "home" },
  { path: "/unauthorized", component: UnAuthenrized },
  { path: "/notfound", component: PageNotFound},
  {
    // Routes with module code parameters
    path: "/:role/module/:code",
    component: ModuleDetail,
    props: true, // Accepts route parameters
    name: "Assignment information",
    children: [
      {
        // Child route doesn't have '/'
        path: "assignment_result/:assName",
        component: AssignmentStudent,
        props: true,
        name: "Assignment detail",
      },
      {
        path: "assignment_setting/:assName",
        component: AssignmentTeacher,
        props: true,
        name: "Assignment criteria",
      },
    ],
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

// route guard
router.beforeEach((to, from, next) => {
  // Convert role to lower case because it need to be written in the route
  let role = localStorage.getItem("userRole");
  console.log("role:", role);
  role !== "" && role !== null ? (role = role.toLowerCase()) : (role = "");
  const isAuthnticated = localStorage.getItem("isAuthenticated");
  // if page unexist
  if (to.matched.length === 0){
    if (isAuthnticated) {
      next("/notFound");
    }
    else{
      next("/login")
    }
  }
  // if user haven't be authenticated
  if (to.path !== "/login" && !isAuthnticated) {
    next("/login");
    // if user access unauthorized page
  } else if (to.params?.role && to.params?.role !== role) {
    next("/unauthorized");
  } else if (
    to.path === "/" &&
    isAuthnticated &&
    role !== null &&
    role !== undefined
  ) {
    next({ name: "home", params: { role: role } });
  } else next();
});

export default router;
