<template>
	<view class="container">
		<view class="header">
			<text class="title">模态标识历史</text>
			<text class="subtitle">查看您已使用的模态标识</text>
		</view>
		
		<view class="content">
			<view class="count-card">
				<text class="count-label">已使用次数</text>
				<text class="count-value">{{ userModals.length }}</text>
			</view>
			
			<view class="list-card" v-if="userModals.length > 0">
				<view class="history-list">
					<view class="history-item" v-for="(item, index) in userModals" :key="index">
						<view class="item-header">
							<text class="item-index">#{{ userModals.length - index }}</text>
							<text class="item-status" v-if="item.modalId === userInfo.modalId">当前使用</text>
						</view>
						<view class="item-body">
							<text class="modal-label">模态标识</text>
							<text class="modal-value">{{ item.modalId }}</text>
						</view>
						<view class="item-footer">
							<text class="item-time">{{ formatTime(item.createTime) }}</text>
						</view>
					</view>
				</view>
			</view>
			
			<view class="empty-card" v-else>
				<text class="empty-text">暂无历史记录</text>
				<text class="empty-tip">您还未绑定过模态标识</text>
			</view>
			
			<button class="back-btn" @click="goBack">返回</button>
		</view>
	</view>
</template>

<script>
import request from '../utils/request.js'

export default {
	data() {
		return {
			userInfo: {},
			userId: null,
			userModals: [],
			loading: false
		}
	},
	onLoad() {
		this.userId = uni.getStorageSync('userId')
		this.loadUserInfo()
		this.loadUserModals()
	},
	methods: {
		loadUserInfo() {
			const userInfoStr = uni.getStorageSync('userInfo')
			if (userInfoStr) {
				this.userInfo = JSON.parse(userInfoStr)
			}
		},
		
		async loadUserModals() {
			this.loading = true
			try {
				const res = await request.get('/userModals/' + this.userId)
				if (res.code === 1 || res.code === 200) {
					this.userModals = res.data || []
				}
			} catch (error) {
				console.error(error)
				uni.showToast({
					title: '加载失败',
					icon: 'none'
				})
			} finally {
				this.loading = false
			}
		},
		
		formatTime(time) {
			if (!time) return '-'
			const date = new Date(time)
			const year = date.getFullYear()
			const month = String(date.getMonth() + 1).padStart(2, '0')
			const day = String(date.getDate()).padStart(2, '0')
			const hours = String(date.getHours()).padStart(2, '0')
			const minutes = String(date.getMinutes()).padStart(2, '0')
			const seconds = String(date.getSeconds()).padStart(2, '0')
			return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`
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
	padding: 0 32rpx 32rpx;
}

.count-card {
	background: rgba(255, 255, 255, 0.2);
	border-radius: 16rpx;
	padding: 24rpx;
	margin-bottom: 24rpx;
	text-align: center;
}

.count-label {
	display: block;
	font-size: 26rpx;
	color: rgba(255, 255, 255, 0.9);
	margin-bottom: 8rpx;
}

.count-value {
	display: block;
	font-size: 48rpx;
	font-weight: bold;
	color: #ffffff;
}

.list-card {
	background: #ffffff;
	border-radius: 16rpx;
	padding: 24rpx;
	margin-bottom: 24rpx;
	max-height: 800rpx;
	overflow-y: auto;
}

.history-list {
	display: flex;
	flex-direction: column;
	gap: 16rpx;
}

.history-item {
	background: #F7F8FA;
	border-radius: 12rpx;
	padding: 20rpx;
	border-left: 4rpx solid #4A90E2;
}

.item-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 12rpx;
}

.item-index {
	font-size: 24rpx;
	color: #999999;
	font-weight: 500;
}

.item-status {
	font-size: 22rpx;
	color: #ffffff;
	background: linear-gradient(90deg, #4A90E2 0%, #357ABD 100%);
	padding: 4rpx 12rpx;
	border-radius: 20rpx;
}

.item-body {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 12rpx 0;
}

.modal-label {
	font-size: 26rpx;
	color: #666666;
}

.modal-value {
	font-size: 36rpx;
	font-weight: bold;
	color: #4A90E2;
}

.item-footer {
	margin-top: 12rpx;
	padding-top: 12rpx;
	border-top: 1rpx solid #E5E5E5;
}

.item-time {
	font-size: 22rpx;
	color: #999999;
}

.empty-card {
	background: #ffffff;
	border-radius: 16rpx;
	padding: 80rpx 32rpx;
	text-align: center;
	margin-bottom: 24rpx;
}

.empty-text {
	display: block;
	font-size: 32rpx;
	color: #999999;
	margin-bottom: 16rpx;
}

.empty-tip {
	display: block;
	font-size: 24rpx;
	color: #CCCCCC;
}

.back-btn {
	width: 100%;
	height: 88rpx;
	background: rgba(255, 255, 255, 0.9);
	color: #666666;
	border-radius: 12rpx;
	font-size: 30rpx;
	border: none;
}
</style>
