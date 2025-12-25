<template>
	<view class="container">
		<!-- 顶部用户卡片 -->
		<view class="user-card">
			<view class="user-info">
				<view class="avatar">
					<text class="avatar-text">{{ displayName.substring(0, 1) }}</text>
				</view>
				<view class="info">
					<text class="name">{{ displayName }}</text>
					<text class="phone">{{ userInfo.phone }}</text>
					<text class="user-type" v-if="userInfo.userType">{{ userTypeText }}</text>
				</view>
			</view>
		</view>
		
		<!-- 功能网格 -->
		<view class="content">
			<view class="section-title">我的权益</view>
			<view class="info-grid">
				<view class="grid-item">
					<text class="grid-label">双因子码</text>
					<text class="grid-value">{{ userInfo.twoFactorCode || '未生成' }}</text>
				</view>
				<view class="grid-item">
					<text class="grid-label">网格码</text>
					<text class="grid-value">{{ userInfo.gridCode || '未知' }}</text>
				</view>
				<view class="grid-item">
					<text class="grid-label">模态剩余数量</text>
					<text class="grid-value remaining">{{ formatNumber(modalStats.remainingModals) }}</text>
				</view>
				<view class="grid-item">
					<text class="grid-label">网格码填写状态</text>
					<text class="grid-value" :class="{'active': userInfo.isFillin == 1}">
						{{ userInfo.isFillin == 1 ? '已填写' : '未填写' }}
					</text>
				</view>
			</view>
			
			<view class="section-title">功能菜单</view>
			<view class="menu-grid">
				<view class="menu-card" @click="goToFillInfo" v-if="userInfo.isFillin != 1">
					<view class="card-icon" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
						<text class="icon-text">📝</text>
					</view>
					<text class="card-title">填写网格码</text>
					<text class="card-desc">开通权益</text>
				</view>
				
				<view class="menu-card" @click="goToModalBinding">
					<view class="card-icon" style="background: linear-gradient(135deg, #4A90E2 0%, #357ABD 100%);">
						<text class="icon-text">💼</text>
					</view>
					<text class="card-title">资产确权</text>
					<text class="card-desc">绑定标识</text>
				</view>
							
				<view class="menu-card" @click="goToMyModals">
					<view class="card-icon" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
						<text class="icon-text">🏷️</text>
					</view>
					<text class="card-title">我的模态</text>
					<text class="card-desc">绑定记录</text>
				</view>
				
				<view class="menu-card" @click="refreshData">
					<view class="card-icon" style="background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);">
						<text class="icon-text">🔄</text>
					</view>
					<text class="card-title">刷新信息</text>
					<text class="card-desc">同步数据</text>
				</view>
				
				<view class="menu-card" @click="logout">
					<view class="card-icon" style="background: linear-gradient(135deg, #fc5c7d 0%, #6a82fb 100%);">
						<text class="icon-text">🚪</text>
					</view>
					<text class="card-title">退出登录</text>
					<text class="card-desc">安全退出</text>
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
				userInfo: {},
				modalStats: {
					remainingModals: 0
				}
			}
		},
	computed: {
		// 显示名称：企业显示企业名称，个人显示真实姓名
		displayName() {
			if (this.userInfo.userType === 'ENTERPRISE') {
				return this.userInfo.enterpriseName || '未设置企业名称';
			} else if (this.userInfo.userType === 'PERSONAL') {
				return this.userInfo.realName || '未设置姓名';
			}
			return '用户';
		},
		// 用户类型文本
		userTypeText() {
			if (this.userInfo.userType === 'ENTERPRISE') {
				return '企业用户';
			} else if (this.userInfo.userType === 'PERSONAL') {
				return '个人用户';
			}
			return '';
		}
	},
	onLoad() {
		this.loadUserInfo()
		this.loadModalStats()
		// 监听模态数量变化事件
		uni.$on('refreshModalStats', () => {
			this.loadModalStats()
		})
	},
	onShow() {
		this.loadUserInfo()
		this.loadModalStats()
	},
	onUnload() {
		// 移除事件监听
		uni.$off('refreshModalStats')
	},
	methods: {
		loadUserInfo() {
			const userInfoStr = uni.getStorageSync('userInfo')
			if (userInfoStr) {
				this.userInfo = JSON.parse(userInfoStr)
			}
			this.refreshData()
		},
		
		async loadModalStats() {
			try {
				const userInfoStr = uni.getStorageSync('userInfo')
				if (userInfoStr) {
					const userInfo = JSON.parse(userInfoStr)
					const userId = userInfo.userId
					// 使用用户专属接口查询模态数量
					const res = await request.get(`/modalStats/${userId}`)
					if (res.code === 1 || res.code === 200) {
						this.modalStats = res.data
					}
				}
			} catch (error) {
				console.error('获取模态统计失败', error)
			}
		},
		
		// 格式化数字，添加千分位分隔符
		formatNumber(num) {
			if (num === null || num === undefined) return '0'
			return num.toString().replace(/(\d)(?=(\d{3})+$)/g, '$1,')
		},
		
		async refreshData() {
			const userInfoStr = uni.getStorageSync('userInfo')
			if (!userInfoStr) return
			
			const userInfo = JSON.parse(userInfoStr)
			const userId = userInfo.userId
			if (!userId) return
			
			try {
				const res = await request.get('/' + userId)
				if (res.code === 1 || res.code === 200) {
					this.userInfo = res.data
					uni.setStorageSync('userInfo', JSON.stringify(res.data))
				}
			} catch (error) {
				console.error(error)
			}
		},
		
		goToFillInfo() {
			uni.navigateTo({
				url: '/pages-user/fill-info/fill-info'
			})
		},
		
		goToModalBinding() {
			uni.navigateTo({
				url: '/pages-user/modal-binding/modal-binding'
			})
		},
			
		goToMyModals() {
			uni.navigateTo({
				url: '/pages-user/my-modals/my-modals'
			})
		},
		
		logout() {
			uni.showModal({
				title: '提示',
				content: '确定要退出登录吗?',
				success: (res) => {
					if (res.confirm) {
						uni.removeStorageSync('token')
						uni.removeStorageSync('userId')
						uni.removeStorageSync('userInfo')
						
						uni.showToast({
							title: '已退出登录',
							icon: 'success'
						})
						
						setTimeout(() => {
							uni.reLaunch({
								url: '/pages-user/login/login'
							})
						}, 1000)
					}
				}
			})
		}
	}
}
</script>

