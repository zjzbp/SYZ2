// 认证相关 API
import request from '@/utils/request'

export interface LoginRequest {
  phone: string
  password: string
}

export interface LoginResponse {
  code: number
  message: string
  data?: {
    token?: string
    user?: {
      id?: number
      name?: string
    }
  }
}

/**
 * 登录接口
 */
export const loginApi = async (data: LoginRequest): Promise<LoginResponse> => {
  return request({
    url: '/api/user/login',
    method: 'post',
    data
  })
}

/**
 * 保存登录信息到 localStorage
 */
export const saveLoginInfo = (token: string, userInfo?: any) => {
  localStorage.setItem('token', token)
  
  if (userInfo) {
    localStorage.setItem('userInfo', JSON.stringify(userInfo))
  }
}

/**
 * 保存记住密码信息（一天有效期）
 */
export const saveRememberedAccount = (phone: string, password: string) => {
  const expireTime = Date.now() + 24 * 60 * 60 * 1000 // 一天后过期
  const rememberedData = {
    phone,
    password,
    expireTime
  }
  localStorage.setItem('rememberedAccount', JSON.stringify(rememberedData))
}

/**
 * 获取记住的账号信息
 */
export const getRememberedAccount = (): { phone: string; password: string } | null => {
  const rememberedData = localStorage.getItem('rememberedAccount')
  if (!rememberedData) return null
  
  try {
    const { phone, password, expireTime } = JSON.parse(rememberedData)
    // 检查是否过期
    if (Date.now() < expireTime) {
      return { phone, password }
    } else {
      // 已过期，清除数据
      localStorage.removeItem('rememberedAccount')
      return null
    }
  } catch (e) {
    localStorage.removeItem('rememberedAccount')
    return null
  }
}

/**
 * 清除登录信息
 */
export const clearLoginInfo = () => {
  localStorage.removeItem('token')
  localStorage.removeItem('username')
  localStorage.removeItem('userInfo')
}

/**
 * 清除记住的账号
 */
export const clearRememberedAccount = () => {
  localStorage.removeItem('rememberedAccount')
}
