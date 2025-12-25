<template>
  <div class="user-detail-page">
    <el-card class="header-card">
      <div class="page-header">
        <el-button type="primary" plain @click="goBack">
          <el-icon><ArrowLeft /></el-icon>
          返回用户列表
        </el-button>
        <h2 class="page-title">用户详情</h2>
      </div>
    </el-card>

    <div v-loading="loading" class="content-area">
      <template v-if="userDetail">
        <!-- 基本信息 -->
        <el-row :gutter="20">
          <el-col :span="12">
            <el-card class="info-card">
              <template #header>
                <span class="card-title">用户基本信息</span>
              </template>
              <el-descriptions :column="1" border>
                <el-descriptions-item label="用户ID">{{ userDetail.user?.userId }}</el-descriptions-item>
                <el-descriptions-item label="用户类型">
                  <el-tag :type="userDetail.user?.userType === 'PERSONAL' ? 'primary' : 'success'">
                    {{ userDetail.user?.userType === 'PERSONAL' ? '个人用户' : '企业用户' }}
                  </el-tag>
                </el-descriptions-item>
                <el-descriptions-item label="手机号">{{ userDetail.user?.phone }}</el-descriptions-item>
                <el-descriptions-item label="网格编码">{{ userDetail.user?.gridCode || '-' }}</el-descriptions-item>
                <el-descriptions-item label="双因子码">{{ userDetail.user?.twoFactorCode || '-' }}</el-descriptions-item>
                <el-descriptions-item label="状态">
                  <el-tag :type="userDetail.user?.status === 'ACTIVE' ? 'success' : 'danger'">
                    {{ userDetail.user?.status === 'ACTIVE' ? '正常' : '禁用' }}
                  </el-tag>
                </el-descriptions-item>
                <el-descriptions-item label="创建时间">{{ userDetail.user?.createTime }}</el-descriptions-item>
              </el-descriptions>
            </el-card>
          </el-col>
          
          <el-col :span="12">
            <el-card class="info-card">
              <template #header>
                <span class="card-title">{{ userDetail.user?.userType === 'PERSONAL' ? '个人详情' : '企业详情' }}</span>
              </template>
              <!-- 个人详情 -->
              <template v-if="userDetail.user?.userType === 'PERSONAL' && userDetail.personalDetail">
                <el-descriptions :column="1" border>
                  <el-descriptions-item label="姓名">{{ userDetail.personalDetail.realName || '-' }}</el-descriptions-item>
                  <el-descriptions-item label="身份证号">{{ userDetail.personalDetail.idCard || '-' }}</el-descriptions-item>
                  <el-descriptions-item label="性别">{{ userDetail.personalDetail.gender || '-' }}</el-descriptions-item>
                  <el-descriptions-item label="出生日期">{{ userDetail.personalDetail.birthDate || '-' }}</el-descriptions-item>
                  <el-descriptions-item label="邮箱">{{ userDetail.personalDetail.email || '-' }}</el-descriptions-item>
                  <el-descriptions-item label="职业">{{ userDetail.personalDetail.occupation || '-' }}</el-descriptions-item>
                  <el-descriptions-item label="地址">{{ userDetail.personalDetail.address || '-' }}</el-descriptions-item>
                </el-descriptions>
              </template>
              <!-- 企业详情 -->
              <template v-else-if="userDetail.user?.userType === 'ENTERPRISE' && userDetail.enterpriseDetail">
                <el-descriptions :column="1" border>
                  <el-descriptions-item label="企业名称">{{ userDetail.enterpriseDetail.enterpriseName || '-' }}</el-descriptions-item>
                  <el-descriptions-item label="统一社会信用代码">{{ userDetail.enterpriseDetail.unifiedSocialCreditCode || '-' }}</el-descriptions-item>
                  <el-descriptions-item label="法人姓名">{{ userDetail.enterpriseDetail.legalPersonName || '-' }}</el-descriptions-item>
                  <el-descriptions-item label="联系电话">{{ userDetail.enterpriseDetail.contactPhone || '-' }}</el-descriptions-item>
                  <el-descriptions-item label="企业地址">{{ userDetail.enterpriseDetail.enterpriseAddress || '-' }}</el-descriptions-item>
                  <el-descriptions-item label="注册资本">{{ userDetail.enterpriseDetail.registeredCapital ? `${userDetail.enterpriseDetail.registeredCapital} 万元` : '-' }}</el-descriptions-item>
                </el-descriptions>
              </template>
              <el-empty v-else description="暂无详情信息" />
            </el-card>
          </el-col>
        </el-row>

        <!-- 双因子码和模态标识统计 -->
        <el-row :gutter="20" class="mt-20">
          <el-col :span="8">
            <el-card class="stat-card">
              <template #header>
                <span class="card-title">双因子码信息</span>
              </template>
              <template v-if="userDetail.twoFactorCode">
                <el-descriptions :column="1" border>
                  <el-descriptions-item label="双因子码">{{ userDetail.twoFactorCode.twoFactorValue }}</el-descriptions-item>
                  <el-descriptions-item label="关联网格码">{{ userDetail.twoFactorCode.gridCodeValue || '-' }}</el-descriptions-item>
                  <el-descriptions-item label="剩余模态数">{{ userDetail.twoFactorCode.remainingModals }}</el-descriptions-item>
                  <el-descriptions-item label="状态">
                    <el-tag :type="userDetail.twoFactorCode.status === 'ACTIVATED' ? 'success' : 'warning'">
                      {{ getTwoFactorStatus(userDetail.twoFactorCode.status) }}
                    </el-tag>
                  </el-descriptions-item>
                </el-descriptions>
              </template>
              <el-empty v-else description="暂无双因子码信息" />
            </el-card>
          </el-col>
          
          <el-col :span="8">
            <el-card class="stat-card">
              <template #header>
                <span class="card-title">模态标识统计</span>
              </template>
              <div class="stat-number">
                <span class="number">{{ userDetail.modalIdentifierCount || 0 }}</span>
                <span class="label">个模态标识</span>
              </div>
            </el-card>
          </el-col>
          
          <el-col :span="8">
            <el-card class="stat-card score-card">
              <template #header>
                <span class="card-title">总分统计</span>
              </template>
              <div class="stat-number">
                <span class="number score">{{ userDetail.totalScore || 0 }}</span>
                <span class="label">分</span>
              </div>
            </el-card>
          </el-col>
        </el-row>

        <!-- 项目类别饼状图和分数统计 -->
        <el-row :gutter="20" class="mt-20">
          <el-col :span="12">
            <el-card class="chart-card">
              <template #header>
                <span class="card-title">项目类别分布（饼状图）</span>
              </template>
              <div ref="pieChartRef" class="chart-container"></div>
              <el-empty v-if="!userDetail.projectTypeStats?.length" description="暂无项目数据" />
            </el-card>
          </el-col>
          
          <el-col :span="12">
            <el-card class="chart-card">
              <template #header>
                <span class="card-title">项目类别分数统计</span>
              </template>
              <el-table :data="userDetail.projectTypeStats" v-if="userDetail.projectTypeStats?.length">
                <el-table-column prop="projectTypeName" label="项目类别" />
                <el-table-column prop="count" label="项目数量" width="100" align="center">
                  <template #default="{ row }">
                    <el-tag type="info">{{ row.count }}</el-tag>
                  </template>
                </el-table-column>
                <el-table-column prop="percentage" label="占比" width="100" align="center">
                  <template #default="{ row }">
                    {{ row.percentage }}%
                  </template>
                </el-table-column>
                <el-table-column prop="score" label="分数" width="100" align="center">
                  <template #default="{ row }">
                    <el-tag type="success">{{ row.score }}</el-tag>
                  </template>
                </el-table-column>
              </el-table>
              <div class="total-score-row" v-if="userDetail.projectTypeStats?.length">
                <span class="label">总分：</span>
                <span class="value">{{ userDetail.totalScore }} 分</span>
              </div>
              <el-empty v-else description="暂无项目数据" />
            </el-card>
          </el-col>
        </el-row>

        <!-- 模态标识列表 -->
        <el-card class="mt-20">
          <template #header>
            <span class="card-title">模态标识列表</span>
          </template>
          <el-table :data="userDetail.modalIdentifiers" v-if="userDetail.modalIdentifiers?.length" max-height="300">
            <el-table-column prop="modalId" label="ID" width="80" />
            <el-table-column prop="modalValue" label="模态标识值" />
            <el-table-column prop="identifierType" label="类型" width="120" />
            <el-table-column prop="status" label="状态" width="100">
              <template #default="{ row }">
                <el-tag :type="row.status === 'VALID' ? 'success' : 'danger'">
                  {{ row.status === 'VALID' ? '有效' : '失效' }}
                </el-tag>
              </template>
            </el-table-column>
            <el-table-column prop="createTime" label="创建时间" width="180" />
          </el-table>
          <el-empty v-else description="暂无模态标识" />
        </el-card>

        <!-- 项目列表 -->
        <el-card class="mt-20">
          <template #header>
            <span class="card-title">项目列表</span>
          </template>
          <el-table :data="userDetail.projectInfos" v-if="userDetail.projectInfos?.length" max-height="300">
            <el-table-column prop="projectId" label="ID" width="80" />
            <el-table-column prop="projectName" label="项目名称" />
            <el-table-column prop="projectType" label="项目类别" width="120" />
            <el-table-column prop="projectStatus" label="状态" width="100">
              <template #default="{ row }">
                <el-tag :type="row.projectStatus === 'ONLINE' ? 'success' : 'info'">
                  {{ row.projectStatus === 'ONLINE' ? '上线' : '下架' }}
                </el-tag>
              </template>
            </el-table-column>
            <el-table-column prop="createTime" label="创建时间" width="180" />
          </el-table>
          <el-empty v-else description="暂无项目" />
        </el-card>
      </template>
      
      <el-empty v-else-if="!loading" description="用户不存在" />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, watch, nextTick } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { ArrowLeft } from '@element-plus/icons-vue'
