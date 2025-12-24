<template>
  <span>{{ displayValue }}</span>
</template>

<script setup lang="ts">
import { ref, watch, onMounted } from 'vue'

interface Props {
  value: number
  duration?: number
  prefix?: string
  suffix?: string
}

const props = withDefaults(defineProps<Props>(), {
  value: 0,
  duration: 1000,
  prefix: '',
  suffix: ''
})

const displayValue = ref(props.prefix + '0' + props.suffix)

// 数字动画函数
const animateValue = (start: number, end: number, duration: number) => {
  if (start === end) return
  
  const startTime = performance.now()
  const diff = end - start
  
  const updateValue = (currentTime: number) => {
    const elapsed = currentTime - startTime
    const progress = Math.min(elapsed / duration, 1)
    
    // 使用缓动函数使动画更平滑
    const easeOutQuart = 1 - Math.pow(1 - progress, 4)
    const currentValue = Math.floor(start + diff * easeOutQuart)
    
    displayValue.value = props.prefix + currentValue.toLocaleString() + props.suffix
    
    if (progress < 1) {
      requestAnimationFrame(updateValue)
    }
  }
  
  requestAnimationFrame(updateValue)
}

// 监听值的变化
watch(() => props.value, (newValue, oldValue) => {
  animateValue(oldValue || 0, newValue, props.duration)
})

// 组件挂载时初始化动画
onMounted(() => {
  animateValue(0, props.value, props.duration)
})
</script>

<style scoped>
span {
  font-weight: bold;
}
</style>
