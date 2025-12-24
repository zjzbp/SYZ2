<template>
	<view class="container">
		<view class="header">
			<text class="title">欢迎注册</text>
			<text class="subtitle">请选择您的注册类型</text>
		</view>
		
		<view class="content">
			<view class="type-card" @click="selectType('enterprise')">
				<view class="card-icon enterprise-icon">
					<text class="icon-text">🏢</text>
				</view>
				<view class="card-content">
					<text class="card-title">企业注册</text>
					<text class="card-desc">适用于企业用户，需提供企业信息及法人信息</text>
				</view>
				<text class="arrow">›</text>
			</view>
			
			<view class="type-card" @click="selectType('personal')">
				<view class="card-icon personal-icon">
					<text class="icon-text">👤</text>
				</view>
				<view class="card-content">
					<text class="card-title">个人注册</text>
					<text class="card-desc">适用于个人用户，填写个人信息即可注册</text>
				</view>
				<text class="arrow">›</text>
			</view>
		</view>
		
		<view class="footer">
			<text class="login-text">已有账号？</text>
			<text class="login-link" @click="goToLogin">立即登录</text>
		</view>
	</view>
</template>

<script>
export default {
	methods: {
		selectType(type) {
			if (type === 'enterprise') {
				uni.navigateTo({
					url: '/pages-user/register-enterprise/register-enterprise'
				});
			} else {
				uni.navigateTo({
					url: '/pages-user/register-personal/register-personal'
				});
			}
		},
		
		goToLogin() {
			uni.redirectTo({
				url: '/pages-user/login/login'
			});
		}
	}
};
</script>

<style scoped>
.container {
	min-height: 100vh;
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	padding: 60rpx 40rpx;
	box-sizing: border-box;
}

.header {
	text-align: center;
	margin-bottom: 100rpx;
}

.title {
	display: block;
	font-size: 48rpx;
	font-weight: bold;
	color: #ffffff;
	margin-bottom: 20rpx;
}

.subtitle {
	display: block;
	font-size: 28rpx;
	color: rgba(255, 255, 255, 0.8);
}

.content {
	padding: 0 20rpx;
}

.type-card {
	background: #ffffff;
	border-radius: 24rpx;
	padding: 40rpx;
	margin-bottom: 30rpx;
	display: flex;
	align-items: center;
	box-shadow: 0 8rpx 30rpx rgba(0, 0, 0, 0.1);
	transition: all 0.3s;
}

.type-card:active {
	transform: scale(0.98);
	box-shadow: 0 4rpx 15rpx rgba(0, 0, 0, 0.1);
}

.card-icon {
	width: 100rpx;
	height: 100rpx;
	border-radius: 20rpx;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-right: 30rpx;
	flex-shrink: 0;
}

.enterprise-icon {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.personal-icon {
	background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
}

.icon-text {
	font-size: 50rpx;
}

.card-content {
	flex: 1;
}

.card-title {
	display: block;
	font-size: 32rpx;
	font-weight: bold;
	color: #333333;
	margin-bottom: 10rpx;
}

.card-desc {
	display: block;
	font-size: 24rpx;
	color: #999999;
	line-height: 1.5;
}

.arrow {
	font-size: 50rpx;
	color: #cccccc;
	margin-left: 20rpx;
}

.footer {
	text-align: center;
	margin-top: 80rpx;
}

.login-text {
	font-size: 28rpx;
	color: rgba(255, 255, 255, 0.8);
}

.login-link {
	font-size: 28rpx;
	color: #ffffff;
	font-weight: bold;
	margin-left: 10rpx;
	text-decoration: underline;
}
</style>
