<template>
  <view class="container">
    <view class="header">
      <text class="title">{{ isEdit ? '编辑项目' : '创建项目' }}</text>
    </view>
    
    <view class="content">
      <view class="form-card">
        <view class="form-item">
          <text class="label">项目名称 <text class="required">*</text></text>
          <input 
            class="input" 
            v-model="form.projectName" 
            placeholder="请输入项目名称"
            maxlength="100"
          />
        </view>
        
        <view class="form-item">
          <text class="label">项目类型 <text class="required">*</text></text>
          <picker 
            :value="typeIndex" 
            :range="projectTypes" 
            @change="onTypeChange"
          >
            <view class="picker">
              {{ form.projectType || '请选择项目类型' }}
            </view>
          </picker>
        </view>
        
        <view class="form-item" v-if="!isEdit">
          <text class="label">模态标识 <text class="required">*</text></text>
          <view class="modal-display">{{ userInfo.modalId }}</view>
          <text class="hint">将使用当前绑定的模态标识</text>
        </view>
        
        <view class="form-item">
          <text class="label">云存储URL</text>
          <input 
            class="input" 
            v-model="form.cloudStorageUrl" 
            placeholder="请输入云存储URL（选填）"
          />
        </view>
        
        <view class="form-item">
          <text class="label">项目描述</text>
          <textarea 
            class="textarea" 
            v-model="form.projectDesc" 
            placeholder="请输入项目描述（选填）"
            maxlength="500"
          />
        </view>
        
        <view class="form-item">
          <text class="label">项目状态</text>
          <picker 
            :value="statusIndex" 
            :range="projectStatus" 
            range-key="label"
            @change="onStatusChange"
          >
            <view class="picker">
              {{ currentStatus.label }}
            </view>
          </picker>
        </view>
      </view>
      
      <view class="btn-group">
        <button class="submit-btn" @click="handleSubmit">
          {{ isEdit ? '保存修改' : '创建项目' }}
        </button>
        <button class="cancel-btn" @click="handleCancel">取消</button>
      </view>
    </view>
  </view>
</template>

<script>
import request from '@/utils/request.js'

export default {
  data() {
    return {
      isEdit: false,
      projectId: null,
      userInfo: {},
      form: {
        projectName: '',
        projectType: '',
        cloudStorageUrl: '',
        projectDesc: '',
        projectStatus: 'ONLINE'
      },
      projectTypes: [
        '口述历史',
        '非遗记录',
        '文档存档',
        '艺术作品',
        '学术研究',
        '影像资料',
        '音频资料',
        '其他'
      ],
      typeIndex: 0,
      projectStatus: [
        { value: 'ONLINE', label: '上线' },
        { value: 'OFFLINE', label: '下架' }
      ],
      statusIndex: 0
    }
  },
  
  computed: {
    currentStatus() {
      return this.projectStatus[this.statusIndex]
    }
  },
  
  onLoad(options) {
    this.userInfo = uni.getStorageSync('userInfo') || {}
    
    if (!this.userInfo.modalId && !options.projectId) {
      uni.showToast({
        title: '请先绑定模态标识',
        icon: 'none'
      })
      setTimeout(() => {
        uni.navigateBack()
      }, 1500)
      return
    }
    
    if (options.projectId) {
      this.isEdit = true
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
          this.form = res.data
          this.typeIndex = this.projectTypes.indexOf(res.data.projectType)
          this.statusIndex = this.projectStatus.findIndex(s => s.value === res.data.projectStatus)
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
    
    onTypeChange(e) {
      this.typeIndex = e.detail.value
      this.form.projectType = this.projectTypes[e.detail.value]
    },
    
    onStatusChange(e) {
      this.statusIndex = e.detail.value
      this.form.projectStatus = this.projectStatus[e.detail.value].value
    },
    
    async handleSubmit() {
      // 验证必填字段
      if (!this.form.projectName) {
        uni.showToast({
          title: '请输入项目名称',
          icon: 'none'
        })
        return
      }
      
      if (!this.form.projectType) {
        uni.showToast({
          title: '请选择项目类型',
          icon: 'none'
        })
        return
      }
      
      try {
        uni.showLoading({ title: this.isEdit ? '保存中...' : '创建中...' })
        
        let res
        if (this.isEdit) {
          res = await request.put(`/projects/${this.projectId}`, this.form)
        } else {
          const createData = {
            ...this.form,
            userId: this.userInfo.userId,
            modalId: this.userInfo.modalId,
            modalValue: this.userInfo.modalId
          }
          res = await request.post('/projects', createData)
        }
        
        uni.hideLoading()
        
        if (res.code === 200) {
          uni.showToast({
            title: this.isEdit ? '保存成功' : '创建成功',
            icon: 'success'
          })
          setTimeout(() => {
            uni.navigateBack()
          }, 1500)
        } else {
          uni.showToast({
            title: res.message || '操作失败',
            icon: 'none'
          })
        }
      } catch (error) {
        uni.hideLoading()
        uni.showToast({
          title: '操作失败',
          icon: 'none'
        })
      }
    },
    
    handleCancel() {
      uni.navigateBack()
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
  padding: 30rpx 20rpx;
  margin-bottom: 20rpx;
}

.title {
  font-size: 48rpx;
  font-weight: bold;
  color: #fff;
}

.content {
  padding: 0 20rpx;
}

.form-card {
  background: #fff;
  border-radius: 20rpx;
  padding: 30rpx;
  margin-bottom: 30rpx;
}

.form-item {
  margin-bottom: 30rpx;
}

.form-item:last-child {
  margin-bottom: 0;
}

.label {
  display: block;
  font-size: 28rpx;
  color: #333;
  font-weight: 500;
  margin-bottom: 15rpx;
}

.required {
  color: #f44336;
}

.input, .textarea, .picker {
  width: 100%;
  padding: 20rpx;
  background: #f5f5f5;
  border-radius: 12rpx;
  font-size: 28rpx;
  color: #333;
  box-sizing: border-box;
}

.textarea {
  min-height: 150rpx;
  line-height: 1.6;
}

.picker {
  display: flex;
  align-items: center;
  color: #666;
}

.modal-display {
  padding: 20rpx;
  background: #e3f2fd;
  border-radius: 12rpx;
  font-size: 32rpx;
  color: #2196f3;
  font-weight: bold;
  text-align: center;
}

.hint {
  display: block;
  font-size: 24rpx;
  color: #999;
  margin-top: 10rpx;
}

.btn-group {
  display: flex;
  flex-direction: column;
  gap: 20rpx;
}

.submit-btn, .cancel-btn {
  width: 100%;
  padding: 25rpx;
  border-radius: 50rpx;
  font-size: 32rpx;
  font-weight: bold;
  border: none;
}

.submit-btn {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #fff;
}

.cancel-btn {
  background: rgba(255, 255, 255, 0.3);
  color: #fff;
}
</style>
