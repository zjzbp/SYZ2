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

 Date: 23/12/2025 20:13:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
-- Records of project
-- ----------------------------
INSERT INTO `project` VALUES (1, '口述历史');
INSERT INTO `project` VALUES (2, '福伦酒');
INSERT INTO `project` VALUES (3, '低空经济');
INSERT INTO `project` VALUES (4, '在线商城');
INSERT INTO `project` VALUES (5, '讲习堂');
INSERT INTO `project` VALUES (6, '大健康');

SET FOREIGN_KEY_CHECKS = 1;
