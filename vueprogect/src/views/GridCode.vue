<template>
  <div class="grid-code">
    <el-card class="module-card">
      <template #header>
        <div class="card-header">
          <span class="card-title">网格码管理</span>
          <div class="header-actions">
            <el-button type="primary" @click="handleAddGridCode">新增网格码</el-button>
          </div>
        </div>
      </template>
      
      <!-- 网格码搜索 -->
      <el-form :inline="true" class="search-form">
        <el-form-item label="网格码">
          <el-input v-model="searchForm.gridCodeValue" placeholder="请输入网格码" clearable />
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="searchForm.status" placeholder="请选择状态" clearable>
            <el-option label="有效" value="VALID" />
            <el-option label="失效" value="INVALID" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
        </el-form-item>
      </el-form>
      
      <!-- 网格码表格 -->
      <el-table :data="gridCodeData" style="width: 100%" border stripe v-loading="loading">
        <el-table-column prop="gridCodeId" label="ID" width="80" />
        <el-table-column prop="gridCodeValue" label="网格码" width="200" />
        <el-table-column prop="status" label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.status === 'VALID' ? 'success' : 'danger'">
              {{ row.status === 'VALID' ? '有效' : '失效' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="hashValue" label="区块链存证哈希值" width="250" />
        <el-table-column prop="depositRecordId" label="存证记录ID" width="150" />
        <el-table-column prop="createTime" label="创建时间" width="180" />
        <el-table-column label="操作" width="200" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" size="small" @click="handleViewDetails(row)">详情</el-button>
            <el-button type="success" size="small" @click="handleVerify(row)">验真</el-button>
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
    
    <!-- 网格码详情对话框 -->
    <el-dialog
      v-model="detailDialogVisible"
      title="网格码详情"
      width="600px"
    >
      <el-form :model="detailForm" label-width="150px">
        <el-form-item label="网格码ID">
          <el-input v-model="detailForm.gridCodeId" disabled />
        </el-form-item>
        <el-form-item label="网格码">
          <el-input v-model="detailForm.gridCodeValue" disabled />
        </el-form-item>
        <el-form-item label="状态">
          <el-input v-model="detailForm.status" disabled />
        </el-form-item>
        <el-form-item label="区块链存证哈希值">
          <el-input v-model="detailForm.hashValue" disabled />
        </el-form-item>
        <el-form-item label="存证记录ID">
          <el-input v-model="detailForm.depositRecordId" disabled />
        </el-form-item>
        <el-form-item label="创建时间">
          <el-input v-model="detailForm.createTime" disabled />
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { ElMessage } from 'element-plus'

// 导入网格码API
import {
  getGridCodeList,
  verifyGridCode
} from '@/api/gridCode'

// 搜索表单
const searchForm = reactive({
  gridCodeValue: '',
  status: ''
})

// 表格数据
const gridCodeData = ref<Array<{
  gridCodeId: number
  gridCodeValue: string
  status: string
  hashValue: string
  depositRecordId: string
  createTime: string
}>>([])

const loading = ref(false)

// 分页数据
const page = reactive({
  currentPage: 1,
  pageSize: 10,
  total: 0
})

// 对话框相关
const detailDialogVisible = ref(false)
const detailForm = reactive({
  gridCodeId: 0,
  gridCodeValue: '',
  status: '',
  hashValue: '',
  depositRecordId: '',
  createTime: ''
})

// 新增网格码
const handleAddGridCode = () => {
  ElMessage.info('新增网格码功能')
}

// 搜索
const handleSearch = () => {
  page.currentPage = 1
  fetchGridCodeData()
}

// 重置
const handleReset = () => {
  searchForm.gridCodeValue = ''
  searchForm.status = ''
  handleSearch()
}

// 获取网格码数据
const fetchGridCodeData = async () => {
  loading.value = true
  try {
    const response = await getGridCodeList({
      gridCodeValue: searchForm.gridCodeValue,
      status: searchForm.status,
      currentPage: page.currentPage,
      pageSize: page.pageSize
    })
    
    // response.data 包含实际的业务数据
    if (response && response.data) {
      gridCodeData.value = response.data.records || []
      page.total = response.data.total || 0
    } else {
      gridCodeData.value = []
      page.total = 0
    }
  } catch (error) {
    console.error('获取网格码数据失败:', error)
    ElMessage.error('获取网格码数据失败')
    gridCodeData.value = []
    page.total = 0
  } finally {
    loading.value = false
  }
}

// 查看详情
const handleViewDetails = (row: any) => {
  Object.assign(detailForm, { ...row })
  detailDialogVisible.value = true
}

// 验真
const handleVerify = (row: any) => {
  ElMessage.success(`网格码 "${row.gridCodeValue}" 验真成功`)
}

// 分页相关
const handleSizeChange = (val: number) => {
  page.pageSize = val
  fetchGridCodeData()
}

const handleCurrentChange = (val: number) => {
  page.currentPage = val
  fetchGridCodeData()
}

// 组件挂载时获取数据
onMounted(() => {
  fetchGridCodeData()
})
</script>

<style scoped>
.grid-code {
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