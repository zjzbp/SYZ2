<template>
  <div class="user-management">
    <el-card class="user-card">
      <template #header>
        <div class="card-header">
          <span class="card-title">用户管理</span>
        </div>
      </template>

      <!-- 搜索区域 -->
      <div class="search-section">
        <el-form :inline="true" :model="searchForm" class="search-form">
          <el-form-item label="用户类型">
            <el-select v-model="searchForm.userType" placeholder="请选择用户类型" style="width: 150px" @change="handleSearch">
              <el-option label="用户" value="PERSONAL" />
              <el-option label="企业" value="ENTERPRISE" />
            </el-select>
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
      >
        <el-table-column label="排名" width="80" align="center">
          <template #default="{ $index }">
            <span class="rank-number">{{ (pagination.currentPage - 1) * pagination.pageSize + $index + 1 }}</span>
          </template>
        </el-table-column>
        <el-table-column prop="userType" label="用户类型" width="100">
          <template #default="{ row }">
            <el-tag :type="row.userType === 'PERSONAL' ? 'primary' : 'success'">
              {{ row.userType === 'PERSONAL' ? '用户' : '企业' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="phone" label="手机号" width="140" />
        <el-table-column prop="gridCode" label="网格编码" width="140" />
        <el-table-column prop="twoFactorCode" label="双因子码" width="180" />
        <el-table-column prop="totalScore" label="总分数" width="120" align="center">
          <template #default="{ row }">
            <el-tag type="warning" effect="dark">
              <strong>{{ row.totalScore || 0 }}</strong> 分
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="isFillin" label="是否填写" width="100">
          <template #default="{ row }">
            <el-tag :type="row.isFillin === 1 ? 'success' : 'warning'">
              {{ row.isFillin === 1 ? '已填写' : '未填写' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.status === 'ACTIVE' ? 'success' : 'danger'">
              {{ row.status === 'ACTIVE' ? '正常' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" width="180" />
        <el-table-column label="操作" width="150" fixed="right">
          <template #default="{ row }">
            <el-button type="primary" size="small" @click="viewUserDetail(row)">查看详情</el-button>
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
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { getUserList, type User } from '@/api/user'

const router = useRouter()

// 搜索表单
const searchForm = reactive({
  userType: 'PERSONAL',  // 默认显示用户列表
  phone: ''
})

// 分页信息
const pagination = reactive({
  currentPage: 1,
  pageSize: 10,
  total: 0
})

// 用户列表
const userList = ref<User[]>([])
const loading = ref(false)

// 获取用户列表
const fetchUserList = async () => {
  loading.value = true
  try {
    const response = await getUserList({
      userType: searchForm.userType,
      phone: searchForm.phone || undefined,
      currentPage: pagination.currentPage,
      pageSize: pagination.pageSize
    })
    // 响应拦截器已经返回 response.data，所以 response 就是 { code, message, data }
    if (response.code === 200 && response.data) {
      // MyBatis-Plus 分页返回的是 records 和 total
      userList.value = response.data.records || []
      pagination.total = response.data.total || 0
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
  searchForm.userType = 'PERSONAL'
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

// 查看用户详情 - 跳转到详情页面
const viewUserDetail = (row: User) => {
  router.push(`/user-detail/${row.userId}`)
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

.rank-number {
  font-size: 16px;
  font-weight: bold;
  color: #409eff;
}

.dialog-footer {
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}
</style>