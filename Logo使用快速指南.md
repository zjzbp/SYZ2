# 📸 自定义Logo二维码快速指南

## 🎯 三步生成带Logo的二维码

### 第一步：准备Logo图片

将你的Logo图片复制到以下目录：
```
syz-user/src/main/resources/static/logos/
```

**示例：**
```
syz-user/
  └─ src/main/resources/static/logos/
      ├─ logo.png          ← 你的Logo文件
      ├─ company-logo.png
      └─ brand-logo.jpg
```

**Logo要求：**
- ✅ 格式：PNG、JPG、JPEG、GIF
- ✅ 推荐尺寸：60x60像素或更大（会自动缩放）
- ✅ 推荐形状：圆形或正方形
- ✅ 文件名：只能包含英文、数字、下划线、横杠
- ❌ 文件名不能有中文或特殊字符

### 第二步：重新编译项目

如果后端服务正在运行，需要重新编译：
```bash
# 方法1：重新启动Spring Boot应用
# 方法2：使用热部署（如果配置了）
```

### 第三步：调用接口

假设你的Logo文件名是 `logo.png`

#### 浏览器直接访问
```
http://localhost:8081/qrcode/generate-with-logo?logoUrl=logo.png
```

#### HTML中使用
```html
<img src="http://localhost:8081/qrcode/generate-with-logo?logoUrl=logo.png" alt="二维码" />
```

#### Vue/UniApp中使用
```vue
<template>
  <image :src="qrcodeUrl"></image>
</template>

<script>
export default {
  data() {
    return {
      qrcodeUrl: 'http://localhost:8081/qrcode/generate-with-logo?logoUrl=logo.png'
    }
  }
}
</script>
```

---

## 🌟 三种Logo使用方式

### 方式一：本地Logo文件（推荐）✨

**优点：** 快速、稳定、不依赖网络

**步骤：**
1. 将Logo放到 `resources/static/logos/` 目录
2. 调用接口时使用文件名

```bash
# 使用本地logo.png
http://localhost:8081/qrcode/generate-with-logo?logoUrl=logo.png

# 使用本地company-logo.png
http://localhost:8081/qrcode/generate-with-logo?logoUrl=company-logo.png
```

### 方式二：网络Logo URL

**优点：** 灵活、可动态更换

**步骤：**
1. 确保Logo图片可通过HTTP/HTTPS访问
2. 调用接口时使用完整URL

```bash
http://localhost:8081/qrcode/generate-with-logo?logoUrl=https://example.com/logo.png
```

### 方式三：默认Logo

**优点：** 无需准备Logo，开箱即用

**步骤：**
直接调用接口，不传logoUrl参数

```bash
http://localhost:8081/qrcode/generate-with-logo
```

---

## 📝 实际示例

### 示例1：电商平台品牌二维码

**需求：** 生成带品牌Logo的商品二维码

**步骤：**
```bash
# 1. 准备品牌Logo
syz-user/src/main/resources/static/logos/brand-logo.png

# 2. 生成二维码（跳转到商品详情页）
http://localhost:8081/qrcode/generate-with-logo?content=https://shop.com/product/123&logoUrl=brand-logo.png&width=400&height=400
```

### 示例2：企业登录二维码

**需求：** 生成带公司Logo的登录二维码

**步骤：**
```bash
# 1. 准备公司Logo
syz-user/src/main/resources/static/logos/company-logo.png

# 2. 在登录页面使用
```

```html
<div class="login-section">
  <h2>扫码登录</h2>
  <img src="http://localhost:8081/qrcode/generate-with-logo?logoUrl=company-logo.png" 
       alt="扫码登录" 
       style="width: 300px; height: 300px;" />
</div>
```

### 示例3：活动推广二维码

**需求：** 生成带活动Logo的推广二维码

```javascript
// POST请求 - 自定义内容和Logo
fetch('http://localhost:8081/qrcode/generate-with-logo', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    content: 'https://activity.com/spring-sale',
    width: 500,
    height: 500,
    logoUrl: 'activity-logo.png'  // 本地活动Logo
  })
})
.then(response => response.blob())
.then(blob => {
  const url = URL.createObjectURL(blob);
  document.getElementById('qrcode').src = url;
});
```

---

## 🔍 常见问题

### Q1: Logo没有显示怎么办？

**检查清单：**
- ✅ Logo文件是否在 `resources/static/logos/` 目录？
- ✅ 文件名是否正确（大小写敏感）？
- ✅ 后端服务是否重新编译并启动？
- ✅ 查看后端控制台日志，是否有错误提示？

### Q2: 如何更换Logo？

**方法1：替换文件**
```bash
# 直接替换logos目录下的文件
# 重启服务后生效
```

**方法2：使用新文件名**
```bash
# 添加新的Logo文件
# 调用接口时使用新文件名
http://localhost:8081/qrcode/generate-with-logo?logoUrl=new-logo.png
```

### Q3: Logo会变形吗？

不会！系统会自动缩放Logo到60x60像素，保持比例。建议使用正方形Logo效果最佳。

### Q4: 可以使用PNG透明背景吗？

可以！推荐使用PNG格式的透明背景Logo，效果更好。

### Q5: Logo太大或太小怎么办？

系统会自动缩放到60x60像素，你只需要确保Logo清晰即可。推荐使用60x60或更大的尺寸。

---

## 🎨 Logo设计建议

### 最佳实践

1. **尺寸：** 60x60像素或以上（推荐200x200）
2. **格式：** PNG格式（支持透明背景）
3. **形状：** 圆形或正方形
4. **颜色：** 使用品牌主色，避免复杂渐变
5. **简洁：** Logo要清晰简洁，避免细节过多

### 效果对比

| Logo类型 | 推荐度 | 说明 |
|---------|-------|------|
| 圆形PNG透明背景 | ⭐⭐⭐⭐⭐ | 最佳选择 |
| 正方形PNG透明背景 | ⭐⭐⭐⭐ | 很好 |
| 矩形PNG | ⭐⭐⭐ | 可能有留白 |
| JPG格式 | ⭐⭐ | 无透明背景 |

---

## 🚀 快速测试

### 使用测试页面

1. 打开 `二维码测试页面.html`
2. 在"自定义生成二维码"区域：
   - 类型：选择"带Logo二维码"
   - Logo设置：选择"本地Logo文件"
   - Logo文件名：输入你的文件名（如：logo.png）
3. 点击"生成二维码"

### 浏览器直接测试

```bash
# 替换为你的Logo文件名
http://localhost:8081/qrcode/generate-with-logo?logoUrl=你的文件名.png
```

---

## 📞 技术支持

如有问题，请查看：
- [二维码接口文档.md](二维码接口文档.md) - 完整API文档
- [Logo README](syz-user/src/main/resources/static/logos/README.md) - Logo目录说明
- 后端控制台日志 - 查看错误信息