<style scoped>
.container {
	min-height: 100vh;
	background: #F7F8FA;
}

.user-card {
	background: linear-gradient(135deg, #4A90E2 0%, #357ABD 100%);
	padding: 60rpx 32rpx 40rpx;
	border-radius: 0 0 32rpx 32rpx;
}

.user-info {
	display: flex;
	align-items: center;
}

.avatar {
	width: 100rpx;
	height: 100rpx;
	background: rgba(255, 255, 255, 0.2);
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-right: 24rpx;
}

.avatar-text {
	font-size: 40rpx;
	color: #ffffff;
	font-weight: bold;
}

.info {
	flex: 1;
}

.name {
	display: block;
	font-size: 36rpx;
	font-weight: bold;
	color: #ffffff;
	margin-bottom: 8rpx;
}

.phone {
	display: block;
	font-size: 26rpx;
	color: rgba(255, 255, 255, 0.9);
}

.user-type {
	display: inline-block;
	font-size: 22rpx;
	color: rgba(255, 255, 255, 0.95);
	margin-top: 8rpx;
	padding: 4rpx 12rpx;
	background: rgba(255, 255, 255, 0.2);
	border-radius: 8rpx;
}

.content {
	padding: 32rpx;
}

.section-title {
	font-size: 32rpx;
	font-weight: bold;
	color: #333333;
	margin-bottom: 24rpx;
}

.info-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 16rpx;
	margin-bottom: 40rpx;
}

.grid-item {
	background: #ffffff;
	border-radius: 16rpx;
	padding: 24rpx;
	text-align: center;
}

.grid-label {
	display: block;
	font-size: 24rpx;
	color: #999999;
	margin-bottom: 8rpx;
}

.grid-value {
	display: block;
	font-size: 28rpx;
	font-weight: bold;
	color: #4A90E2;
}

.grid-value.active {
	color: #11998e;
}

.grid-value.remaining {
	color: #11998e;
	font-weight: bold;
	font-size: 30rpx;
}

.menu-grid {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 16rpx;
}

.menu-card {
	display: flex;
	flex-direction: column;
	align-items: center;
	background: #ffffff;
	border-radius: 16rpx;
	padding: 24rpx;
}

.card-icon {
	width: 88rpx;
	height: 88rpx;
	border-radius: 16rpx;
	display: flex;
	align-items: center;
	justify-content: center;
	margin-bottom: 16rpx;
}

.icon-text {
	font-size: 36rpx;
	color: #ffffff;
	font-weight: bold;
}

.card-title {
	display: block;
	font-size: 30rpx;
	font-weight: 500;
	color: #333333;
	margin-bottom: 4rpx;
}

.card-desc {
	display: block;
	font-size: 24rpx;
	color: #999999;
}
</style>
