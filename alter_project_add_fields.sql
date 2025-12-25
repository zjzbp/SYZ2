-- 创建 project 表（如果不存在）
CREATE TABLE IF NOT EXISTS `project` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '项目ID',
  `project_type` VARCHAR(100) NOT NULL COMMENT '项目类型',
  `project_desc` TEXT COMMENT '项目描述',
  `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_delete` TINYINT(1) DEFAULT 0 COMMENT '是否删除 0-未删除 1-已删除',
  PRIMARY KEY (`id`),
  KEY `idx_project_type` (`project_type`),
  KEY `idx_is_delete` (`is_delete`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='项目类型表';

-- 如果表已存在但字段不存在，则添加字段（此部分在表已存在且缺少字段时执行）
-- 如果执行出错，说明字段已存在，可以忽略
