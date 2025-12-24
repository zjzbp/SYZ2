-- 初始化项目数据到 biz_project_info 表
-- 项目类型数据初始化
-- 注意：这些数据仅为系统初始化项目类型，不包含 modal_id、user_id 等绑定信息

INSERT INTO biz_project_info (project_name, project_type, project_desc, project_status, upload_time, deleted) VALUES
('口述历史记录系统', '口述历史', '记录和保存口述历史资料，传承历史文化记忆', 'ONLINE', NOW(), 0),
('福伦酒品牌溯源', '福伦酒', '福伦酒产品溯源与品牌保护系统', 'ONLINE', NOW(), 0),
('低空经济平台', '低空经济', '低空经济产业链管理与服务平台', 'ONLINE', NOW(), 0),
('在线商城系统', '在线商城', '综合电商平台，提供在线购物服务', 'ONLINE', NOW(), 0),
('讲习堂知识分享', '讲习堂', '知识分享与学习交流平台', 'ONLINE', NOW(), 0),
('大健康管理平台', '大健康', '健康数据管理与健康服务平台', 'ONLINE', NOW(), 0);
