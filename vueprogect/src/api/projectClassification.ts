import request from '@/utils/request'

// 获取项目分类列表
export function getProjectClassificationList(params: {
  projectName?: string
  projectType?: string
  modalId?: string
  currentPage: number
  pageSize: number
}) {
  return request({
    url: '/api/projectClassification/list',
    method: 'get',
    params
  })
}

// 获取项目详情
export function getProjectClassificationDetail(id: number) {
  return request({
    url: `/api/projectClassification/${id}`,
    method: 'get'
  })
}

// 创建项目
export function createProjectClassification(data: {
  projectName: string
  projectType: string
  modalValue: string
  cloudStorageUrl: string
  projectDesc?: string
  projectStatus?: string
}) {
  return request({
    url: '/api/projectClassification',
    method: 'post',
    data
  })
}

// 更新项目
export function updateProjectClassification(id: number, data: {
  projectName?: string
  projectType?: string
  modalValue?: string
  cloudStorageUrl?: string
  projectDesc?: string
  projectStatus?: string
}) {
  return request({
    url: `/api/projectClassification/${id}`,
    method: 'put',
    data
  })
}

// 删除项目
export function deleteProjectClassification(id: number) {
  return request({
    url: `/api/projectClassification/${id}`,
    method: 'delete'
  })
}

// 获取所有项目类型
export function getProjectTypes() {
  return request({
    url: '/api/project/types',
    method: 'get'
  })
}

// 新增项目类型
export function createProject(data: {
  projectType: string
  score?: number
}) {
  return request({
    url: '/api/project',
    method: 'post',
    data
  })
}

// 删除项目类型
export function deleteProjectType(projectType: string) {
  return request({
    url: `/api/project/type/${encodeURIComponent(projectType)}`,
    method: 'delete'
  })
}