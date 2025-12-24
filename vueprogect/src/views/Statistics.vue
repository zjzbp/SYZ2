<template>
  <div class="statistics-page">
    <el-card class="statistics-card">
      <template #header>
        <div class="card-header">
          <span class="card-title">数据统计</span>
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
                <span class="card-title">用户注册趋势</span>
              </div>
            </template>
            <div ref="trendChartRef" class="chart-wrapper" style="height: 300px;"></div>
          </el-card>
        </el-col>

        <el-col :xs="24" :lg="8">
          <el-card class="content-card hover-lift slide-in-up" shadow="hover" style="animation-delay: 0.5s">
            <template #header>
              <div class="card-header">
                <span class="card-title">双因子码类型分布</span>
              </div>
            </template>
            <div ref="pieChartRef" class="chart-wrapper" style="height: 300px;"></div>
          </el-card>
        </el-col>
      </el-row>

      <!-- 第二行图表 -->
      <el-row :gutter="20" class="content-row">
        <el-col :xs="24" :lg="8">
          <el-card class="content-card hover-lift slide-in-up" shadow="hover" style="animation-delay: 0.6s">
            <template #header>
              <div class="card-header">
                <span class="card-title">网格码状态分布</span>
              </div>
            </template>
            <div ref="gridCodeChartRef" class="chart-wrapper" style="height: 300px;"></div>
          </el-card>
        </el-col>

        <el-col :xs="24" :lg="8">
          <el-card class="content-card hover-lift slide-in-up" shadow="hover" style="animation-delay: 0.7s">
            <template #header>
              <div class="card-header">
                <span class="card-title">模态标识类型分布</span>
              </div>
            </template>
            <div ref="modalIdentifierChartRef" class="chart-wrapper" style="height: 300px;"></div>
          </el-card>
        </el-col>

        <el-col :xs="24" :lg="8">
          <el-card class="content-card hover-lift slide-in-up" shadow="hover" style="animation-delay: 0.8s">
            <template #header>
              <div class="card-header">
                <span class="card-title">系统概览</span>
              </div>
            </template>
            <div class="overview-info">
              <div class="info-item">
                <el-icon :size="20" color="#409EFF"><Management /></el-icon>
                <div class="info-text">
                  <div class="info-title">网格码管理</div>
                  <div class="info-value">{{ stats[1]?.value || 0 }} 个</div>
                </div>
              </div>
              <div class="info-item">
                <el-icon :size="20" color="#67C23A"><Connection /></el-icon>
                <div class="info-text">
                  <div class="info-title">双因子码管理</div>
                  <div class="info-value">{{ stats[2]?.value || 0 }} 个</div>
                </div>
              </div>
              <div class="info-item">
                <el-icon :size="20" color="#E6A23C"><Folder /></el-icon>
                <div class="info-text">
                  <div class="info-title">模态标识管理</div>
                  <div class="info-value">{{ stats[3]?.value || 0 }} 个</div>
                </div>
              </div>
              <div class="info-item">
                <el-icon :size="20" color="#F56C6C"><Document /></el-icon>
                <div class="info-text">
                  <div class="info-title">项目信息管理</div>
                  <div class="info-value">{{ stats[4]?.value || 0 }} 个</div>
                </div>
              </div>
            </div>
          </el-card>
        </el-col>
      </el-row>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount } from 'vue'
