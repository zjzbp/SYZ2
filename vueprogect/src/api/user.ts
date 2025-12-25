// 用户相关 API
import request from '@/utils/request'

// 用户基本信息类型
export interface User {
  userId?: number
  userType: string  // PERSONAL / ENTERPRISE
  phone: string
  gridCode?: string
  twoFactorCode?: string
  password?: string
  isFillin?: number // 1: 已填写, 0: 未填写
  status?: string
  modalId?: number
  createTime?: string
  updateTime?: string
}

// 个人详情类型
export interface Personal {
  personalId?: number
  userId: number
  realName?: string
  idCard?: string
  idCardFrontUrl?: string
  idCardBackUrl?: string
  gender?: string
  birthDate?: string
  nationality?: string
  address?: string
  email?: string
  occupation?: string
  educationLevel?: string
  emergencyContactName?: string
  emergencyContactPhone?: string
  verificationStatus?: string
  verificationTime?: string
  remark?: string
  createTime?: string
  updateTime?: string
}

// 企业详情类型
export interface Enterprise {
  enterpriseId?: number
  userId: number
  enterpriseName?: string
  unifiedSocialCreditCode?: string
  businessLicenseUrl?: string
  legalPersonName?: string
  legalPersonIdCard?: string
  legalPersonIdFrontUrl?: string
  legalPersonIdBackUrl?: string
  contactPhone?: string
  contactEmail?: string
  enterpriseAddress?: string
  businessScope?: string
  registeredCapital?: number
  establishmentDate?: string
  verificationStatus?: string
  verificationTime?: string
  remark?: string
  createTime?: string
  updateTime?: string
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

// 分页响应类型
export interface PageResponse<T> {
  code: number
  message: string
  data: {
    records: T[]
    total: number
    size: number
    current: number
    pages: number
  }
}

// 通用响应类型
export interface ApiResponse<T> {
  code: number
  message: string
  data: T
}

// 双因子码类型
export interface TwoFactorCode {
  twoFactorId?: number
  twoFactorValue?: string
  gridCodeValue?: string
  codeType?: string
  status?: string
  createTime?: string
  remainingModals?: number
}

// 模态标识类型
export interface ModalIdentifier {
  modalId?: number
  modalValue?: string
  twoFactorValue?: string
  userId?: number
  identifierType?: string
  status?: string
  hashValue?: string
  createTime?: string
  updateTime?: string
}

// 项目信息类型
export interface ProjectInfo {
  projectId?: number
  modalId?: number
  userId?: number
  projectName?: string
  byteSize?: number
  projectType?: string
  cloudStorageUrl?: string
  projectDesc?: string
  uploadTime?: string
  projectStatus?: string
  createTime?: string
}

// 项目类别统计类型
export interface ProjectTypeStat {
  projectType: string
  projectTypeName: string
  count: number
  score: number
  percentage: number
}

// 用户完整详情类型
export interface UserFullDetail {
  user: User
  personalDetail?: Personal
  enterpriseDetail?: Enterprise
  twoFactorCode?: TwoFactorCode
  modalIdentifiers?: ModalIdentifier[]
  modalIdentifierCount?: number
  projectInfos?: ProjectInfo[]
  projectTypeStats?: ProjectTypeStat[]
  totalScore?: number
}

/**
 * 获取用户列表（分页）
 */
export const getUserList = (params: {
  userType?: string  // PERSONAL / ENTERPRISE
  phone?: string
  currentPage?: number
  pageSize?: number
}): Promise<PageResponse<User>> => {
  return request({
    url: '/api/user/list',
    method: 'get',
    params
  })
}

/**
 * 获取个人详情
 */
export const getPersonalDetail = (userId: number): Promise<ApiResponse<Personal>> => {
  return request({
    url: `/api/user/personal/${userId}`,
    method: 'get'
  })
}

/**
 * 获取企业详情
 */
export const getEnterpriseDetail = (userId: number): Promise<ApiResponse<Enterprise>> => {
  return request({
    url: `/api/user/enterprise/${userId}`,
    method: 'get'
  })
}

/**
 * 获取用户完整详情（包括所有关联数据、项目类别统计和分数）
 */
export const getUserFullDetail = (userId: number): Promise<ApiResponse<UserFullDetail>> => {
  return request({
    url: `/api/user/detail/${userId}`,
    method: 'get'
  })
}

/**
 * 根据 ID 获取用户
 */
export const getUserById = async (id: number) => {
  return request({
    url: `/api/user/${id}`,
    method: 'get'
  })
}

/**
 * 根据手机号获取用户
 */
export const getUserByPhone = async (phone: string) => {
  return request({
    url: `/api/user/phone/${phone}`,
    method: 'get'
  })
}

/**
 * 添加用户
 */
export const addUser = async (user: User) => {
  return request({
    url: '/api/user/add',
    method: 'post',
    data: user
  })
}

/**
 * 更新用户
 */
export const updateUser = async (user: User) => {
  return request({
    url: '/api/user/update',
    method: 'put',
    data: user
  })
}

/**
 * 删除用户
 */
export const deleteUser = async (id: number) => {
  return request({
    url: `/api/user/delete/${id}`,
    method: 'delete'
  })
}

/**
 * 分页获取用户列表（兼容旧接口）
 */
export const getUserPage = async (page: number, size: number) => {
  return getUserList({ currentPage: page, pageSize: size })
}
