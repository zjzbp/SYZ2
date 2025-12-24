-- 调整 biz_project_info 表字段顺序
-- 执行日期: 2025-12-23

USE shuangyinzi;

-- 步骤1: 删除现有的 byte_size 字段（如果存在）
ALTER TABLE biz_project_info DROP COLUMN IF EXISTS byte_size;

-- 步骤2: 在 project_type 字段之后重新添加 byte_size 字段
ALTER TABLE biz_project_info 
ADD COLUMN byte_size BIGINT COMMENT '字节码大小（字节）' AFTER project_type;

-- 验证字段顺序
DESC biz_project_info;
