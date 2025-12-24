<template>
  <view class="container">
    <view class="header">
      <text class="title">项目详情</text>
      <button class="edit-btn" @click="goToEdit">
        ✏️ 编辑
      </button>
    </view>
    
    <view class="content">
      <view class="detail-card">
        <view class="detail-header">
          <text class="project-name">{{ project.projectName }}</text>
          <view class="status-badge" :class="'status-' + project.projectStatus.toLowerCase()">
            {{ project.projectStatus === 'ONLINE' ? '上线' : '下架' }}
          </view>
        </view>
        
        <view class="detail-section">
          <view class="section-title">基本信息</view>
          <view class="info-row">
            <text class="info-label">项目类型</text>
            <text class="info-value">{{ project.projectType }}</text>
          </view>
          <view class="info-row">
            <text class="info-label">模态标识</text>
            <text class="info-value modal-value">{{ project.modalValue }}</text>
          </view>
          <view class="info-row">
            <text class="info-label">创建时间</text>
            <text class="info-value">{{ formatTime(project.uploadTime) }}</text>
          </view>
        </view>
        
        <view class="detail-section" v-if="project.cloudStorageUrl">
          <view class="section-title">云存储</view>
          <view class="storage-url">
            <text class="url-text">{{ project.cloudStorageUrl }}</text>
            <button class="copy-btn" @click="copyUrl">复制</button>
          </view>
        </view>
        
        <view class="detail-section" v-if="project.projectDesc">
          <view class="section-title">项目描述</view>
          <text class="desc-text">{{ project.projectDesc }}</text>
        </view>
      </view>
      
      <view class="action-group">
        <button 
          class="action-btn status-btn" 
          @click="toggleStatus"
        >
          {{ project.projectStatus === 'ONLINE' ? '下架项目' : '上线项目' }}
        </button>
        <button class="action-btn delete-btn" @click="confirmDelete">
          删除项目
        </button>
      </view>
    </view>
  </view>
</template>

<script>
import request from '@/utils/request.js'

export default {
  data() {
    return {
      projectId: null,
      project: {
        projectName: '',
        projectType: '',
        modalValue: '',
        cloudStorageUrl: '',
        projectDesc: '',
        uploadTime: '',
        projectStatus: 'ONLINE'
      }
    }
  },
  
  onLoad(options) {
    if (options.projectId) {
      this.projectId = options.projectId
      this.loadProjectDetail()
    }
  },
  
  methods: {
    async loadProjectDetail() {
      try {
        uni.showLoading({ title: '加载中...' })
        const res = await request.get(`/projects/${this.projectId}`)
        uni.hideLoading()
        
        if (res.code === 200) {
          this.project = res.data
        } else {
          uni.showToast({
            title: res.message || '加载失败',
            icon: 'none'
          })
        }
      } catch (error) {
        uni.hideLoading()
        uni.showToast({
          title: '加载失败',
          icon: 'none'
        })
      }
    },
    
    goToEdit() {
      uni.navigateTo({
        url: `/pages-user/project-create/project-create?projectId=${this.projectId}`
      })
    },
    
    async toggleStatus() {
      const newStatus = this.project.projectStatus === 'ONLINE' ? 'OFFLINE' : 'ONLINE'
      const actionText = newStatus === 'ONLINE' ? '上线' : '下架'
      
      try {
        uni.showLoading({ title: `${actionText}中...` })
        const res = await request.patch(`/projects/${this.projectId}/status?status=${newStatus}`)
        uni.hideLoading()
        
        if (res.code === 200) {
          uni.showToast({
            title: `${actionText}成功`,
            icon: 'success'
          })
          this.loadProjectDetail()
        } else {
          uni.showToast({
            title: res.message || `${actionText}失败`,
            icon: 'none'
          })
        }
      } catch (error) {
        uni.hideLoading()
        uni.showToast({
          title: `${actionText}失败`,
          icon: 'none'
        })
      }
    },
    
    confirmDelete() {
      uni.showModal({
        title: '确认删除',
        content: '确定要删除这个项目吗？此操作不可恢复。',
        success: (res) => {
          if (res.confirm) {
            this.deleteProject()
          }
        }
      })
    },
    
    async deleteProject() {
      try {
        uni.showLoading({ title: '删除中...' })
        const res = await request.delete(`/projects/${this.projectId}`)
        uni.hideLoading()
        
        if (res.code === 200) {
          uni.showToast({
            title: '删除成功',
            icon: 'success'
          })
          setTimeout(() => {
            uni.navigateBack()
          }, 1500)
        } else {
          uni.showToast({
            title: res.message || '删除失败',
            icon: 'none'
          })
        }
      } catch (error) {
        uni.hideLoading()
        uni.showToast({
          title: '删除失败',
          icon: 'none'
        })
      }
    },
    
    copyUrl() {
      uni.setClipboardData({
        data: this.project.cloudStorageUrl,
        success: () => {
          uni.showToast({
            title: '复制成功',
            icon: 'success'
          })
        }
      })
    },
    
    formatTime(time) {
      if (!time) return ''
      const date = new Date(time)
      const year = date.getFullYear()
      const month = String(date.getMonth() + 1).padStart(2, '0')
      const day = String(date.getDate()).padStart(2, '0')
      const hour = String(date.getHours()).padStart(2, '0')
      const minute = String(date.getMinutes()).padStart(2, '0')
      return `${year}-${month}-${day} ${hour}:${minute}`
    }
  }
}
</script>

