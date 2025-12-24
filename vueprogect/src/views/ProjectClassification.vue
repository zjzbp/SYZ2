<template>
  <div class="project-classification">
    <el-card class="module-card">
      <template #header>
        <div class="card-header">
          <span class="card-title">项目分类管理</span>
          <div class="header-actions">
            <el-button type="primary" @click="handleAddProject">新增项目</el-button>
          </div>
        </div>
      </template>
      
      <!-- 项目搜索 -->
      <el-form :inline="true" class="search-form">
        <el-form-item label="项目名称">
          <el-input v-model="searchForm.projectName" placeholder="请输入项目名称" clearable />
        </el-form-item>
        <el-form-item label="项目类型">
          <el-select v-model="searchForm.projectType" placeholder="请选择项目类型" clearable>
            <el-option label="口述历史" value="口述历史" />
            <el-option label="非遗记录" value="非遗记录" />
            <el-option label="文档存档" value="文档存档" />
          </el-select>
        </el-form-item>
        <el-form-item label="关联模态标识ID">
          <el-input v-model="searchForm.modalId" placeholder="请输入关联模态标识ID" clearable />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="handleReset">重置</el-button>
        </el-form-item>
      </el-form>
      
      <!-- 项目表格 -->
      <el-table :data="projectData" style="width: 100%" border stripe v-loading="loading">
        <el-table-column prop="projectId" label="ID" width="80" />
        <el-table-column prop="projectName" label="项目名称" width="200" />
        <el-table-column prop="projectType" label="项目类型" width="120">
          <template #default="{ row }">
            <el-tag :type="getProjectTypeTag(row.projectType)">
              {{ row.projectType }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="modalId" label="关联模态标识ID" width="120" />
        <el-table-column prop="cloudStorageUrl" label="云仓库存储URL" width="250" />
        <el-table-column prop="projectDesc" label="项目描述" />
        <el-table-column prop="uploadTime" label="上传时间" width="180" />
        <el-table-column prop="projectStatus" label="项目状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.projectStatus === 'ACTIVE' ? 'success' : 'info'">
              {{ row.projectStatus === 'ACTIVE' ? '激活' : '未激活' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="200" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" size="small" @click="handleViewDetails(row)">详情</el-button>
            <el-button type="success" size="small" @click="handlePreview(row)">预览</el-button>
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
    
    <!-- 项目详情对话框 -->
    <el-dialog
      v-model="detailDialogVisible"
      title="项目详情"
      width="700px"
    >
      <el-form :model="detailForm" label-width="150px">
        <el-form-item label="项目ID">
          <el-input v-model="detailForm.projectId" disabled />
        </el-form-item>
        <el-form-item label="项目名称">
          <el-input v-model="detailForm.projectName" disabled />
        </el-form-item>
        <el-form-item label="项目类型">
          <el-input v-model="detailForm.projectType" disabled />
        </el-form-item>
        <el-form-item label="关联模态标识ID">
          <el-input v-model="detailForm.modalId" disabled />
        </el-form-item>
        <el-form-item label="云仓库存储URL">
          <el-input v-model="detailForm.cloudStorageUrl" disabled />
        </el-form-item>
        <el-form-item label="项目描述">
          <el-input v-model="detailForm.projectDesc" disabled type="textarea" :rows="3" />
        </el-form-item>
        <el-form-item label="上传时间">
          <el-input v-model="detailForm.uploadTime" disabled />
        </el-form-item>
        <el-form-item label="项目状态">
          <el-input v-model="detailForm.projectStatus" disabled />
        </el-form-item>
      </el-form>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { ElMessage } from 'element-plus'

// 导入项目分类API
import {
  getProjectClassificationList
} from '@/api/projectClassification'

// 搜索表单
const searchForm = reactive({
  projectName: '',
  projectType: '',
  modalId: ''
})

// 表格数据
const projectData = ref<Array<{
  projectId: number
  modalId: number
  projectName: string
  projectType: string
  cloudStorageUrl: string
  projectDesc: string
  uploadTime: string
  projectStatus: string
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
  projectId: 0,
  modalId: 0,
  projectName: '',
  projectType: '',
  cloudStorageUrl: '',
  projectDesc: '',
  uploadTime: '',
  projectStatus: ''
})

// 获取项目类型标签
const getProjectTypeTag = (type: string) => {
  const typeMap: Record<string, string> = {
    '口述历史': 'success',
    '非遗记录': 'primary',
    '文档存档': 'warning'
  }
  return typeMap[type] || 'info'
}

// 新增项目
const handleAddProject = () => {
  ElMessage.info('新增项目功能')
}

// 搜索
const handleSearch = () => {
  page.currentPage = 1
  fetchProjectData()
}

// 重置
const handleReset = () => {
  searchForm.projectName = ''
  searchForm.projectType = ''
  searchForm.modalId = ''
  handleSearch()
}

// 获取项目数据
const fetchProjectData = async () => {
  loading.value = true
  try {
    const response = await getProjectClassificationList({
      projectName: searchForm.projectName,
      projectType: searchForm.projectType,
      modalId: searchForm.modalId,
      currentPage: page.currentPage,
      pageSize: page.pageSize
    })
    
    // response.data 包含实际的业务数据
    if (response && response.data) {
      projectData.value = response.data.records || []
      page.total = response.data.total || 0
    } else {
      projectData.value = []
      page.total = 0
    }
  } catch (error) {
    console.error('获取项目数据失败:', error)
    ElMessage.error('获取项目数据失败')
    projectData.value = []
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

// 预览
const handlePreview = (row: any) => {
  ElMessage.success(`预览项目 "${row.projectName}"`)
}

// 分页相关
const handleSizeChange = (val: number) => {
  page.pageSize = val
  fetchProjectData()
}

const handleCurrentChange = (val: number) => {
  page.currentPage = val
  fetchProjectData()
}

// 组件挂载时获取数据
onMounted(() => {
  fetchProjectData()
})
</script>

<style scoped>
.project-classification {
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