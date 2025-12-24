<template>
  <el-dialog
    v-model="visible"
    title="用户详情"
    width="700px"
    :before-close="handleClose"
    class="user-detail-dialog"
  >
    <el-descriptions
      v-if="user"
      :column="1"
      border
      size="medium"
      label-class-name="detail-label"
      content-class-name="detail-content"
    >
      <el-descriptions-item label="用户ID">{{ user.id }}</el-descriptions-item>
      <el-descriptions-item label="姓名">{{ user.name }}</el-descriptions-item>
      <el-descriptions-item label="手机号">{{ user.phone }}</el-descriptions-item>
      <el-descriptions-item label="网格编码">{{ user.gridCode }}</el-descriptions-item>
      <el-descriptions-item label="双因子码">{{ user.twoFactorCode }}</el-descriptions-item>
      <el-descriptions-item label="填写状态">
        <el-tag :type="user.isFillin === 1 ? 'success' : 'info'">
          {{ user.isFillin === 1 ? '已填写' : '未填写' }}
        </el-tag>
      </el-descriptions-item>
      <el-descriptions-item label="创建时间">{{ user.createTime }}</el-descriptions-item>
    </el-descriptions>

    <template #footer>
      <el-button @click="handleClose">关闭</el-button>
    </template>
  </el-dialog>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue'
import type { User } from '@/api/user'

interface Props {
  modelValue: boolean
  user?: User
}

interface Emits {
  (e: 'update:modelValue', value: boolean): void
}

const props = defineProps<Props>()
const emit = defineEmits<Emits>()

const visible = ref(false)

// 监听 modelValue 变化
watch(
  () => props.modelValue,
  (val) => {
    visible.value = val
  }
)

// 监听 visible 变化
watch(visible, (val) => {
  emit('update:modelValue', val)
})

const handleClose = () => {
  visible.value = false
}
</script>

<style scoped>
:deep(.detail-label) {
  font-weight: bold;
  width: 150px !important;
  background: #f0f9ff;
  color: #409eff;
  font-size: 14px;
}

:deep(.detail-content) {
  background: #fff;
  font-size: 14px;
  color: #606266;
}

:deep(.user-detail-dialog .el-dialog__header) {
  background: linear-gradient(135deg, #409eff, #66b1ff);
  color: white;
  padding: 20px;
}

:deep(.user-detail-dialog .el-dialog__title) {
  color: white;
  font-size: 18px;
  font-weight: bold;
}

:deep(.user-detail-dialog .el-dialog__headerbtn .el-dialog__close) {
  color: white;
}

:deep(.user-detail-dialog .el-dialog__body) {
  padding: 30px;
  background: #f5f7fa;
}

:deep(.user-detail-dialog .el-dialog__footer) {
  padding: 20px;
  background: #f5f7fa;
}
</style>
