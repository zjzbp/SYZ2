<template>
	<view class="container">
		<view class="header">
			<text class="title">资产确权</text>
			<text class="subtitle">绑定模态标识完成确权</text>
		</view>
		
		<view class="content">
			<view class="info-card">
				<view class="info-row">
					<text class="info-label">用户姓名</text>
					<text class="info-value">{{ displayName }}</text>
				</view>
				<view class="info-row">
					<text class="info-label">双因子码</text>
					<text class="info-value primary">{{ userInfo.twoFactorCode || '-' }}</text>
				</view>
				<view class="info-row highlight">
					<text class="info-label">剩余模态标识</text>
					<text class="info-value remaining">{{ formatNumber(modalStats.remainingModals) }}</text>
				</view>
			</view>
			
			<view class="tips-card">
				<view class="tips-title">使用模态标识</view>
				
				<view class="input-group">
					<text class="label">选择项目类型</text>
					<picker mode="selector" :range="projectList" range-key="projectType" @change="onProjectChange">
						<view class="picker-input">
							<text :class="{'placeholder': !selectedProject}">{{ selectedProject || '请选择项目类型' }}</text>
							<text class="arrow">▼</text>
						</view>
					</picker>
				</view>
				
				<view class="tips">
					<view class="tip-item">
						<text class="dot">•</text>
						<text class="tip-text">选择项目类型后，系统将自动生成模态标识码</text>
					</view>
					<view class="tip-item">
						<text class="dot">•</text>
						<text class="tip-text">每个模态标识只能使用一次</text>
					</view>
					<view class="tip-item">
						<text class="dot">•</text>
						<text class="tip-text">绑定后将与项目永久关联</text>
					</view>
				</view>
			</view>
			
			<!-- 模态框 -->
			<view class="modal-mask" v-if="showModal" @click="closePopup">
				<view class="modal-container" @click.stop>
					<view class="popup-content">
						<view class="popup-title">完善项目信息</view>
						
						<view class="form-item">
							<text class="form-label">模态标识码</text>
							<input class="form-input" v-model="formData.modalCode" disabled />
						</view>
						
						<view class="form-item">
							<text class="form-label">项目类型</text>
							<input class="form-input" v-model="formData.projectType" disabled />
						</view>
						
						<view class="form-item">
							<text class="form-label">项目名称<text class="required">*</text></text>
							<input class="form-input" v-model="formData.projectName" placeholder="请输入项目具体名称" />
						</view>
						
						<view class="form-item">
							<text class="form-label">字节码大小<text class="required">*</text></text>
							<input class="form-input" v-model.number="formData.byteSize" type="number" placeholder="请输入字节码大小" />
						</view>
						
						<view class="form-item">
							<text class="form-label">项目描述<text class="required">*</text></text>
							<textarea class="form-textarea" v-model="formData.projectDesc" placeholder="请输入项目描述" maxlength="500" />
						</view>
						
						<view class="popup-buttons">
							<button class="popup-btn cancel" @click="closePopup">取消</button>
							<button class="popup-btn confirm" @click="confirmBind" :loading="loading">确认绑定</button>
						</view>
					</view>
				</view>
			</view>
			
			<button class="bind-btn" @click="handleBind" :loading="loading">
				立即绑定
			</button>
			<button class="history-btn" @click="goToMyModals">
				我的模态
			</button>
			<button class="cancel-btn" @click="goBack">返回</button>
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
			loading: false,
			projectList: [],  // 项目列表
			selectedProject: '',  // 选中的项目类型
			selectedProjectIndex: -1,  // 选中的项目索引
			showModal: false,  // 控制模态框显示
			modalStats: {
				totalModals: 100000000,
				usedModals: 0,
				remainingModals: 100000000,
				usageRate: '0.000000'
			},
			formData: {
				modalCode: '',  // 模态标识码（雪花算法生成）
				projectType: '',  // 项目类型
				projectName: '',  // 项目名称
				byteSize: null,  // 字节码大小
				projectDesc: ''  // 项目描述
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
		}
	},
	onLoad() {
		const userInfoStr = uni.getStorageSync('userInfo')
		if (userInfoStr) {
			const userInfo = JSON.parse(userInfoStr)
			this.userId = userInfo.userId
		}
		this.loadUserInfo()
		this.loadModalStats()
		this.loadProjects()
	},
	methods: {
		loadUserInfo() {
			const userInfoStr = uni.getStorageSync('userInfo')
			if (userInfoStr) {
				this.userInfo = JSON.parse(userInfoStr)
			}
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
				console.error('获取模态标识统计失败', error)
			}
		},
		
		// 加载项目列表
		async loadProjects() {
			try {
				const res = await request.get('/projects/available')
				if (res.code === 1 || res.code === 200) {
					this.projectList = res.data || []
				}
			} catch (error) {
				console.error('获取项目列表失败', error)
			}
		},
		
		// 项目选择变化
		onProjectChange(e) {
			const index = e.detail.value
			this.selectedProjectIndex = index
			this.selectedProject = this.projectList[index].projectType
		},
		
		// 格式化数字，添加千分位分隔符
		formatNumber(num) {
			if (num === null || num === undefined) return '0'
			return num.toString().replace(/(\d)(?=(\d{3})+$)/g, '$1,')
		},
		
		async handleBind() {
			// 验证输入
			if (!this.selectedProject) {
				uni.showToast({ title: '请选择项目类型', icon: 'none' })
				return
			}
			
			// 验证userId
			if (!this.userId) {
				uni.showToast({ title: '请先登录', icon: 'none' })
				setTimeout(() => {
					uni.navigateTo({ url: '/pages-user/login/login' })
				}, 1500)
				return
			}
			
			// 调用后端生成模态标识码
			try {
				const res = await request.post('/modal/generate', {
					userId: this.userId,
					projectType: this.selectedProject
				})
				
				if (res.code === 1 || res.code === 200) {
					// 填充表单数据
					this.formData.modalCode = res.data.modalCode
					this.formData.projectType = this.selectedProject
					this.formData.projectName = ''
					this.formData.byteSize = null
					this.formData.projectDesc = ''
					
					// 打开模态框
					this.showModal = true
				} else {
					uni.showToast({ title: res.msg || '生成模态标识码失败', icon: 'none' })
				}
			} catch (error) {
				console.error(error)
				uni.showToast({ title: '网络错误', icon: 'none' })
			}
		},
		
		// 关闭弹窗
		closePopup() {
			this.showModal = false
		},
		
		// 确认绑定
		async confirmBind() {
			// 验证表单
			if (!this.formData.projectName) {
				uni.showToast({ title: '请输入项目名称', icon: 'none' })
				return
			}
			if (!this.formData.byteSize || this.formData.byteSize <= 0) {
				uni.showToast({ title: '请输入正确的字节码大小', icon: 'none' })
				return
			}
			if (!this.formData.projectDesc) {
				uni.showToast({ title: '请输入项目描述', icon: 'none' })
				return
			}
			
			this.loading = true
			try {
				const res = await request.post('/modal/bind', {
					userId: this.userId,
					modalCode: this.formData.modalCode,
					projectType: this.formData.projectType,
					projectName: this.formData.projectName,
					byteSize: this.formData.byteSize,
					projectDesc: this.formData.projectDesc
				})
				
				if (res.code === 1 || res.code === 200) {
					uni.showToast({ title: '绑定成功', icon: 'success' })
					this.closePopup()
					
					setTimeout(async () => {
						await this.loadModalStats() // 刷新统计数据
						this.selectedProject = ''
						this.selectedProjectIndex = -1
						// 触发事件刷新dashboard页面的数据
						uni.$emit('refreshModalStats')
					}, 1000)
				} else {
					uni.showToast({ title: res.msg || '绑定失败', icon: 'none' })
				}
			} catch (error) {
				console.error(error)
				uni.showToast({ title: '绑定失败', icon: 'none' })
			} finally {
				this.loading = false
			}
		},
		
		async refreshUserInfo() {
			try {
				const res = await request.get('/' + this.userId)
				if (res.code === 1 || res.code === 200) {
					this.userInfo = res.data
					uni.setStorageSync('userInfo', JSON.stringify(res.data))
				}
			} catch (error) {
				console.error(error)
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
			return `${year}-${month}-${day} ${hours}:${minutes}`
		},
		
		goToMyModals() {
			uni.navigateTo({
				url: '/pages-user/my-modals/my-modals'
			})
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

.info-card {
	background: #ffffff;
	border-radius: 16rpx;
	padding: 32rpx;
	margin-bottom: 24rpx;
}

.info-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 16rpx 0;
	border-bottom: 1rpx solid #F0F0F0;
}

.info-row:last-child {
	border-bottom: none;
}

.info-label {
	font-size: 28rpx;
	color: #666666;
}

.info-value {
	font-size: 28rpx;
	font-weight: 500;
	color: #333333;
}

.info-value.primary {
	color: #4A90E2;
}

.info-value.success {
	color: #11998e;
}

.info-row.highlight {
	background: linear-gradient(90deg, #F0F7FF 0%, #E8F4FF 100%);
	padding: 20rpx;
	margin: 0 -32rpx -32rpx -32rpx;
	border-radius: 0 0 16rpx 16rpx;
}

.info-value.remaining {
	color: #11998e;
	font-size: 32rpx;
	font-weight: bold;
}

.tips-card {
	background: #ffffff;
	border-radius: 16rpx;
	padding: 32rpx;
	margin-bottom: 32rpx;
}

.input-group {
	margin-bottom: 24rpx;
}

.label {
	display: block;
	font-size: 28rpx;
	color: #666666;
	margin-bottom: 12rpx;
}

.modal-input {
	width: 100%;
	height: 88rpx;
	padding: 0 24rpx;
	background: #F7F8FA;
	border-radius: 12rpx;
	font-size: 28rpx;
	color: #333333;
	box-sizing: border-box;
}

.picker-input {
	width: 100%;
	height: 88rpx;
	padding: 0 24rpx;
	background: #F7F8FA;
	border-radius: 12rpx;
	font-size: 28rpx;
	color: #333333;
	box-sizing: border-box;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.picker-input .placeholder {
	color: #999999;
}

.picker-input .arrow {
	color: #999999;
	font-size: 20rpx;
}

.tips {
	background: #F0F7FF;
	border-radius: 12rpx;
	padding: 20rpx;
}

.tips-title {
	font-size: 30rpx;
	font-weight: bold;
	color: #333333;
	margin-bottom: 20rpx;
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

.bind-btn {
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
	background: rgba(255, 255, 255, 0.9);
	color: #666666;
	border-radius: 12rpx;
	font-size: 30rpx;
	border: none;
}

.history-btn {
	width: 100%;
	height: 88rpx;
	background: #ffffff;
	color: #4A90E2;
	border-radius: 12rpx;
	font-size: 30rpx;
	border: 2rpx solid #4A90E2;
	margin-bottom: 16rpx;
}

/* 模态框样式 */
.modal-mask {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background: rgba(0, 0, 0, 0.5);
	display: flex;
	align-items: center;
	justify-content: center;
	z-index: 9999;
}

.modal-container {
	width: 90%;
	max-width: 600rpx;
}

.popup-content {
	background: #ffffff;
	border-radius: 16rpx;
	padding: 40rpx;
	box-sizing: border-box;
}

.popup-title {
	font-size: 36rpx;
	font-weight: bold;
	color: #333333;
	text-align: center;
	margin-bottom: 32rpx;
}

.form-item {
	margin-bottom: 24rpx;
}

.form-label {
	display: block;
	font-size: 28rpx;
	color: #666666;
	margin-bottom: 12rpx;
}

.required {
	color: #ff3b30;
	margin-left: 4rpx;
}

.form-input {
	width: 100%;
	height: 80rpx;
	padding: 0 20rpx;
	background: #F7F8FA;
	border-radius: 12rpx;
	font-size: 28rpx;
	color: #333333;
	box-sizing: border-box;
}

.form-textarea {
	width: 100%;
	min-height: 160rpx;
	padding: 16rpx 20rpx;
	background: #F7F8FA;
	border-radius: 12rpx;
	font-size: 28rpx;
	color: #333333;
	box-sizing: border-box;
}

.popup-buttons {
	display: flex;
	gap: 16rpx;
	margin-top: 32rpx;
}

.popup-btn {
	flex: 1;
	height: 80rpx;
	border-radius: 12rpx;
	font-size: 30rpx;
	border: none;
}

.popup-btn.cancel {
	background: #F0F0F0;
	color: #666666;
}

.popup-btn.confirm {
	background: linear-gradient(90deg, #4A90E2 0%, #357ABD 100%);
	color: #ffffff;
}
</style>
