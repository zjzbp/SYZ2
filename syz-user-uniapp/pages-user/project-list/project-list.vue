<template>
  <view class="container">
    <view class="header">
      <text class="title">我的项目</text>
      <button class="add-btn" @click="goToCreate">
        <text class="add-icon">+</text>
        创建项目
      </button>
    </view>
    
    <view class="content">
      <!-- 项目列表 -->
      <view class="project-list" v-if="projects.length > 0">
        <view 
          class="project-item" 
          v-for="(project, index) in projects" 
          :key="index"
          @click="goToDetail(project.projectId)"
        >
          <view class="project-header">
            <view class="project-name">{{ project.projectName }}</view>
            <view class="project-status" :class="'status-' + project.projectStatus.toLowerCase()">
              {{ project.projectStatus === 'ONLINE' ? '上线' : '下架' }}
            </view>
          </view>
          <view class="project-info">
            <text class="info-item">类型：{{ project.projectType }}</text>
            <text class="info-item">模态码：{{ project.modalValue }}</text>
          </view>
          <view class="project-desc" v-if="project.projectDesc">
            {{ project.projectDesc }}
          </view>
          <view class="project-footer">
            <text class="upload-time">{{ formatTime(project.uploadTime) }}</text>
            <view class="actions">
              <button class="action-btn edit-btn" @click.stop="goToEdit(project.projectId)">编辑</button>
              <button class="action-btn delete-btn" @click.stop="confirmDelete(project.projectId)">删除</button>
            </view>
          </view>
        </view>
      </view>
      
      <!-- 空状态 -->
      <view class="empty" v-else>
        <text class="empty-icon">📦</text>
        <text class="empty-text">还没有项目</text>
        <text class="empty-hint">点击右上角创建您的第一个项目</text>
      </view>
    </view>
  </view>
</template>

<script>
import request from '@/utils/request.js'

export default {
  data() {
    return {
      userId: null,
      projects: []
    }
  },
  
  onLoad() {
    const userInfo = uni.getStorageSync('userInfo')
    if (userInfo && userInfo.userId) {
      this.userId = userInfo.userId
      this.loadProjects()
    }
  },
  
  methods: {
    async loadProjects() {
      try {
        uni.showLoading({ title: '加载中...' })
        const res = await request.get(`/projects/user/${this.userId}`)
        uni.hideLoading()
        
        if (res.code === 200) {
          this.projects = res.data || []
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
    
    goToCreate() {
      uni.navigateTo({
        url: '/pages-user/project-create/project-create'
      })
    },
    
    goToDetail(projectId) {
      uni.navigateTo({
        url: `/pages-user/project-detail/project-detail?projectId=${projectId}`
      })
    },
    
    goToEdit(projectId) {
      uni.navigateTo({
        url: `/pages-user/project-create/project-create?projectId=${projectId}`
      })
    },
    
    confirmDelete(projectId) {
      uni.showModal({
        title: '确认删除',
        content: '确定要删除这个项目吗？',
        success: (res) => {
          if (res.confirm) {
            this.deleteProject(projectId)
          }
        }
      })
    },
    
    async deleteProject(projectId) {
      try {
        uni.showLoading({ title: '删除中...' })
        const res = await request.delete(`/projects/${projectId}`)
        uni.hideLoading()
        
        if (res.code === 200) {
          uni.showToast({
            title: '删除成功',
            icon: 'success'
          })
          this.loadProjects()
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
    
    formatTime(time) {
      if (!time) return ''
      const date = new Date(time)
      const year = date.getFullYear()
      const month = String(date.getMonth() + 1).padStart(2, '0')
      const day = String(date.getDate()).padStart(2, '0')
      return `${year}-${month}-${day}`
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

.add-btn {
  display: flex;
  align-items: center;
  padding: 15rpx 30rpx;
  background: rgba(255, 255, 255, 0.2);
  border: none;
  border-radius: 50rpx;
  color: #fff;
  font-size: 28rpx;
}

.add-icon {
  font-size: 36rpx;
  margin-right: 10rpx;
  font-weight: bold;
}

.content {
  padding: 0 20rpx;
}

.project-list {
  display: flex;
  flex-direction: column;
  gap: 20rpx;
}

.project-item {
  background: #fff;
  border-radius: 20rpx;
  padding: 30rpx;
  box-shadow: 0 4rpx 12rpx rgba(0, 0, 0, 0.1);
}

.project-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20rpx;
}

.project-name {
  font-size: 32rpx;
  font-weight: bold;
  color: #333;
  flex: 1;
}

.project-status {
  padding: 8rpx 20rpx;
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

.project-info {
  display: flex;
  gap: 30rpx;
  margin-bottom: 15rpx;
}

.info-item {
  font-size: 26rpx;
  color: #666;
}

.project-desc {
  font-size: 28rpx;
  color: #999;
  line-height: 1.6;
  margin-bottom: 20rpx;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}

.project-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 20rpx;
  padding-top: 20rpx;
  border-top: 1rpx solid #f0f0f0;
}

.upload-time {
  font-size: 24rpx;
  color: #999;
}

.actions {
  display: flex;
  gap: 15rpx;
}

.action-btn {
  padding: 10rpx 25rpx;
  border-radius: 30rpx;
  font-size: 24rpx;
  border: none;
}

.edit-btn {
  background: #e3f2fd;
  color: #2196f3;
}

.delete-btn {
  background: #ffebee;
  color: #f44336;
}

.empty {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 100rpx 40rpx;
  text-align: center;
}

.empty-icon {
  font-size: 120rpx;
  margin-bottom: 30rpx;
}

.empty-text {
  font-size: 32rpx;
  color: #fff;
  font-weight: 500;
  margin-bottom: 15rpx;
}

.empty-hint {
  font-size: 26rpx;
  color: rgba(255, 255, 255, 0.8);
}
</style>
