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
  CaretBottom
} from '@element-plus/icons-vue'
import * as echarts from 'echarts'
import AnimatedNumber from '@/components/AnimatedNumber.vue'

const stats = ref([
  {
    title: '网格码总数',
    value: 1234,
    prefix: '',
    gradient: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
    icon: 'Grid',
    trend: '+12%',
    trendClass: 'up',
    trendIcon: 'CaretTop'
  },
  {
    title: '双因子码数量',
    value: 56789,
    prefix: '',
    gradient: 'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)',
    icon: 'Management',
    trend: '+8%',
    trendClass: 'up',
    trendIcon: 'CaretTop'
  },
  {
    title: '模态标识生成量',
    value: 123456,
    prefix: '',
    gradient: 'linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)',
    icon: 'DataAnalysis',
    trend: '+15%',
    trendClass: 'up',
    trendIcon: 'CaretTop'
  },
  {
    title: '资源确权率',
    value: 92.5,
    prefix: '',
    gradient: 'linear-gradient(135deg, #fa709a 0%, #fee140 100%)',
    icon: 'TrendCharts',
    trend: '-2%',
    trendClass: 'down',
    trendIcon: 'CaretBottom'
  }
])

// 图表相关
const trendChartRef = ref<HTMLElement | null>(null)
const pieChartRef = ref<HTMLElement | null>(null)
let trendChart: echarts.ECharts | null = null
let pieChart: echarts.ECharts | null = null

// 最新活动
const activities = ref([
  {
    type: 'grid-create',
    content: '创建了新的网格码：GR-WG-001-0001',
    operator: '张三',
    time: '2023-05-01 10:30:00'
  },
  {
    type: 'code-generate',
    content: '生成了新的双因子码：BP-WG-001-0001',
    operator: '李四',
    time: '2023-05-01 10:25:00'
  },
  {
    type: 'resource-bind',
    content: '将模态标识绑定到双因子码：GR-WG-002-0005',
    operator: '王五',
    time: '2023-05-01 10:20:00'
  },
  {
    type: 'grid-update',
    content: '更新了网格码信息：GR-WG-003-0002',
    operator: '赵六',
    time: '2023-05-01 10:15:00'
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
const renderTrendChart = () => {
  if (!trendChart) return
  
  const option = {
    tooltip: {
      trigger: 'axis'
    },
    legend: {
      data: ['网格码总数', '双因子码', '模态标识']
    },
    xAxis: {
      type: 'category',
      data: ['1月', '2月', '3月', '4月', '5月', '6月']
    },
    yAxis: {
      type: 'value'
    },
    series: [
      {
        name: '网格码总数',
        type: 'line',
        data: [1000, 1050, 1100, 1150, 1200, 1234],
        smooth: true
      },
      {
        name: '双因子码',
        type: 'line',
        data: [45000, 48000, 50000, 52000, 55000, 56789],
        smooth: true
      },
      {
        name: '模态标识',
        type: 'line',
        data: [90000, 98000, 105000, 112000, 118000, 123456],
        smooth: true
      }
    ]
  }
  
  trendChart.setOption(option)
}

// 渲染饼图
const renderPieChart = () => {
  if (!pieChart) return
  
  const option = {
    tooltip: {
      trigger: 'item'
    },
    legend: {
      top: 'bottom'
    },
    series: [
      {
        name: '网格类型',
        type: 'pie',
        radius: ['40%', '70%'],
        data: [
          { value: 856, name: '个人网格' },
          { value: 378, name: '企业网格' }
        ]
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
onMounted(() => {
  initCharts()
  
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