import './assets/main.css'
import { createApp } from 'vue'
import App from './App.vue'
import ElementPlus from 'element-plus'
import * as ElementPlusIconsVue from '@element-plus/icons-vue'
import 'element-plus/dist/index.css'
import {getRequest} from './utils/api'
import {postRequest} from './utils/api'
import {deleteRequest} from './utils/api'
import {putRequest} from './utils/api'
import router from './components/Router'
import store from './components/Store/index.js'


// 创建应用实例
const app = createApp(App)
// 注册所有的element图标
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
    app.component(key, component)
  }
// 使用插件
app.use(ElementPlus)
app.use(store)
app.use(router)
// 挂载应用实例到DOM
app.mount('#app')


// vue3版本的向所有组件实例添加全局方法的功能
app.config.globalProperties.$getRequest = getRequest
app.config.globalProperties.$postRequest = postRequest
app.config.globalProperties.$deleteRequest = deleteRequest
app.config.globalProperties.$putRequest = putRequest
// 添加默认的弹窗效果
app.config.globalProperties.$notifySuccessed = 
function(message) {
  this.$notify({
    title: 'Success',
    message: message || 'Operation successful!',
    type: 'success',
    duration: 5000  // 持续时间，单位毫秒，默认5000
  });
}

app.config.globalProperties.$notifyFailed = 
function(message) {
  this.$notify({
    title: 'Error',
    message: message || 'Operation error!',
    type: 'error',
    duration: 5000  // 持续时间，单位毫秒，默认5000
  });
}

app.config.globalProperties.$baseUrl = '/api';