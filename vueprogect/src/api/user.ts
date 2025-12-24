// 用户相关 API

export interface User {
  id?: bigint
  name: string
  phone: string
  gridCode: string
  twoFactorCode: string
  password: string
  isFillin: number // 1: 已填写, 0: 未填写
  createTime?: string // LocalDateTime 格式
}

export interface UserListResponse {
  code: number
  message: string
  data: User[]
  total: number
}

export interface UserResponse {
  code: number
  message: string
  data?: User
}

/**
 * 获取用户列表
 */
export const getUserList = async (params?: {
  name?: string
  phone?: string
  gridCode?: string
  page?: number
  size?: number
}): Promise<UserListResponse> => {
  const queryParams = new URLSearchParams()
  if (params?.name) queryParams.append('name', params.name)
  if (params?.phone) queryParams.append('phone', params.phone)
  if (params?.gridCode) queryParams.append('gridCode', params.gridCode)
  if (params?.page) queryParams.append('page', params.page.toString())
  if (params?.size) queryParams.append('size', params.size.toString())

  const response = await fetch(`/api/user/search/conditions?${queryParams}`, {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json'
    }
  })

  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`)
  }

  return await response.json()
}

/**
 * 根据ID获取用户
 */
export const getUserById = async (id: bigint): Promise<UserResponse> => {
  const response = await fetch(`/api/user/${id}`, {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json'
    }
  })

  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`)
  }

  return await response.json()
}

/**
 * 根据手机号获取用户
 */
export const getUserByPhone = async (phone: string): Promise<UserResponse> => {
  const response = await fetch(`/api/user/phone/${phone}`, {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json'
    }
  })

  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`)
  }

  return await response.json()
}

/**
 * 添加用户
 */
export const addUser = async (user: User): Promise<UserResponse> => {
  const response = await fetch('/api/user/add', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(user)
  })

  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`)
  }

  return await response.json()
}

/**
 * 更新用户
 */
export const updateUser = async (user: User): Promise<UserResponse> => {
  const response = await fetch('/api/user/update', {
    method: 'PUT',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(user)
  })

  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`)
  }

  return await response.json()
}

/**
 * 删除用户
 */
export const deleteUser = async (id: bigint): Promise<UserResponse> => {
  const response = await fetch(`/api/user/delete/${id}`, {
    method: 'DELETE',
    headers: {
      'Content-Type': 'application/json'
    }
  })

  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`)
  }

  return await response.json()
}

/**
 * 分页获取用户列表
 */
export const getUserPage = async (page: number, size: number): Promise<UserListResponse> => {
  const response = await fetch(`/api/user/page?page=${page}&size=${size}`, {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json'
    }
  })

  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`)
  }

  return await response.json()
}