import { getUserFullDetail, type UserFullDetail } from '@/api/user'
import * as echarts from 'echarts'

const route = useRoute()
const router = useRouter()

const loading = ref(false)
const userDetail = ref<UserFullDetail | null>(null)
const pieChartRef = ref<HTMLDivElement | null>(null)
let pieChart: echarts.ECharts | null = null

// 获取用户ID
const getUserId = (): number => {
  const id = route.params.id
  if (Array.isArray(id)) {
    return parseInt(id[0] || '0')
  }
  return id ? parseInt(id) : 0
}

// 获取双因子码状态文本
const getTwoFactorStatus = (status?: string) => {
  switch (status) {
    case 'ACTIVATED': return '已激活'
    case 'FROZEN': return '冻结'
    case 'INVALID': return '失效'
    default: return '未知'
  }
}

// 获取用户详情
const fetchUserDetail = async () => {
  const userId = getUserId()
  if (!userId) {
    ElMessage.error('用户ID无效')
    return
  }
  
  loading.value = true
  try {
    const response = await getUserFullDetail(userId)
    if (response.code === 200 && response.data) {
      userDetail.value = response.data
      // 等待DOM更新后渲染图表
      nextTick(() => {
        renderPieChart()
      })
    } else {
      ElMessage.error(response.message || '获取用户详情失败')
    }
  } catch (error) {
    console.error('获取用户详情失败:', error)
    ElMessage.error('获取用户详情失败')
  } finally {
    loading.value = false
  }
}

