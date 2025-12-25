<template>
  <div class="project-classification">
    <el-card class="module-card">
      <template #header>
        <div class="card-header">
          <span class="card-title">项目分类管理</span>
          <div class="header-actions">
            <el-button type="primary" @click="handleAddProject">新增项目类别</el-button>
          </div>
        </div>
      </template>

      <!-- 项目搜索 -->
      <el-form :inline="true" class="search-form">
        <el-form-item label="项目名称">
          <el-input v-model="searchForm.projectName" placeholder="请输入项目名称" clearable />
        </el-form-item>
        <el-form-item label="项目类型">
          <div style="display: flex; gap: 10px; align-items: center">
            <el-select
              v-model="searchForm.projectType"
              placeholder="请选择项目类型"
              clearable
              style="width: 150px"
            >
              <el-option
                v-for="type in projectTypeOptions"
                :key="type"
                :label="type"
                :value="type"
              />
            </el-select>
            <el-button
              type="danger"
              size="small"
              :disabled="!searchForm.projectType"
              @click="handleDeleteProjectType"
            >
              删除项目类别
            </el-button>
          </div>
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
            <el-tag :type="row.projectStatus === 'ONLINE' ? 'success' : 'info'">
              {{ row.projectStatus === 'ONLINE' ? '激活' : '未激活' }}
            </el-tag>
          </template>
        </el-table-column>
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

    <!-- 新增项目类别对话框 -->
    <el-dialog v-model="addDialogVisible" title="新增项目类别" width="500px">
      <el-form :model="addForm" :rules="addFormRules" ref="addFormRef" label-width="100px">
        <el-form-item label="项目类型" prop="projectType">
          <el-input v-model="addForm.projectType" placeholder="请输入项目类型" clearable />
        </el-form-item>
        <el-form-item label="类别分数" prop="score">
          <el-input-number v-model="addForm.score" :min="0" :max="100" :precision="1" placeholder="请输入分数" style="width: 100%" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="addDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleConfirmAdd" :loading="submitLoading"
          >确定</el-button
        >
      </template>
    </el-dialog>

    <!-- 项目详情对话框 -->
    <el-dialog v-model="detailDialogVisible" title="项目详情" width="700px">
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
import { ElMessage, ElMessageBox } from 'element-plus'
import type { FormInstance, FormRules } from 'element-plus'

// 导入项目分类API
import {
  getProjectClassificationList,
  getProjectTypes,
  createProject,
  deleteProjectType,
} from '@/api/projectClassification'

// 搜索表单
const searchForm = reactive({
  projectName: '',
  projectType: '',
  modalId: '',
})

// 表格数据
const projectData = ref<
  Array<{
    projectId: number
    modalId: number
    projectName: string
    projectType: string
    cloudStorageUrl: string
    projectDesc: string
    uploadTime: string
    projectStatus: string
  }>
>([])

const loading = ref(false)

// 分页数据
const page = reactive({
  currentPage: 1,
  pageSize: 10,
  total: 0,
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
  projectStatus: '',
})

// 新增项目类别对话框
const addDialogVisible = ref(false)
const addFormRef = ref<FormInstance>()
const submitLoading = ref(false)
const addForm = reactive({
  projectType: '',
  score: 5,
})

const addFormRules = reactive<FormRules>({
  projectType: [{ required: true, message: '请输入项目类型', trigger: 'blur' }],
  score: [{ required: true, message: '请输入类别分数', trigger: 'blur' }],
})

// 项目类型选项
const projectTypeOptions = ref<string[]>([])

// 获取项目类型标签
const getProjectTypeTag = (type: string) => {
  const typeMap: Record<string, string> = {
    口述历史: 'success',
    非遗记录: 'primary',
    文档存档: 'warning',
  }
  return typeMap[type] || 'info'
}

// 新增项目类别
const handleAddProject = async () => {
  // 打开对话框
  addDialogVisible.value = true
  // 重置表单
  if (addFormRef.value) {
    addFormRef.value.resetFields()
  }
  addForm.projectType = ''
  addForm.score = 5
}

// 确认新增
const handleConfirmAdd = async () => {
  if (!addFormRef.value) return

  await addFormRef.value.validate(async (valid) => {
    if (valid) {
      submitLoading.value = true
      try {
        await createProject({
          projectType: addForm.projectType,
          score: addForm.score,
        })
        ElMessage.success('项目类别创建成功')
        addDialogVisible.value = false
        // 刷新列表和项目类型选项
        fetchProjectData()
        loadProjectTypes()
      } catch (error) {
        console.error('创建项目类别失败:', error)
        ElMessage.error('创建项目类别失败')
      } finally {
        submitLoading.value = false
      }
    }
  })
}

// 加载项目类型选项
const loadProjectTypes = async () => {
  try {
    const response = await getProjectTypes()
    if (response && response.data) {
      projectTypeOptions.value = response.data
    }
  } catch (error) {
    console.error('获取项目类型失败:', error)
  }
}

// 删除项目类别
const handleDeleteProjectType = async () => {
  if (!searchForm.projectType) {
    ElMessage.warning('请先选择要删除的项目类型')
    return
  }

  try {
    await ElMessageBox.confirm(
      `确定要删除项目类型“${searchForm.projectType}”吗？此操作不可恢复！`,
      '警告',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
      },
    )

    // 用户确认删除
    await deleteProjectType(searchForm.projectType)
    ElMessage.success('项目类型删除成功')

    // 清空搜索条件
    searchForm.projectType = ''

    // 刷新数据
    loadProjectTypes()
    fetchProjectData()
  } catch (error: any) {
    if (error !== 'cancel') {
      console.error('删除项目类型失败:', error)
      ElMessage.error('删除项目类型失败')
    }
  }
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
      pageSize: page.pageSize,
    })

    // response.data 包含实际的业务数据
    console.log('项目分类API返回:', response)
    if (response && response.data) {
      // 检查是否是嵌套的 data 结构
      const pageData = response.data.data || response.data
      projectData.value = pageData.records || []
      page.total = pageData.total || 0
      console.log('分页数据:', { records: projectData.value.length, total: page.total })
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
  loadProjectTypes() // 加载项目类型选项
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
