import request from '@/utils/request'

// 获取双因子码列表
export function getTwoFactorCodeList(params: {
  twoFactorValue?: string
  gridCodeValue?: string
  codeType?: string
  status?: string
  currentPage: number
  pageSize: number
}) {
  return request({
    url: '/api/twoFactorCode/list',
    method: 'get',
    params
  })
}

// 获取双因子码详情
export function getTwoFactorCodeDetail(id: number) {
  return request({
    url: `/api/twoFactorCode/${id}`,
    method: 'get'
  })
}

// 创建双因子码
export function createTwoFactorCode(data: {
  twoFactorValue: string
  gridCodeValue: string
  codeType: string
  status?: string
}) {
  return request({
    url: '/api/twoFactorCode',
    method: 'post',
    data
  })
}

// 更新双因子码
export function updateTwoFactorCode(id: number, data: {
  codeType?: string
  status?: string
}) {
  return request({
    url: `/api/twoFactorCode/${id}`,
    method: 'put',
    data
  })
}

// 删除双因子码
export function deleteTwoFactorCode(id: number) {
  return request({
    url: `/api/twoFactorCode/${id}`,
    method: 'delete'
  })
}

// 绑定资源到双因子码
export function bindResourceToTwoFactorCode(id: number, data: {
  resourceName: string
  resourceType: string
}) {
  return request({
    url: `/api/twoFactorCode/bindResource/${id}`,
    method: 'post',
    data
  })
}

// 获取双因子码关联详情
export function getTwoFactorCodeDetailWithRelations(id: number) {
  return request({
    url: `/api/twoFactorCode/${id}/relations`,
    method: 'get'
  })
}

// 分页查询模态标识
export function getModalIdentifiersPage(id: number, params: {
  modalValue?: string
  identifierType?: string
  createTimeStart?: string
  createTimeEnd?: string
  currentPage: number
  pageSize: number
}) {
  return request({
    url: `/api/twoFactorCode/${id}/modals/page`,
    method: 'post',
    data: params
  })
}

// 分页查询项目信息
export function getProjectsPage(id: number, params: {
  projectName?: string
  projectType?: string
  createTimeStart?: string
  createTimeEnd?: string
  currentPage: number
  pageSize: number
}) {
  return request({
    url: `/api/twoFactorCode/${id}/projects/page`,
    method: 'post',
    data: params
  })
}

// 获取所有项目类型
export function getProjectTypes() {
  return request({
    url: `/api/twoFactorCode/project/types`,
    method: 'get'
  })
}