-- 为 biz_two_factor_code 表添加 remaining_modals 字段
-- 执行日期: 2025-12-23

USE shuangyinzi;

-- 添加剩余模态标识数量字段
ALTER TABLE biz_two_factor_code 
ADD COLUMN remaining_modals BIGINT DEFAULT 100000000 COMMENT '剩余模态标识数量（默认1亿）' AFTER status;

-- 为现有记录设置默认值
UPDATE biz_two_factor_code SET remaining_modals = 100000000 WHERE remaining_modals IS NULL;

-- 验证字段是否添加成功
DESC biz_two_factor_code;
