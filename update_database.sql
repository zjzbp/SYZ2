/*
 更新数据库表结构 - 建立完整的业务流程链路
 
 业务流程：
 1. 用户注册 -> 生成双因子码 -> 保存到 biz_two_factor_code 表（此时 grid_code_value 为空）
 2. 用户填写网格码 -> 保存到 biz_grid_code 表 -> 与双因子码绑定（更新 biz_two_factor_code.grid_code_value）
 3. 用户绑定模态标识 -> 与双因子码关联保存到 biz_modal_identifier 表
 4. 选择活动（口述历史/非遗记录/文档存档等） -> 一个模态标识对应一个活动 -> 保存到 biz_project_info 表
 
 设计特点：
 1. 移除所有物理外键约束（改为逻辑外键）
 2. 添加逻辑删除字段
 3. 建立完整的关联关系：用户 -> 双因子码 -> 网格码 -> 模态标识 -> 活动项目
 
 Date: 2025-12-23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ============================
-- 1. 删除旧表的外键约束
-- ============================

ALTER TABLE `biz_modal_identifier` DROP FOREIGN KEY IF EXISTS `fk_modal_two_factor`;
ALTER TABLE `biz_project_info` DROP FOREIGN KEY IF EXISTS `fk_project_modal`;
ALTER TABLE `biz_two_factor_code` DROP FOREIGN KEY IF EXISTS `fk_two_factor_grid_code`;

-- ============================
-- 2. 重建网格码表
-- ============================
-- 流程：用户填写网格码时保存

DROP TABLE IF EXISTS `biz_grid_code`;
CREATE TABLE `biz_grid_code` (
  `grid_code_id` bigint NOT NULL AUTO_INCREMENT COMMENT '表内唯一标识（自增）',
  `grid_code_value` varchar(64) NOT NULL COMMENT '网格码唯一值（用户填写）',
  `user_id` bigint NOT NULL COMMENT '用户ID（逻辑外键 -> user.id）',
  `status` varchar(20) NOT NULL DEFAULT 'VALID' COMMENT '状态：VALID-有效、INVALID-失效',
  `hash_value` varchar(128) DEFAULT NULL COMMENT '区块链存证哈希值（用于验真）',
  `deposit_record_id` varchar(64) DEFAULT NULL COMMENT '区块链存证记录ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记：0-未删除，1-已删除',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`grid_code_id`) USING BTREE,
  UNIQUE INDEX `uk_grid_code_value`(`grid_code_value`, `deleted`) USING BTREE COMMENT '网格码值唯一约束（含删除标记）',
  INDEX `idx_user_id`(`user_id`) USING BTREE COMMENT '用户关联索引',
  INDEX `idx_deleted`(`deleted`) USING BTREE COMMENT '逻辑删除索引'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci 
COMMENT = '网格码存储表（用户填写信息后获得）' 
ROW_FORMAT = Dynamic;

-- ============================
-- 3. 重建双因子码表
-- ============================
-- 流程：用户注册时创建（grid_code_value 初始为空），填写网格码后更新 grid_code_value

DROP TABLE IF EXISTS `biz_two_factor_code`;
CREATE TABLE `biz_two_factor_code` (
  `two_factor_id` bigint NOT NULL AUTO_INCREMENT COMMENT '表内唯一标识（自增）',
  `two_factor_value` varchar(64) NOT NULL COMMENT '双因子码唯一值（TFC-XXXXXXXX，用户注册时生成）',
  `user_id` bigint NOT NULL COMMENT '用户ID（逻辑外键 -> user.id）',
  `grid_code_value` varchar(64) DEFAULT NULL COMMENT '关联网格码值（逻辑外键 -> biz_grid_code.grid_code_value，用户填写信息后绑定）',
  `code_type` varchar(20) NOT NULL DEFAULT 'PERSONAL' COMMENT '码类型：ASSET-资产类、PERSONAL-个人类',
  `status` varchar(20) NOT NULL DEFAULT 'ACTIVATED' COMMENT '状态：ACTIVATED-已激活、FROZEN-冻结、INVALID-失效',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记：0-未删除，1-已删除',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`two_factor_id`) USING BTREE,
  UNIQUE INDEX `uk_two_factor_value`(`two_factor_value`, `deleted`) USING BTREE COMMENT '双因子码值唯一约束（含删除标记）',
  INDEX `idx_user_id`(`user_id`) USING BTREE COMMENT '用户关联索引',
  INDEX `idx_grid_code_value`(`grid_code_value`) USING BTREE COMMENT '网格码关联索引（逻辑外键）',
  INDEX `idx_deleted`(`deleted`) USING BTREE COMMENT '逻辑删除索引'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci 
COMMENT = '双因子码存储表（用户注册时生成，填写信息后与网格码绑定）' 
ROW_FORMAT = Dynamic;

-- ============================
-- 4. 重建模态标识表
-- ============================
-- 流程：用户绑定模态标识时创建，与双因子码关联

DROP TABLE IF EXISTS `biz_modal_identifier`;
CREATE TABLE `biz_modal_identifier` (
  `modal_id` bigint NOT NULL AUTO_INCREMENT COMMENT '表内唯一标识（自增主键）',
  `modal_value` int NOT NULL COMMENT '模态标识值（0-99999999，用户选择的值）',
  `two_factor_value` varchar(64) NOT NULL COMMENT '关联双因子码值（逻辑外键 -> biz_two_factor_code.two_factor_value）',
  `user_id` bigint NOT NULL COMMENT '关联用户ID（逻辑外键 -> user.id）',
  `identifier_type` varchar(20) NOT NULL DEFAULT 'PROJECT' COMMENT '标识类型：PROJECT-项目类（如口述历史）',
  `status` varchar(20) NOT NULL DEFAULT 'VALID' COMMENT '状态：VALID-有效、INVALID-失效',
  `hash_value` varchar(128) DEFAULT NULL COMMENT '区块链存证哈希值（用于验真）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记：0-未删除，1-已删除',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`modal_id`) USING BTREE,
  UNIQUE INDEX `uk_user_modal_value`(`user_id`, `modal_value`, `deleted`) USING BTREE COMMENT '用户+模态标识值唯一约束',
  INDEX `idx_two_factor_value`(`two_factor_value`) USING BTREE COMMENT '双因子码关联索引（逻辑外键）',
  INDEX `idx_user_id`(`user_id`) USING BTREE COMMENT '用户关联索引（逻辑外键）',
  INDEX `idx_deleted`(`deleted`) USING BTREE COMMENT '逻辑删除索引'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci 
COMMENT = '模态标识表（用户绑定模态标识时创建，与双因子码关联）' 
ROW_FORMAT = Dynamic;

-- ============================
-- 5. 重建项目信息表（活动表）
-- ============================
-- 流程：用户选择活动类型（口述历史/非遗记录/文档存档等），一个模态标识对应一个活动

DROP TABLE IF EXISTS `biz_project_info`;
CREATE TABLE `biz_project_info` (
  `project_id` bigint NOT NULL AUTO_INCREMENT COMMENT '项目/活动唯一标识',
  `modal_id` bigint NOT NULL COMMENT '关联模态标识ID（逻辑外键 -> biz_modal_identifier.modal_id，一个模态标识对应一个活动）',
  `modal_value` int NOT NULL COMMENT '模态标识值（冗余字段，便于查询）',
  `user_id` bigint NOT NULL COMMENT '用户ID（逻辑外键 -> user.id）',
  `project_name` varchar(100) NOT NULL COMMENT '项目/活动名称（如"张三口述历史-2025"）',
  `project_type` varchar(50) NOT NULL COMMENT '活动类型：口述历史、非遗记录、文档存档等',
  `cloud_storage_url` varchar(255) DEFAULT NULL COMMENT '云仓库存储URL（指向项目文件）',
  `project_desc` text COMMENT '项目描述（可选）',
  `project_status` varchar(20) NOT NULL DEFAULT 'ONLINE' COMMENT '项目状态：ONLINE-上线、OFFLINE-下架',
  `upload_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记：0-未删除，1-已删除',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`project_id`) USING BTREE,
  UNIQUE INDEX `uk_modal_id`(`modal_id`, `deleted`) USING BTREE COMMENT '模态标识唯一约束（一个模态标识只能对应一个活动）',
  INDEX `idx_user_id`(`user_id`) USING BTREE COMMENT '用户关联索引（逻辑外键）',
  INDEX `idx_modal_value`(`modal_value`) USING BTREE COMMENT '模态标识值索引',
  INDEX `idx_project_type`(`project_type`) USING BTREE COMMENT '活动类型索引',
  INDEX `idx_deleted`(`deleted`) USING BTREE COMMENT '逻辑删除索引'
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci 
COMMENT = '项目/活动信息表（一个模态标识对应一个活动：口述历史、非遗记录、文档存档等）' 
ROW_FORMAT = Dynamic;

-- ============================
-- 6. 更新用户表（添加逻辑删除）
-- ============================

ALTER TABLE `user` 
  ADD COLUMN `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间' AFTER `create_time`,
  ADD COLUMN `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记：0-未删除，1-已删除' AFTER `update_time`,
  ADD COLUMN `delete_time` datetime DEFAULT NULL COMMENT '删除时间' AFTER `deleted`,
  ADD INDEX `idx_phone`(`phone`) USING BTREE COMMENT '手机号索引',
  ADD INDEX `idx_grid_code`(`grid_code`) USING BTREE COMMENT '网格码索引',
  ADD INDEX `idx_deleted`(`deleted`) USING BTREE COMMENT '逻辑删除索引';

-- 修改双因子码唯一索引（包含 deleted）
ALTER TABLE `user` DROP INDEX `uk_two_factor_code`;
ALTER TABLE `user` ADD UNIQUE INDEX `uk_two_factor_code`(`two_factor_code`, `deleted`) USING BTREE COMMENT '双因子码唯一约束（含删除标记）';

-- ============================
-- 7. 更新用户模态关联表
-- ============================

ALTER TABLE `user_modal`
  ADD COLUMN `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间' AFTER `create_time`,
  ADD COLUMN `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记：0-未删除，1-已删除' AFTER `update_time`,
  ADD COLUMN `delete_time` datetime DEFAULT NULL COMMENT '删除时间' AFTER `deleted`,
  ADD INDEX `idx_deleted`(`deleted`) USING BTREE COMMENT '逻辑删除索引';

-- 修改唯一索引（包含 deleted）
ALTER TABLE `user_modal` DROP INDEX `uk_user_modal`;
ALTER TABLE `user_modal` ADD UNIQUE INDEX `uk_user_modal`(`user_id`, `modal_id`, `deleted`) USING BTREE COMMENT '用户+模态标识唯一约束（含删除标记）';

-- ============================
-- 8. 更新管理员表（添加逻辑删除）
-- ============================

ALTER TABLE `admin`
  ADD COLUMN `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间' AFTER `password`,
  ADD COLUMN `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间' AFTER `create_time`,
  ADD COLUMN `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记：0-未删除，1-已删除' AFTER `update_time`,
  ADD COLUMN `delete_time` datetime DEFAULT NULL COMMENT '删除时间' AFTER `deleted`,
  ADD INDEX `idx_deleted`(`deleted`) USING BTREE COMMENT '逻辑删除索引';

SET FOREIGN_KEY_CHECKS = 1;

-- ============================
-- 业务流程说明
-- ============================
/*
完整的业务流程链路：

【步骤1：用户注册】
- 用户注册（user表插入记录）
- 系统生成双因子码（TFC-XXXXXXXX）
- 插入 biz_two_factor_code 表：
  * two_factor_value = 生成的双因子码
  * user_id = 用户ID
  * grid_code_value = NULL（此时还未填写网格码）
- 更新 user.two_factor_code = 生成的双因子码

【步骤2：用户填写信息】
- 用户填写网格码
- 插入 biz_grid_code 表：
  * grid_code_value = 用户填写的网格码
  * user_id = 用户ID
- 更新 biz_two_factor_code 表：
  * 根据 user_id 找到对应的双因子码记录
  * 更新 grid_code_value = 用户填写的网格码
- 更新 user.grid_code = 用户填写的网格码
- 更新 user.is_fillin = 1

【步骤3：用户绑定模态标识（资产确权）】
- 用户选择模态标识值（0-99999999）
- 查询 user_modal 表检查是否已使用过该值
- 查询 user 表获取用户的 two_factor_code
- 插入 biz_modal_identifier 表：
  * modal_value = 用户选择的值
  * two_factor_value = 用户的双因子码
  * user_id = 用户ID
  * identifier_type = 'PROJECT'
  * status = 'VALID'
- 插入 user_modal 表（历史记录）：
  * user_id = 用户ID
  * modal_id = 用户选择的值
- 更新 user.modal_id = 用户选择的值

【步骤4：用户创建活动/项目】
- 用户选择一个已绑定的模态标识
- 用户选择活动类型：口述历史、非遗记录、文档存档等
- 用户填写项目名称、描述
- 用户上传文件到云仓库
- 插入 biz_project_info 表：
  * modal_id = 模态标识的主键ID（biz_modal_identifier.modal_id）
  * modal_value = 模态标识值（冗余）
  * user_id = 用户ID
  * project_name = 项目名称
  * project_type = 活动类型（口述历史/非遗记录/文档存档等）
  * cloud_storage_url = 云仓库URL
  * project_desc = 项目描述
  * project_status = 'ONLINE'

【关联关系】
user (用户表)
  ├─ two_factor_code (冗余字段) ─────┐
  ├─ grid_code (冗余字段)            │
  └─ modal_id (冗余字段)             │
                                    ↓
biz_two_factor_code (双因子码表)    │
  ├─ two_factor_value ←─────────────┘
  ├─ user_id (关联用户)
  └─ grid_code_value (关联网格码) ─┐
                                  ↓
biz_grid_code (网格码表)            │
  ├─ grid_code_value ←─────────────┘
  └─ user_id (关联用户)
                                  
biz_modal_identifier (模态标识表)
  ├─ modal_id (主键)
  ├─ modal_value (0-99999999)
  ├─ two_factor_value (关联双因子码) ──→ biz_two_factor_code.two_factor_value
  └─ user_id (关联用户)
       │
       ↓
biz_project_info (活动/项目表)
  ├─ modal_id (关联模态标识) ──→ biz_modal_identifier.modal_id（一对一关系）
  ├─ modal_value (冗余)
  ├─ user_id (关联用户)
  ├─ project_type (活动类型：口述历史、非遗记录、文档存档等)
  └─ cloud_storage_url (云仓库地址)

【数量关系】
- 1个用户 → 1个双因子码
- 1个双因子码 → 1个网格码
- 1个双因子码 → 最多1亿个模态标识（0-99999999）
- 1个模态标识 → 1个活动/项目（唯一）

【设计特点】
1. ✅ 无物理外键，使用逻辑外键（索引 + 注释）
2. ✅ 全部逻辑删除（deleted 字段）
3. ✅ 唯一索引包含 deleted 字段
4. ✅ 数据冗余设计（user 表冗余关键字段，便于快速查询）
5. ✅ 完整的业务流程支持
6. ✅ 审计追踪（create_time, update_time, delete_time）
*/
