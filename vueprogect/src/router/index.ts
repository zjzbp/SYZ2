import { createRouter, createWebHistory } from 'vue-router'
import { ElMessage } from 'element-plus'
import Layout from '@/views/Layout.vue'
import Login from '@/views/Login.vue'
// 核心功能页面
import Overview from '@/views/Overview.vue'
import GridCode from '@/views/GridCode.vue'
import TwoFactorCode from '@/views/TwoFactorCode.vue'
import TwoFactorCodeDetail from '@/views/TwoFactorCodeDetail.vue'
import ModalIdentifier from '@/views/ModalIdentifier.vue'
import ProjectClassification from '@/views/ProjectClassification.vue'
import Statistics from '@/views/Statistics.vue'
import UserManagement from '@/views/UserManagement.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/login',
      name: 'Login',
      component: Login,
      meta: { requiresAuth: false }
    },
    {
      path: '/',
      component: Layout,
      redirect: '/overview',
      meta: { requiresAuth: true },
      children: [
        {
          path: 'overview',
          name: 'Overview',
          component: Overview,
          alias: '/dashboard' // 添加别名支持 /dashboard 路径
        },
        {
          path: 'grid-code',
          name: 'GridCode',
          component: GridCode
        },
        {
          path: 'two-factor-code',
          name: 'TwoFactorCode',
          component: TwoFactorCode
        },
        {
          path: 'two-factor-code/:id',
          name: 'TwoFactorCodeDetail',
          component: TwoFactorCodeDetail,
          props: true
        },
        {
          path: 'modal-identifier',
          name: 'ModalIdentifier',
          component: ModalIdentifier
        },
        {
          path: 'project-classification',
          name: 'ProjectClassification',
          component: ProjectClassification
        },
        {
          path: 'statistics',
          name: 'Statistics',
          component: Statistics
        },
        {
          path: 'user-management',
          name: 'UserManagement',
          component: UserManagement
        }
      ]
    }
  ]
})

// 路由守卫
router.beforeEach((to, from, next) => {
  const token = localStorage.getItem('token')
  
  // 如果路由需要认证
  if (to.meta.requiresAuth) {
    if (token) {
      // 已登录，允许访问
      next()
    } else {
      // 未登录，跳转到登录页
      ElMessage.warning('请先登录')
      next('/login')
    }
  } else {
    // 不需要认证的路由
    if (to.path === '/login' && token) {
      // 已登录用户访问登录页，跳转到首页
      next('/overview')
    } else {
      next()
    }
  }
})

export default router