<style scoped>
.container {
  min-height: 100vh;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  padding: 20rpx;
}

.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 30rpx 20rpx;
  margin-bottom: 20rpx;
}

.title {
  font-size: 48rpx;
  font-weight: bold;
  color: #fff;
}

.edit-btn {
  padding: 15rpx 30rpx;
  background: rgba(255, 255, 255, 0.2);
  border: none;
  border-radius: 50rpx;
  color: #fff;
  font-size: 28rpx;
}

.content {
  padding: 0 20rpx;
}

.detail-card {
  background: #fff;
  border-radius: 20rpx;
  padding: 30rpx;
  margin-bottom: 30rpx;
}

.detail-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 30rpx;
  padding-bottom: 20rpx;
  border-bottom: 1rpx solid #f0f0f0;
}

.project-name {
  font-size: 36rpx;
  font-weight: bold;
  color: #333;
  flex: 1;
}

.status-badge {
  padding: 10rpx 25rpx;
  border-radius: 30rpx;
  font-size: 24rpx;
  font-weight: 500;
}

.status-online {
  background: #e8f5e9;
  color: #4caf50;
}

.status-offline {
  background: #ffebee;
  color: #f44336;
}

.detail-section {
  margin-bottom: 30rpx;
}

.detail-section:last-child {
  margin-bottom: 0;
}

.section-title {
  font-size: 28rpx;
  font-weight: bold;
  color: #666;
  margin-bottom: 20rpx;
}

.info-row {
  display: flex;
  justify-content: space-between;
  padding: 20rpx 0;
  border-bottom: 1rpx solid #f5f5f5;
}

.info-label {
  font-size: 28rpx;
  color: #999;
}

.info-value {
  font-size: 28rpx;
  color: #333;
  font-weight: 500;
}

.modal-value {
  color: #2196f3;
  font-weight: bold;
}

.storage-url {
  display: flex;
  align-items: center;
  padding: 20rpx;
  background: #f5f5f5;
  border-radius: 12rpx;
}

.url-text {
  flex: 1;
  font-size: 26rpx;
  color: #666;
  word-break: break-all;
}

.copy-btn {
  margin-left: 15rpx;
  padding: 10rpx 20rpx;
  background: #2196f3;
  color: #fff;
  border: none;
  border-radius: 8rpx;
  font-size: 24rpx;
}

.desc-text {
  font-size: 28rpx;
  color: #666;
  line-height: 1.8;
}

.action-group {
  display: flex;
  flex-direction: column;
  gap: 20rpx;
}

.action-btn {
  width: 100%;
  padding: 25rpx;
  border-radius: 50rpx;
  font-size: 32rpx;
  font-weight: bold;
  border: none;
}

.status-btn {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff;
}

.delete-btn {
  background: rgba(244, 67, 54, 0.8);
  color: #fff;
}
</style>
