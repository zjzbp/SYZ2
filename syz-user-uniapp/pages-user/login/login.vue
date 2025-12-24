<template>
	<view class="container">
		<view class="header">
			<view class="welcome">
				<text class="welcome-title">欢迎使用</text>
				<text class="welcome-subtitle">双因子码管理系统</text>
			</view>
		</view>
		
		<view class="content">
			<!-- 登录方式切换 -->
			<view class="tab-bar">
				<view 
					class="tab-item" 
					:class="{active: loginType === 'phone'}"
					@click="switchLoginType('phone')"
				>
					<text>手机号</text>
				</view>
				<view 
					class="tab-item" 
					:class="{active: loginType === 'twoFactorCode'}"
					@click="switchLoginType('twoFactorCode')"
				>
					<text>双因子码</text>
				</view>
				<view 
					class="tab-item" 
					:class="{active: loginType === 'gridCode'}"
					@click="switchLoginType('gridCode')"
				>
					<text>网格码</text>
				</view>
			</view>
			
			<view class="login-card">
				<view class="form">
					<view class="input-group">
						<text class="label">{{ accountLabel }}</text>
						<input 
							class="input" 
							v-model="loginForm.account"
							:type="loginType === 'phone' ? 'number' : 'text'"
							:maxlength="loginType === 'phone' ? 11 : 50"
							:placeholder="accountPlaceholder"
						/>
					</view>
					
					<view class="input-group">
						<text class="label">密码</text>
						<input 
							class="input" 
							v-model="loginForm.password"
							password
							placeholder="请输入密码"
						/>
					</view>
					
					<button class="login-btn" @click="handleLogin" :loading="loading">
						登录
					</button>
					
					<view class="footer-links">
						<text class="link" @click="goToRegister">注册账号</text>
						<text class="link" @click="goToReset">忘记密码</text>
					</view>
					
					<view class="tips" v-if="loginType !== 'phone'">
						<view class="tip-item" v-if="loginType === 'twoFactorCode'">
							<text class="dot">•</text>
							<text class="tip-text">双因子码在注册时自动生成，格式为: TFC-XXXXXXXX</text>
						</view>
						<view class="tip-item" v-if="loginType === 'gridCode'">
							<text class="dot">•</text>
							<text class="tip-text">网格码需先登录后在个人中心填写信息获取</text>
						</view>
					</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
import request from '../utils/request.js'

export default {
	data() {
		return {
			loginType: 'phone', // 'phone', 'twoFactorCode', 'gridCode'
			loginForm: {
				account: '',
				password: ''
			},
			loading: false
		}
	},
	computed: {
		accountLabel() {
			const labels = {
				phone: '手机号',
				twoFactorCode: '双因子码',
				gridCode: '网格码'
			}
			return labels[this.loginType] || '账号'
		},
		accountPlaceholder() {
			const placeholders = {
				phone: '请输入手机号',
				twoFactorCode: '请输入双因子码',
				gridCode: '请输入网格码'
			}
			return placeholders[this.loginType] || '请输入账号'
		}
	},
	methods: {
		// 切换登录方式
		switchLoginType(type) {
			this.loginType = type
			this.loginForm.account = '' // 清空账号
		},
		
		// 通用登录方法
		async handleLogin() {
			// 验证账号
			if (!this.loginForm.account) {
				uni.showToast({
					title: '请输入' + this.accountLabel,
					icon: 'none'
				})
				return
			}
			
			// 手机号格式验证
			if (this.loginType === 'phone' && !/^1[3-9]\d{9}$/.test(this.loginForm.account)) {
				uni.showToast({
					title: '手机号格式不正确',
					icon: 'none'
				})
				return
			}
			
			// 验证密码
			if (!this.loginForm.password) {
				uni.showToast({
					title: '请输入密码',
					icon: 'none'
				})
				return
			}
			
			this.loading = true
			try {
				const res = await request.post('/login', {
					loginType: this.loginType,
					account: this.loginForm.account,
					password: this.loginForm.password
				})
				
				if (res.code === 1 || res.code === 200) {
					const data = res.data
					uni.setStorageSync('token', data.token)
					uni.setStorageSync('userId', data.id)
					uni.setStorageSync('userInfo', JSON.stringify(data))
					
					uni.showToast({
						title: '登录成功',
						icon: 'success'
					})
					
					setTimeout(() => {
						uni.redirectTo({
							url: '/pages-user/dashboard/dashboard'
						})
					}, 1000)
				} else {
					uni.showToast({
						title: res.msg || '登录失败',
						icon: 'none'
					})
				}
			} catch (error) {
				console.error(error)
				uni.showToast({
					title: '登录失败,请稍后重试',
					icon: 'none'
				})
			} finally {
				this.loading = false
			}
		},
		
		goToRegister() {
			uni.navigateTo({
				url: '/pages-user/register-select/register-select'
			})
		},
		goToReset() {
			uni.navigateTo({
				url: '/pages-user/reset-password/reset-password'
			})
		}
	}
}
</script>

