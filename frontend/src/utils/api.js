import axios from 'axios'

// 设置 axios请求的基本配置
axios.defaults.baseURL = '/api';

export const getRequest = (url, params = {}) => axios.get(url, {params})
export const postRequest = (url, data) => axios.post(url, data);
export const deleteRequest = (url) => axios.delete(url);
export const putRequest = (url, data) => axios.put(url, data);
