<template>
	<view class="container">
		<view class="header">
			<text class="title">个人注册</text>
		</view>
		
		<view class="content">
			<view class="form-card">
				<!-- 基础信息 -->
				<view class="section-title">基础信息</view>
				
				<view class="form-item">
					<text class="label">手机号 <text class="required">*</text></text>
					<view class="input-wrapper">
						<input 
							class="input" 
							v-model="form.phone" 
							type="number"
							placeholder="请输入手机号"
							maxlength="11"
						/>
					</view>
				</view>
				
				<view class="form-item">
					<text class="label">验证码 <text class="required">*</text></text>
					<view class="input-wrapper code-wrapper">
						<input 
							class="input code-input" 
							v-model="form.verifyCode" 
							type="number"
							placeholder="请输入验证码"
							maxlength="6"
						/>
						<button 
							class="code-btn" 
							@click="sendCode" 
							:disabled="countdown > 0"
						>
							{{ countdown > 0 ? countdown + 's' : '获取验证码' }}
						</button>
					</view>
				</view>
				
				<view class="form-item">
					<text class="label">密码 <text class="required">*</text></text>
					<input 
						class="input" 
						v-model="form.password" 
						type="password"
						placeholder="请输入密码（6-20位）"
						maxlength="20"
					/>
				</view>
				
				<view class="form-item">
					<text class="label">确认密码 <text class="required">*</text></text>
					<input 
						class="input" 
						v-model="form.confirmPassword" 
						type="password"
						placeholder="请再次输入密码"
						maxlength="20"
					/>
				</view>
				
				<!-- 个人信息 -->
				<view class="section-title" style="margin-top: 40rpx;">个人信息</view>
				
				<view class="form-item">
					<text class="label">真实姓名 <text class="required">*</text></text>
					<input 
						class="input" 
						v-model="form.realName" 
						placeholder="请输入真实姓名"
						maxlength="50"
					/>
				</view>
				
				<view class="form-item">
					<text class="label">性别</text>
					<picker 
						:value="genderIndex" 
						:range="genderList" 
						@change="onGenderChange"
					>
						<view class="picker-wrapper">
							<text class="picker-text" :class="{ 'placeholder': !form.gender }">
								{{ form.gender ? getGenderText(form.gender) : '请选择性别' }}
							</text>
							<text class="arrow">›</text>
						</view>
					</picker>
				</view>
				
				<view class="form-item">
					<text class="label">身份证号</text>
					<input 
						class="input" 
						v-model="form.idCard" 
						placeholder="请输入身份证号"
						maxlength="18"
					/>
				</view>
				
				<view class="form-item">
					<text class="label">居住地址</text>
					<input 
						class="input" 
						v-model="form.address" 
						placeholder="请输入居住地址"
					/>
				</view>
				
				<view class="form-item">
					<text class="label">邮箱</text>
					<input 
						class="input" 
						v-model="form.email" 
						placeholder="请输入邮箱"
					/>
				</view>
			</view>
			
			<button class="register-btn" @click="handleRegister">立即注册</button>
			
			<view class="footer-text">
				<text class="text">已有账号？</text>
				<text class="link" @click="goToLogin">立即登录</text>
			</view>
		</view>
	</view>
</template>

<script>
import request from '../utils/request.js';

