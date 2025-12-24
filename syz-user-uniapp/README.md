# SYZ 用户前端 (uni-app)

## 项目说明
基于 uni-app 开发的双因子码用户系统前端应用,支持多端运行(H5/小程序/App)。

## 目录结构
```
syz-user-uniapp/
├── pages-user/              # 用户功能页面
│   ├── login/              # 登录页面
│   ├── register/           # 注册页面
│   ├── reset-password/     # 重置密码页面
│   ├── dashboard/          # 个人中心
│   ├── fill-info/          # 填写网格码信息
│   ├── modal-binding/      # 资产确权绑定
│   └── utils/              # 工具类(request.js)
├── App.vue                 # 应用配置
├── main.js                 # 入口文件
├── pages.json              # 页面配置
└── manifest.json           # 应用配置

```

## 功能页面
- **登录页面**: 手机号+密码登录,支持JWT认证
- **注册页面**: 手机号注册,验证码验证
- **重置密码**: 通过验证码重置密码
- **个人中心**: 查看用户信息、双因子码、网格码、模态标识
- **填写信息**: 填写网格码开通权益
- **资产确权**: 绑定模态标识进行资产确权

## 配置说明
1. 修改后端接口地址: `pages-user/utils/request.js` 中的 `BASE_URL`
2. 默认后端地址: `http://localhost:8081/user`

## 运行方式

### H5 运行
使用 HBuilderX 打开项目,运行到浏览器

### 小程序运行
1. 在 manifest.json 中配置小程序 appid
2. 使用 HBuilderX 运行到微信开发者工具

## 特性
- ✅ 响应式设计,适配手机端和PC端
- ✅ JWT Token 认证
- ✅ 表单验证
- ✅ 统一错误处理
- ✅ 本地缓存管理

## 技术栈
- uni-app (Vue 3)
- uni-ui 组件库
- CSS3 媒体查询
