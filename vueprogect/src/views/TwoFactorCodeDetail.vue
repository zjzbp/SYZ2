<template>
  <div class="two-factor-detail">
    <el-page-header :content="`双因子码详情 - ${twoFactorCode?.twoFactorValue}`" @back="goBack" class="page-header" />
    
    <el-card class="detail-card" v-loading="loading">
      <template #header>
        <div class="card-header">
          <span class="card-title">双因子码基本信息</span>
        </div>
      </template>
      
      <el-descriptions :column="2" border size="small">
        <el-descriptions-item label="双因子码ID">{{ twoFactorCode?.twoFactorId }}</el-descriptions-item>
        <el-descriptions-item label="双因子码值"><strong>{{ twoFactorCode?.twoFactorValue }}</strong></el-descriptions-item>
        <el-descriptions-item label="关联网格码">{{ twoFactorCode?.gridCodeValue }}</el-descriptions-item>
        <el-descriptions-item label="用户姓名"><strong>{{ user?.userName || user?.name }}</strong></el-descriptions-item>
        <el-descriptions-item label="码类型">
          <el-tag :type="twoFactorCode?.codeType === 'ASSET' ? 'primary' : 'success'" size="small">
            {{ twoFactorCode?.codeType === 'ASSET' ? '资产类' : '个人类' }}
          </el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="状态">
          <el-tag :type="getStatusTag(twoFactorCode?.status)" size="small">
            {{ getStatusName(twoFactorCode?.status) }}
          </el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="创建时间">{{ formatDateTime(twoFactorCode?.createTime) }}</el-descriptions-item>
        <el-descriptions-item label="剩余模态标识数量"><strong>{{ twoFactorCode?.remainingModals }}</strong></el-descriptions-item>
      </el-descriptions>
    </el-card>
    
    <!-- 用户信息 -->
    <el-card class="detail-card" v-if="user">
      <template #header>
        <div class="card-header">
          <span class="card-title">用户信息</span>
        </div>
      </template>
      
      <el-descriptions :column="2" border size="small">
        <el-descriptions-item label="用户ID">{{ user?.userId }}</el-descriptions-item>
        <el-descriptions-item label="用户姓名"><strong>{{ user?.userName || user?.name }}</strong></el-descriptions-item>
        <el-descriptions-item label="用户类型">
          <el-tag :type="user?.userType === 'PERSONAL' ? 'success' : 'primary'" size="small">
            {{ user?.userType === 'PERSONAL' ? '个人' : '企业' }}
          </el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="手机号">{{ user?.phone }}</el-descriptions-item>
        <el-descriptions-item label="是否填写信息">
          <el-tag :type="user?.isFillin === 1 ? 'success' : 'warning'" size="small">
            {{ user?.isFillin === 1 ? '已填写' : '未填写' }}
          </el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="创建时间">{{ formatDateTime(user?.createTime) }}</el-descriptions-item>
      </el-descriptions>
    </el-card>
    
    <!-- 关联网格码信息 -->
    <el-card class="detail-card" v-if="gridCode">
      <template #header>
        <div class="card-header">
          <span class="card-title">关联网格码信息</span>
        </div>
      </template>
      
      <el-descriptions :column="2" border size="small">
        <el-descriptions-item label="网格码ID">{{ gridCode?.gridCodeId }}</el-descriptions-item>
        <el-descriptions-item label="网格码值"><strong>{{ gridCode?.gridCodeValue }}</strong></el-descriptions-item>
        <el-descriptions-item label="状态">
          <el-tag :type="gridCode?.status === 'VALID' ? 'success' : 'danger'" size="small">
            {{ gridCode?.status === 'VALID' ? '有效' : '无效' }}
          </el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="创建时间">{{ formatDateTime(gridCode?.createTime) }}</el-descriptions-item>
      </el-descriptions>
    </el-card>
    
    <!-- 关联模态标识列表 -->
    <el-card class="detail-card">
      <template #header>
        <div class="card-header">
          <span class="card-title">关联模态标识</span>
          <div class="header-actions" v-if="modalIdentifierPage.total > 0">
            <span class="count">共 {{ modalIdentifierPage.total }} 条</span>
          </div>
        </div>
      </template>
      
      <!-- 搜索筛选 -->
      <div style="margin-bottom: 16px; padding: 16px; background: #f5f7fa; border-radius: 4px;">
        <el-row :gutter="16" style="margin-bottom: 12px;">
          <el-col :xs="24" :sm="12" :md="6">
            <el-input v-model="modalIdentifierFilters.modalValue" placeholder="模态标识值" clearable />
          </el-col>
          <el-col :xs="24" :sm="12" :md="6">
            <el-select v-model="modalIdentifierFilters.identifierType" placeholder="标识类型" clearable>
              <el-option label="项目类" value="PROJECT" />
              <el-option label="其他" value="OTHER" />
            </el-select>
          </el-col>
          <el-col :xs="24" :sm="12" :md="6">
            <el-date-picker v-model="modalIdentifierFilters.createTimeStart" type="datetime" placeholder="开始时间" style="width: 100%" />
          </el-col>
          <el-col :xs="24" :sm="12" :md="6">
            <el-date-picker v-model="modalIdentifierFilters.createTimeEnd" type="datetime" placeholder="结束时间" style="width: 100%" />
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="12">
            <el-button type="primary" @click="filterModalIdentifiers" :loading="modalIdentifierLoading">{{ modalIdentifierLoading ? '查询中...' : '查询' }}</el-button>
            <el-button @click="() => { modalIdentifierFilters = { modalValue: '', identifierType: '', createTimeStart: '', createTimeEnd: '' }; loadModalIdentifiersPage(1) }">重置</el-button>
          </el-col>
        </el-row>
      </div>
      
      <el-table :data="modalIdentifierPage.records" style="width: 100%" border stripe size="small" v-loading="modalIdentifierLoading">
        <el-table-column prop="modalId" label="ID" width="60" />
        <el-table-column prop="modalValue" label="模态标识值" width="160" />
        <el-table-column prop="identifierType" label="标识类型" width="100">
          <template #default="{ row }">
            <el-tag :type="row.identifierType === 'PROJECT' ? 'primary' : 'success'" size="small">
              {{ row.identifierType === 'PROJECT' ? '项目类' : '其他' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="80">
          <template #default="{ row }">
            <el-tag :type="row.status === 'VALID' ? 'success' : 'danger'" size="small">
              {{ row.status === 'VALID' ? '有效' : '无效' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" width="150">
          <template #default="{ row }">
            {{ formatDateTime(row.createTime) }}
          </template>
        </el-table-column>
        <el-table-column prop="hashValue" label="哈希值" min-width="200" show-overflow-tooltip />
      </el-table>
      
      <!-- 分页 -->
      <el-pagination
        v-model:current-page="modalIdentifierPage.current"
        v-model:page-size="modalIdentifierPage.size"
        :page-sizes="[10, 20, 50, 100]"
        :total="modalIdentifierPage.total"
        layout="total, sizes, prev, pager, next, jumper"
        style="margin-top: 16px; text-align: right;"
        @current-change="loadModalIdentifiersPage"
        @size-change="() => loadModalIdentifiersPage(1)"
      />
    </el-card>
    
    <!-- 关联项目列表 -->
    <el-card class="detail-card">
      <template #header>
        <div class="card-header">
          <span class="card-title">关联项目</span>
          <div class="header-actions" v-if="projectsPage.total > 0">
            <span class="count">共 {{ projectsPage.total }} 条</span>
          </div>
        </div>
      </template>
      
      <!-- 搜索筛选 -->
      <div style="margin-bottom: 16px; padding: 16px; background: #f5f7fa; border-radius: 4px;">
        <el-row :gutter="16" style="margin-bottom: 12px;">
          <el-col :xs="24" :sm="12" :md="6">
            <el-input v-model="projectFilters.projectName" placeholder="项目名称" clearable />
          </el-col>
          <el-col :xs="24" :sm="12" :md="6">
            <el-select v-model="projectFilters.projectType" placeholder="选择项目类型" clearable>
              <el-option v-for="option in projectTypeOptions" :key="option.value" :label="option.label" :value="option.value" />
            </el-select>
          </el-col>
          <el-col :xs="24" :sm="12" :md="6">
            <el-date-picker v-model="projectFilters.createTimeStart" type="datetime" placeholder="开始时间" style="width: 100%" />
          </el-col>
          <el-col :xs="24" :sm="12" :md="6">
            <el-date-picker v-model="projectFilters.createTimeEnd" type="datetime" placeholder="结束时间" style="width: 100%" />
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="12">
            <el-button type="primary" @click="filterProjects" :loading="projectsLoading">{{ projectsLoading ? '查询中...' : '查询' }}</el-button>
            <el-button @click="() => { projectFilters = { projectName: '', projectType: '', createTimeStart: '', createTimeEnd: '' }; loadProjectsPage(1) }">重置</el-button>
          </el-col>
        </el-row>
      </div>
      
      <el-table :data="projectsPage.records" style="width: 100%" border stripe size="small" v-loading="projectsLoading">
        <el-table-column prop="projectId" label="项目ID" width="60" />
        <el-table-column prop="projectName" label="项目名称" width="160" />
        <el-table-column prop="projectType" label="项目类型" width="100">
          <template #default="{ row }">
            <el-tag type="primary" size="small">{{ row.projectType }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="projectStatus" label="项目状态" width="80">
          <template #default="{ row }">
            <el-tag :type="row.projectStatus === 'ONLINE' ? 'success' : 'warning'" size="small">
              {{ row.projectStatus === 'ONLINE' ? '在线' : '离线' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="byteSize" label="文件大小(B)" width="100" />
        <el-table-column prop="uploadTime" label="上传时间" width="150">
          <template #default="{ row }">
            {{ formatDateTime(row.uploadTime) }}
          </template>
        </el-table-column>
        <el-table-column prop="cloudStorageUrl" label="云存储URL" min-width="150" show-overflow-tooltip />
      </el-table>
      
      <!-- 分页 -->
      <el-pagination
        v-model:current-page="projectsPage.current"
        v-model:page-size="projectsPage.size"
        :page-sizes="[10, 20, 50, 100]"
        :total="projectsPage.total"
        layout="total, sizes, prev, pager, next, jumper"
        style="margin-top: 16px; text-align: right;"
        @current-change="loadProjectsPage"
        @size-change="() => loadProjectsPage(1)"
      />
    </el-card>
    
    <!-- 数据统计区域 -->
    <div class="charts-wrapper">
      <!-- 关联数据统计 -->
      <el-card class="chart-card compact-chart">
        <template #header>
          <div class="card-header">
            <span class="card-title-small">关联数据统计</span>
          </div>
        </template>
        
        <div class="chart-container-small">
          <div ref="chartRef" class="chart" style="height: 260px;"></div>
        </div>
      </el-card>
      
      <!-- 模态标识类型统计 -->
      <el-card class="chart-card compact-chart">
        <template #header>
          <div class="card-header">
            <span class="card-title-small">模态标识统计</span>
          </div>
        </template>
        
        <div class="chart-container-small">
          <div ref="chartRef3" class="chart" style="height: 260px;"></div>
        </div>
      </el-card>
      
      <!-- 项目类型统计 -->
      <el-card class="chart-card compact-chart">
        <template #header>
          <div class="card-header">
            <span class="card-title-small">项目统计</span>
          </div>
        </template>
        
        <div class="chart-container-small">
          <div ref="chartRef4" class="chart" style="height: 260px;"></div>
        </div>
      </el-card>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, nextTick, onUnmounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { ElMessage } from 'element-plus'
import { getTwoFactorCodeDetailWithRelations, getModalIdentifiersPage, getProjectsPage, getProjectTypes } from '@/api/twoFactorCode'
import * as echarts from 'echarts'

// 路由相关
const router = useRouter()
const route = useRoute()

// 数据
const loading = ref(false)
const twoFactorCode = ref<any>(null)
const user = ref<any>(null)
const gridCode = ref<any>(null)
const modalIdentifiers = ref<any[]>([])
const projects = ref<any[]>([])
const chartRef = ref<HTMLElement | null>(null)
const chartRef3 = ref<HTMLElement | null>(null)
const chartRef4 = ref<HTMLElement | null>(null)
let chart: echarts.ECharts | null = null
let chart3: echarts.ECharts | null = null
let chart4: echarts.ECharts | null = null

// 模态标识分页数据
const modalIdentifierPage = ref<any>({
  records: [],
  current: 1,
  size: 10,
  total: 0
})
const modalIdentifierLoading = ref(false)
const modalIdentifierFilters = ref({
  modalValue: '',
  identifierType: '',
  createTimeStart: '',
  createTimeEnd: ''
})

// 项目信息分页数据
const projectsPage = ref<any>({
  records: [],
  current: 1,
  size: 10,
  total: 0
})
const projectsLoading = ref(false)
const projectFilters = ref({
  projectName: '',
  projectType: '',
  createTimeStart: '',
  createTimeEnd: ''
})
const projectTypeOptions = ref<any[]>([])

// 获取双因子码ID
const twoFactorId = Number(route.params.id)

// 获取详情数据
const fetchDetailData = async () => {
  loading.value = true
  try {
    const response = await getTwoFactorCodeDetailWithRelations(twoFactorId)
    if (response && response.data) {
      const data = response.data
      twoFactorCode.value = data.twoFactorCode
      user.value = data.user
      // 如果后端返回了userName，将其添加到user对象中
      if (data.userName) {
        user.value = { ...user.value, userName: data.userName }
      }
      gridCode.value = data.gridCode
      modalIdentifiers.value = data.modalIdentifiers || []
      projects.value = data.projects || []
      
      // 渲染图表
      await nextTick()
      renderChart()
      renderChart3()
      renderChart4()
      
      // 加载分页数据
      await loadModalIdentifiersPage(1)
      await loadProjectsPage(1)
      
      // 加载项目类型
      await loadProjectTypes()
    } else {
      ElMessage.error('获取双因子码详情失败')
    }
  } catch (error) {
    console.error('获取双因子码详情失败:', error)
    ElMessage.error('获取双因子码详情失败')
  } finally {
    loading.value = false
  }
}

// 返回上一页
const goBack = () => {
  router.go(-1)
}

// 获取状态标签
const getStatusTag = (status: string) => {
  const statusMap: Record<string, string> = {
    ACTIVATED: 'success',
    FROZEN: 'warning',
    INVALID: 'danger'
  }
  return statusMap[status] || 'info'
}

// 获取状态名称
const getStatusName = (status: string) => {
  const statusMap: Record<string, string> = {
    ACTIVATED: '已激活',
    FROZEN: '冻结',
    INVALID: '失效'
  }
  return statusMap[status] || '未知'
}

// 格式化日期时间
const formatDateTime = (dateString: string) => {
  if (!dateString) return '-'
  const date = new Date(dateString)
  return date.toLocaleString('zh-CN')
}

// 渲染图表
const renderChart = () => {
  if (!chartRef.value) return
  
  chart = echarts.init(chartRef.value)
  
  const option = {
    title: {
      text: '双因子码关联数据统计',
      left: 'center',
      top: 10,
      textStyle: {
        fontSize: 13,
        fontWeight: 'bold',
        color: '#1f2937'
      },
      subtextStyle: {
        fontSize: 11,
        color: '#6b7280'
      }
    },
    tooltip: {
      trigger: 'item',
      confine: true
    },
    legend: {
      orient: 'vertical',
      left: '10%',
      textStyle: {
        fontSize: 11,
        color: '#6b7280'
      }
    },
    series: [
      {
        name: '数据类型',
        type: 'pie',
        radius: ['30%', '45%'],
        center: ['60%', '50%'],
        data: [
          { value: user.value ? 1 : 0, name: '用户' },
          { value: gridCode.value ? 1 : 0, name: '网格码' },
          { value: modalIdentifiers.value.length, name: '模态标识' },
          { value: projects.value.length, name: '项目' }
        ],
        itemStyle: {
          borderRadius: 4,
          borderColor: '#fff',
          borderWidth: 2
        },
        emphasis: {
          itemStyle: {
            shadowBlur: 8,
            shadowOffsetX: 0,
            shadowColor: 'rgba(0, 0, 0, 0.3)'
          }
        },
        labelLine: {
          smooth: 0.2
        },
        label: {
          fontSize: 11
        }
      }
    ]
  }
  
  chart.setOption(option)
}

// 渲染模态标识单独图表
const renderChart3 = () => {
  if (!chartRef3.value) return
  
  chart3 = echarts.init(chartRef3.value)
  
  // 按标识类型统计模态标识
  const modalTypeMap: Record<string, number> = {}
  modalIdentifiers.value.forEach(modal => {
    const type = modal.identifierType || '未知'
    modalTypeMap[type] = (modalTypeMap[type] || 0) + 1
  })
  
  const modalTypes = Object.keys(modalTypeMap)
  const modalCounts = Object.values(modalTypeMap)
  
  const option = {
    title: {
      text: '模态标识类型',
      left: 'center',
      top: 8,
      textStyle: {
        fontSize: 12,
        fontWeight: 'bold',
        color: '#1f2937'
      }
    },
    tooltip: {
      trigger: 'item',
      confine: true
    },
    legend: {
      orient: 'vertical',
      right: '5%',
      textStyle: {
        fontSize: 10,
        color: '#6b7280'
      }
    },
    series: [
      {
        name: '模态标识类型',
        type: 'pie',
        radius: ['25%', '40%'],
        center: ['40%', '55%'],
        data: modalTypes.map((type, index) => ({
          value: modalCounts[index],
          name: type
        })),
        itemStyle: {
          borderRadius: 4,
          borderColor: '#fff',
          borderWidth: 2
        },
        emphasis: {
          itemStyle: {
            shadowBlur: 8,
            shadowOffsetX: 0,
            shadowColor: 'rgba(0, 0, 0, 0.3)'
          }
        },
        label: {
          fontSize: 10
        }
      }
    ]
  }
  
  chart3.setOption(option)
}

// 渲染项目单独图表
const renderChart4 = () => {
  if (!chartRef4.value) return
  
  chart4 = echarts.init(chartRef4.value)
  
  // 按项目类型统计项目
  const projectTypeMap: Record<string, number> = {}
  projects.value.forEach(project => {
    const type = project.projectType || '未知'
    projectTypeMap[type] = (projectTypeMap[type] || 0) + 1
  })
  
  const projectTypes = Object.keys(projectTypeMap)
  const projectCounts = Object.values(projectTypeMap)
  
  const option = {
    title: {
      text: '项目类型',
      left: 'center',
      top: 8,
      textStyle: {
        fontSize: 12,
        fontWeight: 'bold',
        color: '#1f2937'
      }
    },
    tooltip: {
      trigger: 'item',
      confine: true
    },
    legend: {
      orient: 'vertical',
      right: '5%',
      textStyle: {
        fontSize: 10,
        color: '#6b7280'
      }
    },
    series: [
      {
        name: '项目类型',
        type: 'pie',
        radius: ['25%', '40%'],
        center: ['40%', '55%'],
        data: projectTypes.map((type, index) => ({
          value: projectCounts[index],
          name: type
        })),
        itemStyle: {
          borderRadius: 4,
          borderColor: '#fff',
          borderWidth: 2
        },
        emphasis: {
          itemStyle: {
            shadowBlur: 8,
            shadowOffsetX: 0,
            shadowColor: 'rgba(0, 0, 0, 0.3)'
          }
        },
        label: {
          fontSize: 10
        }
      }
    ]
  }
  
  chart4.setOption(option)
}

// 格式化日期为 yyyy-MM-dd HH:mm:ss
const formatDateTimeString = (date: any) => {
  if (!date) return ''
  if (typeof date === 'string') return date
  const d = new Date(date)
  const year = d.getFullYear()
  const month = String(d.getMonth() + 1).padStart(2, '0')
  const day = String(d.getDate()).padStart(2, '0')
  const hours = String(d.getHours()).padStart(2, '0')
  const minutes = String(d.getMinutes()).padStart(2, '0')
  const seconds = String(d.getSeconds()).padStart(2, '0')
  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`
}

// 加载模态标识分页
const loadModalIdentifiersPage = async (page: number = 1) => {
  modalIdentifierLoading.value = true
  try {
    const response = await getModalIdentifiersPage(twoFactorId, {
      modalValue: modalIdentifierFilters.value.modalValue,
      identifierType: modalIdentifierFilters.value.identifierType,
      createTimeStart: formatDateTimeString(modalIdentifierFilters.value.createTimeStart),
      createTimeEnd: formatDateTimeString(modalIdentifierFilters.value.createTimeEnd),
      currentPage: page,
      pageSize: 10
    })
    console.log('模态标识API返回:', response)
    if (response && response.data) {
      // 检查是否是嵌套的 data 结构
      const pageData = response.data.data || response.data
      modalIdentifierPage.value = pageData
      console.log('模态标识分页数据:', modalIdentifierPage.value)
    }
  } catch (error) {
    console.error('加载模态标识失败:', error)
    ElMessage.error('加载模态标识失败')
  } finally {
    modalIdentifierLoading.value = false
  }
}

// 加载项目信息分页
const loadProjectsPage = async (page: number = 1) => {
  projectsLoading.value = true
  try {
    const response = await getProjectsPage(twoFactorId, {
      projectName: projectFilters.value.projectName,
      projectType: projectFilters.value.projectType,
      createTimeStart: formatDateTimeString(projectFilters.value.createTimeStart),
      createTimeEnd: formatDateTimeString(projectFilters.value.createTimeEnd),
      currentPage: page,
      pageSize: 10
    })
    console.log('项目API返回:', response)
    if (response && response.data) {
      // 检查是否是嵌套的 data 结构
      const pageData = response.data.data || response.data
      projectsPage.value = pageData
      console.log('项目分页数据:', projectsPage.value)
    }
  } catch (error) {
    console.error('加载项目信息失败:', error)
    ElMessage.error('加载项目信息失败')
  } finally {
    projectsLoading.value = false
  }
}

// 模态标识筛选
const filterModalIdentifiers = () => {
  loadModalIdentifiersPage(1)
}

// 项目信息筛选
const filterProjects = () => {
  loadProjectsPage(1)
}

// 加载项目类型
const loadProjectTypes = async () => {
  try {
    const response = await getProjectTypes()
    if (response && response.data) {
      projectTypeOptions.value = (response.data as string[]).map(type => ({
        label: type,
        value: type
      }))
    }
  } catch (error) {
    console.error('加载项目类型失败:', error)
  }
}

// 监听窗口大小变化
const handleResize = () => {
  if (chart) {
    chart.resize()
  }
  if (chart3) {
    chart3.resize()
  }
  if (chart4) {
    chart4.resize()
  }
}

// 组件挂载时获取数据
onMounted(() => {
  fetchDetailData()
  window.addEventListener('resize', handleResize)
})

// 组件卸载时清理资源
onUnmounted(() => {
  if (chart) {
    chart.dispose()
  }
  if (chart3) {
    chart3.dispose()
  }
  if (chart4) {
    chart4.dispose()
  }
  window.removeEventListener('resize', handleResize)
})
</script>

<style scoped>
.two-factor-detail {
  padding: 20px;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  min-height: 100vh;
}

.detail-card {
  margin-bottom: 16px;
  border-radius: 8px;
  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
  transition: box-shadow 0.3s ease, transform 0.3s ease;
}

.detail-card:hover {
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.12);
  transform: translateY(-2px);
}

.chart-card {
  padding: 0;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-title {
  font-size: 15px;
  font-weight: 600;
  color: #1f2937;
  letter-spacing: 0.5px;
}

.header-actions {
  display: flex;
  align-items: center;
}

.count {
  color: #6b7280;
  font-size: 13px;
  font-weight: 500;
}

.chart-container-small {
  width: 100%;
  height: 260px;
  padding: 8px;
}

.chart {
  width: 100%;
  height: 100%;
}

.charts-wrapper {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 16px;
  margin-bottom: 16px;
  background: linear-gradient(135deg, rgba(255, 255, 255, 0.9) 0%, rgba(248, 249, 250, 0.95) 100%);
  padding: 20px;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
}

.chart-card.compact-chart {
  padding: 12px;
  border-radius: 8px;
  border: 1px solid rgba(0, 0, 0, 0.05);
  background: #ffffff;
  box-shadow: 0 1px 4px rgba(0, 0, 0, 0.04);
  transition: all 0.3s ease;
}

.chart-card.compact-chart:hover {
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  transform: translateY(-2px);
  border-color: rgba(0, 0, 0, 0.1);
}

.card-title-small {
  font-size: 13px;
  font-weight: 600;
  color: #1f2937;
  letter-spacing: 0.3px;
}

/* 刣应式设计 */
@media (max-width: 1600px) {
  .charts-wrapper {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 1200px) {
  .charts-wrapper {
    grid-template-columns: 1fr;
  }
}

/* 优化表格样式 */
:deep(.el-table) {
  border-radius: 4px;
}

:deep(.el-descriptions) {
  background: #fafafa;
  border-radius: 4px;
}

:deep(.el-descriptions-item) {
  padding: 8px 12px;
}

:deep(.el-descriptions__label) {
  color: #6b7280;
  font-weight: 500;
}

:deep(.el-tag) {
  border-radius: 4px;
  padding: 4px 10px;
  font-size: 12px;
  font-weight: 500;
}
</style>