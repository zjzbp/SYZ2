<template>
  <div class="login-container">
    <!-- 动态背景 -->
    <div class="background">
      <div class="bubble" v-for="i in 15" :key="i" :style="getBubbleStyle(i)"></div>
    </div>

    <!-- 登录卡片 -->
    <div class="login-card">
      <div class="card-header">
        <div class="logo-wrapper">
          <div class="logo-circle">
            <el-icon :size="40" color="#409EFF">
              <User />
            </el-icon>
          </div>
        </div>
        <h2 class="title">用户管理系统</h2>
        <p class="subtitle">欢迎登录</p>
      </div>

      <el-form
        ref="loginFormRef"
        :model="loginForm"
        :rules="rules"
        class="login-form"
        @keyup.enter="handleLogin"
      >
        <el-form-item prop="phone">
          <el-input
            v-model="loginForm.phone"
            placeholder="请输入手机号"
            size="large"
            clearable
            maxlength="11"
          >
            <template #prefix>
              <el-icon class="input-icon"><User /></el-icon>
            </template>
          </el-input>
        </el-form-item>

        <el-form-item prop="password">
          <el-input
            v-model="loginForm.password"
            type="password"
            placeholder="请输入密码"
            size="large"
            show-password
            clearable
          >
            <template #prefix>
              <el-icon class="input-icon"><Lock /></el-icon>
            </template>
          </el-input>
        </el-form-item>

        <el-form-item prop="captcha">
          <div class="captcha-row">
            <el-input
              v-model="loginForm.captcha"
              placeholder="请输入验证码"
              size="large"
              clearable
              maxlength="4"
              style="flex: 1"
            >
              <template #prefix>
                <el-icon class="input-icon"><Key /></el-icon>
              </template>
            </el-input>
            <Captcha 
              ref="captchaRef" 
              @update:code="updateCaptchaCode" 
              :width="120" 
              :height="46"
            />
          </div>
        </el-form-item>

        <el-form-item>
          <div class="remember-wrapper">
            <el-checkbox v-model="loginForm.remember">记住密码</el-checkbox>
            <el-link type="primary" :underline="false">忘记密码?</el-link>
          </div>
        </el-form-item>

        <el-form-item>
          <el-button
            type="primary"
            size="large"
            class="login-button"
            :loading="loading"
            @click="handleLogin"
          >
            {{ loading ? '登录中...' : '登 录' }}
          </el-button>
        </el-form-item>
      </el-form>

      <div class="card-footer">
        <p class="tips">没有账号？<el-link type="primary" :underline="false">立即注册</el-link></p>
      </div>
    </div>

    <!-- 装饰元素 -->
    <div class="decoration">
      <div class="circle circle-1"></div>
      <div class="circle circle-2"></div>
      <div class="circle circle-3"></div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { User, Lock, Key } from '@element-plus/icons-vue'
import type { FormInstance, FormRules } from 'element-plus'
import Captcha from '@/components/Captcha.vue'
import { 
  loginApi, 
  saveLoginInfo, 
  saveRememberedAccount, 
  getRememberedAccount,
  clearRememberedAccount 
} from '@/api/auth'

const router = useRouter()
const loginFormRef = ref<FormInstance>()
const captchaRef = ref<InstanceType<typeof Captcha>>()
const loading = ref(false)
const captchaCode = ref('')

const loginForm = reactive({
  phone: '',
  password: '',
  captcha: '',
  remember: false
})

// 从 localStorage 加载记住的账号密码
const loadRememberedAccount = () => {
  const remembered = getRememberedAccount()
  if (remembered) {
    loginForm.phone = remembered.phone
    loginForm.password = remembered.password
    loginForm.remember = true
  }
}

// 组件挂载时加载记住的账号
onMounted(() => {
  loadRememberedAccount()
})

const rules: FormRules = {
  phone: [
    { required: true, message: '请输入手机号', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号', trigger: 'blur' }
  ],
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    { min: 6, max: 20, message: '密码长度在 6 到 20 个字符', trigger: 'blur' }
  ],
  captcha: [
    { required: true, message: '请输入验证码', trigger: 'blur' },
    { len: 4, message: '验证码为4位', trigger: 'blur' }
  ]
}

// 更新验证码
const updateCaptchaCode = (code: string) => {
  captchaCode.value = code
}

// 生成随机气泡样式
const getBubbleStyle = (index: number) => {
  const size = Math.random() * 60 + 20
  const left = Math.random() * 100
  const duration = Math.random() * 10 + 10
  const delay = Math.random() * 5

  return {
    width: `${size}px`,
    height: `${size}px`,
    left: `${left}%`,
    animationDuration: `${duration}s`,
    animationDelay: `${delay}s`
  }
}