import {
  User,
  Grid,
  Management,
  DataAnalysis,
  Connection,
  Folder,
  Document,
  CaretTop,
  CaretBottom
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
const gridCodeChartRef = ref<HTMLElement | null>(null)
const modalIdentifierChartRef = ref<HTMLElement | null>(null)

let trendChart: echarts.ECharts | null = null
let pieChart: echarts.ECharts | null = null
let gridCodeChart: echarts.ECharts | null = null
let modalIdentifierChart: echarts.ECharts | null = null

// 用户趋势数据
const userTrendData = ref<{ date: string; count: number }[]>([])

// 双因子码类型分布数据
const twoFactorDistributionData = ref<{ type: string; count: number }[]>([])

// 网格码状态分布数据
const gridCodeStatusData = ref<{ status: string; count: number }[]>([])

// 模态标识类型分布数据
const modalIdentifierTypeData = ref<{ type: string; count: number }[]>([])

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
  
  if (gridCodeChartRef.value) {
    gridCodeChart = echarts.init(gridCodeChartRef.value)
    renderGridCodeChart()
  }
  
  if (modalIdentifierChartRef.value) {
    modalIdentifierChart = echarts.init(modalIdentifierChartRef.value)
    renderModalIdentifierChart()
  }
}

// 渲染趋势图
const renderTrendChart = () => {
  if (!trendChart) return
  
  const dates = userTrendData.value.map(item => item.date)
  const counts = userTrendData.value.map(item => item.count)
  
  const option = {
    tooltip: {
      trigger: 'axis'
    },
    xAxis: {
      type: 'category',
      data: dates
    },
    yAxis: {
      type: 'value'
    },
    series: [{
      data: counts,
      type: 'line',
      smooth: true,
      itemStyle: {
        color: '#3498db'
      }
    }]
  }
  
  trendChart.setOption(option)
}

// 渲染双因子码类型分布饼图
const renderPieChart = () => {
  if (!pieChart) return
  
  const data = twoFactorDistributionData.value.map(item => ({
    name: item.type,
    value: item.count
  }))
  
  const option = {
    tooltip: {
      trigger: 'item'
    },
    legend: {
      top: '5%',
      left: 'center'
    },
    series: [
      {
        name: '双因子码类型',
        type: 'pie',
        radius: ['40%', '70%'],
        avoidLabelOverlap: false,
        itemStyle: {
          borderRadius: 10,
          borderColor: '#fff',
          borderWidth: 2
        },
        label: {
          show: true,
          formatter: '{b}: {c} ({d}%)'
        },
        emphasis: {
          label: {
            show: true,
            fontSize: '18',
            fontWeight: 'bold'
          }
        },
        data: data
      }
    ]
  }
  
  pieChart.setOption(option)
}

// 渲染网格码状态分布图
const renderGridCodeChart = () => {
  if (!gridCodeChart) return
  
  const data = gridCodeStatusData.value.map(item => ({
    name: item.status,
    value: item.count
  }))
  
  const option = {
    tooltip: {
      trigger: 'item'
    },
    legend: {
      top: '5%',
      left: 'center'
    },
    series: [
      {
        name: '网格码状态',
        type: 'pie',
        radius: ['40%', '70%'],
        avoidLabelOverlap: false,
        itemStyle: {
          borderRadius: 10,
          borderColor: '#fff',
          borderWidth: 2
        },
        label: {
          show: true,
          formatter: '{b}: {c} ({d}%)'
        },
        emphasis: {
          label: {
            show: true,
            fontSize: '18',
            fontWeight: 'bold'
          }
        },
        data: data
      }
    ]
  }
  
  gridCodeChart.setOption(option)
}

// 渲染模态标识类型分布图
const renderModalIdentifierChart = () => {
  if (!modalIdentifierChart) return
  
  const data = modalIdentifierTypeData.value.map(item => ({
    name: item.type,
    value: item.count
  }))
  
  const option = {
    tooltip: {
      trigger: 'item'
    },
    legend: {
      top: '5%',
      left: 'center'
    },
    series: [
      {
        name: '模态标识类型',
        type: 'pie',
        radius: ['40%', '70%'],
        avoidLabelOverlap: false,
        itemStyle: {
          borderRadius: 10,
          borderColor: '#fff',
          borderWidth: 2
        },
        label: {
          show: true,
          formatter: '{b}: {c} ({d}%)'
        },
        emphasis: {
          label: {
            show: true,
            fontSize: '18',
            fontWeight: 'bold'
          }
        },
        data: data
      }
    ]
  }
  
  modalIdentifierChart.setOption(option)
}

