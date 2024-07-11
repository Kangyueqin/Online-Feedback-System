import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    vue(),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  },
  server: {
    proxy: {
      // 代理规则：将 /api 开头的请求代理到另一个服务器
      '/api': {
        target: 'http://localhost:8080', // 目标接口的域名或IP及端口号
        changeOrigin: true, // 是否改变域名来源
        rewrite: 
        (path) => path.replace(/^\/api/, ''), // 路径重写，移除 /api
      },
      // 你可以在这里继续添加其他代理规则
    }
  },
  build: {  // 配置debug
    sourcemap: true
  }

})