<style scoped>
.container {
	min-height: 100vh;
	background: linear-gradient(180deg, #4A90E2 0%, #357ABD 100%);
}

.header {
	padding: 100rpx 40rpx 60rpx;
}

.welcome {
	text-align: center;
}

.welcome-title {
	display: block;
	font-size: 48rpx;
	font-weight: bold;
	color: #ffffff;
	margin-bottom: 16rpx;
}

.welcome-subtitle {
	display: block;
	font-size: 28rpx;
	color: rgba(255, 255, 255, 0.9);
}

.content {
	padding: 0 32rpx;
}

.tab-bar {
	display: flex;
	background: rgba(255, 255, 255, 0.2);
	border-radius: 16rpx;
	padding: 8rpx;
	margin-bottom: 24rpx;
}

.tab-item {
	flex: 1;
	height: 72rpx;
	line-height: 72rpx;
	text-align: center;
	font-size: 28rpx;
	color: rgba(255, 255, 255, 0.7);
	border-radius: 12rpx;
	transition: all 0.3s;
}

.tab-item.active {
	background: #ffffff;
	color: #4A90E2;
	font-weight: 500;
}

.login-card {
	background: #ffffff;
	border-radius: 24rpx;
	padding: 40rpx 32rpx;
	box-shadow: 0 8rpx 24rpx rgba(0, 0, 0, 0.1);
}

.card-header {
	margin-bottom: 40rpx;
}

.card-title {
	font-size: 36rpx;
	font-weight: bold;
	color: #333333;
}

.input-group {
	margin-bottom: 32rpx;
}

.label {
	display: block;
	font-size: 28rpx;
	color: #666666;
	margin-bottom: 12rpx;
}

.input {
	width: 100%;
	height: 88rpx;
	padding: 0 24rpx;
	background: #F7F8FA;
	border-radius: 12rpx;
	font-size: 28rpx;
	color: #333333;
	box-sizing: border-box;
}

.login-btn {
	width: 100%;
	height: 88rpx;
	line-height: 88rpx;
	background: linear-gradient(90deg, #4A90E2 0%, #357ABD 100%);
	border-radius: 12rpx;
	color: #ffffff;
	font-size: 32rpx;
	font-weight: 500;
	border: none;
	margin-top: 24rpx;
}

.footer-links {
	display: flex;
	justify-content: space-between;
	margin-top: 32rpx;
}

.link {
	font-size: 26rpx;
	color: #4A90E2;
}

.tips {
	margin-top: 32rpx;
	background: #F0F7FF;
	border-radius: 12rpx;
	padding: 20rpx;
}

.tip-item {
	display: flex;
	align-items: flex-start;
	margin-bottom: 12rpx;
}

.tip-item:last-child {
	margin-bottom: 0;
}

.dot {
	color: #4A90E2;
	margin-right: 8rpx;
	font-size: 24rpx;
}

.tip-text {
	flex: 1;
	font-size: 24rpx;
	color: #666666;
	line-height: 1.6;
}

/* 响应式 */
@media screen and (min-width: 768px) {
	.container {
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.content {
		width: 100%;
		max-width: 450px;
	}
}
</style>
