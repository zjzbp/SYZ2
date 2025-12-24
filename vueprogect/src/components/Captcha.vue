<template>
  <div class="captcha-wrapper" @click="refreshCaptcha">
    <canvas ref="canvasRef" :width="width" :height="height"></canvas>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, watch } from 'vue'

interface Props {
  width?: number
  height?: number
}

const props = withDefaults(defineProps<Props>(), {
  width: 120,
  height: 40
})

const emit = defineEmits<{
  (e: 'update:code', value: string): void
}>()

const canvasRef = ref<HTMLCanvasElement>()
const code = ref('')

// 生成随机颜色
const randomColor = (min: number, max: number): string => {
  const r = Math.floor(Math.random() * (max - min) + min)
  const g = Math.floor(Math.random() * (max - min) + min)
  const b = Math.floor(Math.random() * (max - min) + min)
  return `rgb(${r},${g},${b})`
}

// 生成随机验证码
const generateCode = (): string => {
  const chars = 'ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz23456789'
  let result = ''
  for (let i = 0; i < 4; i++) {
    result += chars.charAt(Math.floor(Math.random() * chars.length))
  }
  return result
}

// 绘制验证码
const drawCaptcha = () => {
  if (!canvasRef.value) return

  const canvas = canvasRef.value
  const ctx = canvas.getContext('2d')
  if (!ctx) return

  // 生成新的验证码
  code.value = generateCode()
  emit('update:code', code.value)

  // 清空画布
  ctx.clearRect(0, 0, props.width, props.height)

  // 绘制背景
  ctx.fillStyle = randomColor(200, 240)
  ctx.fillRect(0, 0, props.width, props.height)

  // 绘制干扰线
  for (let i = 0; i < 5; i++) {
    ctx.strokeStyle = randomColor(100, 200)
    ctx.lineWidth = 1
    ctx.beginPath()
    ctx.moveTo(Math.random() * props.width, Math.random() * props.height)
    ctx.lineTo(Math.random() * props.width, Math.random() * props.height)
    ctx.stroke()
  }

  // 绘制干扰点
  for (let i = 0; i < 40; i++) {
    ctx.fillStyle = randomColor(0, 255)
    ctx.beginPath()
    ctx.arc(
      Math.random() * props.width,
      Math.random() * props.height,
      1,
      0,
      2 * Math.PI
    )
    ctx.fill()
  }

  // 绘制验证码文字
  for (let i = 0; i < code.value.length; i++) {
    const char = code.value.charAt(i)
    const x = (props.width / 4) * i + props.width / 8
    const y = props.height / 2

    // 随机字体大小
    const fontSize = Math.floor(Math.random() * 8) + 20
    ctx.font = `${fontSize}px Arial`
    ctx.fillStyle = randomColor(50, 160)

    // 保存当前状态
    ctx.save()

    // 设置旋转中心点
    ctx.translate(x, y)

    // 随机旋转角度
    const angle = (Math.random() - 0.5) * 0.6
    ctx.rotate(angle)

    // 绘制文字
    ctx.fillText(char, 0, 0)

    // 恢复状态
    ctx.restore()
  }
}

// 刷新验证码
const refreshCaptcha = () => {
  drawCaptcha()
}

// 暴露方法给父组件
defineExpose({
  refreshCaptcha
})

onMounted(() => {
  drawCaptcha()
})

// 监听尺寸变化
watch([() => props.width, () => props.height], () => {
  drawCaptcha()
})
</script>

<style scoped>
.captcha-wrapper {
  display: inline-block;
  cursor: pointer;
  border-radius: 4px;
  overflow: hidden;
  transition: all 0.3s;
}

.captcha-wrapper:hover {
  opacity: 0.8;
  transform: scale(1.02);
}

canvas {
  display: block;
}
</style>
