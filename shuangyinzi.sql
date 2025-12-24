/*
 Navicat Premium Dump SQL

 Source Server         : cuco
 Source Server Type    : MySQL
 Source Server Version : 80044 (8.0.44)
 Source Host           : 192.168.1.142:3306
 Source Schema         : shuangyinzi

 Target Server Type    : MySQL
 Target Server Version : 80044 (8.0.44)
 File Encoding         : 65001

 Date: 23/12/2025 21:00:41
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '管理者姓名',
  `number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '管理者账号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '管理者密码',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '删除标记：0-未删除，1-已删除',
  `delete_time` datetime NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_deleted`(`deleted` ASC) USING BTREE COMMENT '逻辑删除索引'
) ENGINE = InnoDB AUTO_INCREMENT = 1003 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for biz_enterprise
-- ----------------------------
DROP TABLE IF EXISTS `biz_enterprise`;
CREATE TABLE `biz_enterprise`  (
  `enterprise_id` bigint NOT NULL AUTO_INCREMENT COMMENT '企业信息ID',
  `user_id` bigint NOT NULL COMMENT '关联用户ID（逻辑外键 → biz_user.user_id）',
  `enterprise_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '企业名称',
  `unified_social_credit_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '统一社会信用代码（18位）',
  `business_license_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '营业执照照片URL',
  `legal_person_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '法人姓名',
  `legal_person_id_card` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '法人身份证号',
  `legal_person_id_front_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '法人身份证正面照URL',
  `legal_person_id_back_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '法人身份证反面照URL',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '企业联系电话',
  `contact_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '企业联系邮箱',
  `enterprise_address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '企业地址',
  `business_scope` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '经营范围',
  `registered_capital` decimal(15, 2) NULL DEFAULT NULL COMMENT '注册资本（元）',
  `establishment_date` date NULL DEFAULT NULL COMMENT '成立日期',
  `verification_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'PENDING' COMMENT '认证状态：PENDING-待审核，APPROVED-已通过，REJECTED-已拒绝',
  `verification_time` datetime NULL DEFAULT NULL COMMENT '认证时间',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注说明',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`enterprise_id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id` ASC, `deleted` ASC) USING BTREE COMMENT '用户ID唯一约束',
  UNIQUE INDEX `uk_credit_code`(`unified_social_credit_code` ASC, `deleted` ASC) USING BTREE COMMENT '统一社会信用代码唯一约束',
  INDEX `idx_verification_status`(`verification_status` ASC) USING BTREE COMMENT '认证状态索引',
  INDEX `idx_enterprise_name`(`enterprise_name` ASC) USING BTREE COMMENT '企业名称索引'
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '企业用户详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for biz_grid_code
-- ----------------------------
DROP TABLE IF EXISTS `biz_grid_code`;
CREATE TABLE `biz_grid_code`  (
  `grid_code_id` bigint NOT NULL AUTO_INCREMENT COMMENT '网格码ID',
  `grid_code_value` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '网格码唯一值',
  `user_id` bigint NOT NULL COMMENT '关联用户ID（逻辑外键 → biz_user.user_id）',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'VALID' COMMENT '状态：VALID-有效、INVALID-失效',
  `hash_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区块链存证哈希值',
  `deposit_record_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区块链存证记录ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`grid_code_id`) USING BTREE,
  UNIQUE INDEX `uk_grid_code_value`(`grid_code_value` ASC, `deleted` ASC) USING BTREE COMMENT '网格码唯一约束',
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE COMMENT '用户ID索引'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '网格码表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for biz_modal_identifier
-- ----------------------------
DROP TABLE IF EXISTS `biz_modal_identifier`;
CREATE TABLE `biz_modal_identifier`  (
  `modal_id` bigint NOT NULL AUTO_INCREMENT COMMENT '模态标识ID（确权最小单元）',
  `modal_value` bigint NOT NULL COMMENT '模态标识值（0-99999999，用户选择的值）',
  `two_factor_value` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '关联双因子码值',
  `user_id` bigint NOT NULL COMMENT '关联用户ID（逻辑外键 → biz_user.user_id）',
  `identifier_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'PROJECT' COMMENT '标识类型：PROJECT-项目类',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'VALID' COMMENT '状态：VALID-有效、INVALID-失效',
  `hash_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区块链存证哈希值（用于验真）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`modal_id`) USING BTREE,
  INDEX `idx_two_factor_value`(`two_factor_value` ASC) USING BTREE COMMENT '双因子码索引',
  UNIQUE INDEX `uk_user_modal_value`(`user_id` ASC, `modal_value` ASC, `deleted` ASC) USING BTREE COMMENT '用户+模态标识唯一约束',
  INDEX `idx_modal_value`(`modal_value` ASC) USING BTREE COMMENT '模态标识值索引'
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '模态标识表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for biz_personal
-- ----------------------------
DROP TABLE IF EXISTS `biz_personal`;
CREATE TABLE `biz_personal`  (
  `personal_id` bigint NOT NULL AUTO_INCREMENT COMMENT '个人信息ID',
  `user_id` bigint NOT NULL COMMENT '关联用户ID（逻辑外键 → biz_user.user_id）',
  `real_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '真实姓名',
  `id_card` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证号',
  `id_card_front_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证正面照URL',
  `id_card_back_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证反面照URL',
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '性别：MALE-男，FEMALE-女，OTHER-其他',
  `birth_date` date NULL DEFAULT NULL COMMENT '出生日期',
  `nationality` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '中国' COMMENT '国籍',
  `address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '居住地址',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `occupation` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '职业',
  `education_level` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '学历：HIGH_SCHOOL-高中，ASSOCIATE-专科，BACHELOR-本科，MASTER-硕士，DOCTOR-博士',
  `emergency_contact_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '紧急联系人姓名',
  `emergency_contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '紧急联系人电话',
  `verification_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'PENDING' COMMENT '实名认证状态：PENDING-待审核，APPROVED-已通过，REJECTED-已拒绝',
  `verification_time` datetime NULL DEFAULT NULL COMMENT '认证时间',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注说明',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`personal_id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id` ASC, `deleted` ASC) USING BTREE COMMENT '用户ID唯一约束',
  UNIQUE INDEX `uk_id_card`(`id_card` ASC, `deleted` ASC) USING BTREE COMMENT '身份证号唯一约束',
  INDEX `idx_verification_status`(`verification_status` ASC) USING BTREE COMMENT '认证状态索引',
  INDEX `idx_real_name`(`real_name` ASC) USING BTREE COMMENT '真实姓名索引'
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '个人用户详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for biz_project_info
-- ----------------------------
DROP TABLE IF EXISTS `biz_project_info`;
CREATE TABLE `biz_project_info`  (
  `project_id` bigint NOT NULL AUTO_INCREMENT COMMENT '项目唯一标识',
  `modal_id` bigint NULL DEFAULT NULL COMMENT '关联模态标识ID（逻辑外键 -> biz_modal_identifier.modal_id，一个模态标识对应一个活动）',
  `modal_value` int NULL DEFAULT NULL COMMENT '模态标识值（冗余字段，便于查询）',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户ID（逻辑外键 -> user.id）',
  `project_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '项目名称',
  `byte_size` bigint NULL DEFAULT NULL COMMENT '字节码大小',
  `project_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '项目类型：ORAL_HISTORY-口述历史，INTANGIBLE_HERITAGE-非遗记录，DOCUMENT_ARCHIVE-文档存档，ART_WORK-艺术作品，ACADEMIC_RESEARCH-学术研究',
  `cloud_storage_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '云仓库存储URL',
  `project_desc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '项目描述',
  `upload_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
  `project_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'ONLINE' COMMENT '项目状态：ONLINE-上线、OFFLINE-下架',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`project_id`) USING BTREE,
  UNIQUE INDEX `uk_modal_id`(`modal_id` ASC, `deleted` ASC) USING BTREE COMMENT '模态标识ID唯一约束（一个模态标识对应一个项目）',
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE COMMENT '用户ID索引',
  INDEX `idx_project_type`(`project_type` ASC) USING BTREE COMMENT '项目类型索引',
  INDEX `idx_project_status`(`project_status` ASC) USING BTREE COMMENT '项目状态索引'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '项目信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for biz_two_factor_code
-- ----------------------------
DROP TABLE IF EXISTS `biz_two_factor_code`;
CREATE TABLE `biz_two_factor_code`  (
  `two_factor_id` bigint NOT NULL AUTO_INCREMENT COMMENT '双因子码ID',
  `two_factor_value` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '双因子码值（注册时生成，格式：TFC-XXXXXXXX）',
  `user_id` bigint NOT NULL COMMENT '关联用户ID（逻辑外键 → biz_user.user_id）',
  `grid_code_value` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联网格码值（初始为NULL，填写详细信息后绑定）',
  `code_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'PERSONAL' COMMENT '码类型：ASSET-资产类、PERSONAL-个人类',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'ACTIVATED' COMMENT '状态：ACTIVATED-已激活、FROZEN-冻结、INVALID-失效',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`two_factor_id`) USING BTREE,
  UNIQUE INDEX `uk_two_factor_value`(`two_factor_value` ASC, `deleted` ASC) USING BTREE COMMENT '双因子码唯一约束',
  INDEX `idx_grid_code_value`(`grid_code_value` ASC) USING BTREE COMMENT '网格码值索引',
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE COMMENT '用户ID索引'
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '双因子码表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for biz_user
-- ----------------------------
DROP TABLE IF EXISTS `biz_user`;
CREATE TABLE `biz_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户类型：ENTERPRISE-企业，PERSONAL-个人',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号（唯一登录凭证）',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码（加密存储）',
  `two_factor_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '双因子码（注册时生成，格式：TFC-XXXXXXXX）',
  `grid_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '网格码（填写详细信息后生成）',
  `modal_id` int NULL DEFAULT NULL COMMENT '当前模态标识值（0-99999999）',
  `is_fillin` tinyint NOT NULL DEFAULT 0 COMMENT '是否已填写详细信息：0-未填写，1-已填写',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'ACTIVE' COMMENT '账户状态：ACTIVE-正常，FROZEN-冻结，DELETED-注销',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `uk_phone`(`phone` ASC, `deleted` ASC) USING BTREE COMMENT '手机号唯一约束（含删除标记）',
  UNIQUE INDEX `uk_two_factor_code`(`two_factor_code` ASC, `deleted` ASC) USING BTREE COMMENT '双因子码唯一约束（含删除标记）',
  UNIQUE INDEX `uk_grid_code`(`grid_code` ASC, `deleted` ASC) USING BTREE COMMENT '网格码唯一约束（含删除标记）',
  INDEX `idx_user_type`(`user_type` ASC) USING BTREE COMMENT '用户类型索引',
  INDEX `idx_status`(`status` ASC) USING BTREE COMMENT '账户状态索引'
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户主表-企业和个人公共信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `project_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_modal
-- ----------------------------
DROP TABLE IF EXISTS `user_modal`;
CREATE TABLE `user_modal`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `user_id` bigint NOT NULL COMMENT '用户ID（逻辑外键 → biz_user.user_id）',
  `modal_id` int NOT NULL COMMENT '模态标识值（0-99999999）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE COMMENT '用户ID索引',
  INDEX `idx_modal_id`(`modal_id` ASC) USING BTREE COMMENT '模态标识索引'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户模态标识历史记录表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
