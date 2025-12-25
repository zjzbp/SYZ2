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

 Date: 24/12/2025 16:13:38
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
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', 'admin', 'admin123', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (3, 'Ando Miu', '8PNM4ljz6i', 'CHig8OeRy5', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (4, 'Ruby Bryant', 'QOMMiaMqu9', 'jlOSHUm1BD', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (5, 'Du Shihan', 'wmCXogAzmy', 'MlMcvvoT4c', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (6, 'Fu Anqi', 'FokJdcQgD4', 'fSfSAILCES', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (7, 'Ku Siu Wai', 'lBJ5Tzyy4Y', 'BAAdWZxVqO', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (8, 'Yin Rui', 'K0z1cVgNqI', 'ZUxv4kAj2y', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (9, 'Liu Zitao', 'THAnMMla1R', 'PtGOU9vOxC', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (10, 'Yuan Zhennan', 'N31t0MzN1h', 'ivyINH1qxo', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (11, 'Suzuki Yuito', 'u9PHbpNnT9', 'JPFg9zVoP1', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (12, 'Wu Zhiyuan', 'VjGmWiiYZB', 'FGKDsMsfqF', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (13, 'To Ling Ling', 'qFgKIFumAv', '8HdQnxFIXO', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (14, 'Kono Daisuke', '7KkBLeFFpm', '4bw7przni3', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (15, 'Abe Yuito', 'cRQqpgdAUW', 'VLy6A90V8d', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (16, 'Kaneko Sara', 'hPS7FMP33S', 'kWPadv5s0e', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (17, 'Tin Yun Fat', 'spFHNEVK7j', 'GR2dogdIWC', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (18, 'Chiang Ka Ling', 'rPa7MrMCfh', 'DerA5Nqq4l', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (19, 'Yamazaki Daisuke', 'dsjF3IpU5M', 'CCyGpxheVY', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (20, 'Zhao Zhiyuan', 'U3tWSTzIS4', 'PmrXzgn5gx', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (21, 'Kudo Momoe', '36TTMTh69Q', 'SdhCeS8pEd', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (22, 'Hasegawa Aoshi', 'bmideD1znC', 'JpJrc5Mgsm', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (23, 'Chung Lai Yan', 'auixubHGDe', '1fd1Hxo0PO', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (24, 'Louis Vasquez', '6KWQynjrZh', 'A9peMY4dA1', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (25, 'Jiang Lu', 'RKQOIsD9zl', 'TARcjrklNH', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (26, 'Cao Shihan', 'MNtIUScZPR', 'EDSBzpcBPl', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (27, 'Han Xiaoming', 'UdpJ7124ie', 'gyAYwTCYlu', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (28, 'Deng Lu', 'YBCceNbVj2', 'u0IFyBgg4T', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (29, 'Miu Kwok Ming', '1gFPJU4FIu', 'tw9BeR2OJH', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (30, 'Matsui Ayano', 'uGKtRDWdW2', '5aIWnwysJW', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (31, 'Kyle Butler', 'HEcrNgGfW8', 'XidDf7isjD', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (32, 'Zhong Ziyi', 'gsIRnywBj3', '4XD40OyMH8', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (33, 'Maruyama Ren', 'SZwq1XWlZy', '49OSIa1GtE', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (34, 'Danielle Bennett', 'WvxZNwwZBK', 'gKe5mg5GtZ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (35, 'Yung Kwok Wing', 'tkQ714pICy', 'Fufw8zZbkq', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (36, 'Morita Hina', 'o3L3KFW3Cv', 'Ceg8ZZWSOU', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (37, 'Matsui Itsuki', 'VWMTgQiMwX', 'knTLOIwi3v', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (38, 'Sakamoto Kasumi', 'stdVtZQEQs', 'qMXtIgrb4g', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (39, 'Nathan Patel', 'J6ZkzORbEM', 'RlVFxs8oPm', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (40, 'Kono Mai', 'nr3n0tYW8b', '3xT1jdev9V', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (41, 'Shawn Parker', 'nwrH1DCkNC', 'VSFiA98e2r', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (42, 'Shirley Hernandez', 'WUmg6mPm3B', 'myU7aQQo14', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (43, 'Yamada Rena', 'tE0J2EtrAV', 'csoDsDAlZw', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (44, 'Lok Sai Wing', 'flNCzGoMuV', 'TDMB8SFX0C', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (45, 'Siu Sau Man', 'l7n9xTMMkl', 'P9LoR20HE9', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (46, 'Kao Chi Ming', 'IyNyqTM8IB', '0x9yite81q', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (47, 'Sun Jiehong', 'f8tL7X8pFa', '6vO80DD4m3', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (48, 'Takahashi Hana', 'bCVfRAyFPt', 'vNMX3qcrIb', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (49, 'Rodney Watson', 'v4TJHIWc5Q', 'cKSchNyiF4', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (50, 'Heung Chi Yuen', 'Q3NPhDjyZc', 'UysPcvFTuS', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (51, 'Louis Alvarez', 'ZaSANtp1Wx', '4W2ZhqkmsY', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (52, 'Sylvia Sullivan', 'AFxzdxqWY9', 'KdcgT22HCs', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (53, 'Leroy Gonzalez', 'U504aDv2Xx', 'cqKAzkq40l', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (54, 'Mao Yuning', 'kGdSSMMb9l', 'SQ4PgmiV4D', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (55, 'Aoki Ikki', 'rQhAJ1gthN', '17d9xfesNz', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (56, 'Joyce Jenkins', 'hP7DxClCtI', 'pBbnbAM2iF', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (57, 'Ruby Scott', '0q40lA9usN', 'U1JKchhQQY', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (58, 'Rose Owens', '9HGN7hii3e', 'kjchZ7DWAy', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (59, 'Cheng Xiaoming', 'E6cuZZYjfo', 'XlZZnr8Up2', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (60, 'Fukuda Itsuki', 'f77HroRUh7', 'fzK7aHowj9', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (61, 'Louise Smith', 'LOFy22JgmS', 'CSB7gB9WMF', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (62, 'Wu Hok Yau', 'GKfj15kvoT', 'lcVA4NOJc2', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (63, 'Yoshida Ren', 'q7MikQTVEZ', 'BpcOsCqSSD', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (64, 'Sylvia Harrison', 'EnP8ug3eMf', 'VqEFjQbDxp', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (65, 'Fong On Kay', 'NToDdgLsio', 'uITw1sMrpK', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (66, 'Iwasaki Tsubasa', 'AgoUGrZ0B6', 're8K1YpH0Y', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (67, 'Zhong Xiuying', '8NhKpwnZUL', 'X6fU8yxAT2', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (68, 'Harada Yuito', 'F3rVcJ0sHC', 'JXm2GauwAX', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (69, 'Lu Zhennan', 'daUCgNawg7', '3iYr78HJGE', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (70, 'Abe Kazuma', 'cbw8Req8do', 'NafrBRQEm5', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (71, 'Donald West', 'b8rjPTTqEB', 'mpS2lcoGFV', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (72, 'Francisco Wood', 'MLNb81lFF2', 'cBl8HMp78J', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (73, 'Wong Tin Wing', 'ORVdh2WXeI', 'ZHiC5bQOq2', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (74, 'Louis Henderson', 'W2nGsbfgwr', 'u6c7aAZTBc', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (75, 'Tang Chi Ming', 'JDMZWzVp8R', 'NthIEsZ8ik', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (76, 'Kam Wai Man', 'pbVFQLGjDN', 'euUew9FdQh', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (77, 'Earl White', '54gBWe8f26', 'QRjR4ZPGKK', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (78, 'Pan Jialun', 'PsZm9X3QBm', 'wxtlhO0wZD', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (79, 'Elizabeth Reynolds', 'tR8EvkKt1V', '6BTofpAJlj', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (80, 'Sato Eita', 'iel7Hku216', '9oI431TRh3', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (81, 'Sit Ming', 'CzUdSaPbOR', 'NF3pZ3qEr1', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (82, 'Yu Jiehong', 'ZVLx4OEgV1', 'PuWDAoVpqL', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (83, 'Martha Turner', '7YYOxHEN8r', 'q4EwnXTXkC', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (84, 'Lai Sai Wing', 'ioBIc2VmPl', 'QeOAQk8wnS', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (85, 'Zeng Yuning', 'Jue3Yqi05w', 'wnvX53Ubmi', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (86, 'Kim White', 'Vmhdt4rwrr', 'F5M36FXOm8', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (87, 'Nakamori Yuito', 'DsN64BAPsO', '158Eg0TBTm', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (88, 'Cheung Ka Fai', 'pOKXbns2IZ', 'U9KiupkC5Y', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (89, 'Gu Yunxi', 'YZ4gFv8dkm', '6nkDZFkcZr', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (90, 'Rosa Simmons', '9tWC8OSSPZ', 'lqcmdQNQuW', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (91, 'Nomura Eita', 'I17L9nuy5o', 'A4US5HcDsg', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (92, 'Koo Sau Man', 'kTHBCeotMr', 'VCVOv6YddP', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (93, 'Feng Ziyi', 'x3GBlBvuOY', 'f1Guo6gHd9', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (94, 'Miu Fu Shing', 'y7gVkJCEtB', 'Rz9bvjcz4C', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (95, 'Li Shihan', 'vjm9wOLJSZ', 'mHfIjrUbUL', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (96, 'Miu Chun Yu', 'zdJyMMHthe', 'UfB1wRrEjz', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (97, 'Heung Sai Wing', 'lCNyVsjram', 'dGh3LVM8zD', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (98, 'Kobayashi Hikari', 'NpWT3y6W1G', '9gZiSuvL0r', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (99, 'Fujiwara Kenta', 'vioEFgmOee', 'kJnA6yyvVN', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (100, 'Choi Tak Wah', 'kkMaYBja0T', 'khnnannAVp', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (101, 'Takahashi Miu', 'Q9sCBcidKC', 'AqDeSQ1dnJ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (102, 'Zhao Zhennan', 'oIpUeqSUQI', 'oTCK0w79Ug', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (103, 'Xia Jialun', 'LrlbJYV9zV', 'WAvLjqgkQO', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (104, 'Fan Lu', 'GNzY8S3lj7', 'ixbF7tUVtU', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (105, 'Jiang Xiaoming', 'iUMLgdqbem', 'z6xaBUW1wB', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (106, 'Pang Tsz Ching', 'HZ54khVT6f', 'vUzLlnXetU', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (107, 'Rita Owens', 'KDyaChBpNr', 'u1xJTX7YNc', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (108, 'Debbie Gordon', 'PdMU0OmQQ2', 'Xa2kPMNLKk', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (109, 'Curtis Garcia', 'nPBO0DpA2k', 'HtnQbHdCAJ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (110, 'Kimura Takuya', 'L5wgftvMNq', 'XoVUBYq4Xf', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (111, 'Xue Rui', '1L8HBnpFlb', 't5vu4HE4Ga', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (112, 'Jia Ziyi', '1diUAPiyio', 'yLOhvdfRcJ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (113, 'Lu Shihan', 'jesZ6k5KPB', 'npDGPjoJ2V', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (114, 'Kam Tsz Hin', 'nD7IkOxYyv', 'dfMxAGfP3w', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (115, 'Takada Momoka', 'w0NISQopuK', '5A9RVIJTiC', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (116, 'Hung Ka Fai', 'cy9KCpSSW7', 'Els0L7P3in', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (117, 'Tang Yuning', 'yEFldNUWo2', 'loK0qrzLAX', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (118, 'Xu Xiaoming', 'Bb6LZ5CkiR', 'dUT36a8G15', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (119, 'Xie Lan', '3tKPboJNDk', 'jJURl7qn9x', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (120, 'Takeuchi Rin', 'JOrzsadmyO', 'WISgCJCbVx', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (121, 'Kondo Yuna', '0fpWGQX3Kh', 'mvZ4GUJXVM', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (122, 'Hsuan Wing Sze', 'TNR3aW25Ug', '6eE0sSEEWR', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (123, 'Long Ziyi', 'FoAyNPYh6Q', 'JGuwlNFjGr', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (124, 'Shen Xiaoming', 'tKSAefrDcZ', 'K1Mm5CcziM', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (125, 'Zheng Zhennan', 'i2iljP38cf', 'qzUOymlES3', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (126, 'Jane Palmer', 'oecRGiSWEu', 'pODua6EUhS', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (127, 'Alice Green', 'dhPUR9VO5E', 'UkLT5qDhlb', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (128, 'Zhong Yuning', '4yJdEph9aT', '7A1NMapnNX', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (129, 'Ando Sakura', 'CvkydueUp3', 'yMBhMKat93', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (130, 'Fred Simpson', 'v9K7X2ryvQ', 'QvoT6e4Kmp', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (131, 'Daniel Martin', 'RkldHzj1le', '08yW10pIhs', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (132, 'Fujiwara Hikaru', 'dc7cXEJfqV', 'x5vEHAtzyY', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (133, 'Mao Jialun', 'rwKzHUMkh0', '361xQTk45D', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (134, 'Suzuki Hana', 'z8YDq2NnB3', 'hWB8CSGaSx', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (135, 'Kaneko Yuto', 'CpggXtEsoC', 'bLyknwzo05', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (136, 'Pak Ka Keung', 'UdSqnSfi1L', '0Ni0TD0IQ4', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (137, 'Okamoto Ryota', 'hpo4C0gaHk', '0WBZHmrrDJ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (138, 'Yeow Wing Sze', 'nj9xjawLrb', 'TLNllaPqev', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (139, 'Nicholas Reyes', 'fMZ0OYktYw', 'zVlLYFR0VZ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (140, 'Kono Ikki', 'o3Bxw2GLiS', 'aCfxgWAUWa', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (141, 'Murata Ayano', 'lWF187HPwV', 'oUIRsW3iP5', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (142, 'Jesse West', 'Rx2anw92OV', 'sXkgawDXGA', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (143, 'Pan Anqi', '8Dl7bp8u6l', 'ZF3h8HAFHJ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (144, 'Li Xiaoming', 'sdBv0qBpY1', 'k14K7X2VTg', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (145, 'George Murphy', 'fJ75g3T7HL', 'pRCFigg0Fy', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (146, 'Tin Ka Fai', 'wO6GOsZzGn', 'UTkpYLqfvf', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (147, 'Manuel Henry', 'NJA8zYQXj9', 'unKmHGMpPY', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (148, 'Koo Hui Mei', 'qih0yNYRTS', 'vF6ed6MSfo', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (149, 'Zhu Zhiyuan', 'mM1zNVUkNX', 'MF9Zf8g1Of', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (150, 'Michael Ward', 'BnZSfqESPJ', 'qGN4hwT2AF', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (151, 'Carol Hamilton', 'G1tbZZdYpz', 'p2x8ymwexZ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (152, 'Wong Chi Yuen', 'X3JxNiYQbL', 'bSTcXt0VVc', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (153, 'Mak Suk Yee', '0kILjNjxYp', '3ODXhxVOug', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (154, 'Yokoyama Kazuma', 'uUGH03rB07', 'Id07KyyEmh', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (155, 'Lui Cho Yee', 'tMvkFI2SIT', 'cflDHRObLU', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (156, 'Siu Fu Shing', 'TqetYOJiDs', 'JvLFK0e6jR', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (157, 'Matsui Minato', 'jmRG5wO13T', 'uVFOCQc6p7', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (158, 'Fan Chi Yuen', 'qeiAlAmK4m', 'VwD6452FB0', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (159, 'Lok Siu Wai', 'P5Tv4rtv5Y', 'gDhD0YJvo0', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (160, 'Henry Morgan', 'LjTCdd9c9d', 'SpT8vA3G4n', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (161, 'Ethel Kelly', 'SOopS0w17U', 'HPUmVeWXoZ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (162, 'Yin Xiaoming', 'IzYAncLQnO', 'H5VQPHEtJZ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (163, 'Sakai Yuito', 'JLrXNz8NU0', 'feEZMcsh4H', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (164, 'Dennis Simmons', 'SuBopie3i9', '00YZAIwZL1', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (165, 'Hasegawa Minato', '3s3KtHHpEB', 'rRe7va0i02', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (166, 'Howard Owens', 'Jb2iFUeTcA', 'buezmWxfMk', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (167, 'Jonathan Hayes', 'Aeb5PT0LgB', 'j2wSVBFclX', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (168, 'Jin Xiaoming', 'HueexB1dpf', '6vpGx3vBPH', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (169, 'Jia Zitao', 'ATblRIrORp', 'FOgWjNHbl0', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (170, 'Matsumoto Mai', 'yLXPrl8sGN', 'NPLVUznAnW', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (171, 'Ethel Flores', 'DZHFm9whE5', 'jsBepGPa9N', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (172, 'Ishida Daichi', '2JMkSd44Vw', 'q7bW0HBuTK', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (173, 'Lok Chung Yin', 'gWlRTfmwo2', 'FOXWX6fl40', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (174, 'Aoki Momoka', 'TJzbsoxh9A', 'tKFov5jnqx', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (175, 'Rhonda Alexander', 'GRCUlFZe4K', 'bLofXNzYHh', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (176, 'Edward Woods', 'Fcf9ijshHa', 'S5U7NlvZbZ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (177, 'Fong Ka Ling', '2G45xxbELF', 'gs2lbpKdat', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (178, 'Glenn Evans', 'ixUxeTVPMe', 'cz6x81OgAN', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (179, 'Mo Sze Yu', 'orDFFCaPd3', 'UvrUxfdmx6', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (180, 'Ethel Grant', 'SIEqtOl6eR', 'LnPAyGLEWk', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (181, 'Ho Wai Lam', 'WkHCWqaJ5x', 'zJRFGGbItC', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (182, 'Chang Xiuying', 'xospIbzKDH', 'EDyUQYVXEd', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (183, 'Sato Sara', 'EnlSghtaQJ', 'OYa3HWb3Kr', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (184, 'Barbara Watson', '3MzXpaDOkv', 'YGOyVlkTIB', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (185, 'Nakayama Kaito', '4mF2ZIBLGd', '4G5ASoBo85', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (186, 'Yao Zhennan', 'q9ugHGECpx', 'X8783YhUen', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (187, 'Lam Chun Yu', '40o2dtkLEM', 'msQgSmzy9u', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (188, 'Kong Sum Wing', 'VSBcdCM1PE', 'E77ahhoWPO', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (189, 'Karen Morgan', 'rJUwfY8g0T', '27ofQcC7cO', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (190, 'Cheng Lu', 'Ktn6hqcO2P', 'bMjvaHalaZ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (191, 'Sheh On Na', 'nPVtKz2Vsl', 'wm4HlwVlRI', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (192, 'Mao Lu', 'UFXFw7FyIC', '4CHrbP1QY9', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (193, 'Tracy Peterson', 'UhIFt1da8T', 'dyxLjuJ9iB', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (194, 'Yamazaki Eita', 'MwJcqhe2Is', 'tTBqZ625np', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (195, 'Wei Jialun', 't1KfIbKyXa', 'BXRCcKU3pl', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (196, 'Wada Kenta', '4EbN2x3g8W', 'KfB1YyN1ZP', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (197, 'Yuen Chung Yin', 'jqpoYAZADX', 'XHz90aOQwG', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (198, 'Philip Kelly', 'cbmXCklii1', '8I832JMD3x', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (199, 'Fujita Eita', 'JKvyKVe19z', 'EJVW4Xh2eG', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (200, 'Wan Kwok Kuen', 't7Hf4qwhLM', '4S1tbnncQJ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (201, 'Tong Wing Suen', 'nTM6fF9jyR', '0Bf2DzqqOo', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (202, 'Okada Aoi', '26jOOxp0fn', 'QftbyluLP3', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (203, 'Walter Cole', 'iMdGrJYYtB', 'vkqQbsiVMG', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (204, 'Matsui Momoe', 'DpUcf1OEiZ', 'gOQDb0mH1G', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (205, 'Fan Ziyi', 'hqBK1QEhTU', 'X2lMvQLmVp', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (206, 'Lau Fu Shing', 'xEnqGuBzaY', 'U6mg2hHOOf', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (207, 'Gong Lu', '7yDFe6T7EA', 'F2Feo44SZn', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (208, 'Kathleen Robinson', 'bCRi9tmfWz', 'P493yXyNj8', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (209, 'Tsang Suk Yee', '5Pydzue2Wd', 'pDqh5xd5n1', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (210, 'Jeff Kelley', 'NOtAsiE3x4', 'reOMqzCZpI', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (211, 'Fong Ho Yin', '2VM1iMYFPP', 'KMaJNSAbkQ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (212, 'Shimizu Akina', 'ViZ51WmcsT', '729u8zPHkh', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (213, 'Jacob Hayes', 'vGvzsX65tx', '5asZDikGM0', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (214, 'Takagi Hikaru', 'XkFsgCLT7S', 'xZOlfuhbqC', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (215, 'Fujita Aoshi', '8OMmkaoQgO', 'wQiiKatA5B', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (216, 'Li Lan', 'H7ZhT9Phtg', 'QmGU4E8D8J', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (217, 'Zeng Zhiyuan', 'YzAf7PLRDx', 'gjw27yU05I', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (218, 'Inoue Kenta', 'KwqVZ480Bo', 'hjnP0UZsIQ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (219, 'Howard Wood', '5WjMthIHhm', 'P13huFZZoD', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (220, 'Cai Ziyi', 'hTBlteU5rO', 'gi1P97i6l7', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (221, 'Tao Ming Sze', '0I8VuN4UaV', 'znHQNECnmU', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (222, 'Dai Chung Yin', 'pVrLWQD6aJ', 'VXgQzRI5w9', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (223, 'Manuel Cox', 'cmrTEm5Vrv', 'TysVNoHsSl', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (224, 'Du Zitao', '0has1pI3Ah', 'iS8Ghqwh8z', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (225, 'Marcus Nguyen', 'ROrG8wpHQu', 'i01J7PzCDG', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (226, 'Qiu Zhiyuan', '0Xuz9BpYr8', '634gxWMM6W', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (227, 'Wu Zhiyuan', 'BKDmyRzpaY', '2kNLuSejPl', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (228, 'Zeng Lu', 'XUOroCtRdY', '6lyMKpoIou', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (229, 'Kenneth Ryan', 'oHwB5WXbkt', 'Iqg9hQEOHy', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (230, 'Zhong Anqi', 'DatyGGfnHT', 'gtzGvF9IwS', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (231, 'Nakano Yuna', '7bDIelypv1', 'plKsmuAfy9', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (232, 'Che Siu Wai', 'ynjZfSocf5', 'FKEDw0ESiW', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (233, 'Gao Ziyi', '47QIdTebMj', 'iCdS0lDvKs', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (234, 'Zeng Shihan', 'Hu0ul1PlHP', 'ShIHvHKdj4', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (235, 'Nakamura Mitsuki', 'Q4DnAQFkev', 'e0hcgofoQ8', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (236, 'Yin Sau Man', 'FivA20w23d', 'uMst9EnZRl', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (237, 'Chung Sum Wing', 'lUQfjAaT3R', 'BjY4rc1H3j', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (238, 'Su Xiaoming', 'pNSVFfjPqh', 'lg9sIRDGUV', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (239, 'Ono Ryota', 'sMYaGLJxGF', '3TmNSBi4nu', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (240, 'Nishimura Yuto', 'MH5VYdTQAT', 'RiEQC5bfzI', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (241, 'Tong Ming', 'KozUU0gRO3', 'FemHMIGiBI', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (242, 'Wong Sze Kwan', 'rmhPZwHzQa', 'rL57sXu1P3', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (243, 'Zhong Yunxi', 'ChU39XLAbA', '7Vkb6HrDMw', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (244, 'Sugawara Riku', 'PsENeZDInJ', 'ac4XiiUXwk', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (245, 'Tin Ming', 'EGQYXjkB2P', 'KxboftPQ7i', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (246, 'Goto Ren', 'VwUxLg5IUt', 'S2NcMROdwn', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (247, 'Ueno Misaki', 'ueot622K15', 'Ze67MlSjyf', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (248, 'Crystal Bennett', 'j4pxmfx7pn', 'S86rLvFLv7', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (249, 'Lok Lik Sun', 'nybBu4moLT', 'TtEiFpX3CE', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (250, 'Xue Lan', 'mHMGsbFqme', 'OWE0Vll9T9', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (251, 'Yau Kwok Ming', 'aRsyLstXcw', 'OFgeN4cPQ2', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (252, 'Tao Shihan', 'FI1WMIkdoR', '48Nrz6V6db', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (253, 'Zou Anqi', 'sEhqNpzB0b', 'BaGCoRvIST', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (254, 'Lin Lan', 'ndcQzEc60m', 'r3dsx5lgo0', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (255, 'Heung Wai Han', 'PA86p2EO2U', '6FhW0u0RNU', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (256, 'Liu Zhennan', 'fXe1tzRjHM', 'iCCpV0ueBC', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (257, 'Paul Dixon', '5F7orj0DSU', 'UwyKC3Oelo', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (258, 'Nomura Mio', 'J9boMyGndw', 'oh6SvXBM6R', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (259, 'Sheh Hok Yau', '801JLaiKcx', 'yINugT8YE7', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (260, 'Che Sum Wing', 'jt93zUVxlw', 'dtj0ticsmV', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (261, 'Lucille Tucker', 'y3ePGcspEG', 'BGcHN6xsWr', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (262, 'Hsuan Kwok Wing', '9tMOpFKdUv', '1mumX2ZeDO', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (263, 'Valerie Woods', 'IWlAccOI3J', 'KanAqSNzPv', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (264, 'Nomura Sara', 'MmqHUTfwzY', 'lMzM9Jj0gr', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (265, 'Ricky Hernandez', 'gx1tmqMqbS', 'SQa3XRYUYH', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (266, 'Pan Ziyi', 'SSMIePbiTi', 'pfqiIWpplG', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (267, 'Ichikawa Mio', 'Ijc2i5He1U', 'guMBXI4oLv', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (268, 'Jacob Tran', 'WyRX6BdwBO', '3NQi1oxP6z', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (269, 'Loui Kar Yan', 'okBUki2ydW', '7ojT7hMWVh', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (270, 'Chiba Daisuke', 'Fh4jMpzx6N', 'lPa1eRM3FU', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (271, 'Martin Wilson', 'mGmEg3E7yP', 'DMg08tQKiW', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (272, 'Irene Tucker', '53IGvq7sIT', 'Ffqrd1XyIk', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (273, 'Ueda Ikki', '8DYM2xv7rp', '3Ws4oSu1Mi', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (274, 'Matsuda Hazuki', 'iBkU2YbosX', 'l3N7RW784m', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (275, 'Miu On Na', 'cw7oqk1KKJ', 'OoO4aXuJlz', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (276, 'Kinoshita Aoshi', '87tdogsQNl', 'ClbZY5UUND', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (277, 'So Yu Ling', 'AeUrgsrlHJ', 'ptpsCNdjPp', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (278, 'Mui Ting Fung', 'DZSImaprhB', 'VR8EEf7Bu8', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (279, 'Fujii Aoshi', '80BYbUhMBM', '7LIxPkva9n', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (280, 'Gary Ross', '2itjNUTtZE', 'ofGPr1FFEz', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (281, 'Yamamoto Yuito', 'D22YCWetRu', 'WXLR9HzaRX', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (282, 'Tian Jiehong', 'IXYrsRPl3S', 'FSxmUc9lOi', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (283, 'Aoki Hana', 'Gcmc6gEcdN', 'WmCd6yi3Ee', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (284, 'Kong Zhennan', 'MC9oCh0ms6', 'MzyFb5MipX', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (285, 'Okamoto Ayano', '9eqyMNkQ7L', 'FpxglwuXhv', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (286, 'Joanne Payne', 'fZRcY3C5Lq', 'WSvp2eckQj', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (287, 'Chung Wai Man', 'rcyz5aWEXa', 'MJHdajoQgZ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (288, 'Harada Ikki', '6Hk7gUNdoz', 'TjFX6CpbtZ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (289, 'Yuen Chi Yuen', 'fr3WDMwYRf', 'duKvYNBvYR', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (290, 'Yu Yuning', 'FD1VlDOAbZ', 'J7egwzFHLr', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (291, 'Yung Ka Fai', '12fzqoe0Xu', 'SQ5RMlSQoO', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (292, 'Jessica Alvarez', 'MSSTEOMsF6', 'dqkdGpk9xv', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (293, 'Xu Rui', 'YlQpGdyYjs', 'rP8DcepuAL', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (294, 'Wang Xiaoming', 'XeWxYxcvIs', 'm1zlKhjAZX', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (295, 'Fujita Mai', 'EXhBQa1wsv', 'b0Ca1pvIRh', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (296, 'Susan Freeman', 'Zmmw0d3UOz', '1DMw2Wuwx8', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (297, 'Cheryl Kennedy', 'AGapnSshMH', 'PsNUgXkWSi', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (298, 'Yamamoto Daichi', '3FT4NZuCQF', 'UQuBCPK8kg', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (299, 'Sakai Ayano', '1BCgamx3aj', 'R9iKSx8wzK', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (300, 'Julia Wright', '2963RLVk0M', 'CEUAIqWdQN', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (301, 'James Garcia', '0YZlzbOvuH', 'bI0VUfRKUu', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (302, 'Victoria Stone', '7Z4I3cWmR5', 'DudJhtDE6p', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (303, 'Endo Sara', 'zGXrIzNGa5', '52SRZcbxor', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (304, 'Sun Zitao', 'WIhpZsVABG', 'ch0J3U4Irr', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (305, 'John Castillo', 'mS90tACNHT', '8vdPvV5aNT', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (306, 'Cai Jialun', 'uITVsojqHY', 'dvloxZDd6i', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (307, 'Fung Ming Sze', 'wgeYEDwpgx', 'dzKb7MJKc4', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (308, 'Zhao Lan', '859iRdTNHT', 'egz49O9VlN', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (309, 'Donald Smith', '05RpOryqlW', 'Fi35z3ubwe', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (310, 'Elaine Gibson', '861X6C3UPT', 'd24TJxtcpD', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (311, 'Murata Kasumi', 'JD3bpSqWbs', 'kqdWp4EM14', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (312, 'Shi Zhennan', 'en1SRVm6ha', '53gEKqapzr', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (313, 'Shi Shihan', '1I9RNT5wVX', 'OAQirMxLV8', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (314, 'Hui Hui Mei', 'bz92LOwSGd', 'lix1QVfYIA', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (315, 'Man Sum Wing', 'rGMpMRKR1A', 'l4pdOITMoM', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (316, 'Thelma Mills', 'oK2ySlnwWO', 'l48vy6Pkne', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (317, 'Cheung Chieh Lun', 'NTU0A9KhKW', 'VhcqVR5xzk', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (318, 'Kato Ayato', 'vS2fqxGcoC', 'vzp8rnbOxy', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (319, 'Qian Jialun', 'ROo5ZR2HVp', 'MuCuv0CV6L', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (320, 'Jiang Lu', 'Cx2WZnxTxa', 'CJOwHidBfJ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (321, 'Zheng Jiehong', 'lerulUgnHB', 'LJ9brp8L9T', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (322, 'Yin Anqi', 'YkOLtEwlCB', 'u71HfTcWrx', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (323, 'Yamada Kaito', 'VMOAxGlWq4', 'GZtxxdR5s4', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (324, 'Kojima Kasumi', '1366NRbOd3', 'OveGS2Kykb', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (325, 'Nakamura Yuto', 'fc0GGyOXlf', 'QPAYA8FRsl', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (326, 'Fujiwara Kazuma', 'NLReCZ91zb', 'VzjFIkWJ8p', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (327, 'Nakayama Hazuki', '3dT2ZySDam', 'zuXVY2KWZD', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (328, 'Zou Shihan', 'sK52FfopIt', 'xTb1NiBK4R', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (329, 'Miu Chieh Lun', 'GyfNrs7Y3r', 'tCW5t9c9hd', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (330, 'Cai Ziyi', 'meGOKoX4O4', 'b8NlLibcFv', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (331, 'Lam Chieh Lun', 'HZeLPtJsBw', 'JErVYmVVre', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (332, 'Stanley Hunter', 'zgC9Wn2xAZ', '75NpGDbY94', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (333, 'Loui Kwok Kuen', 'DNM3AjiwKR', 'JcWq4CdOj0', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (334, 'Zhou Anqi', 'sGqhaXlfVo', 'FIVpg87bol', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (335, 'Ito Yota', '0xS2pL0Bhv', 'rCRKss2EAo', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (336, 'Wu Chung Yin', 'ieCmeOWCvi', 'H8pZoFH8is', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (337, 'Margaret Tucker', 'UK9CLG8uIS', '8bi6LqY8Jp', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (338, 'Mo Wing Suen', '4d1BSM2xCO', 'Qsd2WYrW4U', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (339, 'Wu Sze Kwan', 'W5ZSdzidKF', 'PedaVLF1bX', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (340, 'Pan Shihan', 'v6mLdkcPjT', 'LWAfXn8WIr', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (341, 'Morita Miu', '6TjdDOV6QT', 'Hx132gEK4w', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (342, 'Yokoyama Nanami', 'sELMqzNtqR', 'YEtWzkvf3Y', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (343, 'Kimura Riku', 'YrayXVF1bC', 'G4OZqKo01R', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (344, 'Takeda Hina', 'lCCqSXsjcQ', 'xCSohnSrb0', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (345, 'Dong Anqi', 'NnUErN2Q13', 'ljP6AQxq1V', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (346, 'Wan Cho Yee', 'J9a38EKI9a', 'mVmWbcV7aj', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (347, 'Meng Xiaoming', 'dcx5KrUJhl', 'GQOSp3rBX6', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (348, 'Song Lan', '6hAJM3dD50', '4UifAznmjK', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (349, 'Yeung Ling Ling', 'BmDb8t1Sp6', 'RzDKbEnp7c', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (350, 'Timothy Taylor', 'QOsAcwmTQ0', 'VxGjwi0KIi', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (351, 'Paul Carter', 'rwafMPVAmU', '0AsTRCgKuH', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (352, 'Che Tsz Hin', 'hVMJd8DZVA', 'NdwTRQ3Jzw', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (353, 'Steve Mendoza', 'SifcxnKakJ', 'no6tbr4MDr', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (354, 'Lok Ka Man', 'CI2SEMy7Hc', 'vlg7bpZwyu', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (355, 'Glenn Adams', 'RV2QHkWhFQ', '4mk7kLI5Hw', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (356, 'Fan Yuning', '3whcKaJQ5h', 'JhSxjDNBhR', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (357, 'Joshua Aguilar', '1cnXZMK9Sf', '9IZAvLT5gN', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (358, 'Karen Barnes', 'M9d53Ajrv1', 'PaT75y4L5V', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (359, 'Paula Williams', 'WC2qi4TOB3', 'YCQa0rQ9KJ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (360, 'Hsuan Tsz Ching', 'G4XToYP0ts', 'kTGPZsnEo8', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (361, 'Siu Wai San', 'nZ489H0WgN', 'NdqndX73lf', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (362, 'Kyle Patel', 'VmXhd51SBr', 'xrNpjAzxlB', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (363, 'Melvin Peterson', 'vFDbRWBW9b', 'aRP5bNQTY1', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (364, 'Yin Wing Suen', 'zsOf23JHq1', 'C9ELNiRMpO', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (365, 'Shimizu Yuito', 'HGPx3nGxzY', 'qOt4V75pLD', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (366, 'Christina Hunter', 'G1FEZ4huY8', 'VegAWLwrS4', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (367, 'Han Cho Yee', 'IQeM95FOtH', 'wbxeXASI2N', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (368, 'Todd Kim', 'S4G2mTTtVQ', 'qrcX7k91kD', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (369, 'Ryan Taylor', 'FApByaDXW3', '383UztGXXf', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (370, 'Shawn Garza', 'IHA2FHrWwa', '75FV1vde9i', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (371, 'Hsuan Wing Fat', '5nqDUMdtvf', '4OEKpooT33', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (372, 'Pak Wing Sze', 'z5T9klXbNr', 'KZxfSwX6Bp', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (373, 'Iwasaki Rena', 'Odt3qsMobF', 'jFK9W0lhFR', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (374, 'Brenda Walker', 'idvo2RBdeQ', 'K6fj8jwexg', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (375, 'Luo Zhennan', '0hojYuZZUr', 'T9l9WZthlQ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (376, 'Shimada Hikari', 'uFUYppwIaw', 'T2udPPtJdO', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (377, 'Barry Howard', 'bPGQua1vsH', 'KbLu77vhNh', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (378, 'Xu Yuning', 'Fzg1vlkiEP', 'inOUDEh4hI', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (379, 'Sheh Chi Yuen', 'UNeBqFqAYn', 'QGkqAIh3GY', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (380, 'Grace Ward', 'YpAq27XOqF', 'MITmUjaJfa', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (381, 'Angela Ross', 'ipY7PNiYFQ', 'FVjpafpetg', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (382, 'Fong Tak Wah', 'AHeWYcuXYP', 'H5cmC2GBFv', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (383, 'Kao Ting Fung', 'fTlO4epodt', 'ThDRIEa2YW', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (384, 'Goto Kenta', 'hC2ZkSrqpL', 'uYscKDVFUw', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (385, 'Sherry Rodriguez', 'XjW4BL8gMI', 'vpK3RDbmyT', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (386, 'Clarence Jenkins', 'kfvn0dSi9e', 'UTbjljFLlc', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (387, 'Luis Coleman', 'gYxDPC7zmL', 'MvsCpXfR5S', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (388, 'Hou Xiuying', 'EfyEPu1aE9', '0GyPQpxmho', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (389, 'Lisa Kelly', 'HOMTRCn2By', 'kaHoCNhFWw', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (390, 'Pang Chun Yu', 'cf2ebYpSyw', 'Sxgjz5hDTN', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (391, 'Liu Lu', 'kZuSNTnRqJ', 'rYW441oXQ3', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (392, 'Kato Nanami', 'mp7vjSQseC', '8YmS6STr05', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (393, 'Norma Collins', 'PXSWjbjS5e', 'x9yQAKz6EA', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (394, 'Mori Aoi', 'HJFTlzExAw', '0qM5RA3sis', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (395, 'Choi Ka Ming', 'vx9dnTpsvO', '1cAeSo1oVa', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (396, 'Murata Aoi', 'GrKKFfm6c6', 'Ax2KclOazm', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (397, 'Barry Alvarez', 'Y8wPHWDjS6', 'K1tthEYEK4', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (398, 'Li Zhiyuan', 'dYvcL2svgd', 'fdBzgA5KlC', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (399, 'Ruby Grant', '0NYusGEUut', 'ytlkpZLcH6', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (400, 'Cheng Ho Yin', 'uobsUbowUF', 'ezZ1Gg4Z3Q', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (401, 'Zou Rui', 'pwo775vHDp', 'Pvar2q3PAy', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (402, 'Kam Tin Lok', 'T1RTM0rkzh', '7Qj0KNdSxa', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (403, 'Julia Russell', 'RXARPqavHs', '87cjEa6YgT', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (404, 'Nakayama Takuya', 'nmfbLOyj5Z', '0OtIYDzqxh', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (405, 'Sasaki Ren', 'WyYeH2YG6m', 'BlkMoOuRzl', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (406, 'Hui Chung Yin', 'SqXtBSrCC7', 'yO7eO7uzTj', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (407, 'Ogawa Takuya', 'ygaKouMvgz', 'axgdgjv7Nq', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (408, 'Masuda Seiko', 'LrhxzbpqqQ', 'hFX0tJGsbD', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (409, 'Shen Lu', '2f4NwbDqUW', '5DysuzOEve', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (410, 'Ku Kwok Kuen', 'WjFIoQK8Dy', 'Ed4KEUOkJ5', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (411, 'Jacob Gray', 'fiFTi1Wc4k', '8iKBlSAPMa', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (412, 'Tao Yun Fat', '3G0SBkdRzA', 'jfLPm0FBCF', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (413, 'Eugene Kelley', 'iQspHS9jtb', 'S3gWGYhDUL', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (414, 'Au Chi Ming', '7bbhZnyfjQ', 'rm7SNp5a09', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (415, 'Zeng Zitao', 'MfzdhlbA2T', 'xGWf73lgoR', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (416, 'Pang Ting Fung', 'qDKYG849GV', 'TT7nnQADOM', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (417, 'Fu Wai Lam', '1t4XD2jfrv', 'nXTs9H5yWO', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (418, 'Lau Chun Yu', '03yyictkD2', 'oZrqnBhhWG', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (419, 'Wei Zitao', 'LtL4Qo4zgA', 'jbiRL3kxxY', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (420, 'Gao Jiehong', 'pq8cfS0Aos', 'zaVIYuJwpC', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (421, 'Yoshida Minato', 'PYCHgqifkj', 'ocsrDGluC3', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (422, 'Eugene Crawford', 'VpaN1fCfEr', 'aUL7w2oGB5', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (423, 'Fan Zhiyuan', 'CFqUWRSjni', 'YKZj3bsEyP', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (424, 'Wei Yuning', 'kAT1bi0WgN', '4lHwilyeor', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (425, 'Hui Ling Ling', 'K7GktksdCf', 'HIakc9tVXE', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (426, 'Chic Ming Sze', 'WaN22kndgJ', 'i8xVkmKQQ0', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (427, 'Xiong Xiaoming', 'pvoVeOWJYX', '5MPUY9NVVu', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (428, 'Angela Price', 'mm1eUC2YMA', 'dk9ePXXWvw', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (429, 'Shawn Robertson', 'OSE6yCRjtK', 'CKP0M1jjlZ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (430, 'Kudo Rin', 'dPBPXPZIWu', 'durNOe2AZ0', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (431, 'Brenda Weaver', 'OFOQOKf3Qw', 'ko8oHcg8jn', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (432, 'Sun Zhiyuan', '2QiQ7Ruu7k', 'avjAlsff4L', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (433, 'Hu Yunxi', 'nNQCafia2G', 'Xb6IWN4pah', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (434, 'Shing Wai Man', '1qMLwyNCxX', '6b1IlQk4VI', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (435, 'Miyamoto Itsuki', 'aq9xyCzutZ', 'ydsn9Hi98i', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (436, 'Jiang Anqi', 'XMFB3rd0HP', 'Y3wr6diaD6', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (437, 'Edna Campbell', 'oxR3tB1DzO', 'MISTcXxebl', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (438, 'Elaine Patel', '3L5fTlIbOZ', 'zRs6eh6RT5', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (439, 'Suzuki Kenta', 'c0i4ii78BO', 'stqhRHgU6y', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (440, 'Mo Shihan', 'zPHfswJWbE', 'klNjnRxGZ7', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (441, 'Jin Shihan', 'ViCzocfSdw', 'UuKBP7cHBr', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (442, 'Mike Ross', 'YIlUiZ1NQP', 'lIOeYcUwDW', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (443, 'Cho Ka Fai', 'IZTeuS0RtV', 'dr3p6FalNh', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (444, 'Robert Mendoza', 'hezPe6mXVe', 'UYolpqx5Te', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (445, 'Diana Morales', 'OX7UKtsCHS', 'VsywafNeK5', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (446, 'Pan Jialun', '3Tg5BRwhgZ', 'bLX6MyQGPQ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (447, 'Lai Ka Ling', 'GIzuphBvKy', 'YULhuyNWqI', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (448, 'Tina Murray', 'kYI4JLEFLh', 'SHEjuQ42sC', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (449, 'Hou Ziyi', 'yNXBDU7ofZ', 'YL4Dvf6XsF', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (450, 'Peng Jialun', 'ea5tuVTMgl', 'qtCalxl8dc', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (451, 'Siu Wai Han', 'ZN7RVUeD4o', 'XSWnyVkG0T', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (452, 'Diana Gardner', 'HdsBN8Y01F', 'ecioTXmQs7', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (453, 'Beverly Edwards', 'bvs9td4rXQ', 'WcuPSPKgZF', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (454, 'Yin Xiuying', '81qoG8sUE8', 'QzWuMCUxHl', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (455, 'Sato Sakura', '7qkjGKYfyS', 'dBg6Yd5xa4', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (456, 'Gary Clark', 'gwLZub4Duj', 'Z2iXaJ08xR', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (457, 'Guo Yunxi', 'zFJzPiMaMV', 'TKO1l4Xv43', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (458, 'Ma Tak Wah', 'TSQQ7nynto', 'LJH9Rz0VUf', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (459, 'Nakamori Seiko', 'AIu57OMWQN', 't5qTevKR8L', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (460, 'Joyce Ramirez', 'c0AIQ8xtBe', '6Y3ChCPKiW', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (461, 'James Alexander', '64aa0YPPCP', 'UtsmZeHMIa', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (462, 'Wong Wing Sze', 'n9FIbvoqIo', 'VgNCUT9Zmy', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (463, 'Lo Ka Ming', 'Luurp4IGjk', 'p6jIRAMviu', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (464, 'Siu Tak Wah', 'sUSOjoWBdz', 'GzFlNAmV5Y', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (465, 'He Xiaoming', 'ws36KyYqLc', 'pFlYNA46vG', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (466, 'Tao Xiaoming', '2gYXgwoXLR', 'Hb23WIpwUR', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (467, 'Cui Anqi', 'CaghAji7TD', '3BZc9AzdEo', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (468, 'Chung Sai Wing', 'Fddw9Ki7Tu', 'SBDYLOJmep', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (469, 'Cai Lu', '0oGcRPM5Nt', 'Ai2N50McRV', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (470, 'Miyamoto Kazuma', 'sJ8cCrOquL', 'XrDgAPjUkS', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (471, 'Imai Momoka', 'GCUikSKXPB', 'QxA4BxJDBh', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (472, 'Danielle Ward', 'P5Y7PhU30O', 'JnSg0a37Kz', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (473, 'Ye Lan', 'Xf6vUdswfV', 'JzcxQuIINw', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (474, 'Yin Chi Yuen', 't5FdecTTUq', 'XuK28wfGbR', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (475, 'Fan Xiuying', '3q9Yl0IAvX', 'MipgZqLEih', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (476, 'Tang Wing Fat', 'ekkezMjZDa', 'D7gDIky9C4', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (477, 'He Zhiyuan', 'xcCNA16GHa', 'Z9v3fG7TX2', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (478, 'Sakurai Aoshi', 'pQg8TD9lcO', '3Kn6myk8bj', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (479, 'Christine Jordan', 'BzIJwavbVp', 'umIw1gfXo9', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (480, 'Zheng Zhennan', 'Qgrek940L6', 'MSuTJuxTjw', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (481, 'Cui Ziyi', 'EW5ksRff34', 'gUdrXCTgxO', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (482, 'Suzuki Ikki', 'KRQRSAfHaw', 'lggEV2Uvp8', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (483, 'Leung Lik Sun', 'aTyYvz3JZL', 'TdJW9CYLx1', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (484, 'Peng Anqi', 'aa5gl4ksV8', 'H2rxQwcIXC', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (485, 'Mori Ayato', 'DluEfAvBB6', 'jcza2PuTNz', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (486, 'Pauline Gonzalez', 'IxJMG7tLH1', 'iX2IoEBYe4', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (487, 'Christina Gonzalez', 'iOkjzm9HiH', 'xEFR0VBoCs', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (488, 'Miyazaki Itsuki', 'MahhqWBQcK', 'YiHdQMKRT0', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (489, 'Barbara Thomas', 'd6JL3TVDgE', 'ja4Iwg3hdr', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (490, 'Matsui Momoka', 'uv6k71zwfE', '7tpFJsq8MT', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (491, 'Ueda Momoe', 'ArMHySRrFT', 'E9dhC4GVU9', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (492, 'Yu Xiuying', 'UyQcX8W857', 'WqXIakgLYH', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (493, 'Kondo Takuya', 'VAOOcomn7a', 'EHC6nPqG95', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (494, 'Kong Wing Fat', 'P6CwYRjGMU', 'AByO0CgztF', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (495, 'Louis Clark', 'KkAXLIoXnu', 'Ow72s37jRl', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (496, 'Chang Lik Sun', 'fCuAtWK1TT', 'JUtN2OFyte', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (497, 'Hung Wing Fat', 'iYXY4R1KNI', 'VdnQYWJ1NY', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (498, 'Qiu Anqi', 'hsNB5GVN19', 'Jk8nkdQoEp', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (499, 'Joanne Russell', 'fEQk1kcRLz', 'NwMMoyMZim', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (500, 'Yamada Sakura', 'ym6q2futWS', 'r9XrTAm9Ml', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (501, 'Nomura Daichi', 'hjrgQGofVh', 'JY78iNi7EJ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (502, 'Nakano Rin', 'gYRvVNCZtG', 'Gd8A6ZZSwM', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (503, 'Shi Xiuying', 'HhM35JK3fV', 's6c8p5AGPT', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (504, 'Miu Ka Keung', 'fwMg3mkATA', '9uhp6CvAMV', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (505, 'Ye Yuning', 'WnwKcW8p9D', 'u67da17HMl', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (506, 'Lei Zhiyuan', '0LqtX5pX6U', 'yQAk6799Ev', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (507, 'Lei Ziyi', 'yklPYhzB2g', 'jIcjjBiD00', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (508, 'Yin Xiaoming', 'nM8TW1ArSh', 'aZWrMcEszn', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (509, 'Yan Zitao', 'l8nR12K0hh', 'c7tenB258G', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (510, 'Xia Zhennan', 'F6cedpjixl', 'y4rwZY92MA', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (511, 'Yin Wai Man', 'PEpofy4Uqj', 'q8Z1gbo58V', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (512, 'Chu Ka Fai', 'DaHBdVph0U', '0HxSMJj3SC', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (513, 'Fan Wai Man', 'Zbn1svmyd0', 'sQYtnyBmLX', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (514, 'Wu Xiuying', 'rtgzBNQXs1', 'iOb2F5sECc', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (515, 'Tsang Chun Yu', 'f8fL8FslTx', 'RydHLERqPL', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (516, 'Ren Zhennan', 'vZDVqJJOek', 'MW39l6KOcY', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (517, 'Kwok Chiu Wai', 'u9zg0yUMcu', 'tAwGbgKBm5', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (518, 'Wendy Payne', 'Lp1dzrkgOW', 'JBAxmUGFpc', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (519, 'Endo Sakura', 'akoiRYCU34', '3aNF5cshDl', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (520, 'Fukuda Daisuke', '9arcUq5uxU', 'dXAetHiBoI', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (521, 'Man Sai Wing', '1sM3CJ6wus', 'HUQ9GaCYCX', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (522, 'Ando Misaki', 'e8qP6D320E', 'nByHzoeRyd', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (523, 'Su Lu', 'eBTF40h1j9', 'Hy6uICCBUA', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (524, 'Takahashi Hina', 'fbuTsarJsp', 'dVuSjM3edP', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (525, 'Gao Ziyi', '2pStBciYGB', 'HNHd2g5wDZ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (526, 'Shi Jialun', 'ZJJPdW7Wro', 'NE1KzO4Wkg', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (527, 'Chiang Lik Sun', 'QaXX5HyDPj', '1OwingT8ex', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (528, 'Wada Momoe', 'zAmx7Mk0U5', 'd0KqeZBdjY', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (529, 'Chow Yu Ling', 'in5b6j2Gmh', 'MwrKq2I38T', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (530, 'Mak Chi Ming', 'stKhNE2HIw', 'wSfCcyfB6c', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (531, 'Joseph Perez', 'gLy7Or9DYT', 'MFAQVrsZvK', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (532, 'Lu Zhiyuan', 'dGL74YK1YE', 'oc8DbckyRH', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (533, 'Sakai Tsubasa', 'wfSTL7WgS6', 'CHjYKlBSQq', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (534, 'Alfred Washington', 'yoCXsonZIW', 'rvzIrGV7gw', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (535, 'Jiang Zhiyuan', '4jwOjyVtAS', '3dbsfDDxGz', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (536, 'Meng Lu', 'g2ORlUviKR', '6V2kRfAZGZ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (537, 'Ray Ruiz', 'MkSQC6cmVi', 'S6B8W7dclp', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (538, 'Heung Wing Fat', 'gF46uP8CDF', '7jhZ85zeTj', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (539, 'Mui Tsz Hin', 'Ia4jIlBzx3', 'muFgEV1bCs', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (540, 'Jiang Zhiyuan', 'yTJgEef9sZ', 'dfD7hnENsY', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (541, 'Wei Zhiyuan', 'zpGbQtdeTC', 'G4HqXVzRLo', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (542, 'Lin Rui', '3Dij71So9w', 'gdQiyUKfDe', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (543, 'Mak Ka Ling', 'ZixlCj8v6g', 'CHeAIVKndf', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (544, 'Yokoyama Hana', 'XvE7xIi8h1', '5vYTA9hSDS', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (545, 'Jeremy Cruz', 'BEoHz469gd', 'mJhuqd3rQZ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (546, 'Fong Ming', 'Qqyq4iRI7E', 'tvZim52kuw', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (547, 'Ethel Black', 'UH2d2t0pjR', '1xJ4FfDGLB', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (548, 'Chang Zitao', 'ALFGuMLO4m', 'WbJeKBJDS5', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (549, 'Gong Zhiyuan', 'Jl9Wysi66z', 'qCpI8vs51m', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (550, 'Yang Yunxi', 'D66J0PqrWS', '2b47Qw9AVx', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (551, 'Kikuchi Sakura', 'O8NEv8RnIk', 'Gkk3YqtSLX', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (552, 'Charles Snyder', 'deTkMueoOg', 'GEwFasTJ3B', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (553, 'Maeda Daichi', 'QyXyT056rI', '0M3iPo3Ewy', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (554, 'Tracy Brown', 'cVcTo2OCVS', 'kMu2uthMFZ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (555, 'Tam Tin Wing', 'Il0RW0oJ0l', '0iwliORIRR', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (556, 'Stephen Hawkins', 'Cx1pZlc0dq', 'rgL7nX5Jpl', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (557, 'Wang Xiaoming', 'GH3DvyMu5L', 'hvusyQQs8g', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (558, 'Nakayama Aoi', 'iyoWdcWh5e', 'kYR0ZGtNc4', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (559, 'Lu Zitao', '7GxWWs1qBp', 'pZCj7CqAlS', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (560, 'Yung Wai Man', 'kM8O9hr2vH', 'dzQRkpqQOc', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (561, 'Kwan Sze Kwan', '0DRiR1T9SD', 'aY1Ek0giPt', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (562, 'Yokoyama Shino', 'YbuHcWWd09', '7yctvUtEch', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (563, 'Wanda Coleman', 'xjHWvdaxq7', 'kckylYVRqS', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (564, 'Christina Evans', 'JterVduqFR', '8yiSi7hWNk', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (565, 'Shen Ziyi', 'YKhxDWiONs', 'ScLIjggDIw', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (566, 'Kelly Hill', 'elA0q1jTap', 'd96xtWOftT', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (567, 'Ichikawa Minato', 'wWXu2KeQ0S', 'bfl52uKMB7', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (568, 'Fujii Aoshi', 'tQ0YxSE75K', 'STSZH3SekL', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (569, 'Kondo Yota', 'cnZxzgZj70', '8bEl1U8lUN', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (570, 'Koo Hiu Tung', '15lvEuipbN', 'Jw1zLAQJTP', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (571, 'Lu Zitao', 'CMUKNkWobM', '8s7bboMrzv', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (572, 'Mui Tin Wing', 'j3PqHr8NRt', 'NPRYeT8VQe', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (573, 'Ernest Adams', 'X3gw2FIjl5', 'QN48Wy1QE8', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (574, 'Kong Tak Wah', 'Rv1bOHi3TU', '4H0AV6N2xa', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (575, 'Yip Sum Wing', 'qUowL5WADo', 'Om1f1ZHkbg', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (576, 'Kimberly Black', 'iXA03H0WjG', 'zPIQKpj2Pd', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (577, 'Carlos Robinson', 'hh30KL7uPy', 'PjVPltMeAc', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (578, 'Curtis Baker', 'uB8cybPJbY', 'L97YhuQbZ1', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (579, 'Xia Xiaoming', 'P2WIGaorQg', 'tkCIDzwcbQ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (580, 'Arai Momoka', 'Uy2VbQhfs1', 'QgZJ6mjQN4', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (581, 'Matsui Nanami', 'rhUhR4dTsY', 'bKBiQvcgRQ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (582, 'Jin Zhennan', 'AwD2TfulWo', 'hJF9Ws0qOQ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (583, 'Marjorie Martin', '4a317kNmsZ', 'OkIDyJC2r7', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (584, 'Hsuan Fat', 'hwlhsjvAvC', 'TNoyqG2GsG', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (585, 'Yu Rui', 'MDCW0imryN', 'CjjtPA2dV7', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (586, 'Ku Wing Fat', '2440ivbnTY', 'meb2VYohL6', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (587, 'Chin Sau Man', 'ysNgSHB45Y', 'vtVXPUAtkC', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (588, 'Jerry Coleman', 'ufcYxuiHlD', 'a9PnzleDSi', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (589, 'Lok Sum Wing', '4VM4wLhue0', '3lKGCVXGds', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (590, 'Abe Akina', 'PBgkNGDWcL', 'qJmgifFpCw', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (591, 'Tao Lan', 'VpJgXMcNzf', 'Hy4GVl64FW', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (592, 'Cheng Zitao', 'WAENzPWxm1', 'azwGjwduaP', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (593, 'Lois Ross', 'quKRjVYxmH', 'RvLdEDyRzs', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (594, 'Goto Kazuma', '014kkiZoky', '2RD4pLjkPf', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (595, 'Jeremy Medina', 'SKay3hG3nn', 'oxT6VXhCcq', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (596, 'Hao Xiaoming', 'p49b6NpcC6', 'O74WsDokPv', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (597, 'Sean Jones', 'HRG9dFMIf6', 'YH2uLE6puQ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (598, 'Arimura Momoe', 'aGGapGoGAA', 'qlPNlcx4Y6', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (599, 'Qiu Jiehong', 'HxXXZqhxj2', '7YtvpIMiDd', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (600, 'Kondo Momoka', 'NLjxG92Ijg', 'XxaWo2FMZe', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (601, 'Brian Mendoza', 'rHt195JZJf', 'iHPzzV24xz', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (602, 'Lui Ka Ming', 'Yz4oohsC8A', 'ICb0u9O00i', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (603, 'He Yunxi', 'ZXyxlGbozf', 'LvGbCNq0Iz', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (604, 'Sakurai Miu', 'HeZUvzerTi', 'Oeif7CW03H', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (605, 'Nishimura Ryota', 'RJUWrzRMbI', '1NjiGbuTGt', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (606, 'Hsuan Tak Wah', 'SE6BCbiTUb', 'b1Mmcrb5lW', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (607, 'Tammy Tran', '7lMcEJKYmg', 'GSymZ4kDoP', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (608, 'Mo Zhiyuan', '0pqqhyLgvd', 'xDLO3Kxy1W', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (609, 'Kinoshita Yuto', '3Zp4MjftjJ', 'wJ1SOIkgRg', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (610, 'Nakamori Yota', 'iVnKJuAdHy', 'ZTVuVugXEp', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (611, 'Sun Rui', 'm3Nc3nr6A1', '6NYG6xvAGG', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (612, 'Dong Yunxi', '1Qj81Qd9rb', 'rz7h5X3e5J', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (613, 'Wu Sai Wing', '9ICGfkUA9Q', 'DgG3SXeOYM', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (614, 'Harada Tsubasa', 'mmjKhOGlsJ', 'Rrjjq3zQXt', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (615, 'Sugawara Ayano', 'vctOvWZalM', 'bl7pItihpr', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (616, 'Saito Kenta', '00d4IIT7Ry', '6NvJFOXu2m', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (617, 'Wong Wing Sze', 'xlmCBqbKYK', 'VJQ6XzsomS', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (618, 'Ng Ka Fai', '6uDcgE9uvN', 'W6vSkMBJFL', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (619, 'Dai Kwok Kuen', 'jrRZyXpnEw', 'nRZnwYipGs', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (620, 'Ma Zhiyuan', 'hvW7Q3YPzp', 'lwUw2AEopZ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (621, 'Liao Ziyi', '2JJy8E9a7A', 'pkzvRCZhHe', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (622, 'Ando Misaki', 'QM6kYReKjY', '4ZgVvgNLab', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (623, 'Howard Owens', 'wFZon5QjdF', 'UKiz25vRIq', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (624, 'Tao Shihan', 'aHtHBMJsxH', 'liAHaimQbv', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (625, 'Ishida Riku', '8gbJK3nYlY', 'WZ21on0HDa', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (626, 'Chang Hui Mei', 'Epcseu6bq2', 'is2W2uLsVC', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (627, 'Tanaka Hikari', 'K0B2tBimop', 'WzE5grumwo', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (628, 'Cho Kwok Wing', 'q6FvGZmsMV', 'MfWZf91LFA', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (629, 'Wong Tsz Ching', 'TeuB7i5Via', '8ddeanJ7pC', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (630, 'Hsuan On Kay', '6XtL5ZLeYm', 'ZCyoSZitBE', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (631, 'Walter Stewart', 'l2hkLBsMLP', 'N0uSKOtJWs', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (632, 'Chen Anqi', 'FBkZrb6CsZ', 'V0Yb9DiHZp', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (633, 'Joe Gray', 'f5H2I3h7sD', 'lk4YHWwwTE', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (634, 'Li Xiuying', 'on3YaW8I9u', 'zobtbhfsh4', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (635, 'Murakami Yuna', 'c6vYXk7tNv', '5gAvPdexGm', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (636, 'Sasaki Ayano', 'bJqaDYIxgw', 'eATxscj00K', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (637, 'Che Wing Sze', 'xAkFxN618X', 'ov8dLKdyDD', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (638, 'Sakamoto Shino', 'fDDhJrIrCH', 'pFcb5x0ewO', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (639, 'Lam Tak Wah', 'g2G6OPfGWO', 'tT3LVZdhSX', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (640, 'Lam Chi Yuen', 'iY93Q5aXwa', 'EvuJxQlTC5', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (641, 'Wei Anqi', 'UOlwnPVuxf', '290yvEsxnM', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (642, 'Scott Marshall', 'GswwsX7MbS', 'qdiZ4Reavt', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (643, 'Josephine Sanders', 'erV5KKreMH', 'Zatm8ona0c', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (644, 'Aoki Hikari', 'uPtzSPuZ4Q', 'Os3V7Pqmn3', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (645, 'Yin Xiuying', '3FlMJiKGrY', 'uSJwC4h3ln', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (646, 'Nakano Minato', '3S8CZ0qnzn', '0hovfLkh5w', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (647, 'Chic Wing Fat', 'C7ypj13KNo', 'CYmmGRjUNB', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (648, 'Kojima Seiko', 'BEObP8ufBL', '2yzPTtEA7l', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (649, 'Fan Ziyi', 'uDxXuwsnVc', '52JLdo0mna', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (650, 'Daniel Coleman', 'oWq2MHtnkE', 'OzRMZetDVf', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (651, 'Ishikawa Yuto', 'kzxqUmTbsI', 'OzAbiL872b', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (652, 'Sheh Kwok Yin', 'e6b1te3Cl1', 'HxieqlHJfX', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (653, 'Han Lu', 'crww9ThpYu', 'YXQnFtG3km', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (654, 'Kwan Kwok Yin', 'eXU0wGSnrq', 'Qcob8sv2qC', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (655, 'Kondo Yamato', 'UIunKPa2ko', 'TUTC742CFf', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (656, 'Fu Xiuying', '4xjockS3Q6', 'ouxLQYBwvH', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (657, 'Kinoshita Airi', '2o13TqIrrN', 'DPUCS4w75R', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (658, 'Lam Ho Yin', '6SiIpZYRIG', '0TYi9yAF7M', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (659, 'Gu Lu', 'rbQ26piw1p', 'XLYCrkobXg', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (660, 'Josephine Parker', 'cqBClCt4oY', 'z1P1k2eeVK', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (661, 'Fu Xiuying', 'uJPzL9OgtA', '3a5IkpaNXl', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (662, 'Wei Zhiyuan', '7DedZ8N3rV', 'm0ihvLZFNk', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (663, 'Albert Cole', 'byVzSqvUFj', 'uRDYXpDzaJ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (664, 'Duan Lu', 'O8d2qQ88xv', 'ODT9BKCYN1', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (665, 'Lee Chieh Lun', 'WfsAzQ8QKf', 'GmKi6rdvbC', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (666, 'Anita Jimenez', 'EHkUCNC176', 'zTKMXZ3m2L', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (667, 'Nakamura Takuya', 'tIr33cqUes', 'jgauNE3b9u', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (668, 'Walter Weaver', '6sONVxa4Qr', 'LLSUzYdvyI', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (669, 'Donna Henderson', 'ghE87MxyT7', 'RZBnrn4vdD', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (670, 'Jack Evans', 'dtWhww2OFC', 'M0HKgoQJEa', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (671, 'Xu Jialun', '2UJYlXBEQB', 'OsyAhDXHkZ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (672, 'Leroy Jimenez', 'TCMGlzuoXc', 'Oo3pzJFV0s', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (673, 'Yamazaki Hazuki', 'sIXSUYQ3vB', 'tSoKBFshm6', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (674, 'Wong Wing Sze', 'e1Pa82syvn', 're0hDKkWf2', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (675, 'Nakayama Mitsuki', 'aQSzJxXVI8', 'LOVZJd9yIv', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (676, 'Ye Ziyi', 'RtPnKbA4mt', 'E968fM1y7g', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (677, 'Koo Ching Wan', 'QAtB3g2wMp', 'A7Bk7Tdwkh', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (678, 'Zheng Zhennan', 'Evrnwvq8Mx', 'TT54AEjLQC', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (679, 'Ying Tin Wing', 'Fi7nGAqTHi', 'DOeqJqxnF3', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (680, 'Lo Sai Wing', 'M0dCCLeinM', 'xCjHlJFdUr', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (681, 'Ando Kaito', 'gn3P6F78CP', 'o7wphSM6E0', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (682, 'Xu Lan', 'Gh8WnjrVK3', 'CGWkXrYEQd', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (683, 'Pak Ming Sze', 'aaM5moUnpy', 'PXUntXgxlx', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (684, 'Kaneko Minato', 'vKSks9CMX4', 'WDnwX4DUc4', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (685, 'Liao Yun Fat', 'gp95rQNMzY', 'Z5XkSzYRNK', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (686, 'Inoue Miu', 'x1PvSVTfwg', 'C33voeFX6S', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (687, 'Ti On Na', '0MxWJ8V2sr', 'vFqsPRjWyc', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (688, 'Mui Kwok Yin', 'HREUsW88PZ', 'rwpfq8KMDt', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (689, 'Harold Mendoza', 'Ht8i8l79wk', 'HXHS4yqly0', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (690, 'Choi Wing Sze', 'StJfpGDGIR', 'ElWE7qUsav', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (691, 'Loui Wai Man', 'eK3OJl5qvJ', 'v4Bp4wD4ny', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (692, 'Lai Ka Ling', 'CLFERXdkSQ', 'cJO8Gl2Gf4', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (693, 'Deng Lan', 'BZD5C0iF6F', '48RGlFbBqE', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (694, 'Lam Kar Yan', 'd5pr1SMMuU', '1IhUTJ39lL', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (695, 'Wang Anqi', 'BnIxrwZSUf', 'CMVSrznPdC', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (696, 'Aaron Payne', 'lz1hfhP8yc', 'hiHym6zxME', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (697, 'Lu Jialun', 'JbR1BD0iAs', 'YNxH7q9fI2', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (698, 'Che On Na', 'DaDACA9rWh', 'VnC1bFRJu6', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (699, 'Ti Wing Sze', '9ABeDXaCwD', 'TPEsUhmLp7', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (700, 'Jeffery Campbell', 'lBHEtP93tj', 'RtSrononKI', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (701, 'Tin Kar Yan', 'TtooGBwJ4w', 'Efqei1YbVs', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (702, 'Shibata Mai', 'l6QqirhltT', 'oTF5vdEYn0', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (703, 'Julia Porter', 'FruzYV5nox', 'd0nifTmYGH', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (704, 'Endo Momoka', '6xCK8GrLdA', 'aQIshxBeDP', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (705, 'Thomas Thomas', 'cQ3cSKwPFh', 'edRUaWvHUW', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (706, 'Lu Zhiyuan', '7Fk4c3V6DV', 'OkmAARQMz8', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (707, 'Long Xiuying', 'cWiYH3dyXi', 'tQmouxRzXh', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (708, 'Suzuki Yamato', 'QRIESXrM3q', 'JYJogEEQ26', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (709, 'Yau Sze Yu', 'eKf57dH8MD', 'sVIMFvs2dN', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (710, 'Chan Chieh Lun', 'Iu52WaXa42', 'dfIHWEZRVk', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (711, 'Tang Yu Ling', 'MalxUacVNA', 'RqtIH1CXLb', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (712, 'Meng On Kay', 'HdgIjrapZt', 'ONWwe5qN3r', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (713, 'Hazel Webb', 'wTJ4yMqOn3', 'iKMBpmD9GA', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (714, 'Chin Sum Wing', 'wm70VFcBbz', 'AopmUYhZDj', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (715, 'Carolyn Green', 'ZlMs1o5HcW', 'UwVEeQQ7kl', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (716, 'Yu Lan', 'GZJ94VX2y3', '7lp4gUD6aL', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (717, 'Zou Ziyi', 'hvkaWi8qoR', '1ydMlTIdbA', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (718, 'Shimada Kasumi', 'KUVKFsjAW3', 'vIeCyfl8Wt', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (719, 'Shibata Ryota', '44gKbaJJKb', 'VugnRw6Lkk', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (720, 'Yip Ka Keung', 'oWIOQtB0G2', '3ay4WtRpPX', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (721, 'Pan Zitao', 'JhHXw6eGK1', 'B6N7uc20iZ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (722, 'Zhu Shihan', 'cKIUSVqzbH', 'OdbMhWOPyt', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (723, 'Dai Xiuying', 'mxrapXyi7u', 'LaBB6Oplg2', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (724, 'Man Wai San', 'khHwI4k4hF', 'MGNbFAI6D4', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (725, 'Nakamori Yamato', 'Uc8zA5lzDM', 'PaGhwOKoBP', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (726, 'Wei Jialun', 'H1GBVAKz4p', 'OxtEs7JkWS', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (727, 'David Henry', '5YYokAvQRO', 'tPG8ULTajj', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (728, 'Ito Kaito', 'mVyoL4BAZZ', 'y4fzs2aLzk', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (729, 'Lok Sai Wing', 'Xlb0nWXC6f', 'UILAMPp3UE', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (730, 'Zou Xiuying', 'ONMFvI6bCM', 'g6pucceIWr', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (731, 'Kimura Daichi', 'MBzzq5G3jG', 'pgh98wva5b', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (732, 'Qin Lan', 'ffryoOCDMG', '5g3i9pZ04I', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (733, 'Randy Watson', 'Upw01Z2S13', '0DMtILtwk5', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (734, 'Loui Suk Yee', '7F4gykxpCY', 'DZcmvgzLY2', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (735, 'Yau Ming', 'Xg0qBr5rZK', 'xgtaCv6EoS', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (736, 'Yang Anqi', 'fQoEDl8caI', 'dw3wkEGoQn', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (737, 'Stephanie Davis', 'f0Ppj5s4Rw', 'iECA3QNJhy', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (738, 'Fu Siu Wai', 'WDttwKYE54', 'zP19OoZcCK', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (739, 'Gong Anqi', 'BS7JA38Fx8', '4WOS7pETAv', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (740, 'Li Rui', 'i3iPSVzP9v', 'LXFj2zyiDH', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (741, 'Tian Jialun', 'uh0VEENu2O', 'JpTr2HboNm', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (742, 'Stephen Hall', '4C94xNi3ow', 'g6hnPTfnzR', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (743, 'Au Chung Yin', 'zPhitIYhrT', 'HWhXSwil17', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (744, 'Leroy Hayes', 'w5PgZN1zrV', '8E7AHwVcro', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (745, 'Siu On Kay', '2wbAkNBW2F', 'tIA31CUMYp', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (746, 'Kwok Wing Sze', 'k8ec5csUUS', 'l8CzB8dx5L', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (747, 'Uchida Riku', 'hjcSav42qc', 'oh8mMAPZaE', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (748, 'Lok Sze Yu', 'eML4yB6Juv', '5YMQvCB8ud', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (749, 'Hasegawa Sara', 'qbFYARlXJ4', 'A4cOFrO8FX', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (750, 'William Rice', 'ax6MymbK1I', '2nJTRUQsRG', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (751, 'Shing Kwok Yin', 'LeGsgsZr1z', '0LobkkNJkT', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (752, 'Fang Jialun', 'CGJI0uFJ6n', 'S0ki4FmWUF', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (753, 'Feng Zitao', '1rNprulQRS', 'ZJ9YGZ64pW', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (754, 'Yokoyama Itsuki', 'XN4laEPPZN', 'irh4KMZuHI', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (755, 'Ishii Kenta', 'XZU6VJ5Rit', 'Lp6GErdpsh', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (756, 'So Kwok Yin', 'ZpgWSdzZej', 'PQQthalaAf', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (757, 'Nathan Meyer', 'otn0xgUeGX', 'Hh1l3O7oMY', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (758, 'Kwok Wing Sze', 'Iv4bOSK6G5', 'SAaxQjgOqn', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (759, 'Scott Lee', 'umFft6ao0P', 'kKR36TW6Ux', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (760, 'Nakajima Nanami', '07omQiSJqA', 'J4SGJnmjOB', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (761, 'Ma Xiaoming', 'rAPW1NwlrM', '16yGnWnxjM', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (762, 'Liang Lu', 'r1V49TvS35', 'gf9sXQvKss', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (763, 'Ye Xiaoming', 'ckbr3H7d61', '3v87oNJDB1', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (764, 'Matsui Miu', 'OOOoVVJJXg', '6LRNypTQyW', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (765, 'Yin Jiehong', 'kUfHpxsCVF', 'gPz77FkDh3', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (766, 'Kojima Yuito', 'cdsUm6iTN3', 'OFwQ3fbBEO', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (767, 'Ma Jiehong', 'unA86wUi0V', 'ueqyara331', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (768, 'Imai Ikki', 'hCSswZ6EjC', 'Ai4KGb9fyY', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (769, 'Ando Momoe', 'sbeMzfigli', 'WW2B2Dhfef', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (770, 'Eleanor Romero', 'An1NQp9wIg', 'tQNNytxsHb', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (771, 'Anita Tran', 'Xc8aE9JWXr', 'DD1Ecc2Ybg', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (772, 'Sarah West', 'VqoNZ7IZ49', 'elZsU7fwAf', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (773, 'Dawn James', 'Y3Qng0i9eE', 'CbIyo95klh', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (774, 'Kwok Ka Fai', 'o2k257QoRx', 'w3OSQLy4fn', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (775, 'Yan Anqi', 'nndA9xdViX', 'XOuqm8NCGb', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (776, 'Koyama Airi', 'ACludt0Ga9', 'd8O7NvsM0A', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (777, 'Mak Sau Man', '0gv1Q60tj1', 'SLeqLjH4FI', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (778, 'Gao Anqi', 'ek4aI6nAYb', '5wfDJBTNTo', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (779, 'To Ka Fai', 'V5nW4UP8pA', 'CzguoPHaUj', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (780, 'Cheryl Hernandez', 'Ry0Vp9caJ8', 'wCwGcC7QVV', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (781, 'Cao Lu', 'tbSBiRiaGn', 'KKi6yZi476', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (782, 'Hirano Nanami', 'xoEL0hxISi', '0OAAKHzFeT', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (783, 'Leung Ka Ming', 'DrIkmLxz6h', 'kSnecuH9XL', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (784, 'Julia Price', 'MQymLHAC5f', 'GfRMyvmi05', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (785, 'Kondo Hikaru', 'zQeGga7amE', 'fTwAkFXRxT', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (786, 'Otsuka Miu', 'FDeJe764V3', 'YMQx59oj7L', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (787, 'Shimada Seiko', 'pR3zoY2MhF', 'TS0W3EqVdP', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (788, 'Long Zhiyuan', 'cZme4sWmAQ', 'DDVOKWdquN', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (789, 'Yamada Hana', 'SV6bQvTpyJ', 'y2comfcXRR', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (790, 'Nomura Nanami', 'JzqWhEi7i3', 'SFt4kAEzN8', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (791, 'Tian Anqi', 'NoWLDwpuAD', 'LJwgzNunG9', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (792, 'Xie Shihan', 'MsMdZVOLlw', 'oZgUw4EiJN', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (793, 'Nakayama Rin', 'Sd5rdXaDyv', '4eXZ8cs6IO', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (794, 'Cai Rui', '59B36asoCj', 'e451GVwkOg', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (795, 'Gu Rui', 'bfJe0v4HbX', 'OlL2QXGjaH', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (796, 'Patrick Grant', '71h2jb8et1', '0PIn4aPwz0', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (797, 'Zhao Lan', 'MdCuDV7HNk', 'SSClyW9Rb3', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (798, 'Siu Chung Yin', '14QoFjdYLG', 'bdJsnjC0g3', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (799, 'Lo Yun Fat', 'DMskCJ9bdf', 'lKLOAXd4G2', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (800, 'Ota Ayato', 'twOUZWColu', 'dRJxXW2Fh4', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (801, 'Ono Riku', '6AEV5trNUt', 'Ym8X7kbIQ4', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (802, 'Chung Ho Yin', 'Evu6WtBPxW', 'OHExESIohm', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (803, 'Theodore Griffin', 'Tr0Exm3SS5', 'Y0WnHp9HMK', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (804, 'Tian Lan', 'SpNWPP11jp', '8AFTKvNbEZ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (805, 'Murata Rin', 'WlYJKeuhQ0', 'EhX8paYrrP', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (806, 'Ma Chi Yuen', 'tO5DrBs4xP', 'C5mTp4iiwZ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (807, 'Abe Ren', 'KO6SCfpM1h', '8SHaBLq96I', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (808, 'Jonathan Ferguson', 'PE8KTX87QZ', 'Tv5iJyBuF9', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (809, 'Sakamoto Hazuki', 'X9dw9aJ0C0', '0hNIIVSWlz', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (810, 'Yip Kwok Yin', 'bfO5inoAfq', 'DUAWbthV75', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (811, 'Yamada Hina', 'zREaX2zABh', '1eJ1E1X44y', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (812, 'Koon Sum Wing', '07YsxpdgE7', '6zcx2YBNqx', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (813, 'Steven Marshall', 't5nH6h3AfE', 'cmY4vboxFD', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (814, 'Yokoyama Sara', 'ec75L5vvag', 'wTLAZ32ud1', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (815, 'Heung Suk Yee', '11mBGZBRyS', 'LCEsbAuvbB', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (816, 'Han Wai Lam', 'cQlAxCQ1zQ', 'I1JVkJUDTz', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (817, 'Kudo Rin', 'gnGlMOsQ3E', 'Elk3k53dHT', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (818, 'To Lai Yan', 'bTJi75OfQD', 'plRYZ8y3s9', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (819, 'Li Yuning', 'E7WIKKDBPo', 'rk6o4RT63S', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (820, 'Huang Yunxi', 'TnaKZTX0R0', 'RuUjneSf6K', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (821, 'Koon Ho Yin', 'lwNBU0vvSb', 'HT3kHZS3Nl', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (822, 'Iwasaki Shino', 'pGzUUxBncx', 'NzKGDjguM3', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (823, 'Shi Yunxi', 'yAalzpExeS', '8asJWEu8I7', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (824, 'Yao Xiuying', 'C5Bbcqxqdq', 'LhvVL7Hojx', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (825, 'Nakayama Hazuki', '9qsUjewa8b', 'WKtiJVC1bE', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (826, 'Melvin Campbell', 'BNBfkUISQd', 'IlvtKkHvs1', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (827, 'Gregory Stephens', 'p1uZA5rWNo', 'eWcy6OCjoT', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (828, 'Ray Black', 'eh6P5WE93o', 'pEHIi7I8LW', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (829, 'Ying Kwok Ming', 'Kp0CSjoMvS', 'Ifrk6njzZM', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (830, 'Ku Lik Sun', 'XOcpy5Bu5Q', 'ipgkhD2060', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (831, 'Mak Kwok Ming', 'xCxV8Fx1J8', 'xfpTxDBX4B', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (832, 'Chiang Chi Yuen', 'QzPYc4igP9', 'cc8p9k7jg8', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (833, 'Peng Xiuying', 'g6LvVquztE', 'oAuvUvGvmy', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (834, 'Fang Anqi', 'aY8M55d6g8', 'eGC3nnRxYc', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (835, 'Dai Yuning', 'aVSYUI8F7t', '8xT3L1zh4k', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (836, 'Shannon Stewart', 'Scsr7y2MPt', 'L3pzCTLnpO', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (837, 'Wang Xiuying', 'L0qezsj4DX', 'G6BAqtgMKR', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (838, 'Francisco Thomas', 'x6A83Nvh8O', 'Z7nzusMgrL', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (839, 'Lui Yu Ling', 'N4b2bHBnGG', 'J0lzTuiz5R', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (840, 'Patrick Powell', 'd0iMz39fB5', 't0EbdAlBJJ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (841, 'Lu Xiaoming', 'AjqtwaTEVY', 'YoKwz5J8Ic', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (842, 'Heung Hui Mei', 'vfrA5ZIIWj', 'tLC8YFtXr9', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (843, 'Xia Zitao', 'TwH0M89Tzl', 'BFwzniofnc', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (844, 'Tao Anqi', 'yhspe2lg4j', 'J2XHfRoniQ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (845, 'Irene Watson', 'T3XzYwTluA', '0KQxWEKEGl', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (846, 'Guo Xiaoming', 'bx4si5EtIN', 'EhBGmf0CIj', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (847, 'Chen Xiaoming', 'c5A6rssLuQ', 'pC6l5O5MMi', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (848, 'Okamoto Shino', 'zl55hHvh8K', '5tGJny6AXm', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (849, 'Raymond Jackson', '8NRUoyC0JZ', '21y4iDsBrc', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (850, 'Fang Jiehong', 'XOHato83rH', 'lPO4JP7BKl', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (851, 'Nakano Hana', 'HjfkTALJyr', 'MHZ1YujeEB', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (852, 'Lei Zitao', '2auNo8nGiH', 'As5PoTn8Ik', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (853, 'Julia Burns', 'TDUVHYQX55', 'oNGLuqCgja', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (854, 'Takada Yuito', '4aAVpv9jWz', 'V8wOfWTY26', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (855, 'Watanabe Daichi', 'iC2OhWVb9F', 'WzoED5xHJY', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (856, 'Feng Shihan', 'FbO9g2tbL3', 'RzosikxSSe', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (857, 'Lisa Henry', '98K6dMq5hp', 'huKn90qkjt', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (858, 'Miura Sara', 'jGts6DutlL', 'mkO8p8CmO6', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (859, 'Ito Ayano', 'Jwo9gnCQw8', 'LX1V1QAdMY', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (860, 'Kao Chieh Lun', 'szQfYzLK1I', '1o5Rf8FtqR', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (861, 'Murakami Hina', 'MIEbZyoAsI', 'azOjurxH1p', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (862, 'Cheung Hok Yau', 'sdIA4aXVFG', 'OCH17eqnES', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (863, 'Wong Fat', '7ezHMCttcN', 'XQDYltu0lH', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (864, 'Connie Ward', 'HxAMVmx30H', 'lewutBjnSt', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (865, 'Yan Rui', 'FCKccIOGB7', 'Sv5kpA5Wa2', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (866, 'Yeow Lik Sun', 'H005KvC4gK', 'ir0nCOAcAk', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (867, 'Sato Mitsuki', 'ZWGCKC9HBN', 'f4HnSbOoxh', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (868, 'Du Anqi', 'pUeyZFfmk6', 'YLpdBibOrD', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (869, 'Ota Eita', 'dMiDcU8xhf', '0IUB4BBDXG', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (870, 'Wong Sau Man', 'nLuI9BwFu2', 'rZkWaqeHom', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (871, 'Chang Wing Fat', 'Gdc29i8KTf', 'j3nE2Q7ogj', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (872, 'Yuen Kwok Ming', '3zUyKioosz', 'ASF5G1veTg', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (873, 'Hashimoto Yamato', 'aU2TTuCcbG', 'b6kHzAcruT', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (874, 'Hu Ziyi', '02dWQZXmGM', '8ds51mS1y3', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (875, 'Su Yuning', 'BAsKmp82y1', 'azqoAOHkTN', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (876, 'Tang Wing Sze', 'byRggx5dUj', 'FCSgN8P13F', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (877, 'Murakami Sakura', 'KoEYMHzzDW', 'XTreeuQj34', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (878, 'Cai Yuning', '6SfhCAuexX', 'aK07dneras', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (879, 'Hsuan Chun Yu', 'cVPBHyiuJd', 'vWC7PtuS9D', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (880, 'Siu Kwok Kuen', 'OgMVTG49hO', 'XfBkLlXROY', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (881, 'Andrea Sanchez', 'YbsTMlAgY8', 'uIUeLWRao0', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (882, 'Masuda Eita', '5hoXuBNcBJ', 'jfbsrz6WSx', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (883, 'Norma Wilson', 'Lyg4DGgSNH', 'MnR7vxaOMu', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (884, 'Huang Shihan', '5en49geodg', 'lUYVhMWhWl', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (885, 'Martin Aguilar', 'jWNAu3DyBJ', 'Qsza3BKUIC', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (886, 'Arimura Minato', '8CNMF2clkj', 'LQXpqrxvTN', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (887, 'Nakano Daisuke', 'Ag4jGAqB3v', 'hGBt4bihwo', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (888, 'Cheung Wing Fat', 'R8XJqHOfSD', 'rn6jGgxOOP', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (889, 'Fong Kwok Ming', '5emKZxcP6y', 'v2n03Os9Me', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (890, 'Earl Medina', 'RsYdzrupoL', 'rPfX9vomwN', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (891, 'Chang Wai Lam', 'FpFHrQz4EY', '1y9TMMQdlG', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (892, 'Sakurai Hana', 'CFrc9EkAez', 'qldmCN8Dqk', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (893, 'Phyllis Campbell', 'fsNqiT8o5n', 'GvfPbZnFYd', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (894, 'Jin Yunxi', '7g5BoMHImB', 'E8ldJVcAdj', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (895, 'Su Lu', 'A7CJg2p9XK', 'AtGwtMEreX', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (896, 'Siu Kwok Kuen', 'RbYqb3FJQj', 'i9mMnVk6D0', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (897, 'Helen Campbell', 'GoWvAH713V', 'Va4kL2yei0', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (898, 'Pak Ka Man', 'X9wHO5nuVm', 'Wu2o4mozHq', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (899, 'Tian Lu', '5RpJAQr7Sk', 'Oty57nl1rO', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (900, 'Bruce Jones', 'TehCMn3WOV', 'OPc6nxvXip', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (901, 'Ti Ming', 'zyTwUjs6LL', 'J55dX3mJmW', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (902, 'Chic On Na', 'cVwM93oXUo', 'UOjuJSjtnc', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (903, 'Donna Young', 'NUTByjHBKp', 'nFxJzajwFO', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (904, 'Shi Yuning', 'OcSzVcxmYv', 'Ju4vem6uiE', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (905, 'Chin Sze Kwan', 'BEizNWbj5o', 'wNX01ToU24', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (906, 'Nakamori Yamato', '3q3TEe9Dhv', '6hOdKH9XJJ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (907, 'Kong Chi Yuen', '5htFeYzFix', 'pbH38VQgIo', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (908, 'Willie Taylor', 'VNvrzlYPJt', 'EAauwtmEmD', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (909, 'Murata Hikari', 'S1YDbKj6JR', '3WJACcFFVk', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (910, 'Ogawa Sara', '7b9kbrD7uB', 'NLLMXgQoAt', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (911, 'Kondo Ren', 'mAMGw7UelD', 'HfOxmG9gD6', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (912, 'Ishikawa Eita', '8t4Kr1LjKP', 'c0iTGLXUNe', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (913, 'Catherine Walker', 'rWd0rCCJdg', 'q78Z1hmRKE', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (914, 'Lin Zhennan', 'brSHmPgGy2', 'alBrEpXTdg', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (915, 'Ishida Mio', 'ETRlFwNUPa', 'ROhlKGzK4a', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (916, 'Lo Lik Sun', 'pNQRSfB6wO', 'UaXkJwuYA1', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (917, 'Ye Zitao', 'V53tG1ZGHM', 'iN45qxT8b3', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (918, 'Ku Yu Ling', 'wcjqYp9eYD', '5LGlphSEra', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (919, 'Edith Grant', 'u0wiCgj9DF', 'SpYWveHIm0', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (920, 'Lin Zitao', '2fAPs7vpi5', '1PlTQN5QM8', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (921, 'Miyamoto Minato', '17nQL5eMVC', 'KqCB89nq26', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (922, 'Larry Murphy', 'UblNfFCQOh', 'llmSQfP3ym', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (923, 'Mo Jialun', 'TlguMVU8bJ', 'qm3z1pm9DS', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (924, 'Alfred Simmons', 'AeMiRl5xif', 'QcngkOQpO1', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (925, 'Li Xiaoming', 'swsPJUN5b4', 'b6JmzhGynp', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (926, 'Xu Lan', 'rfemJR2ksU', 'ZLGvXqf4NB', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (927, 'Choi On Na', 'hCDH5Iwnop', '2PHfMDZ4qj', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (928, 'Shao Xiuying', 'KOv8Ze8LH7', 'o636FQjdoB', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (929, 'Wada Mio', 'bvrf5Z8NMO', 'AtOTyufLLc', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (930, 'Mak Hiu Tung', 'oNhMwccXc3', '0mGAeLmG1G', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (931, 'Barbara Guzman', 'lDGy7bArKh', 'sBImqiJPkE', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (932, 'Tong Wing Kuen', 'aNBkpm9Bgp', '6DZKFuiy7a', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (933, 'Elizabeth Stevens', '2WKLdDzqEk', 'uJrQSk9NMI', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (934, 'Choi Ting Fung', 'V6s4azojPP', 'l1VR8ZPXuR', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (935, 'Tang Ka Fai', 'pUT4wZtTZm', 'lUsr2BA6kd', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (936, 'Jiang Lan', 'pyBHQYe6XM', 'rOvcaah0za', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (937, 'Tsui Lik Sun', 'dvT6xWurj3', 'zcmH7LD0PU', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (938, 'Jin Jiehong', 'KuGIPUYTGr', 'xLCK0XF6sI', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (939, 'Mui Chung Yin', 'M3EuH330tT', 'Wg2tnhtj7e', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (940, 'Tong Hok Yau', 'Nk7ThMefTX', 'pi4m0e6yUa', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (941, 'Jesus Lewis', 'vIUVWK7kcq', 'VHLdqIMo2G', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (942, 'Judith Munoz', '2G3oWlVsP0', 'V6KtdKeTVr', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (943, 'Ogawa Mio', 'PmuS6Wnr6v', '1q406l4JA4', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (944, 'Suzuki Mitsuki', 'oaURCyhz4E', 'CzpYj81fwp', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (945, 'Matsuda Momoe', '6uDe6WRoPo', 'dmCjQABgHf', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (946, 'Mori Riku', '3rZSATZH7h', 't04yhtX0WA', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (947, 'Kathryn Webb', 'LNJFE33lT9', '5nFewyyc5m', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (948, 'Frances Russell', 'XXhRrGgPHo', '8KaRG7bkAZ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (949, 'Kwan Hiu Tung', 'Z1ToDq9K2p', 'CY9tzxsIUg', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (950, 'Inoue Yamato', 'pvscWwVpf0', '0R0gYnZfUd', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (951, 'Murata Ryota', 'kSMLoqE1aR', 'aowwv5ort2', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (952, 'Kono Eita', 'E0aKMFDVxY', 'qCxXw7gdDK', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (953, 'Luo Jiehong', 'GB8ARSY5L3', 't3d1aCGhqM', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (954, 'Sato Daisuke', 'MB2jKnMrIM', 'kHOJLCCDLk', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (955, 'Gladys Gordon', 'Q2D5YSQpAE', 'HLgSFPAtGr', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (956, 'Rachel Spencer', 'ex03qm5mLX', '9UcscdDpi8', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (957, 'Harry Martinez', 'GnmEjgjoQt', 'Z5zn7rjQvt', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (958, 'Koon Wing Sze', 'Q0bhiuUfRY', 'IdZ2fWj8c7', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (959, 'Ito Riku', '3IB9fHkQ15', 'f2Wy8Wzk8M', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (960, 'Sara Ellis', '3bIEyaZ98M', '22vvoieNXe', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (961, 'Dai Kwok Kuen', 'wkbQBu8dfM', 'EcDxm2W865', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (962, 'Ryan Fox', 'D2lQ3KKul2', 'L5mq7DwOQ8', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (963, 'Chiba Ryota', '0CYD5a6tgT', 'HA1cDy0dlJ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (964, 'Wu Yunxi', '5zbg2xAiaI', 'LU7jwI6k2x', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (965, 'Ye Rui', 'JoBGlokRWD', 'gG7LBIDH1C', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (966, 'Fujita Miu', 'aVKdonarRZ', '6GveT5BTuc', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (967, 'Lo Wing Fat', 'aV5DD9Hacx', '66munrTtT5', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (968, 'So Tsz Ching', 'EG3sJQXqkN', 'zIQEJVSeNZ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (969, 'Zheng Zhennan', 'VA413cSe6t', 'beBjDehdlx', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (970, 'Xiao Lan', 'cKHIuaLruo', 'xVT74DNIIE', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (971, 'Chiang Chun Yu', 'G8GCCV0Umm', 'MNQoR2LslX', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (972, 'Chiang Wai Man', 'vNESXBlUka', 'V3fu8iUJNa', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (973, 'Alexander Scott', 'agJSgxr55m', 'ylivBWAfbU', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (974, 'Liu Zitao', '0edYAwspx3', 'BKpkBkfQTJ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (975, 'Tong Kwok Ming', 'hHgtb8Icbu', 'ew4J8VH8nz', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (976, 'Zhong Rui', 'VvHFpTMCVq', 'om1pGK6921', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (977, 'Wong Cho Yee', '53lVoLXwUO', 'K6dO5A1Mcx', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (978, 'William Jenkins', '1FM1X1kuJd', '9pGVvlphKn', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (979, 'Kobayashi Ren', 'n2r4wmtfv8', 'SRd8qRItLN', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (980, 'Marilyn Soto', 'pSnOAxnstG', 'WlIf4pzTrG', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (981, 'Shao Rui', 'slpNFpVv9N', 'LlP3HYbh4s', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (982, 'Anthony Hernandez', 'Wm0ca74Zn7', 'EL3gEKDl8p', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (983, 'Lo Chun Yu', '9EHHVr0tde', 'Mwu4d4ZgsO', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (984, 'Ruth Morris', 'THlh60tWGN', 'WWZgonUwPH', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (985, 'Randall King', 'JlE2AyxHsZ', 'n0x4KVAZzq', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (986, 'Timothy Harrison', 'ul81xD1QJg', '6SqhA7QZN7', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (987, 'Shi Lan', 'wuViRrQfzg', 'CiQLfJ0MRs', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (988, 'Yamaguchi Hikari', 'P7Sc5QPUEF', 'VrRNpipqOF', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (989, 'Kobayashi Hazuki', 'mFwni0oVj7', 'yoOaDnUmcb', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (990, 'Sheila Sullivan', 'lNSmOkuUgN', 'QaPDDUP6rP', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (991, 'Ichikawa Airi', 'igPKXBuIGM', 'Sl616pO1P7', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (992, 'Lo Sai Wing', 'IbUHXazjr9', 'wGl8tY0PMs', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (993, 'Mok Tin Lok', 'mcEkS2levs', 'KDhYIpjsWg', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (994, 'Dai Rui', 'MMzaQrrQWL', '2mVGeCgOTt', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (995, 'Xu Xiaoming', 'fT5XC79PGH', 'ESg13bDHdV', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (996, 'Shirley Vargas', 'pguezEDjMc', '9ph6Ox1jBB', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (997, 'Goto Minato', 'U8fDlzPkxT', 'gGrxKg68N3', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (998, 'Cynthia Castro', '1ad0sUQgrk', 'iNn51XRo26', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (999, 'Imai Hikaru', '78Dod74DVe', 'eygwBwURXC', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (1000, 'Man Wing Suen', 'dRgVNcEXqA', 'XDqKXA6TkJ', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (1001, 'Mo Ming Sze', '8o04bZhYNC', 'BKUkOULPl9', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);
INSERT INTO `admin` VALUES (1002, 'Ruby Peterson', 'VLQmFDaX0V', '8nAIeyIYxK', '2025-12-23 16:29:58', '2025-12-23 16:29:58', 0, NULL);

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
-- Records of biz_enterprise
-- ----------------------------
INSERT INTO `biz_enterprise` VALUES (1, 1, '测试科技有限公司', '91110000MA01234567', NULL, '张三', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'PENDING', NULL, NULL, '2025-12-23 17:46:07', '2025-12-23 17:46:07', 0);

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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '网格码表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of biz_grid_code
-- ----------------------------
INSERT INTO `biz_grid_code` VALUES (1, '123321', 3, 'VALID', NULL, NULL, '2025-12-24 11:28:06', '2025-12-24 11:28:06', 0);

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
  UNIQUE INDEX `uk_user_modal_value`(`user_id` ASC, `modal_value` ASC, `deleted` ASC) USING BTREE COMMENT '用户+模态标识唯一约束',
  INDEX `idx_two_factor_value`(`two_factor_value` ASC) USING BTREE COMMENT '双因子码索引',
  INDEX `idx_modal_value`(`modal_value` ASC) USING BTREE COMMENT '模态标识值索引'
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '模态标识表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of biz_modal_identifier
-- ----------------------------
INSERT INTO `biz_modal_identifier` VALUES (18, 261836046331805696, 'TFC-T43G8AP8', 3, '口述历史', 'VALID', 'e4abed33', '2025-12-23 21:08:17', '2025-12-23 21:08:17', 0);
INSERT INTO `biz_modal_identifier` VALUES (19, 261845789125378048, 'TFC-T43G8AP8', 3, '口述历史', 'VALID', 'HASH-C339FFC3', '2025-12-23 21:21:54', '2025-12-23 21:21:54', 0);
INSERT INTO `biz_modal_identifier` VALUES (20, 261850499374907392, 'TFC-T43G8AP8', 3, '口述历史', 'VALID', 'HASH-D76A5A81', '2025-12-23 21:40:37', '2025-12-23 21:40:37', 0);
INSERT INTO `biz_modal_identifier` VALUES (21, 262054658741108736, 'TFC-T43G8AP8', 3, '福伦酒', 'VALID', 'HASH-DF470A0A', '2025-12-24 11:11:54', '2025-12-24 11:11:54', 0);
INSERT INTO `biz_modal_identifier` VALUES (22, 262056264496840704, 'TFC-PER67890', 2, '口述历史', 'VALID', 'HASH-7C5CE3E3', '2025-12-24 11:18:15', '2025-12-24 11:18:15', 0);

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
-- Records of biz_personal
-- ----------------------------
INSERT INTO `biz_personal` VALUES (1, 2, '李四', '110101199001011234', NULL, NULL, NULL, NULL, '中国', NULL, NULL, NULL, NULL, NULL, NULL, 'PENDING', NULL, NULL, '2025-12-23 17:46:07', '2025-12-23 17:46:07', 0);
INSERT INTO `biz_personal` VALUES (2, 3, '张吉哲', '410704200406112018', NULL, NULL, 'MALE', NULL, '中国', '河南省新乡市', '3603086098@qq.com', NULL, NULL, NULL, NULL, 'PENDING', NULL, NULL, '2025-12-23 18:08:12', '2025-12-23 18:08:12', 0);

-- ----------------------------
-- Table structure for biz_project_info
-- ----------------------------
DROP TABLE IF EXISTS `biz_project_info`;
CREATE TABLE `biz_project_info`  (
  `project_id` bigint NOT NULL AUTO_INCREMENT COMMENT '项目唯一标识',
  `modal_id` bigint NULL DEFAULT NULL COMMENT '关联模态标识ID（逻辑外键 -> biz_modal_identifier.modal_id，一个模态标识对应一个活动）',
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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '项目信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of biz_project_info
-- ----------------------------
INSERT INTO `biz_project_info` VALUES (1, 18, 3, '张吉哲口述历史', 1111, '口述历史', NULL, '张吉哲非要口述历史', '2025-12-23 21:08:17', 'ONLINE', '2025-12-23 21:08:17', '2025-12-23 21:08:17', 0);
INSERT INTO `biz_project_info` VALUES (2, 19, 3, '蔡口述', 100, '口述历史', NULL, '蔡口述蔡口述蔡口述', '2025-12-23 21:21:54', 'ONLINE', '2025-12-23 21:21:54', '2025-12-23 21:21:54', 0);
INSERT INTO `biz_project_info` VALUES (3, 20, 3, '蔡口述', 1100, '口述历史', NULL, '蔡口述蔡口述蔡口述', '2025-12-23 21:40:37', 'ONLINE', '2025-12-23 21:40:37', '2025-12-23 21:40:37', 0);
INSERT INTO `biz_project_info` VALUES (4, 21, 3, '蔡买福伦酒', 123, '福伦酒', NULL, '蔡买福伦酒蔡买福伦酒', '2025-12-24 11:11:54', 'ONLINE', '2025-12-24 11:11:54', '2025-12-24 11:11:54', 0);
INSERT INTO `biz_project_info` VALUES (5, 22, 2, '李四口述西游记', 130, '口述历史', NULL, '李四口述西游记李四口述西游记', '2025-12-24 11:18:15', 'ONLINE', '2025-12-24 11:18:15', '2025-12-24 11:18:15', 0);

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
  `remaining_modals` bigint NULL DEFAULT 100000000 COMMENT '剩余模态标识数量（默认1亿）',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `deleted` tinyint NOT NULL DEFAULT 0 COMMENT '逻辑删除：0-未删除，1-已删除',
  PRIMARY KEY (`two_factor_id`) USING BTREE,
  UNIQUE INDEX `uk_two_factor_value`(`two_factor_value` ASC, `deleted` ASC) USING BTREE COMMENT '双因子码唯一约束',
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE COMMENT '用户ID索引',
  INDEX `idx_grid_code_value`(`grid_code_value` ASC) USING BTREE COMMENT '网格码值索引'
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '双因子码表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of biz_two_factor_code
-- ----------------------------
INSERT INTO `biz_two_factor_code` VALUES (1, 'TFC-ENT12345', 1, NULL, 'ASSET', 'ACTIVATED', 100000000, '2025-12-23 17:46:07', '2025-12-23 17:46:07', 0);
INSERT INTO `biz_two_factor_code` VALUES (2, 'TFC-PER67890', 1, NULL, 'PERSONAL', 'ACTIVATED', 99999999, '2025-12-23 17:46:07', '2025-12-24 11:18:15', 0);
INSERT INTO `biz_two_factor_code` VALUES (3, 'TFC-T43G8AP8', 3, '123321', 'PERSONAL', 'ACTIVATED', 99999998, '2025-12-23 18:08:12', '2025-12-24 11:28:06', 0);

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
-- Records of biz_user
-- ----------------------------
INSERT INTO `biz_user` VALUES (1, 'ENTERPRISE', '13800138000', 'encrypted_password_123', 'TFC-ENT12345', NULL, NULL, 0, 'ACTIVE', '2025-12-23 17:46:07', '2025-12-23 17:46:07', 0);
INSERT INTO `biz_user` VALUES (2, 'PERSONAL', '13900139000', 'encrypted_password_456', 'TFC-PER67890', NULL, NULL, 0, 'ACTIVE', '2025-12-23 17:46:07', '2025-12-23 17:46:07', 0);
INSERT INTO `biz_user` VALUES (3, 'PERSONAL', '13525055216', '123456', 'TFC-T43G8AP8', '123321', NULL, 1, 'ACTIVE', '2025-12-23 18:08:12', '2025-12-24 11:28:06', 0);

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

-- ----------------------------
-- Records of user_modal
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
