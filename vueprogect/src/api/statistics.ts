import request from '@/utils/request'

// 获取统计数据
export function getStatisticsData() {
  return request({
    url: '/api/statistics/data',
    method: 'get'
  })
}

// 获取用户趋势数据
export function getUserTrendData() {
  return request({
    url: '/api/statistics/user-trend',
    method: 'get'
  })
}

// 获取双因子码类型分布
export function getTwoFactorCodeTypeDistribution() {
  return request({
    url: '/api/statistics/two-factor-distribution',
    method: 'get'
  })
}

// 获取网格码状态分布
export function getGridCodeStatusDistribution() {
  return request({
    url: '/api/statistics/grid-code-status',
    method: 'get'
  })
}

// 获取模态标识类型分布
export function getModalIdentifierTypeDistribution() {
  return request({
    url: '/api/statistics/modal-identifier-type',
    method: 'get'
  })
}