const handleLogin = async () => {
  if (!loginFormRef.value) return

  await loginFormRef.value.validate(async (valid) => {
    if (valid) {
      // 验证图形验证码（不区分大小写）
      if (loginForm.captcha.toLowerCase() !== captchaCode.value.toLowerCase()) {
        ElMessage.error('验证码错误')
        captchaRef.value?.refreshCaptcha()
        loginForm.captcha = ''
        return
      }

      loading.value = true

      try {
        // 调用后端登录接口
        const data = await loginApi({
          phone: loginForm.phone,
          password: loginForm.password
        })

        // 登录成功
        // 保存 token 和用户信息
        if (data.data?.token && data.data?.user) {
          saveLoginInfo(data.data.token, data.data.user)
        }

        // 处理记住密码功能
        if (loginForm.remember) {
          saveRememberedAccount(loginForm.phone, loginForm.password)
        } else {
          clearRememberedAccount()
        }

        ElMessage.success(data.message || '登录成功')
        
        // 跳转到首页
        router.push('/dashboard')
      } catch (error) {
        console.error('登录请求失败:', error)
        ElMessage.error('网络错误，请稍后重试')
        captchaRef.value?.refreshCaptcha()
        loginForm.captcha = ''
      } finally {
        loading.value = false
      }
    }
  })
}
</script>

<style scoped>
.login-container {
  position: relative;
  width: 100%;
  height: 100vh;
  overflow: hidden;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  display: flex;
  justify-content: center;
  align-items: center;
}

/* 动态背景气泡 */
.background {
  position: absolute;
  width: 100%;
  height: 100%;
  overflow: hidden;
}

.bubble {
  position: absolute;
  bottom: -100px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 50%;
  animation: rise 15s infinite ease-in;
  backdrop-filter: blur(5px);
}

@keyframes rise {
  0% {
    bottom: -100px;
    opacity: 0;
  }
  10% {
    opacity: 1;
  }
  90% {
    opacity: 1;
  }
  100% {
    bottom: 110vh;
    opacity: 0;
  }
}

/* 装饰圆圈 */
.decoration {
  position: absolute;
  width: 100%;
  height: 100%;
  pointer-events: none;
}

.circle {
  position: absolute;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.05);
  animation: float 20s infinite ease-in-out;
}

.circle-1 {
  width: 300px;
  height: 300px;
  top: -150px;
  left: -150px;
  animation-delay: 0s;
}

.circle-2 {
  width: 200px;
  height: 200px;
  bottom: -100px;
  right: -100px;
  animation-delay: 2s;
}

.circle-3 {
  width: 150px;
  height: 150px;
  top: 50%;
  right: 10%;
  animation-delay: 4s;
}

@keyframes float {
  0%, 100% {
    transform: translateY(0) rotate(0deg);
  }
  50% {
    transform: translateY(-20px) rotate(180deg);
  }
}

/* 登录卡片 */
.login-card {
  position: relative;
  width: 420px;
  padding: 50px 40px 40px;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(10px);
  border-radius: 20px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
  animation: slideIn 0.6s ease-out;
  z-index: 1;
}

@keyframes slideIn {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.card-header {
  text-align: center;
  margin-bottom: 40px;
}

.logo-wrapper {
  display: flex;
  justify-content: center;
  margin-bottom: 20px;
}

.logo-circle {
  width: 80px;
  height: 80px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0%, 100% {
    transform: scale(1);
    box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
  }
  50% {
    transform: scale(1.05);
    box-shadow: 0 15px 40px rgba(102, 126, 234, 0.5);
  }
}

.title {
  font-size: 28px;
  font-weight: 600;
  color: #333;
  margin: 0 0 10px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.subtitle {
  font-size: 14px;
  color: #999;
  margin: 0;
}

/* 表单样式 */
.login-form {
  margin-top: 30px;
}

.login-form :deep(.el-form-item) {
  margin-bottom: 24px;
}

.login-form :deep(.el-input__wrapper) {
  border-radius: 12px;
  padding: 8px 15px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  transition: all 0.3s;
}

.login-form :deep(.el-input__wrapper:hover) {
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.15);
}

.login-form :deep(.el-input__wrapper.is-focus) {
  box-shadow: 0 4px 12px rgba(102, 126, 234, 0.25);
}

.input-icon {
  color: #999;
}

.captcha-row {
  display: flex;
  gap: 12px;
  align-items: center;
}

.remember-wrapper {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
}

.login-button {
  width: 100%;
  height: 48px;
  font-size: 16px;
  font-weight: 600;
  border-radius: 12px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border: none;
  transition: all 0.3s;
}

.login-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
}

.login-button:active {
  transform: translateY(0);
}

.card-footer {
  text-align: center;
  margin-top: 20px;
}

.tips {
  font-size: 14px;
  color: #666;
  margin: 0;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .login-card {
    width: 90%;
    padding: 40px 30px 30px;
  }

  .title {
    font-size: 24px;
  }
}
</style>
