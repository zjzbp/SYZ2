<template>
	<view class="container">
		<view class="header">
			<text class="title">填写网格码</text>
			<text class="subtitle">开通您的网格权益</text>
		</view>
		
		<view class="content">
			<view class="card">
				<view class="input-group">
					<text class="label">网格码</text>
					<input class="input" v-model="gridCode" placeholder="请输入您的网格码" />
				</view>
				
				<view class="tips">
					<view class="tip-item">
						<text class="dot">•</text>
						<text class="tip-text">网格码是您在系统中的唯一标识</text>
					</view>
					<view class="tip-item">
						<text class="dot">•</text>
						<text class="tip-text">填写后将自动开通网格权益功能</text>
					</view>
					<view class="tip-item">
						<text class="dot">•</text>
						<text class="tip-text">请确保网格码信息准确无误</text>
					</view>
				</view>
				
				<button class="submit-btn" @click="handleSubmit" :loading="loading">提交</button>
				<button class="cancel-btn" @click="goBack">取消</button>
			</view>
		</view>
	</view>
</template>

<script>
import request from '../utils/request.js'

export default {
	data() {
		return {
			gridCode: '',
			userId: null,
			loading: false
		}
	},
	onLoad() {
		this.userId = uni.getStorageSync('userId')
		console.log('获取到的userId:', this.userId)
		
		// 如果userID不存在，提示重新登录
		if (!this.userId) {
			uni.showModal({
				title: '提示',
				content: '请先登录',
				showCancel: false,
				success: () => {
					uni.redirectTo({
						url: '/pages-user/login/login'
					})
				}
			})
		}
	},
	methods: {
		async handleSubmit() {
			if (!this.gridCode) {
				uni.showToast({ title: '请输入网格码', icon: 'none' })
				return
			}
			
			// 再次检查userId
			if (!this.userId) {
				uni.showModal({
					title: '提示',
					content: '请先登录',
					showCancel: false,
					success: () => {
						uni.redirectTo({
							url: '/pages-user/login/login'
						})
					}
				})
				return
			}
			
			console.log('提交的数据:', { userId: this.userId, gridCode: this.gridCode })
			
			this.loading = true
			try {
				const res = await request.post('/fillInfo', {
					userId: this.userId,
					gridCode: this.gridCode
				})
				
				if (res.code === 1 || res.code === 200) {
					uni.showToast({ title: '网格权益开通成功', icon: 'success' })
					setTimeout(() => uni.navigateBack(), 1000)
				} else {
					uni.showToast({ title: res.msg || '提交失败', icon: 'none' })
				}
			} catch (error) {
				console.error('提交错误:', error)
				uni.showToast({ title: '提交失败', icon: 'none' })
			} finally {
				this.loading = false
			}
		},
		
		goBack() {
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

.tips {
	background: #F0F7FF;
	border-radius: 12rpx;
	padding: 24rpx;
	margin-bottom: 24rpx;
}

.tip-item {
	display: flex;
	margin-bottom: 12rpx;
}

.tip-item:last-child {
	margin-bottom: 0;
}

.dot {
	color: #4A90E2;
	margin-right: 8rpx;
}

.tip-text {
	flex: 1;
	font-size: 24rpx;
	color: #666666;
	line-height: 1.6;
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
	margin-bottom: 16rpx;
}

.cancel-btn {
	width: 100%;
	height: 88rpx;
	background: #F7F8FA;
	color: #666666;
	border-radius: 12rpx;
	font-size: 30rpx;
	border: none;
}
</style>
