<template>
  <div class="common-layout">
    <el-container>
      <el-aside width="250px" class="sidebar">
        <div class="logo">
          <el-icon :size="30" color="#409EFF">
            <Platform />
          </el-icon>
          <span class="logo-title">网格管理系统</span>
        </div>
        <el-menu
          :default-active="activeMenu"
          class="el-menu-vertical"
          router
          background-color="#001529"
          text-color="#fff"
          active-text-color="#409EFF"
        >
          <el-menu-item index="/overview">
            <el-icon><DataAnalysis /></el-icon>
            <span>概述信息</span>
          </el-menu-item>

           
          
          <el-menu-item index="/grid-code">
            <el-icon><Grid /></el-icon>
            <span>网格码管理</span>
          </el-menu-item>
          
          <el-menu-item index="/two-factor-code">
            <el-icon><Management /></el-icon>
            <span>双因子码管理</span>
          </el-menu-item>
          
          <el-menu-item index="/modal-identifier">
            <el-icon><Connection /></el-icon>
            <span>模态标识管理</span>
          </el-menu-item>
          
          <el-menu-item index="/project-classification">
            <el-icon><Folder /></el-icon>
            <span>项目分类管理</span>
          </el-menu-item>
          
          <el-menu-item index="/statistics">
            <el-icon><DataAnalysis /></el-icon>
            <span>数据统计</span>
          </el-menu-item>
          <el-menu-item index="/user-management">
            <el-icon><User /></el-icon>
            <span>用户管理</span>
          </el-menu-item>
        </el-menu>
      </el-aside>

      <el-container>
        <el-header class="header">
          <div class="header-left">
            <el-breadcrumb separator="/">
              <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
              <el-breadcrumb-item>{{ currentPageTitle }}</el-breadcrumb-item>
            </el-breadcrumb>
          </div>
          <div class="header-right">
            <el-badge :value="12" class="item">
              <el-icon :size="20"><Bell /></el-icon>
            </el-badge>
            <el-dropdown class="user-dropdown">
              <div class="user-info">
                <el-avatar :size="35" src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png" />
                <span class="username">{{ username }}</span>
              </div>
              <template #dropdown>
                <el-dropdown-menu>
                  <el-dropdown-item>个人中心</el-dropdown-item>
                  <el-dropdown-item>设置</el-dropdown-item>
                  <el-dropdown-item divided @click="handleLogout">退出登录</el-dropdown-item>
                </el-dropdown-menu>
              </template>
            </el-dropdown>
          </div>
        </el-header>

        <el-main class="main-content">
          <router-view />
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script setup lang="ts">
import { computed, ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { clearLoginInfo } from '@/api/auth'
import {
  Platform,
  DataAnalysis,
  Grid,
  Management,
  Connection,
  Folder,
  Bell,
  User
} from '@element-plus/icons-vue'

const route = useRoute()
const router = useRouter()
const username = ref('Admin')

onMounted(() => {
  // 获取用户名
  const userInfoStr = localStorage.getItem('userInfo')
  if (userInfoStr) {
    try {
      const userInfo = JSON.parse(userInfoStr)
      username.value = userInfo.name || 'Admin'
    } catch (e) {
      console.error('解析用户信息失败:', e)
    }
  }
})

const activeMenu = computed(() => route.path)

const currentPageTitle = computed(() => {
  const titleMap: Record<string, string> = {
    '/overview': '概述信息',
    '/grid-code': '网格码管理',
    '/two-factor-code': '双因子码管理',
    '/modal-identifier': '模态标识管理',
    '/project-classification': '项目分类管理',
    '/statistics': '数据统计',
    '/user-management': '用户管理'
  }
  return titleMap[route.path] || '首页'
})

// 退出登录
const handleLogout = () => {
  ElMessageBox.confirm('确定要退出登录吗?', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  })
    .then(() => {
      // 清除登录信息
      clearLoginInfo()
      
      ElMessage.success('退出成功')
      
      // 跳转到登录页
      router.push('/login')
    })
    .catch(() => {
      // 取消退出
    })
}
</script>

<style scoped>
.common-layout {
  height: 100vh;
}

.el-container {
  height: 100%;
}

.sidebar {
  background-color: #001529;
  height: 100vh;
  overflow-y: auto;
}

.logo {
  height: 64px;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 12px;
  color: #fff;
  font-size: 18px;
  font-weight: bold;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.logo-title {
  color: #fff;
}

.el-menu-vertical {
  border-right: none;
  height: calc(100vh - 64px);
}

.header {
  background: #fff;
  box-shadow: 0 1px 4px rgba(0, 21, 41, 0.08);
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 24px;
}

.header-left {
  flex: 1;
}

.header-right {
  display: flex;
  align-items: center;
  gap: 24px;
}

.item {
  cursor: pointer;
}

.user-dropdown {
  cursor: pointer;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.username {
  font-size: 14px;
  color: #333;
}

.main-content {
  background: #f0f2f5;
  padding: 24px;
  overflow-y: auto;
}
</style>