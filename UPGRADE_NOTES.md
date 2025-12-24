# 资产确权与模态标识绑定功能升级说明

## 一、功能概述

本次升级将资产确权模块全面重构，实现了模态标识与项目类型的绑定管理功能。

## 二、主要变更

### 1. 数据库准备

请先执行以下SQL脚本初始化项目数据：

```bash
mysql -u用户名 -p数据库名 < init_project_data.sql
```

该脚本会初始化以下6个项目类型：
- 口述历史
- 福伦酒
- 低空经济
- 在线商城
- 讲习堂
- 大健康

### 2. 资产确权页面改造

**改动点：**
- ✅ 修复用户姓名显示（企业显示企业名称，个人显示真实姓名）
- ✅ 移除"当前模态ID"显示
- ✅ 标题改为"使用模态标识"
- ✅ 新增"选择项目类型"下拉框
- ✅ 实现二次确认绑定
- ✅ 绑定信息存储到 `biz_modal_identifier` 表
- ✅ 绑定后模态剩余数量自动减一

**操作流程：**
1. 输入模态标识值（0-99999999）
2. 选择项目类型（从下拉框选择）
3. 点击"立即绑定"
4. 二次确认弹窗，确认后完成绑定
5. 页面自动刷新，显示最新剩余数量

### 3. 新增"我的模态"功能

**功能特性：**
- ✅ 卡片式展示已绑定的模态标识
- ✅ 项目分类筛选（下拉选择）
- ✅ 日期范围查询（开始日期 - 结束日期）
- ✅ 默认显示近一个月的绑定记录
- ✅ 每个项目类型使用不同渐变色
- ✅ 点击卡片跳转到对应项目页面

**访问路径：**
个人中心 → 我的模态

### 4. 后端接口

**新增接口：**

1. `GET /user/projects/available` - 查询所有可用项目类型
2. `POST /user/modal/bind` - 绑定模态标识到项目
   ```json
   {
     "userId": 123,
     "modalValue": 888888,
     "projectType": "口述历史"
   }
   ```
3. `GET /user/modal/bindings/{userId}` - 查询用户的模态绑定记录
   - 可选参数：projectType（项目类型）
   - 可选参数：startDate, endDate（日期范围）

## 三、数据表说明

### biz_modal_identifier（模态标识表）

新增字段：
- `create_time` - 创建时间，用于日期查询

存储内容：
- modal_value: 模态标识值
- two_factor_value: 关联双因子码
- user_id: 关联用户ID
- identifier_type: 项目类型（如"口述历史"）
- status: 状态（VALID-有效）
- hash_value: 区块链存证哈希值
- create_time: 绑定时间

### biz_project_info（项目信息表）

初始化了6条项目记录，每条包含：
- project_name: 项目名称
- project_type: 项目类型（用于绑定）
- project_desc: 项目描述
- project_status: 项目状态（ONLINE）

## 四、前端页面

### 新增文件：
- `pages-user/my-modals/my-modals.vue` - 我的模态页面

### 修改文件：
- `pages-user/modal-binding/modal-binding.vue` - 资产确权页面
- `pages-user/dashboard/dashboard.vue` - 个人中心（新增"我的模态"入口）
- `pages.json` - 路由配置

## 五、项目跳转页面（待开发）

点击模态卡片时，会根据项目类型跳转到不同页面：

- 口述历史 → `/pages-project/oral-history/oral-history`
- 福伦酒 → `/pages-project/fulun-wine/fulun-wine`
- 低空经济 → `/pages-project/low-altitude/low-altitude`
- 在线商城 → `/pages-project/online-mall/online-mall`
- 讲习堂 → `/pages-project/lecture-hall/lecture-hall`
- 大健康 → `/pages-project/health/health`

这些页面目前未创建，点击会提示"页面开发中"。

## 六、使用说明

### 1. 初始化数据库

```bash
cd e:/project1/SYZ
mysql -u用户名 -p数据库名 < init_project_data.sql
```

### 2. 启动后端服务

确保后端服务正常运行，检查以下接口是否可访问：
- GET /user/projects/available
- POST /user/modal/bind
- GET /user/modal/bindings/{userId}

### 3. 测试绑定流程

1. 登录系统
2. 进入"资产确权"页面
3. 输入模态标识：888888
4. 选择项目类型：口述历史
5. 点击"立即绑定"
6. 确认绑定
7. 查看"我的模态"，确认绑定记录

### 4. 测试查询功能

1. 进入"我的模态"页面
2. 默认显示近一个月的记录
3. 使用项目分类筛选
4. 使用日期范围查询
5. 点击卡片查看跳转功能

## 七、注意事项

1. ⚠️ 每个模态标识只能使用一次，重复绑定会报错
2. ⚠️ 绑定后无法更改，请谨慎操作
3. ⚠️ 项目页面需要单独开发，目前仅占位
4. ⚠️ 确保数据库表 `biz_modal_identifier` 有 `create_time` 字段
5. ⚠️ 前端需要重启才能看到新页面

## 八、技术要点

- 使用事务保证数据一致性（@Transactional）
- 模态标识与项目绑定为永久关联
- 查询默认只显示 VALID 状态的记录
- 日期查询使用 DATE() 函数匹配
- 卡片渐变色通过项目类型动态生成
- 用户姓名根据 userType 自动适配

---

**开发完成时间：** 2025-12-23
**版本号：** v2.0
**开发者：** AI Assistant
