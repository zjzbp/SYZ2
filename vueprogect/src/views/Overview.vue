<template>
  <div class="overview">
    <el-card class="module-card">
      <template #header>
        <div class="card-header">
          <span class="card-title">系统概述</span>
        </div>
      </template>
      
      <!-- 统计卡片 -->
      <el-row :gutter="20" class="stats-row">
        <el-col :xs="24" :sm="12" :lg="6" v-for="(stat, index) in stats" :key="index">
          <el-card 
            class="stat-card hover-lift slide-in-up" 
            shadow="hover"
            :style="{ animationDelay: `${index * 0.1}s` }"
          >
            <div class="stat-content">
              <div class="stat-icon" :style="{ background: stat.gradient }">
                <el-icon :size="30" class="pulse">
                  <component :is="stat.icon" />
                </el-icon>
              </div>
              <div class="stat-info">
                <div class="stat-title">{{ stat.title }}</div>
                <div class="stat-value">
                  <AnimatedNumber :value="stat.value" :prefix="stat.prefix" />
                </div>
                <div class="stat-trend" :class="stat.trendClass">
                  <el-icon><component :is="stat.trendIcon" /></el-icon>
                  <span>{{ stat.trend }}</span>
                </div>
              </div>
            </div>
          </el-card>
        </el-col>
      </el-row>

      <!-- 图表区域 -->
      <el-row :gutter="20" class="content-row">
        <el-col :xs="24" :lg="16">
          <el-card class="content-card hover-lift slide-in-up" shadow="hover" style="animation-delay: 0.4s">
            <template #header>
              <div class="card-header">
                <span class="card-title">关键指标趋势</span>
              </div>
            </template>
            <div ref="trendChartRef" class="chart-wrapper" style="height: 300px;"></div>
          </el-card>
        </el-col>

        <el-col :xs="24" :lg="8">
          <el-card class="content-card hover-lift slide-in-up" shadow="hover" style="animation-delay: 0.5s">
            <template #header>
              <div class="card-header">
                <span class="card-title">网格类型分布</span>
              </div>
            </template>
            <div ref="pieChartRef" class="chart-wrapper" style="height: 300px;"></div>
          </el-card>
        </el-col>
      </el-row>

      <!-- 最新活动 -->
      <el-row :gutter="20" class="content-row">
        <el-col :span="24">
          <el-card class="content-card hover-lift slide-in-up" shadow="hover" style="animation-delay: 0.6s">
            <template #header>
              <div class="card-header">
                <span class="card-title">最新活动</span>
              </div>
            </template>
            <el-table :data="activities" style="width: 100%" border stripe>
              <el-table-column prop="type" label="活动类型" width="120">
                <template #default="{ row }">
                  <el-tag :type="getActivityTypeTag(row.type)">
                    {{ getActivityTypeName(row.type) }}
                  </el-tag>
                </template>
              </el-table-column>
              <el-table-column prop="content" label="活动内容" />
              <el-table-column prop="operator" label="操作人" width="120" />
              <el-table-column prop="time" label="操作时间" width="180" />
            </el-table>
          </el-card>
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount } from 'vue'
import {
  Grid,
  Management,
  DataAnalysis,
  TrendCharts,
  CaretTop,
  CaretBottom,
  User,
  Connection,
  Folder
} from '@element-plus/icons-vue'
import * as echarts from 'echarts'
import AnimatedNumber from '@/components/AnimatedNumber.vue'

// 导入统计API
import {
  getStatisticsData,
  getUserTrendData,
  getTwoFactorCodeTypeDistribution,
  getGridCodeStatusDistribution,
  getModalIdentifierTypeDistribution
} from '@/api/statistics'

// 统计数据
interface StatItem {
  title: string;
  value: number;
  prefix: string;
  gradient: string;
  icon: any;
  trend: string;
  trendClass: string;
  trendIcon: any;
}

const stats = ref<StatItem[]>([
  { title: '总用户数', value: 0, prefix: '', gradient: 'linear-gradient(45deg, #3498db, #8e44ad)', icon: User, trend: '+5.2%', trendClass: 'up', trendIcon: CaretTop },
  { title: '网格码总数', value: 0, prefix: '', gradient: 'linear-gradient(45deg, #e74c3c, #e67e22)', icon: Grid, trend: '+3.1%', trendClass: 'up', trendIcon: CaretTop },
  { title: '双因子码总数', value: 0, prefix: '', gradient: 'linear-gradient(45deg, #2ecc71, #1abc9c)', icon: Management, trend: '+7.8%', trendClass: 'up', trendIcon: CaretTop },
  { title: '模态标识总数', value: 0, prefix: '', gradient: 'linear-gradient(45deg, #f39c12, #d35400)', icon: Connection, trend: '+2.5%', trendClass: 'up', trendIcon: CaretTop },
  { title: '项目总数', value: 0, prefix: '', gradient: 'linear-gradient(45deg, #9b59b6, #34495e)', icon: Folder, trend: '+1.9%', trendClass: 'up', trendIcon: CaretTop }
])

// 图表相关
const trendChartRef = ref<HTMLElement | null>(null)
const pieChartRef = ref<HTMLElement | null>(null)
let trendChart: echarts.ECharts | null = null
let pieChart: echarts.ECharts | null = null

