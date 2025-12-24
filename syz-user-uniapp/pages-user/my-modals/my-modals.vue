<template>
	<view class="container">
		<view class="header">
			<text class="title">我的模态</text>
			<text class="subtitle">查看已绑定的模态标识</text>
		</view>
		
		<view class="content">
			<!-- 筛选栏 -->
			<view class="filter-bar">
				<picker mode="selector" :range="projectTypes" @change="onTypeChange">
					<view class="filter-item">
						<text class="filter-label">项目分类</text>
						<view class="filter-value">
							<text :class="{'placeholder': !selectedType}">{{ selectedType || '全部' }}</text>
							<text class="arrow">▼</text>
						</view>
					</view>
				</picker>
			</view>
			
			<!-- 日期查询 -->
			<view class="date-filter">
				<view class="date-item">
					<text class="date-label">开始日期</text>
					<picker mode="date" :value="startDate" @change="onStartDateChange">
						<view class="date-value">
							<text>{{ startDate || '选择日期' }}</text>
							<text class="icon">📅</text>
						</view>
					</picker>
				</view>
				<view class="date-item">
					<text class="date-label">结束日期</text>
					<picker mode="date" :value="endDate" @change="onEndDateChange">
						<view class="date-value">
							<text>{{ endDate || '选择日期' }}</text>
							<text class="icon">📅</text>
						</view>
					</picker>
				</view>
			</view>
			
			<view class="action-row">
				<button class="search-btn" @click="handleSearch">查询</button>
				<button class="reset-btn" @click="handleReset">重置</button>
			</view>
			
			<!-- 卡片列表 -->
			<view class="card-list" v-if="modalList.length > 0">
				<view 
					class="modal-card" 
					v-for="(item, index) in modalList" 
					:key="index"
					@click="goToProject(item)"
				>
					<view class="card-header">
						<view class="project-badge" :style="{'background': getProjectColor(item.projectType)}">
							{{ item.projectType }}
						</view>
						<text class="modal-value">模态 #{{ item.modalValue }}</text>
					</view>
					<view class="card-body">
						<text class="project-name">{{ item.projectName }}</text>
						<text class="project-desc">{{ item.projectDesc }}</text>
					</view>
					<view class="card-footer">
						<text class="create-time">{{ formatTime(item.createTime) }}</text>
						<text class="status" :class="{'active': item.status === 'VALID'}">
							{{ item.status === 'VALID' ? '有效' : '失效' }}
						</text>
					</view>
				</view>
			</view>
			
			<!-- 空状态 -->
			<view class="empty-state" v-else>
				<text class="empty-icon">📦</text>
				<text class="empty-text">暂无绑定记录</text>
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
			userId: null,
			modalList: [],
			projectTypes: ['全部', '口述历史', '福伦酒', '低空经济', '在线商城', '讲习堂', '大健康'],
			selectedType: '',
			startDate: '',
			endDate: '',
			defaultStartDate: ''  // 默认一个月前
		}
	},
	onLoad() {
		const userInfoStr = uni.getStorageSync('userInfo')
		if (userInfoStr) {
			const userInfo = JSON.parse(userInfoStr)
			this.userId = userInfo.userId
		}
		this.initDefaultDate()
		this.loadModalBindings()
	},
	methods: {
		// 初始化默认日期（近一个月）
		initDefaultDate() {
			const now = new Date()
			const oneMonthAgo = new Date()
			oneMonthAgo.setMonth(now.getMonth() - 1)
			
			this.startDate = this.formatDate(oneMonthAgo)
			this.endDate = this.formatDate(now)
			this.defaultStartDate = this.startDate
		},
		
		formatDate(date) {
			const year = date.getFullYear()
			const month = String(date.getMonth() + 1).padStart(2, '0')
			const day = String(date.getDate()).padStart(2, '0')
			return `${year}-${month}-${day}`
		},
		
		onTypeChange(e) {
			const index = e.detail.value
			this.selectedType = this.projectTypes[index] === '全部' ? '' : this.projectTypes[index]
		},
		
		onStartDateChange(e) {
			this.startDate = e.detail.value
		},
		
		onEndDateChange(e) {
			this.endDate = e.detail.value
		},
		
		async loadModalBindings() {
			try {
				let url = `/modal/bindings/${this.userId}`
				const params = []
				
				if (this.selectedType) {
					params.push(`projectType=${this.selectedType}`)
				}
				if (this.startDate && this.endDate) {
					params.push(`startDate=${this.startDate}`)
					params.push(`endDate=${this.endDate}`)
				}
				
				if (params.length > 0) {
					url += '?' + params.join('&')
				}
				
				const res = await request.get(url)
				if (res.code === 1 || res.code === 200) {
					this.modalList = res.data || []
				}
			} catch (error) {
				console.error('获取绑定记录失败', error)
				uni.showToast({ title: '加载失败', icon: 'none' })
			}
		},
		
		handleSearch() {
			this.loadModalBindings()
		},
		
		handleReset() {
			this.selectedType = ''
			this.initDefaultDate()
			this.loadModalBindings()
		},
		
		formatTime(time) {
			if (!time) return '-'
			const date = new Date(time)
			const year = date.getFullYear()
			const month = String(date.getMonth() + 1).padStart(2, '0')
			const day = String(date.getDate()).padStart(2, '0')
			return `${year}-${month}-${day}`
		},
		
		getProjectColor(projectType) {
			const colors = {
				'口述历史': 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
				'福伦酒': 'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)',
				'低空经济': 'linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)',
				'在线商城': 'linear-gradient(135deg, #43e97b 0%, #38f9d7 100%)',
				'讲习堂': 'linear-gradient(135deg, #fa709a 0%, #fee140 100%)',
				'大健康': 'linear-gradient(135deg, #30cfd0 0%, #330867 100%)'
			}
			return colors[projectType] || 'linear-gradient(135deg, #4A90E2 0%, #357ABD 100%)'
		},
		
		goToProject(item) {
			// 根据项目类型跳转到不同页面
			const projectPages = {
				'口述历史': '/pages-project/oral-history/oral-history',
				'福伦酒': '/pages-project/fulun-wine/fulun-wine',
				'低空经济': '/pages-project/low-altitude/low-altitude',
				'在线商城': '/pages-project/online-mall/online-mall',
				'讲习堂': '/pages-project/lecture-hall/lecture-hall',
				'大健康': '/pages-project/health/health'
			}
			
			const url = projectPages[item.projectType]
			if (url) {
				uni.navigateTo({
					url: `${url}?modalId=${item.modalId}&modalValue=${item.modalValue}`
				})
			} else {
				uni.showToast({ title: '页面开发中', icon: 'none' })
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
	padding: 0 32rpx 32rpx;
}

.filter-bar {
	background: #ffffff;
	border-radius: 16rpx;
	padding: 24rpx 32rpx;
	margin-bottom: 16rpx;
}

.filter-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.filter-label {
	font-size: 28rpx;
	color: #333333;
	font-weight: 500;
}

.filter-value {
	display: flex;
	align-items: center;
	font-size: 28rpx;
	color: #333333;
}

.filter-value .placeholder {
	color: #999999;
}

.filter-value .arrow {
	margin-left: 8rpx;
	color: #999999;
	font-size: 20rpx;
}

.date-filter {
	background: #ffffff;
	border-radius: 16rpx;
	padding: 24rpx 32rpx;
	margin-bottom: 16rpx;
}

.date-item {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 16rpx;
}

.date-item:last-child {
	margin-bottom: 0;
}

.date-label {
	font-size: 28rpx;
	color: #666666;
}

.date-value {
	display: flex;
	align-items: center;
	padding: 12rpx 20rpx;
	background: #F7F8FA;
	border-radius: 8rpx;
	font-size: 26rpx;
	color: #333333;
}

.date-value .icon {
	margin-left: 8rpx;
}

.action-row {
	display: flex;
	gap: 16rpx;
	margin-bottom: 24rpx;
}

.search-btn {
	flex: 1;
	height: 72rpx;
	background: linear-gradient(90deg, #4A90E2 0%, #357ABD 100%);
	color: #ffffff;
	border-radius: 12rpx;
	font-size: 28rpx;
	border: none;
}

.reset-btn {
	flex: 1;
	height: 72rpx;
	background: #ffffff;
	color: #666666;
	border-radius: 12rpx;
	font-size: 28rpx;
	border: none;
}

.card-list {
	margin-bottom: 24rpx;
}

.modal-card {
	background: #ffffff;
	border-radius: 16rpx;
	padding: 24rpx;
	margin-bottom: 16rpx;
	box-shadow: 0 4rpx 12rpx rgba(0, 0, 0, 0.08);
}

.card-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 16rpx;
}

.project-badge {
	padding: 8rpx 16rpx;
	border-radius: 8rpx;
	font-size: 24rpx;
	color: #ffffff;
	font-weight: bold;
}

.modal-value {
	font-size: 26rpx;
	color: #666666;
}

.card-body {
	margin-bottom: 16rpx;
}

.project-name {
	display: block;
	font-size: 30rpx;
	font-weight: bold;
	color: #333333;
	margin-bottom: 8rpx;
}

.project-desc {
	display: block;
	font-size: 24rpx;
	color: #999999;
	line-height: 1.6;
}

.card-footer {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding-top: 16rpx;
	border-top: 1rpx solid #F0F0F0;
}

.create-time {
	font-size: 24rpx;
	color: #999999;
}

.status {
	font-size: 24rpx;
	color: #999999;
	padding: 4rpx 12rpx;
	border-radius: 8rpx;
	background: #F0F0F0;
}

.status.active {
	color: #11998e;
	background: #E8F8F5;
}

.empty-state {
	text-align: center;
	padding: 120rpx 0;
}

.empty-icon {
	display: block;
	font-size: 120rpx;
	margin-bottom: 24rpx;
}

.empty-text {
	display: block;
	font-size: 28rpx;
	color: rgba(255, 255, 255, 0.8);
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
