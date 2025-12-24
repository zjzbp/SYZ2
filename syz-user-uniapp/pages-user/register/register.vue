<template>
	<view class="container">
		<view class="header">
			<text class="title">注册账号</text>
			<text class="subtitle">创建您的专属账号</text>
		</view>
		
		<view class="content">
			<view class="card">
				<view class="input-group">
					<text class="label">姓名</text>
					<input class="input" v-model="form.username" placeholder="请输入您的姓名" />
				</view>
				
				<view class="input-group">
					<text class="label">手机号</text>
					<input class="input" v-model="form.phone" type="number" maxlength="11" placeholder="请输入手机号" />
				</view>
				
				<view class="input-group">
					<text class="label">验证码</text>
					<view class="code-input">
						<input class="input" v-model="form.verifyCode" type="number" maxlength="6" placeholder="请输入验证码" />
						<button class="code-btn" :disabled="countdown > 0" @click="sendCode">
							{{ countdown > 0 ? countdown + 's' : '获取验证码' }}
						</button>
					</view>
				</view>
				
				<view class="input-group">
					<text class="label">密码</text>
					<input class="input" v-model="form.password" password placeholder="请输入密码" />
				</view>
				
				<view class="input-group">
					<text class="label">确认密码</text>
					<input class="input" v-model="confirmPassword" password placeholder="请再次输入密码" />
				</view>
				
				<button class="submit-btn" @click="handleRegister" :loading="loading">注册</button>
				
				<view class="footer">
					<text class="tip">已有账号?</text>
					<text class="link" @click="goToLogin">立即登录</text>
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
			form: {
				username: '',
				phone: '',
				verifyCode: '',
				password: ''
			},
			confirmPassword: '',
			loading: false,
			countdown: 0,
			timer: null
		}
	},
	methods: {
		async sendCode() {
			if (!this.form.phone || !/^1[3-9]\d{9}$/.test(this.form.phone)) {
				uni.showToast({ title: '请输入正确的手机号', icon: 'none' })
				return
			}
			
			try {
				const res = await request.post('/sendCode?phone=' + this.form.phone)
				if (res.code === 1 || res.code === 200) {
					uni.showToast({ title: '验证码已发送', icon: 'success' })
					this.countdown = 60
					this.timer = setInterval(() => {
						this.countdown--
						if (this.countdown <= 0) clearInterval(this.timer)
					}, 1000)
				}
			} catch (error) {
				uni.showToast({ title: '发送失败', icon: 'none' })
			}
		},
		
		async handleRegister() {
			if (!this.form.username || !this.form.phone || !this.form.verifyCode || !this.form.password) {
				uni.showToast({ title: '请填写完整信息', icon: 'none' })
				return
			}
			
			if (this.form.password !== this.confirmPassword) {
				uni.showToast({ title: '两次密码不一致', icon: 'none' })
				return
			}
			
			this.loading = true
			try {
				const res = await request.post('/register', this.form)
				if (res.code === 1 || res.code === 200) {
					uni.showToast({ title: '注册成功', icon: 'success' })
					setTimeout(() => uni.navigateBack(), 1000)
				} else {
					uni.showToast({ title: res.msg || '注册失败', icon: 'none' })
				}
			} catch (error) {
				uni.showToast({ title: '注册失败', icon: 'none' })
			} finally {
				this.loading = false
			}
		},
		
		goToLogin() {
			uni.navigateBack()
		}
	}
}
</script>

<style scoped>
.container {
	min-height: 100vh;
	background: linear-gradient(180deg, #4A90E2 0%, #357ABD 100%);
	padding-top: 60rpx;
}

.header {
	text-align: center;
	padding: 40rpx 32rpx;
}

.title {
	display: block;
	font-size: 48rpx;
	font-weight: bold;
	color: #ffffff;
	margin-bottom: 16rpx;
}

.subtitle {
	display: block;
	font-size: 28rpx;
	color: rgba(255, 255, 255, 0.9);
}

.content {
	padding: 0 32rpx;
}

.card {
	background: #ffffff;
	border-radius: 24rpx;
	padding: 40rpx 32rpx;
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
	box-sizing: border-box;
}

.code-input {
	display: flex;
	gap: 16rpx;
}

.code-input .input {
	flex: 1;
}

.code-btn {
	width: 200rpx;
	height: 88rpx;
	line-height: 88rpx;
	background: #4A90E2;
	color: #ffffff;
	border-radius: 12rpx;
	font-size: 26rpx;
	border: none;
	padding: 0;
}

.code-btn[disabled] {
	background: #CCCCCC;
}

.submit-btn {
	width: 100%;
	height: 88rpx;
	background: linear-gradient(90deg, #4A90E2 0%, #357ABD 100%);
	color: #ffffff;
	border-radius: 12rpx;
	font-size: 32rpx;
	font-weight: 500;
	border: none;
	margin-top: 24rpx;
}

.footer {
	text-align: center;
	margin-top: 32rpx;
}

.tip {
	font-size: 26rpx;
	color: #999999;
	margin-right: 8rpx;
}

.link {
	font-size: 26rpx;
	color: #4A90E2;
	font-weight: 500;
}
</style>