// 最新活动
// TODO: 从API获取最新活动
const activities = ref([
  {
    type: '',
    content: '',
    operator: '',
    time: ''
  }
])

// 获取活动类型标签
const getActivityTypeTag = (type: string) => {
  const typeMap: Record<string, string> = {
    'grid-create': 'success',
    'code-generate': 'primary',
    'resource-bind': 'warning',
    'grid-update': 'info'
  }
  return typeMap[type] || 'info'
}

// 获取活动类型名称
const getActivityTypeName = (type: string) => {
  const typeMap: Record<string, string> = {
    'grid-create': '网格码创建',
    'code-generate': '码生成',
    'resource-bind': '资源绑定',
    'grid-update': '网格码更新'
  }
  return typeMap[type] || '未知'
}

// 初始化图表
const initCharts = () => {
  if (trendChartRef.value) {
    trendChart = echarts.init(trendChartRef.value)
    renderTrendChart()
  }
  
  if (pieChartRef.value) {
    pieChart = echarts.init(pieChartRef.value)
    renderPieChart()
  }
}

// 渲染趋势图
const renderTrendChart = (trendData?: any[]) => {
  if (!trendChart) return
  
  // 如果提供了趋势数据，使用该数据；否则使用默认空数据
  const dates = trendData ? trendData.map(item => item.date) : []
  const counts = trendData ? trendData.map(item => item.count) : []
  
  const option = {
    tooltip: {
      trigger: 'axis'
    },
    legend: {
      data: ['用户注册数']
    },
    xAxis: {
      type: 'category',
      data: dates
    },
    yAxis: {
      type: 'value'
    },
    series: [
      {
        name: '用户注册数',
        type: 'line',
        data: counts,
        smooth: true
      }
    ]
  }
  
  trendChart.setOption(option)
}

// 渲染饼图
const renderPieChart = (pieData?: any[]) => {
  if (!pieChart) return
  
  // 确保饼图数据显示中文状态值
  const chartData = pieData ? pieData.map(item => ({
    name: item.name || item.status || item.type || item.label,
    value: item.value || item.count
  })) : []
  
  const option = {
    tooltip: {
      trigger: 'item'
    },
    legend: {
      top: 'bottom'
    },
    series: [
      {
        name: '网格码状态',
        type: 'pie',
        radius: ['40%', '70%'],
        data: chartData
      }
    ]
  }
  
  pieChart.setOption(option)
}

// 窗口大小变化时重绘图表
const handleResize = () => {
  if (trendChart) {
    trendChart.resize()
  }
  if (pieChart) {
    pieChart.resize()
  }
}

// 组件挂载时加载数据
onMounted(async () => {
  initCharts()
  
  try {
    // 获取统计数据
    const statsResponse = await getStatisticsData()
    if (statsResponse && statsResponse.data) {
      const data = statsResponse.data
      if (stats.value && stats.value.length >= 5) {
        if (stats.value[0]) stats.value[0].value = data.totalUsers || 0
        if (stats.value[1]) stats.value[1].value = data.totalGridCodes || 0
        if (stats.value[2]) stats.value[2].value = data.totalTwoFactorCodes || 0
        if (stats.value[3]) stats.value[3].value = data.totalModalIdentifiers || 0
        if (stats.value[4]) stats.value[4].value = data.totalProjects || 0
      }
    }
    
    // 获取用户趋势数据
    const userTrendResponse = await getUserTrendData()
    if (userTrendResponse && userTrendResponse.data) {
      const trendData = userTrendResponse.data
      renderTrendChart(trendData)
    }
    
    // 获取网格码状态分布数据
    const gridCodeStatusResponse = await getGridCodeStatusDistribution()
    if (gridCodeStatusResponse && gridCodeStatusResponse.data) {
      const statusData = gridCodeStatusResponse.data
      renderPieChart(statusData)
    }
  } catch (error) {
    console.error('获取统计数据失败:', error)
  }
  
  // 监听窗口大小变化
  window.addEventListener('resize', handleResize)
})

// 组件卸载前清理
onBeforeUnmount(() => {
  if (trendChart) {
    trendChart.dispose()
  }
  if (pieChart) {
    pieChart.dispose()
  }
  
  // 移除事件监听
  window.removeEventListener('resize', handleResize)
})
</script>

<style scoped>
.overview {
  width: 100%;
}

.stats-row {
  margin-bottom: 20px;
}

.stat-card {
  margin-bottom: 20px;
  border-radius: 8px;
}

.stat-content {
  display: flex;
  align-items: center;
  gap: 20px;
}

.stat-icon {
  width: 70px;
  height: 70px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #fff;
  flex-shrink: 0;
}

.stat-info {
  flex: 1;
}

.stat-title {
  font-size: 14px;
  color: #909399;
  margin-bottom: 8px;
}

.stat-value {
  font-size: 28px;
  font-weight: bold;
  color: #303133;
  margin-bottom: 4px;
}

.stat-trend {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 12px;
}

.stat-trend.up {
  color: #67c23a;
}

.stat-trend.down {
  color: #f56c6c;
}

.content-row {
  margin-top: 20px;
}

.content-card {
  border-radius: 8px;
  margin-bottom: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-title {
  font-size: 16px;
  font-weight: bold;
  color: #303133;
}

.chart-wrapper {
  width: 100%;
}
</style>