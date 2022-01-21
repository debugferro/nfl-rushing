import axios from 'axios';
import { getApiUrl } from '../configs';

axios.defaults.baseURL = getApiUrl();

export const request = async (info) => {
    const axiosArgs = info.data ? [info.url, info.data, info.configs] : [info.url, info.configs]
    const response = await axios[info.actionType].apply(this, axiosArgs);
    return response.data;
}