// 窗口大小变化时重绘图表
const handleResize = () => {
  if (trendChart) {
    trendChart.resize()
  }
  if (pieChart) {
    pieChart.resize()
  }
  if (gridCodeChart) {
    gridCodeChart.resize()
  }
  if (modalIdentifierChart) {
    modalIdentifierChart.resize()
  }
}

// 获取统计数据
const fetchStatisticsData = async () => {
  try {
    // 获取统计数据
    const statsResponse = await getStatisticsData()
    if (statsResponse.data) {
      const data = statsResponse.data
      // 安全地更新统计值
      if (stats.value && stats.value.length >= 5) {
        stats.value[0]!.value = data.totalUsers || 0
        stats.value[1]!.value = data.totalGridCodes || 0
        stats.value[2]!.value = data.totalTwoFactorCodes || 0
        stats.value[3]!.value = data.totalModalIdentifiers || 0
        stats.value[4]!.value = data.totalProjects || 0
      }
    }
    
    // 获取用户趋势数据
    const userTrendResponse = await getUserTrendData()
    if (userTrendResponse.data) {
      userTrendData.value = userTrendResponse.data.map((item: any) => ({
        date: item.date,
        count: item.count
      }))
    }
    
    // 获取双因子码类型分布数据
    const twoFactorResponse = await getTwoFactorCodeTypeDistribution()
    if (twoFactorResponse.data) {
      twoFactorDistributionData.value = twoFactorResponse.data.map((item: any) => ({
        type: item.type,
        count: item.count
      }))
    }
    
    // 获取网格码状态分布数据
    const gridCodeResponse = await getGridCodeStatusDistribution()
    if (gridCodeResponse.data) {
      gridCodeStatusData.value = gridCodeResponse.data.map((item: any) => ({
        status: item.status,
        count: item.count
      }))
    }
    
    // 获取模态标识类型分布数据
    const modalIdentifierResponse = await getModalIdentifierTypeDistribution()
    if (modalIdentifierResponse.data) {
      modalIdentifierTypeData.value = modalIdentifierResponse.data.map((item: any) => ({
        type: item.type,
        count: item.count
      }))
    }
    
    // 更新图表
    setTimeout(() => {
      renderTrendChart()
      renderPieChart()
      renderGridCodeChart()
      renderModalIdentifierChart()
    }, 100)
  } catch (error) {
    console.error('获取统计数据失败:', error)
  }
}

// 组件挂载时加载数据
onMounted(() => {
  initCharts()
  fetchStatisticsData()
  
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
  if (gridCodeChart) {
    gridCodeChart.dispose()
  }
  if (modalIdentifierChart) {
    modalIdentifierChart.dispose()
  }
  
  // 移除事件监听
  window.removeEventListener('resize', handleResize)
})
</script>

<style scoped>
.statistics-page {
  width: 100%;
  padding: 20px;
  background-color: #f5f7fa;
}

.statistics-card {
  border-radius: 8px;
}

.stats-row {
  margin-bottom: 20px;
}

.stat-card {
  margin-bottom: 20px;
  border-radius: 8px;
  transition: all 0.3s ease;
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

.overview-info {
  display: flex;
  flex-direction: column;
  gap: 15px;
}

.info-item {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 10px;
  border-radius: 6px;
  background-color: #f8f9fa;
}

.info-text {
  flex: 1;
}

.info-title {
  font-size: 14px;
  color: #606266;
  margin-bottom: 4px;
}

.info-value {
  font-size: 18px;
  font-weight: bold;
  color: #303133;
}

/* 动画效果 */
.hover-lift {
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.hover-lift:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
}

.slide-in-up {
  opacity: 0;
  transform: translateY(20px);
  animation: slideInUp 0.6s forwards;
}

@keyframes slideInUp {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.pulse {
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.1);
  }
  100% {
    transform: scale(1);
  }
}
</style>