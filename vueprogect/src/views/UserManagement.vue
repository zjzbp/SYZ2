<template>
  <div class="user-management">
    <el-card class="user-card">
      <template #header>
        <div class="card-header">
          <span class="card-title">用户管理</span>
          <el-button type="primary" @click="showAddDialog = true">新增用户</el-button>
        </div>
      </template>

      <!-- 搜索区域 -->
      <div class="search-section">
        <el-form :inline="true" :model="searchForm" class="search-form">
          <el-form-item label="用户名">
            <el-input v-model="searchForm.name" placeholder="请输入用户名" clearable />
          </el-form-item>
          <el-form-item label="手机号">
            <el-input v-model="searchForm.phone" placeholder="请输入手机号" clearable />
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="handleSearch">查询</el-button>
            <el-button @click="resetSearch">重置</el-button>
          </el-form-item>
        </el-form>
      </div>

      <!-- 用户列表 -->
      <el-table
        :data="userList"
        v-loading="loading"
        style="width: 100%"
        border
        stripe
        @selection-change="handleSelectionChange"
      >
        <el-table-column type="selection" width="55" />
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="name" label="用户名" width="120" />
        <el-table-column prop="phone" label="手机号" width="150" />
        <el-table-column prop="gridCode" label="网格编码" width="150" />
        <el-table-column prop="twoFactorCode" label="双因子码" width="180" />
        <el-table-column prop="isFillin" label="是否填写" width="100">
          <template #default="{ row }">
            <el-tag :type="row.isFillin === 1 ? 'success' : 'warning'">
              {{ row.isFillin === 1 ? '已填写' : '未填写' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" width="180" />
        <el-table-column prop="modalId" label="模态标识" width="120" />
        <el-table-column label="操作" width="220" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" size="small" @click="editUser(row)">编辑</el-button>
            <el-button type="success" size="small" @click="viewUser(row)">查看</el-button>
            <el-button type="danger" size="small" @click="deleteUser(row.id)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <div class="pagination">
        <el-pagination
          v-model:current-page="pagination.currentPage"
          v-model:page-size="pagination.pageSize"
          :page-sizes="[10, 20, 50, 100]"
          :total="pagination.total"
          layout="total, sizes, prev, pager, next, jumper"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </el-card>

    <!-- 新增/编辑用户对话框 -->
    <el-dialog
      v-model="showAddDialog"
      :title="dialogTitle"
      width="500px"
      :before-close="handleDialogClose"
    >
      <el-form
        :model="userForm"
        :rules="userFormRules"
        ref="userFormRef"
        label-width="100px"
      >
        <el-form-item label="用户名" prop="name">
          <el-input v-model="userForm.name" placeholder="请输入用户名" />
        </el-form-item>
        <el-form-item label="手机号" prop="phone">
          <el-input v-model="userForm.phone" placeholder="请输入手机号" />
        </el-form-item>
        <el-form-item label="网格编码" prop="gridCode">
          <el-input v-model="userForm.gridCode" placeholder="请输入网格编码" />
        </el-form-item>
        <el-form-item label="双因子码" prop="twoFactorCode">
          <el-input v-model="userForm.twoFactorCode" placeholder="请输入双因子码" />
        </el-form-item>
        <el-form-item label="是否填写" prop="isFillin">
          <el-select v-model="userForm.isFillin" placeholder="请选择是否填写">
            <el-option label="未填写" :value="0" />
            <el-option label="已填写" :value="1" />
          </el-select>
        </el-form-item>
        <el-form-item label="模态标识" prop="modalId">
          <el-input v-model="userForm.modalId" type="number" placeholder="请输入模态标识" />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="showAddDialog = false">取消</el-button>
          <el-button type="primary" @click="submitUserForm">确定</el-button>
        </span>
      </template>
    </el-dialog>

    <!-- 查看用户对话框 -->
    <el-dialog
      v-model="showViewDialog"
      title="查看用户信息"
      width="500px"
    >
      <el-descriptions :column="1" border>
        <el-descriptions-item label="ID">{{ viewUserDetail?.id }}</el-descriptions-item>
        <el-descriptions-item label="用户名">{{ viewUserDetail?.name }}</el-descriptions-item>
        <el-descriptions-item label="手机号">{{ viewUserDetail?.phone }}</el-descriptions-item>
        <el-descriptions-item label="网格编码">{{ viewUserDetail?.gridCode }}</el-descriptions-item>
        <el-descriptions-item label="双因子码">{{ viewUserDetail?.twoFactorCode }}</el-descriptions-item>
        <el-descriptions-item label="是否填写">
          <el-tag :type="viewUserDetail?.isFillin === 1 ? 'success' : 'warning'">
            {{ viewUserDetail?.isFillin === 1 ? '已填写' : '未填写' }}
          </el-tag>
        </el-descriptions-item>
        <el-descriptions-item label="创建时间">{{ viewUserDetail?.createTime }}</el-descriptions-item>
        <el-descriptions-item label="模态标识">{{ viewUserDetail?.modalId }}</el-descriptions-item>
      </el-descriptions>
      <template #footer>
        <el-button type="primary" @click="showViewDialog = false">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, reactive } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { User, Search } from '@element-plus/icons-vue'
import { getUserPage, addUser, updateUser, deleteUser } from '@/api/user'

// 定义用户类型，与API中的User类型一致
interface UserItem {
  id?: bigint
  name: string
  phone: string
  gridCode: string
  twoFactorCode: string
  password: string
  isFillin: number // 1: 已填写, 0: 未填写
  createTime?: string // LocalDateTime 格式
  modalId?: number
}

// 搜索表单
const searchForm = reactive({
  name: '',
  phone: ''
})

// 分页信息
const pagination = reactive({
  currentPage: 1,
  pageSize: 10,
  total: 0
})

// 用户列表
const userList = ref<UserItem[]>([])
const loading = ref(false)

// 对话框控制
const showAddDialog = ref(false)
const showViewDialog = ref(false)
const dialogTitle = ref('新增用户')
const isEdit = ref(false)

// 用户表单
const userForm = ref<UserItem>({
  id: undefined,
  name: '',
  phone: '',
  gridCode: '',
  twoFactorCode: '',
  password: '', // 添加密码字段以满足User接口要求
  isFillin: 0,
  createTime: undefined,
  modalId: undefined
})

// 查看用户详情
const viewUserDetail = ref<UserItem | null>(null)

// 表单验证规则
const userFormRules = {
  name: [
    { required: true, message: '请输入用户名', trigger: 'blur' },
    { min: 2, max: 20, message: '用户名长度在2-20个字符', trigger: 'blur' }
  ],
  phone: [
    { required: true, message: '请输入手机号', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号', trigger: 'blur' }
  ]
}

// 表单引用
const userFormRef = ref()

// 获取用户列表
const fetchUserList = async () => {
  loading.value = true
  try {
    const response = await getUserPage(pagination.currentPage, pagination.pageSize)
    if (response.code === 200) {
      userList.value = response.data
      pagination.total = response.total || 0
    } else {
      ElMessage.error(response.message || '获取用户列表失败')
    }
  } catch (error) {
    console.error('获取用户列表失败:', error)
    ElMessage.error('获取用户列表失败')
  } finally {
    loading.value = false
  }
}

// 搜索
const handleSearch = () => {
  pagination.currentPage = 1
  fetchUserList()
}

// 重置搜索
const resetSearch = () => {
  searchForm.name = ''
  searchForm.phone = ''
  pagination.currentPage = 1
  fetchUserList()
}

// 分页大小改变
const handleSizeChange = (size: number) => {
  pagination.pageSize = size
  pagination.currentPage = 1
  fetchUserList()
}

// 当前页改变
const handleCurrentChange = (page: number) => {
  pagination.currentPage = page
  fetchUserList()
}

// 处理多选
const selectedUsers = ref<UserItem[]>([])
const handleSelectionChange = (selection: UserItem[]) => {
  selectedUsers.value = selection
}

// 新增用户
const addUserHandler = () => {
  dialogTitle.value = '新增用户'
  isEdit.value = false
  userForm.value = {
    id: undefined,
    name: '',
    phone: '',
    gridCode: '',
    twoFactorCode: '',
    password: '', // 默认密码字段
    isFillin: 0,
    createTime: undefined,
    modalId: undefined
  }
  showAddDialog.value = true
}

// 编辑用户
const editUser = (row: UserItem) => {
  dialogTitle.value = '编辑用户'
  isEdit.value = true
  userForm.value = { ...row }
  // 如果密码为空，设置默认值以满足接口要求
  if (!userForm.value.password) {
    userForm.value.password = ''
  }
  showAddDialog.value = true
}

// 查看用户
const viewUser = (row: UserItem) => {
  viewUserDetail.value = { ...row }
  showViewDialog.value = true
}

// 删除用户
const deleteUserHandler = async (id: bigint) => {
  try {
    await ElMessageBox.confirm('确定要删除该用户吗？', '删除确认', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    
    const response = await deleteUser(id)
    if (response.code === 200) {
      ElMessage.success('删除成功')
      fetchUserList()
    } else {
      ElMessage.error(response.message || '删除失败')
    }
  } catch (error) {
    console.error('删除用户失败:', error)
  }
}

// 提交用户表单
const submitUserForm = async () => {
  try {
    await userFormRef.value.validate()
    
    // 创建一个临时对象，不包含undefined的id以避免更新问题
    const userSubmitData = {
      ...userForm.value
    }
    
    let response
    if (isEdit.value && userForm.value.id) {
      // 更新用户
      response = await updateUser(userSubmitData)
    } else {
      // 新增用户，移除id以让后端自动生成
      delete (userSubmitData as any).id
      response = await addUser(userSubmitData)
    }
    
    if (response.code === 200) {
      ElMessage.success(isEdit.value ? '更新成功' : '新增成功')
      showAddDialog.value = false
      fetchUserList()
    } else {
      ElMessage.error(response.message || (isEdit.value ? '更新失败' : '新增失败'))
    }
  } catch (error) {
    console.error(isEdit.value ? '更新用户失败:' : '新增用户失败:', error)
    ElMessage.error(isEdit.value ? '更新失败' : '新增失败')
  }
}

// 关闭对话框
const handleDialogClose = () => {
  showAddDialog.value = false
}

// 初始化
onMounted(() => {
  fetchUserList()
})
</script>

<style scoped>
.user-management {
  padding: 20px;
}

.user-card {
  border-radius: 8px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.card-title {
  font-size: 18px;
  font-weight: bold;
}

.search-section {
  margin-bottom: 20px;
}

.search-form {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.search-form .el-form-item {
  margin-bottom: 10px;
}

.pagination {
  margin-top: 20px;
  display: flex;
  justify-content: center;
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}
</style>