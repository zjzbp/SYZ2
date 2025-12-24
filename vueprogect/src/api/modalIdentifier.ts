import request from '@/utils/request'

// 获取模态标识列表
export function getModalIdentifierList(params: {
  modalValue?: string
  twoFactorValue?: string
  identifierType?: string
  status?: string
  currentPage: number
  pageSize: number
}) {
  return request({
    url: '/api/modalIdentifier/list',
    method: 'get',
    params
  })
}

// 获取模态标识详情
export function getModalIdentifierDetail(id: number) {
  return request({
    url: `/api/modalIdentifier/${id}`,
    method: 'get'
  })
}

// 创建模态标识
export function createModalIdentifier(data: {
  modalValue: string
  twoFactorValue: string
  identifierType: string
  status?: string
  hashValue: string
}) {
  return request({
    url: '/api/modalIdentifier',
    method: 'post',
    data
  })
}

// 更新模态标识
export function updateModalIdentifier(id: number, data: {
  identifierType?: string
  status?: string
  hashValue?: string
}) {
  return request({
    url: `/api/modalIdentifier/${id}`,
    method: 'put',
    data
  })
}

// 删除模态标识
export function deleteModalIdentifier(id: number) {
  return request({
    url: `/api/modalIdentifier/${id}`,
    method: 'delete'
  })
}

// 绑定项目到模态标识
export function bindProjectToModalIdentifier(id: number, data: {
  projectName: string
  projectType: string
}) {
  return request({
    url: `/api/modalIdentifier/bindProject/${id}`,
    method: 'post',
    data
  })
}