-- ================================================
-- 双因子码用户系统重建脚本 - 支持企业和个人两种角色
-- 创建时间: 2025-12-23
-- ================================================

/*
【业务流程说明】
1. 用户注册 → 选择企业/个人 → 填写基础信息（手机号、密码）→ 系统生成双因子码 → 保存到 biz_user、biz_enterprise/biz_personal、biz_two_factor_code
2. 用户填写详细信息 → 生成网格码 → 保存到 biz_grid_code 表 → 更新 biz_user 和 biz_two_factor_code
3. 用户绑定模态标识 → 保存到 biz_modal_identifier 表 → 更新 biz_user.modal_id
4. 用户创建项目/活动 → 保存到 biz_project_info 表
5. 用户登录 → 支持手机号/双因子码/网格码 + 密码三种方式
*/

-- ================================================
-- 1. 用户主表（企业和个人公共信息）
-- ================================================
DROP TABLE IF EXISTS `biz_user`;
CREATE TABLE `biz_user` (
  `user_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_type` VARCHAR(20) NOT NULL COMMENT '用户类型：ENTERPRISE-企业，PERSONAL-个人',
  `phone` VARCHAR(20) NOT NULL COMMENT '手机号（唯一登录凭证）',
  `password` VARCHAR(255) NOT NULL COMMENT '密码（加密存储）',
  `two_factor_code` VARCHAR(64) NOT NULL COMMENT '双因子码（注册时生成，格式：TFC-XXXXXXXX）',
  `grid_code` VARCHAR(64) DEFAULT NULL COMMENT '网格码（填写详细信息后生成）',
  `modal_id` INT DEFAULT NULL COMMENT '当前模态标识值（0-99999999）',
  `is_fillin` TINYINT NOT NULL DEFAULT 0 COMMENT '是否已填写详细信息：0-未填写，1-已填写',
  `status` VARCHAR(20) NOT NULL DEFAULT 'ACTIVE' COMMENT '账户状态：ACTIVE-正常，FROZEN-冻结，DELETED-注销',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `uk_phone` (`phone`, `deleted`) COMMENT '手机号唯一约束（含删除标记）',
  UNIQUE INDEX `uk_two_factor_code` (`two_factor_code`, `deleted`) COMMENT '双因子码唯一约束（含删除标记）',
  UNIQUE INDEX `uk_grid_code` (`grid_code`, `deleted`) COMMENT '网格码唯一约束（含删除标记）',
  INDEX `idx_user_type` (`user_type`) COMMENT '用户类型索引',
  INDEX `idx_status` (`status`) COMMENT '账户状态索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户主表-企业和个人公共信息';

-- ================================================
-- 2. 企业信息表
-- ================================================
DROP TABLE IF EXISTS `biz_enterprise`;
CREATE TABLE `biz_enterprise` (
  `enterprise_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '企业信息ID',
  `user_id` BIGINT NOT NULL COMMENT '关联用户ID（逻辑外键 → biz_user.user_id）',
  `enterprise_name` VARCHAR(200) NOT NULL COMMENT '企业名称',
  `unified_social_credit_code` VARCHAR(50) DEFAULT NULL COMMENT '统一社会信用代码（18位）',
  `business_license_url` VARCHAR(500) DEFAULT NULL COMMENT '营业执照照片URL',
  `legal_person_name` VARCHAR(50) NOT NULL COMMENT '法人姓名',
  `legal_person_id_card` VARCHAR(18) DEFAULT NULL COMMENT '法人身份证号',
  `legal_person_id_front_url` VARCHAR(500) DEFAULT NULL COMMENT '法人身份证正面照URL',
  `legal_person_id_back_url` VARCHAR(500) DEFAULT NULL COMMENT '法人身份证反面照URL',
  `contact_phone` VARCHAR(20) DEFAULT NULL COMMENT '企业联系电话',
  `contact_email` VARCHAR(100) DEFAULT NULL COMMENT '企业联系邮箱',
  `enterprise_address` VARCHAR(500) DEFAULT NULL COMMENT '企业地址',
  `business_scope` TEXT DEFAULT NULL COMMENT '经营范围',
  `registered_capital` DECIMAL(15,2) DEFAULT NULL COMMENT '注册资本（元）',
  `establishment_date` DATE DEFAULT NULL COMMENT '成立日期',
  `verification_status` VARCHAR(20) NOT NULL DEFAULT 'PENDING' COMMENT '认证状态：PENDING-待审核，APPROVED-已通过，REJECTED-已拒绝',
  `verification_time` DATETIME DEFAULT NULL COMMENT '认证时间',
  `remark` TEXT DEFAULT NULL COMMENT '备注说明',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`enterprise_id`),
  UNIQUE INDEX `uk_user_id` (`user_id`, `deleted`) COMMENT '用户ID唯一约束',
  UNIQUE INDEX `uk_credit_code` (`unified_social_credit_code`, `deleted`) COMMENT '统一社会信用代码唯一约束',
  INDEX `idx_verification_status` (`verification_status`) COMMENT '认证状态索引',
  INDEX `idx_enterprise_name` (`enterprise_name`) COMMENT '企业名称索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='企业用户详细信息表';

-- ================================================
-- 3. 个人信息表
-- ================================================
DROP TABLE IF EXISTS `biz_personal`;
CREATE TABLE `biz_personal` (
  `personal_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '个人信息ID',
  `user_id` BIGINT NOT NULL COMMENT '关联用户ID（逻辑外键 → biz_user.user_id）',
  `real_name` VARCHAR(50) NOT NULL COMMENT '真实姓名',
  `id_card` VARCHAR(18) DEFAULT NULL COMMENT '身份证号',
  `id_card_front_url` VARCHAR(500) DEFAULT NULL COMMENT '身份证正面照URL',
  `id_card_back_url` VARCHAR(500) DEFAULT NULL COMMENT '身份证反面照URL',
  `gender` VARCHAR(10) DEFAULT NULL COMMENT '性别：MALE-男，FEMALE-女，OTHER-其他',
  `birth_date` DATE DEFAULT NULL COMMENT '出生日期',
  `nationality` VARCHAR(50) DEFAULT '中国' COMMENT '国籍',
  `address` VARCHAR(500) DEFAULT NULL COMMENT '居住地址',
  `email` VARCHAR(100) DEFAULT NULL COMMENT '邮箱',
  `occupation` VARCHAR(100) DEFAULT NULL COMMENT '职业',
  `education_level` VARCHAR(50) DEFAULT NULL COMMENT '学历：HIGH_SCHOOL-高中，ASSOCIATE-专科，BACHELOR-本科，MASTER-硕士，DOCTOR-博士',
  `emergency_contact_name` VARCHAR(50) DEFAULT NULL COMMENT '紧急联系人姓名',
  `emergency_contact_phone` VARCHAR(20) DEFAULT NULL COMMENT '紧急联系人电话',
  `verification_status` VARCHAR(20) NOT NULL DEFAULT 'PENDING' COMMENT '实名认证状态：PENDING-待审核，APPROVED-已通过，REJECTED-已拒绝',
  `verification_time` DATETIME DEFAULT NULL COMMENT '认证时间',
  `remark` TEXT DEFAULT NULL COMMENT '备注说明',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`personal_id`),
  UNIQUE INDEX `uk_user_id` (`user_id`, `deleted`) COMMENT '用户ID唯一约束',
  UNIQUE INDEX `uk_id_card` (`id_card`, `deleted`) COMMENT '身份证号唯一约束',
  INDEX `idx_verification_status` (`verification_status`) COMMENT '认证状态索引',
  INDEX `idx_real_name` (`real_name`) COMMENT '真实姓名索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='个人用户详细信息表';

-- ================================================
-- 4. 双因子码表（保持不变，只更新user_id关联）
-- ================================================
DROP TABLE IF EXISTS `biz_two_factor_code`;
CREATE TABLE `biz_two_factor_code` (
  `two_factor_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '双因子码ID',
  `two_factor_value` VARCHAR(64) NOT NULL COMMENT '双因子码值（注册时生成，格式：TFC-XXXXXXXX）',
  `user_id` BIGINT NOT NULL COMMENT '关联用户ID（逻辑外键 → biz_user.user_id）',
  `grid_code_value` VARCHAR(64) DEFAULT NULL COMMENT '关联网格码值（初始为NULL，填写详细信息后绑定）',
  `code_type` VARCHAR(20) NOT NULL DEFAULT 'PERSONAL' COMMENT '码类型：ASSET-资产类、PERSONAL-个人类',
  `status` VARCHAR(20) NOT NULL DEFAULT 'ACTIVATED' COMMENT '状态：ACTIVATED-已激活、FROZEN-冻结、INVALID-失效',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`two_factor_id`),
  UNIQUE INDEX `uk_two_factor_value` (`two_factor_value`, `deleted`) COMMENT '双因子码唯一约束',
  INDEX `idx_user_id` (`user_id`) COMMENT '用户ID索引',
  INDEX `idx_grid_code_value` (`grid_code_value`) COMMENT '网格码值索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='双因子码表';

-- ================================================
-- 5. 网格码表（保持不变，添加user_id）
-- ================================================
DROP TABLE IF EXISTS `biz_grid_code`;
CREATE TABLE `biz_grid_code` (
  `grid_code_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '网格码ID',
  `grid_code_value` VARCHAR(64) NOT NULL COMMENT '网格码唯一值',
  `user_id` BIGINT NOT NULL COMMENT '关联用户ID（逻辑外键 → biz_user.user_id）',
  `status` VARCHAR(20) NOT NULL DEFAULT 'VALID' COMMENT '状态：VALID-有效、INVALID-失效',
  `hash_value` VARCHAR(255) DEFAULT NULL COMMENT '区块链存证哈希值',
  `deposit_record_id` VARCHAR(255) DEFAULT NULL COMMENT '区块链存证记录ID',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`grid_code_id`),
  UNIQUE INDEX `uk_grid_code_value` (`grid_code_value`, `deleted`) COMMENT '网格码唯一约束',
  INDEX `idx_user_id` (`user_id`) COMMENT '用户ID索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='网格码表';

-- ================================================
-- 6. 模态标识表（保持不变）
-- ================================================
DROP TABLE IF EXISTS `biz_modal_identifier`;
CREATE TABLE `biz_modal_identifier` (
  `modal_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '模态标识ID（确权最小单元）',
  `modal_value` INT NOT NULL COMMENT '模态标识值（0-99999999）',
  `two_factor_value` VARCHAR(64) NOT NULL COMMENT '关联双因子码值',
  `user_id` BIGINT NOT NULL COMMENT '关联用户ID（逻辑外键 → biz_user.user_id）',
  `identifier_type` VARCHAR(50) NOT NULL DEFAULT 'PROJECT' COMMENT '标识类型：PROJECT-项目类',
  `status` VARCHAR(20) NOT NULL DEFAULT 'VALID' COMMENT '状态：VALID-有效、INVALID-失效',
  `hash_value` VARCHAR(255) DEFAULT NULL COMMENT '区块链存证哈希值（用于验真）',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`modal_id`),
  UNIQUE INDEX `uk_user_modal_value` (`user_id`, `modal_value`, `deleted`) COMMENT '用户+模态标识唯一约束',
  INDEX `idx_two_factor_value` (`two_factor_value`) COMMENT '双因子码索引',
  INDEX `idx_modal_value` (`modal_value`) COMMENT '模态标识值索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='模态标识表';

-- ================================================
-- 7. 项目信息表（保持不变）
-- ================================================
DROP TABLE IF EXISTS `biz_project_info`;
CREATE TABLE `biz_project_info` (
  `project_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '项目唯一标识',
  `modal_id` BIGINT NOT NULL COMMENT '关联模态标识ID（逻辑外键 → biz_modal_identifier.modal_id）',
  `modal_value` INT NOT NULL COMMENT '模态标识值（冗余字段，便于查询）',
  `user_id` BIGINT NOT NULL COMMENT '关联用户ID（逻辑外键 → biz_user.user_id）',
  `project_name` VARCHAR(100) NOT NULL COMMENT '项目名称',
  `project_type` VARCHAR(50) NOT NULL COMMENT '项目类型：ORAL_HISTORY-口述历史，INTANGIBLE_HERITAGE-非遗记录，DOCUMENT_ARCHIVE-文档存档，ART_WORK-艺术作品，ACADEMIC_RESEARCH-学术研究',
  `cloud_storage_url` VARCHAR(500) DEFAULT NULL COMMENT '云仓库存储URL',
  `project_desc` TEXT DEFAULT NULL COMMENT '项目描述',
  `upload_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
  `project_status` VARCHAR(20) NOT NULL DEFAULT 'ONLINE' COMMENT '项目状态：ONLINE-上线、OFFLINE-下架',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` TINYINT NOT NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`project_id`),
  UNIQUE INDEX `uk_modal_id` (`modal_id`, `deleted`) COMMENT '模态标识ID唯一约束（一个模态标识对应一个项目）',
  INDEX `idx_user_id` (`user_id`) COMMENT '用户ID索引',
  INDEX `idx_project_type` (`project_type`) COMMENT '项目类型索引',
  INDEX `idx_project_status` (`project_status`) COMMENT '项目状态索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='项目信息表';

-- ================================================
-- 8. 用户模态标识历史表（保持不变）
-- ================================================
DROP TABLE IF EXISTS `user_modal`;
CREATE TABLE `user_modal` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `user_id` BIGINT NOT NULL COMMENT '用户ID（逻辑外键 → biz_user.user_id）',
  `modal_id` INT NOT NULL COMMENT '模态标识值（0-99999999）',
  `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  INDEX `idx_user_id` (`user_id`) COMMENT '用户ID索引',
  INDEX `idx_modal_id` (`modal_id`) COMMENT '模态标识索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户模态标识历史记录表';

-- ================================================
-- 业务流程示例数据
-- ================================================

-- 示例1：企业用户注册
INSERT INTO `biz_user` (`user_type`, `phone`, `password`, `two_factor_code`) 
VALUES ('ENTERPRISE', '13800138000', 'encrypted_password_123', 'TFC-ENT12345');

INSERT INTO `biz_enterprise` (`user_id`, `enterprise_name`, `legal_person_name`, `unified_social_credit_code`) 
VALUES (LAST_INSERT_ID(), '测试科技有限公司', '张三', '91110000MA01234567');

INSERT INTO `biz_two_factor_code` (`two_factor_value`, `user_id`, `code_type`) 
VALUES ('TFC-ENT12345', LAST_INSERT_ID(), 'ASSET');

-- 示例2：个人用户注册
INSERT INTO `biz_user` (`user_type`, `phone`, `password`, `two_factor_code`) 
VALUES ('PERSONAL', '13900139000', 'encrypted_password_456', 'TFC-PER67890');

INSERT INTO `biz_personal` (`user_id`, `real_name`, `id_card`) 
VALUES (LAST_INSERT_ID(), '李四', '110101199001011234');

INSERT INTO `biz_two_factor_code` (`two_factor_value`, `user_id`, `code_type`) 
VALUES ('TFC-PER67890', LAST_INSERT_ID(), 'PERSONAL');
