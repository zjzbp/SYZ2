<template>
  <div class="two-factor-code">
    <el-card class="module-card">
      <template #header>
        <div class="card-header">
          <span class="card-title">双因子码管理</span>
        </div>
      </template>
      
      <!-- 双因子码搜索 -->
      <el-form :inline="true" class="search-form">
        <el-form-item label="双因子码">
          <el-input v-model="searchForm.twoFactorValue" placeholder="请输入双因子码" clearable />
        </el-form-item>
        <el-form-item label="关联网格码">
          <el-input v-model="searchForm.gridCodeValue" placeholder="请输入关联网格码" clearable />
        </el-form-item>
        <el-form-item label="码类型">
          <el-select v-model="searchForm.codeType" placeholder="请选择码类型" clearable style="width: 150px">
            <el-option label="资产类" value="ASSET" />
            <el-option label="个人类" value="PERSONAL" />
          </el-select>
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="searchForm.status" placeholder="请选择状态" clearable style="width: 150px">
            <el-option label="已激活" value="ACTIVATED" />
            <el-option label="冻结" value="FROZEN" />
            <el-option label="失效" value="INVALID" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
        </el-form-item>
      </el-form>
      
      <!-- 双因子码表格 -->
      <el-table :data="twoFactorData" style="width: 100%" border stripe v-loading="loading">
        <el-table-column prop="twoFactorId" label="ID" width="80" />
        <el-table-column prop="twoFactorValue" label="双因子码" width="200" />
        <el-table-column prop="gridCodeValue" label="关联网格码" width="200" />
        <el-table-column prop="codeType" label="码类型" width="100">
          <template #default="{ row }">
            <el-tag :type="row.codeType === 'ASSET' ? 'primary' : 'success'">
              {{ row.codeType === 'ASSET' ? '资产类' : '个人类' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="getStatusTag(row.status)">
              {{ getStatusName(row.status) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" width="180">
          <template #default="{ row }">
            {{ row.createTime ? new Date(row.createTime).toLocaleString('zh-CN') : '-' }}
          </template>
        </el-table-column>
        <el-table-column prop="remainingModals" label="剩余模态标识数量" width="150" />
        <el-table-column label="操作" width="120" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" size="small" @click="handleViewDetails(row)">详情</el-button>
          </template>
        </el-table-column>
      </el-table>
      
      <!-- 分页 -->
      <div class="pagination">
        <el-pagination
          v-model:current-page="page.currentPage"
          v-model:page-size="page.pageSize"
          :page-sizes="[10, 20, 50, 100]"
          :total="page.total"
          layout="total, sizes, prev, pager, next, jumper"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </el-card>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'

// 导入双因子码API
import {
  getTwoFactorCodeList
} from '@/api/twoFactorCode'

const router = useRouter()

// 搜索表单
const searchForm = reactive({
  twoFactorValue: '',
  gridCodeValue: '',
  codeType: '',
  status: ''
})

// 表格数据
const twoFactorData = ref<Array<{
  twoFactorId: number
  twoFactorValue: string
  gridCodeValue: string
  codeType: string
  status: string
  createTime: string
  remainingModals: number
}>>([])

const loading = ref(false)

// 分页数据
const page = reactive({
  currentPage: 1,
  pageSize: 10,
  total: 0
})

// 对话框相关已被移除，详情功能现在跳转到新页面

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

// 新增双因子码
const handleAddTwoFactorCode = () => {
  ElMessage.info('新增双因子码功能')
}

// 搜索
const handleSearch = () => {
  page.currentPage = 1
  fetchTwoFactorData()
}

// 重置
const handleReset = () => {
  searchForm.twoFactorValue = ''
  searchForm.gridCodeValue = ''
  searchForm.codeType = ''
  searchForm.status = ''
  handleSearch()
}

// 获取双因子码数据
const fetchTwoFactorData = async () => {
  loading.value = true
  try {
    const response = await getTwoFactorCodeList({
      twoFactorValue: searchForm.twoFactorValue,
      gridCodeValue: searchForm.gridCodeValue,
      codeType: searchForm.codeType,
      status: searchForm.status,
      currentPage: page.currentPage,
      pageSize: page.pageSize
    })
    
    // response.data 包含实际的业务数据
    console.log('双因子码API返回:', response)
    if (response && response.data) {
      // 检查是否是嵌套的 data 结构
      const pageData = response.data.data || response.data
      twoFactorData.value = pageData.records || []
      page.total = pageData.total || 0
      console.log('分页数据:', { records: twoFactorData.value.length, total: page.total })
    } else {
      twoFactorData.value = []
      page.total = 0
    }
  } catch (error) {
    console.error('获取双因子码数据失败:', error)
    ElMessage.error('获取双因子码数据失败')
    twoFactorData.value = []
    page.total = 0
  } finally {
    loading.value = false
  }
}

// 查看详情
const handleViewDetails = (row: any) => {
  // 跳转到详情页面
  router.push(`/two-factor-code/${row.twoFactorId}`)
}

// 绑定资源
// 该功能已从表格操作中移除，保留函数以备后续使用
const handleBindResource = (row: any) => {
  ElMessage.success(`绑定资源到双因子码 "${row.twoFactorValue}"`)
}

// 分页相关
const handleSizeChange = (val: number) => {
  page.pageSize = val
  fetchTwoFactorData()
}

const handleCurrentChange = (val: number) => {
  page.currentPage = val
  fetchTwoFactorData()
}

// 组件挂载时获取数据
onMounted(() => {
  fetchTwoFactorData()
})
</script>

<style scoped>
.two-factor-code {
  width: 100%;
}

.module-card {
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

.search-form {
  margin-bottom: 20px;
}

.pagination {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
}
</style>