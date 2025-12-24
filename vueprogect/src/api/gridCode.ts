import request from '@/utils/request'

// 获取网格码列表
export function getGridCodeList(params: {
  gridCodeValue?: string
  status?: string
  currentPage: number
  pageSize: number
}) {
  return request({
    url: '/api/gridCode/list',
    method: 'get',
    params
  })
}

// 获取网格码详情
export function getGridCodeDetail(id: number) {
  return request({
    url: `/api/gridCode/${id}`,
    method: 'get'
  })
}

// 创建网格码
export function createGridCode(data: {
  gridCodeValue: string
  status?: string
  hashValue: string
  depositRecordId: string
}) {
  return request({
    url: '/api/gridCode',
    method: 'post',
    data
  })
}

// 更新网格码
export function updateGridCode(id: number, data: {
  status?: string
  hashValue?: string
  depositRecordId?: string
}) {
  return request({
    url: `/api/gridCode/${id}`,
    method: 'put',
    data
  })
}

// 删除网格码
export function deleteGridCode(id: number) {
  return request({
    url: `/api/gridCode/${id}`,
    method: 'delete'
  })
}

// 验真网格码
export function verifyGridCode(id: number) {
  return request({
    url: `/api/gridCode/verify/${id}`,
    method: 'post'
  })
}