// 渲染饼状图
const renderPieChart = () => {
  if (!pieChartRef.value || !userDetail.value?.projectTypeStats?.length) return
  
  // 如果图表已存在，先销毁
  if (pieChart) {
    pieChart.dispose()
  }
  
  pieChart = echarts.init(pieChartRef.value)
  
  const data = userDetail.value.projectTypeStats.map(item => ({
    name: item.projectTypeName,
    value: item.count
  }))
  
  const option: echarts.EChartsOption = {
    tooltip: {
      trigger: 'item',
      formatter: '{a} <br/>{b}: {c} ({d}%)'
    },
    legend: {
      orient: 'vertical',
      left: 'left',
      top: 'center'
    },
    series: [
      {
        name: '项目类别',
        type: 'pie',
        radius: ['40%', '70%'],
        center: ['60%', '50%'],
        avoidLabelOverlap: false,
        itemStyle: {
          borderRadius: 10,
          borderColor: '#fff',
          borderWidth: 2
        },
        label: {
          show: true,
          formatter: '{b}: {c}'
        },
        emphasis: {
          label: {
            show: true,
            fontSize: 16,
            fontWeight: 'bold'
          }
        },
        data: data
      }
    ],
    color: ['#5470c6', '#91cc75', '#fac858', '#ee6666', '#73c0de', '#3ba272']
  }
  
  pieChart.setOption(option)
}

// 返回用户列表
const goBack = () => {
  router.push('/user-management')
}

// 监听窗口大小变化，重新渲染图表
const handleResize = () => {
  if (pieChart) {
    pieChart.resize()
  }
}

onMounted(() => {
  fetchUserDetail()
  window.addEventListener('resize', handleResize)
})

// 组件销毁时清理
import { onUnmounted } from 'vue'
onUnmounted(() => {
  window.removeEventListener('resize', handleResize)
  if (pieChart) {
    pieChart.dispose()
  }
})
</script>

<style scoped>
.user-detail-page {
  padding: 20px;
}

.header-card {
  margin-bottom: 20px;
}

.page-header {
  display: flex;
  align-items: center;
  gap: 20px;
}

.page-title {
  margin: 0;
  font-size: 20px;
  font-weight: bold;
}

.content-area {
  min-height: 400px;
}

.info-card, .stat-card, .chart-card {
  height: 100%;
}

.card-title {
  font-size: 16px;
  font-weight: bold;
}

.mt-20 {
  margin-top: 20px;
}

.stat-number {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 120px;
}

.stat-number .number {
  font-size: 48px;
  font-weight: bold;
  color: #409eff;
}

.stat-number .number.score {
  color: #67c23a;
}

.stat-number .label {
  font-size: 14px;
  color: #909399;
  margin-top: 10px;
}

.chart-container {
  height: 300px;
  width: 100%;
}

.total-score-row {
  display: flex;
  justify-content: flex-end;
  align-items: center;
  padding: 16px 20px;
  border-top: 1px solid #ebeef5;
  margin-top: 16px;
}

.total-score-row .label {
  font-size: 16px;
  color: #606266;
}

.total-score-row .value {
  font-size: 24px;
  font-weight: bold;
  color: #67c23a;
  margin-left: 10px;
}

.score-card {
  background: linear-gradient(135deg, #f6ffed 0%, #fff 100%);
}
</style>
