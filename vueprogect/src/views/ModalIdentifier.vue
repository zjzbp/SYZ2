<template>
  <div class="modal-identifier">
    <el-card class="module-card">
      <template #header>
        <div class="card-header">
          <span class="card-title">模态标识管理</span>
          <div class="header-actions">
            <el-button type="primary" @click="handleAddModalIdentifier">新增模态标识</el-button>
          </div>
        </div>
      </template>
      
      <!-- 模态标识搜索 -->
      <el-form :inline="true" class="search-form">
        <el-form-item label="模态标识">
          <el-input v-model="searchForm.modalValue" placeholder="请输入模态标识" clearable />
        </el-form-item>
        <el-form-item label="关联双因子码">
          <el-input v-model="searchForm.twoFactorValue" placeholder="请输入关联双因子码" clearable />
        </el-form-item>
        <el-form-item label="标识类型">
          <el-select v-model="searchForm.identifierType" placeholder="请选择标识类型" clearable>
            <el-option label="项目类" value="PROJECT" />
          </el-select>
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
      
      <!-- 模态标识表格 -->
      <el-table :data="modalData" style="width: 100%" border stripe v-loading="loading">
        <el-table-column prop="modalId" label="ID" width="80" />
        <el-table-column prop="modalValue" label="模态标识" width="200" />
        <el-table-column prop="twoFactorValue" label="关联双因子码" width="200" />
        <el-table-column prop="identifierType" label="标识类型" width="120">
          <template #default="{ row }">
            <el-tag type="primary">
              {{ row.identifierType === 'PROJECT' ? '项目类' : '未知' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.status === 'VALID' ? 'success' : 'danger'">
              {{ row.status === 'VALID' ? '有效' : '失效' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="hashValue" label="区块链存证哈希值" width="250" />
        <el-table-column prop="createTime" label="创建时间" width="180" />
        <el-table-column label="操作" width="200" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" size="small" @click="handleViewDetails(row)">详情</el-button>
            <el-button type="success" size="small" @click="handleBindProject(row)">绑定项目</el-button>
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
    
    <!-- 模态标识详情对话框 -->
    <el-dialog
      v-model="detailDialogVisible"
      title="模态标识详情"
      width="600px"
    >
      <el-form :model="detailForm" label-width="180px">
        <el-form-item label="模态标识ID">
          <el-input v-model="detailForm.modalId" disabled />
        </el-form-item>
        <el-form-item label="模态标识">
          <el-input v-model="detailForm.modalValue" disabled />
        </el-form-item>
        <el-form-item label="关联双因子码">
          <el-input v-model="detailForm.twoFactorValue" disabled />
        </el-form-item>
        <el-form-item label="标识类型">
          <el-input v-model="detailForm.identifierType" disabled />
        </el-form-item>
        <el-form-item label="状态">
          <el-input v-model="detailForm.status" disabled />
        </el-form-item>
        <el-form-item label="区块链存证哈希值">
          <el-input v-model="detailForm.hashValue" disabled />
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

// 导入模态标识API
import {
  getModalIdentifierList
} from '@/api/modalIdentifier'

// 搜索表单
const searchForm = reactive({
  modalValue: '',
  twoFactorValue: '',
  identifierType: '',
  status: ''
})

// 表格数据
const modalData = ref<Array<{
  modalId: number
  modalValue: string
  twoFactorValue: string
  identifierType: string
  status: string
  hashValue: string
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
  modalId: 0,
  modalValue: '',
  twoFactorValue: '',
  identifierType: '',
  status: '',
  hashValue: '',
  createTime: ''
})

// 新增模态标识
const handleAddModalIdentifier = () => {
  ElMessage.info('新增模态标识功能')
}

// 搜索
const handleSearch = () => {
  page.currentPage = 1
  fetchModalData()
}

// 重置
const handleReset = () => {
  searchForm.modalValue = ''
  searchForm.twoFactorValue = ''
  searchForm.identifierType = ''
  searchForm.status = ''
  handleSearch()
}

// 获取模态标识数据
const fetchModalData = async () => {
  loading.value = true
  try {
    const response = await getModalIdentifierList({
      modalValue: searchForm.modalValue,
      twoFactorValue: searchForm.twoFactorValue,
      identifierType: searchForm.identifierType,
      status: searchForm.status,
      currentPage: page.currentPage,
      pageSize: page.pageSize
    })
    
    // response.data 包含实际的业务数据
    if (response && response.data) {
      modalData.value = response.data.records || []
      page.total = response.data.total || 0
    } else {
      modalData.value = []
      page.total = 0
    }
  } catch (error) {
    console.error('获取模态标识数据失败:', error)
    ElMessage.error('获取模态标识数据失败')
    modalData.value = []
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

// 绑定项目
const handleBindProject = (row: any) => {
  ElMessage.success(`绑定项目到模态标识 "${row.modalValue}"`)
}

// 分页相关
const handleSizeChange = (val: number) => {
  page.pageSize = val
  fetchModalData()
}

const handleCurrentChange = (val: number) => {
  page.currentPage = val
  fetchModalData()
}

// 组件挂载时获取数据
onMounted(() => {
  fetchModalData()
})
</script>

<style scoped>
.modal-identifier {
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