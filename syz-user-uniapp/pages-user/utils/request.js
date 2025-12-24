// 封装的请求工具类
const BASE_URL = 'http://localhost:8080/user' // 后端接口地址，根据实际情况修改

const request = (options) => {
	return new Promise((resolve, reject) => {
		// 获取token
		const token = uni.getStorageSync('token')
		
		uni.request({
			url: BASE_URL + options.url,
			method: options.method || 'GET',
			data: options.data || {},
			header: {
				'Content-Type': 'application/json',
				'Authorization': token ? `Bearer ${token}` : ''
			},
			success: (res) => {
				if (res.statusCode === 200) {
					resolve(res.data)
				} else {
					reject(res.data)
				}
			},
			fail: (err) => {
				reject(err)
			}
		})
	})
}

export default {
	get(url, data) {
		return request({
			url: url,
			method: 'GET',
			data: data
		})
	},
	post(url, data) {
		return request({
			url: url,
			method: 'POST',
			data: data
		})
	},
	put(url, data) {
		return request({
			url: url,
			method: 'PUT',
			data: data
		})
	},
	delete(url, data) {
		return request({
			url: url,
			method: 'DELETE',
			data: data
		})
	}
}
