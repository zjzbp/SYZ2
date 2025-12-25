-- =============================================
-- 添加总分数和项目类别分数字段
-- =============================================

-- 1. 在 biz_user 表中添加 total_score 字段（用户总分）
ALTER TABLE `biz_user` 
ADD COLUMN `total_score` DOUBLE DEFAULT 0 COMMENT '用户总分数' AFTER `status`;

-- 2. 在 project 表中添加 score 字段（项目类别分数）
ALTER TABLE `project` 
ADD COLUMN `score` DOUBLE DEFAULT 5 COMMENT '项目类别分数' AFTER `is_delete`;

-- =============================================
-- 更新现有数据的默认分数值
-- =============================================

-- 为现有的项目类别设置默认分数（5分）
UPDATE `project` SET `score` = 5 WHERE `score` IS NULL;

-- =============================================
-- 验证字段是否添加成功
-- =============================================
-- 查看 biz_user 表结构
-- DESCRIBE biz_user;

-- 查看 project 表结构
-- DESCRIBE project;
