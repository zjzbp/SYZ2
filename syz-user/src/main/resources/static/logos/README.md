# Logo 图片存放目录

## 📁 目录说明

这个目录用于存放二维码中使用的Logo图片。

## 💡 使用方法

### 1. 存放Logo图片

将你的Logo图片文件放在这个目录下，例如：
- `logo.png`
- `company-logo.png`
- `brand-logo.jpg`

**支持的图片格式**：PNG、JPG、JPEG、GIF

**建议尺寸**：
- 推荐尺寸：60x60 像素或更大（系统会自动缩放到60x60）
- 推荐格式：PNG（支持透明背景）
- 建议使用正方形或圆形Logo

### 2. 调用接口时使用

#### 方式一：使用本地文件名（推荐）

```bash
# GET请求
http://localhost:8081/qrcode/generate-with-logo?logoUrl=logo.png

# 或者
http://localhost:8081/qrcode/generate-with-logo?logoUrl=company-logo.png
```

```javascript
// POST请求
fetch('http://localhost:8081/qrcode/generate-with-logo', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    content: 'http://localhost:5173/#/',
    logoUrl: 'logo.png'  // 使用本地Logo
  })
})
```

#### 方式二：使用网络URL

```bash
http://localhost:8081/qrcode/generate-with-logo?logoUrl=https://example.com/logo.png
```

#### 方式三：使用默认Logo

```bash
# 不传logoUrl参数，或传空值
http://localhost:8081/qrcode/generate-with-logo

# 或者
http://localhost:8081/qrcode/login?withLogo=true
```

## 📝 示例

假设你在这个目录下放了一个 `my-logo.png` 文件：

```
syz-user/src/main/resources/static/logos/
  └── my-logo.png
```

那么在调用接口时：

```html
<!-- HTML中使用 -->
<img src="http://localhost:8081/qrcode/generate-with-logo?logoUrl=my-logo.png" />
```

```vue
<!-- Vue/UniApp中使用 -->
<template>
  <image :src="qrcodeUrl"></image>
</template>

<script>
export default {
  data() {
    return {
      qrcodeUrl: 'http://localhost:8081/qrcode/generate-with-logo?logoUrl=my-logo.png'
    }
  }
}
</script>
```

## 🎨 Logo设计建议

1. **尺寸**：推荐60x60像素或以上
2. **形状**：圆形或正方形效果最佳
3. **格式**：PNG格式（支持透明背景）
4. **颜色**：使用品牌主色，避免过于复杂的渐变
5. **清晰度**：确保Logo清晰，避免模糊
6. **对比度**：Logo与二维码背景要有足够对比度

## ⚠️ 注意事项

1. Logo文件名不能包含中文或特殊字符
2. 文件名大小写敏感
3. Logo会自动缩放到60x60像素
4. 如果Logo文件不存在或加载失败，会自动使用默认蓝色圆形Logo
5. 建议Logo文件大小不超过500KB

## 🔍 故障排查

如果Logo没有显示：

1. 检查文件是否存在于 `resources/static/logos/` 目录
2. 检查文件名是否正确（大小写敏感）
3. 检查文件格式是否支持（PNG/JPG/JPEG/GIF）
4. 查看后端控制台日志，是否有错误信息
5. 确保后端服务已重新编译并启动