export default {
	data() {
		return {
			form: {
				phone: '',
				verifyCode: '',
				password: '',
				confirmPassword: '',
				realName: '',
				gender: '',
				idCard: '',
				address: '',
				email: ''
			},
			countdown: 0,
			timer: null,
			genderList: ['男', '女', '其他'],
			genderIndex: -1
		};
	},
	
	methods: {
		// 发送验证码
		async sendCode() {
			if (!this.form.phone) {
				uni.showToast({ title: '请输入手机号', icon: 'none' });
				return;
			}
			
			if (!/^1[3-9]\d{9}$/.test(this.form.phone)) {
				uni.showToast({ title: '手机号格式不正确', icon: 'none' });
				return;
			}
			
			try {
				const res = await request.post('/sendCode?phone=' + this.form.phone);
				
				if (res.code === 1 || res.code === 200) {
					uni.showToast({ title: '验证码已发送', icon: 'success' });
					this.startCountdown();
				} else {
					uni.showToast({ title: res.msg || '发送失败', icon: 'none' });
				}
			} catch (error) {
				uni.showToast({ title: '网络错误', icon: 'none' });
			}
		},
		
		// 倒计时
		startCountdown() {
			this.countdown = 60;
			this.timer = setInterval(() => {
				this.countdown--;
				if (this.countdown <= 0) {
					clearInterval(this.timer);
				}
			}, 1000);
		},
		
		// 性别选择
		onGenderChange(e) {
			this.genderIndex = e.detail.value;
			const genderMap = { 0: 'MALE', 1: 'FEMALE', 2: 'OTHER' };
			this.form.gender = genderMap[e.detail.value];
		},
		
		getGenderText(gender) {
			const map = { 'MALE': '男', 'FEMALE': '女', 'OTHER': '其他' };
			return map[gender] || '';
		},
		
		// 验证表单
		validateForm() {
			if (!this.form.phone) {
				uni.showToast({ title: '请输入手机号', icon: 'none' });
				return false;
			}
			
			if (!/^1[3-9]\d{9}$/.test(this.form.phone)) {
				uni.showToast({ title: '手机号格式不正确', icon: 'none' });
				return false;
			}
			
			if (!this.form.verifyCode) {
				uni.showToast({ title: '请输入验证码', icon: 'none' });
				return false;
			}
			
			if (!this.form.password) {
				uni.showToast({ title: '请输入密码', icon: 'none' });
				return false;
			}
			
			if (this.form.password.length < 6 || this.form.password.length > 20) {
				uni.showToast({ title: '密码长度为6-20位', icon: 'none' });
				return false;
			}
			
			if (!this.form.confirmPassword) {
				uni.showToast({ title: '请确认密码', icon: 'none' });
				return false;
			}
			
			if (this.form.password !== this.form.confirmPassword) {
				uni.showToast({ title: '两次密码不一致', icon: 'none' });
				return false;
			}
			
			if (!this.form.realName) {
				uni.showToast({ title: '请输入真实姓名', icon: 'none' });
				return false;
			}
			
			return true;
		},
		
		// 注册
		async handleRegister() {
			if (!this.validateForm()) {
				return;
			}
			
			uni.showLoading({ title: '注册中...' });
			
			try {
				const res = await request.post('/register/personal', this.form);
				uni.hideLoading();
				
				if (res.code === 1 || res.code === 200) {
					uni.showModal({
						title: '注册成功',
						content: `您的双因子码：${res.data.twoFactorCode}\n请妥善保管，可用于登录`,
						showCancel: false,
						success: () => {
							uni.redirectTo({
								url: '/pages-user/login/login'
							});
						}
					});
				} else {
					uni.showToast({ title: res.msg || '注册失败', icon: 'none' });
				}
			} catch (error) {
				uni.hideLoading();
				uni.showToast({ title: error.message || '网络错误', icon: 'none' });
			}
		},
		
		goToLogin() {
			uni.redirectTo({
				url: '/pages-user/login/login'
			});
		}
	},
	
	beforeDestroy() {
		if (this.timer) {
			clearInterval(this.timer);
		}
	}
};
</script>

<style scoped>
.container {
	min-height: 100vh;
	background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
	padding: 40rpx;
	box-sizing: border-box;
}

.header {
	text-align: center;
	margin-bottom: 40rpx;
}

.title {
	font-size: 44rpx;
	font-weight: bold;
	color: #ffffff;
}

.content {
	/* ... existing code ... */
}

.form-card {
	background: #ffffff;
	border-radius: 24rpx;
	padding: 40rpx;
	margin-bottom: 30rpx;
}

.section-title {
	font-size: 32rpx;
	font-weight: bold;
	color: #333333;
	margin-bottom: 30rpx;
	padding-bottom: 15rpx;
	border-bottom: 2rpx solid #eeeeee;
}

.form-item {
	margin-bottom: 30rpx;
}

.label {
	display: block;
	font-size: 28rpx;
	color: #666666;
	margin-bottom: 15rpx;
}

.required {
	color: #ff4d4f;
}

.input-wrapper {
	position: relative;
}

.input {
	width: 100%;
	height: 88rpx;
	background: #f5f7fa;
	border-radius: 12rpx;
	padding: 0 30rpx;
	font-size: 28rpx;
	color: #333333;
	box-sizing: border-box;
}

.code-wrapper {
	display: flex;
	align-items: center;
	gap: 20rpx;
}

.code-input {
	flex: 1;
}

.code-btn {
	height: 88rpx;
	padding: 0 30rpx;
	background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
	color: #ffffff;
	border-radius: 12rpx;
	font-size: 26rpx;
	border: none;
	flex-shrink: 0;
}

.code-btn[disabled] {
	background: #cccccc;
}

.picker-wrapper {
	height: 88rpx;
	background: #f5f7fa;
	border-radius: 12rpx;
	padding: 0 30rpx;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.picker-text {
	font-size: 28rpx;
	color: #333333;
}

.picker-text.placeholder {
	color: #999999;
}

.arrow {
	font-size: 40rpx;
	color: #cccccc;
}

.register-btn {
	width: 100%;
	height: 88rpx;
	background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
	color: #ffffff;
	border-radius: 12rpx;
	font-size: 32rpx;
	font-weight: bold;
	border: none;
	margin-bottom: 30rpx;
}

.footer-text {
	text-align: center;
	font-size: 28rpx;
}

.text {
	color: rgba(255, 255, 255, 0.8);
}

.link {
	color: #ffffff;
	font-weight: bold;
	text-decoration: underline;
	margin-left: 10rpx;
}
</style>
