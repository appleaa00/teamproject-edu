/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.176.1-mysql
 Source Server Type    : MySQL
 Source Server Version : 80041
 Source Host           : 192.168.176.1:3306
 Source Schema         : course_ai

 Target Server Type    : MySQL
 Target Server Version : 80041
 File Encoding         : 65001

 Date: 07/07/2025 21:52:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for a7_paper
-- ----------------------------
DROP TABLE IF EXISTS `a7_paper`;
CREATE TABLE `a7_paper`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_dept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `paper_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '试卷名称',
  `create_role` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '当前试卷是什么角色的人创建的',
  `create_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人姓名',
  `paper_difficulty` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '测验难度（基础、中等、挑战）',
  `paper_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '试卷类型（全部题型、编程题、选择题）',
  `paper_subject` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '科目：计算机科学与技术',
  `topic_number` int NULL DEFAULT NULL COMMENT '题目数量',
  `answer_time` int NULL DEFAULT NULL COMMENT '答题时间（单位：分钟）',
  `collection` bit(1) NULL DEFAULT b'0' COMMENT '收藏',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1941674286618849282 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试卷信息对象' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of a7_paper
-- ----------------------------

-- ----------------------------
-- Table structure for a7_paper_answer
-- ----------------------------
DROP TABLE IF EXISTS `a7_paper_answer`;
CREATE TABLE `a7_paper_answer`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_dept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `paper_id` bigint NULL DEFAULT NULL COMMENT '试卷ID',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户ID',
  `topic_id` bigint NULL DEFAULT NULL COMMENT '题目ID',
  `topic_write` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '填写答案',
  `right_answer` bit(1) NULL DEFAULT b'0' COMMENT '是否正确',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1941674432949727235 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试卷信息对象' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of a7_paper_answer
-- ----------------------------

-- ----------------------------
-- Table structure for a7_paper_user_relation
-- ----------------------------
DROP TABLE IF EXISTS `a7_paper_user_relation`;
CREATE TABLE `a7_paper_user_relation`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_dept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `paper_id` bigint NULL DEFAULT NULL COMMENT '试卷ID',
  `user_id` bigint NULL DEFAULT NULL COMMENT '考试人',
  `finished` bit(1) NULL DEFAULT b'0' COMMENT '是否完成（默认false）',
  `finish_time` int NULL DEFAULT NULL COMMENT '完成时间（单位：分钟）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1941674432819703811 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试卷信息对象' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of a7_paper_user_relation
-- ----------------------------

-- ----------------------------
-- Table structure for a7_topic
-- ----------------------------
DROP TABLE IF EXISTS `a7_topic`;
CREATE TABLE `a7_topic`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_dept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `paper_id` bigint NULL DEFAULT NULL COMMENT '关联试卷ID',
  `topic_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '题目名称',
  `topic_difficulty` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '题目难度 基础、中等、挑战',
  `topic_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '题目类型 选择题、编程题',
  `topic_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '题目内容',
  `topic_answer` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '参考答案',
  `collection` bit(1) NULL DEFAULT b'0' COMMENT '收藏',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1941674287650648067 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试卷信息对象' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of a7_topic
-- ----------------------------

-- ----------------------------
-- Table structure for a7_topic_option
-- ----------------------------
DROP TABLE IF EXISTS `a7_topic_option`;
CREATE TABLE `a7_topic_option`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_dept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `topic_id` bigint NULL DEFAULT NULL COMMENT '所属题目ID',
  `sorted` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '排序，选择题则以1、2、3或者A、B、C去录入',
  `option_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '选项内容',
  `right_answer` bit(1) NULL DEFAULT b'0' COMMENT '是否是正确答案',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1941674287583539202 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '试卷信息对象' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of a7_topic_option
-- ----------------------------

-- ----------------------------
-- Table structure for b4_video_course
-- ----------------------------
DROP TABLE IF EXISTS `b4_video_course`;
CREATE TABLE `b4_video_course`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `create_dept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `video_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视频名称',
  `video_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视频类型',
  `video_size` bigint NULL DEFAULT NULL COMMENT '视频大小',
  `formatted_size` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视频大小',
  `video_duration` decimal(10, 2) NULL DEFAULT NULL COMMENT '视频时常',
  `formatted_duration` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视频时常',
  `collection` bit(1) NULL DEFAULT b'0' COMMENT '收藏',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1941835562112368643 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '视频课程对象' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of b4_video_course
-- ----------------------------
INSERT INTO `b4_video_course` VALUES (1941835562112368642, NULL, NULL, '2025-07-06 20:24:10', NULL, '2025-07-06 20:24:10', '生物神经元与神经网络', 'mp4', 100908985, '96.23 MB', 527.30, '8:47', b'0');

-- ----------------------------
-- Table structure for chat_config
-- ----------------------------
DROP TABLE IF EXISTS `chat_config`;
CREATE TABLE `chat_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置类型',
  `config_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置名称',
  `config_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置值',
  `config_dict` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '说明',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `version` int NULL DEFAULT NULL COMMENT '版本',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `update_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新IP',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户Id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_category_key`(`category` ASC, `config_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1904862904897019906 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '配置信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_config
-- ----------------------------
INSERT INTO `chat_config` VALUES (1779450794448789505, 'chat', 'apiKey', 'sk-xx', 'API 密钥', 103, '2024-04-14 18:05:05', '1', '1', '2025-03-31 19:54:16', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779450794872414210, 'chat', 'apiHost', 'https://api.pandarobot.chat/', 'API 地址', 103, '2024-04-14 18:05:05', '1', '1', '2025-03-31 19:54:16', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779497340548784129, 'pay', 'pid', '1000', '商户PID', 103, '2024-04-14 21:10:02', '1', '1', '2025-05-23 15:11:40', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779497340938854401, 'pay', 'key', 'xx', '商户密钥', 103, '2024-04-14 21:10:02', '1', '1', '2025-05-23 15:11:40', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779497341135986690, 'pay', 'payUrl', 'https://pay.pandarobot.chat/mapi.php', '支付地址', 103, '2024-04-14 21:10:02', '1', '1', '2025-05-23 15:11:40', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779497341400227842, 'pay', 'notify_url', 'https://www.pandarobot.chat/pay/notifyUrl', '回调地址', 103, '2024-04-14 21:10:02', '1', '1', '2025-05-23 15:11:40', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779497341588971522, 'pay', 'return_url', 'https://www.pandarobot.chat/pay/returnUrl', '跳转通知', 103, '2024-04-14 21:10:02', '1', '1', '2024-04-28 17:46:31', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779513580331835394, 'mail', 'host', 'smtp.163.com', '主机地址', 103, '2024-04-14 22:14:34', '1', '1', '2025-05-23 15:12:45', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779513580658991106, 'mail', 'port', '465', '主机端口', 103, '2024-04-14 22:14:34', '1', '1', '2025-05-23 15:12:46', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779513580919037953, 'mail', 'from', 'ageerle@163.com', '发送方', 103, '2024-04-14 22:14:34', '1', '1', '2025-05-23 15:12:46', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779513581107781634, 'mail', 'user', 'ageerle@163.com', '用户名', 103, '2024-04-14 22:14:34', '1', '1', '2025-05-23 15:12:46', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779513581309108225, 'mail', 'pass', 'xxxx', '授权码', 103, '2024-04-14 22:14:34', '1', '1', '2025-05-23 15:12:46', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1786058372188569602, 'review', 'enabled', 'false', '文本审核', 103, '2024-05-02 23:41:14', '1', '1', '2025-03-30 22:45:29', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1786058372637360129, 'review', 'apiKey', 'xx', 'apiKey', 103, '2024-05-02 23:41:14', '1', '1', '2025-03-30 22:45:29', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1786058372897406977, 'review', 'secretKey', 'xx', 'secretKey', 103, '2024-05-02 23:41:14', '1', '1', '2025-03-30 22:45:29', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1792207511704100866, 'sys', 'name', '熊猫助手', '网站名称', 103, '2024-05-19 22:55:43', '1', '1', '2025-03-26 19:48:33', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1792207512089976834, 'sys', 'logoImage', 'http://panda-1253683406.cos.ap-guangzhou.myqcloud.com/panda/2024/05/19/4c106628754b4bd882a4c002eaa317f5.jpg', '网站logo', 103, '2024-05-19 22:55:43', '1', '1', '2025-03-26 19:48:33', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1792207512412938241, 'sys', 'copyright', 'ageerle', '版权信息', 103, '2024-05-19 22:55:43', '1', '1', '2025-03-26 19:48:33', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1792207512740093954, 'sys', 'customImage', '', '客服二维码', 103, '2024-05-19 22:55:43', '1', '1', '2025-03-26 19:48:33', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1811317732300914689, 'mail', 'mailModel', '<p>您此次的验证码为：{code}，有效期为30分钟，请尽快填写!</p><p><br></p>', '邮箱模板', 103, '2024-07-11 16:32:55', '1', '1', '2024-07-17 17:28:52', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1813506141979254785, 'mail', 'mailTitle', '【熊猫助手】验证码', '邮箱标题', 103, '2024-07-17 17:28:52', '1', '1', '2024-07-17 17:28:52', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1897610056458412050, 'weaviate', 'protocol', 'http', '协议', 103, '2025-03-06 21:10:02', '1', '1', '2025-03-06 21:10:31', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1897610056458412051, 'weaviate', 'host', '127.0.0.1:6038', '地址', 103, '2025-03-06 21:10:02', '1', '1', '2025-03-06 21:10:31', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1897610056458412052, 'weaviate', 'classname', 'LocalKnowledge', '分类名称', 103, '2025-03-06 21:10:02', '1', '1', '2025-03-06 21:10:31', NULL, NULL, '0', NULL, 0);

-- ----------------------------
-- Table structure for chat_message
-- ----------------------------
DROP TABLE IF EXISTS `chat_message`;
CREATE TABLE `chat_message`  (
  `id` bigint NOT NULL COMMENT '主键',
  `session_id` bigint NULL DEFAULT NULL COMMENT '会话id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '消息内容',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '对话角色',
  `deduct_cost` double(20, 2) NULL DEFAULT 0.00 COMMENT '扣除金额',
  `total_tokens` int NULL DEFAULT 0 COMMENT '累计 Tokens',
  `model_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模型名称',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '聊天消息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_message
-- ----------------------------

-- ----------------------------
-- Table structure for chat_model
-- ----------------------------
DROP TABLE IF EXISTS `chat_model`;
CREATE TABLE `chat_model`  (
  `id` bigint NOT NULL COMMENT '主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `category` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模型分类',
  `model_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模型名称',
  `model_describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模型描述',
  `model_price` double NULL DEFAULT NULL COMMENT '模型价格',
  `model_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '计费类型',
  `model_show` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否显示',
  `system_prompt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '系统提示词',
  `api_host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求地址',
  `api_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密钥',
  `api_url` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求后缀',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '聊天模型' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_model
-- ----------------------------
INSERT INTO `chat_model` VALUES (1782792839548735490, '000000', 'chat', 'midjourney', 'midjourney', 0.5, '2', '1', NULL, 'https://api.pandarobot.chat/', 'sk-xx', NULL, 103, 1, '2024-04-23 23:25:10', 1, '2025-03-23 09:15:55', 'midjourney');
INSERT INTO `chat_model` VALUES (1782792839548735491, '000000', 'chat', 'suno', 'suno', 0.3, '2', '1', NULL, 'https://api.pandarobot.chat/', 'sk-xx', NULL, 103, 1, '2024-04-23 23:25:10', 1, '2024-12-27 22:29:15', 'suno');
INSERT INTO `chat_model` VALUES (1782792839548735492, '000000', 'chat', 'luma', 'luma', 1, '2', '1', NULL, 'https://api.pandarobot.chat/', 'sk-xx', NULL, 103, 1, '2024-04-23 23:25:10', 1, '2025-03-27 10:08:15', 'luma');
INSERT INTO `chat_model` VALUES (1782792839548735493, '000000', 'chat', 'ppt', 'ppt', 1.1, '2', '1', NULL, 'https://docmee.cn', 'sk-xx', NULL, 103, 1, '2025-01-10 23:25:10', 1, '2025-03-22 08:30:29', 'ppt');
INSERT INTO `chat_model` VALUES (1828324413241466880, '000000', 'vector', 'quentinz/bge-large-zh-v1.5', 'bge-large-zh-v1.5', 0, '2', '1', NULL, 'http://127.0.0.1:11434/', 'sk-xx', NULL, 103, 1, '2025-04-03 07:28:56', 1, '2025-05-24 17:25:57', 'bge-large-zh-v1.5');
INSERT INTO `chat_model` VALUES (1828324413241466881, '000000', 'vector', 'baai/bge-m3', 'baai/bge-m3', 0.01, '2', '1', NULL, 'https://api.ppinfra.com/v3/openai', 'sk-xx', NULL, 103, 1, '2024-08-27 14:51:23', 1, '2025-05-24 17:33:11', 'BGE-M3 是一款具备多维度能力的文本嵌入模型，可同时实现密集检索、多向量检索和稀疏检索三大核心功能。该模型设计上兼容超过100种语言，并支持从短句到长达8192词元的长文本等多种输入形式。在跨语言检索任务中，BGE-M3展现出显著优势，其性能在MIRACL、MKQA等国际基准测试中位居前列。此外，针对长文档检索场景，该模型在MLDR、NarritiveQA等数据集上的表现同样达到行业领先水平。');
INSERT INTO `chat_model` VALUES (1859570229117022211, '000000', 'chat', 'deepseek/deepseek-v3-0324', 'deepseek/deepseek-v3-0324', 0.1, '1', '0', '', 'https://api.ppinfra.com/v3/openai/chat/completions', 'sk-xx', NULL, 103, 1, '2024-11-21 20:11:06', 1, '2025-05-24 17:56:22', 'DeepSeek V3 0324 是深度求索（DeepSeek）团队旗舰级对话模型系列的最新版本，采用混合专家（Mixture-of-Experts, MoE）架构，参数量达685B参数。');
INSERT INTO `chat_model` VALUES (1859570229117022212, '000000', 'chat', 'deepseek/deepseek-r1', 'deepseek/deepseek-r1', 0.1, '1', '0', '', 'https://api.ppinfra.com/v3/openai/chat/completions', 'sk-xx', NULL, 103, 1, '2024-11-21 20:11:06', 1, '2025-05-24 17:56:14', 'DeepSeek R1是DeepSeek团队发布的最新开源模型，具备非常强悍的推理性能，尤其在数学、编程和推理任务上达到了与OpenAI的o1模型相当的水平。');
INSERT INTO `chat_model` VALUES (1926215622017482754, '000000', 'chat', 'gpt-4o-mini', 'gpt-4o-mini', 0.1, '1', '0', NULL, 'https://api.pandarobot.chat/v1/chat/completions/', 'sk-xx', NULL, 103, 1, '2025-05-24 17:56:06', 1, '2025-05-24 17:56:06', 'gpt 多模态模型');
INSERT INTO `chat_model` VALUES (1926215622017482755, '000000', 'chat', 'gpt-4-all', 'gpt-4-all', 0.5, '2', '0', NULL, 'https://api.pandarobot.chat/v1/chat/completions/', 'sk-xx', NULL, 103, 1, '2025-05-24 17:56:06', 1, '2025-05-24 17:59:21', 'gpt 逆向多模态模型');
INSERT INTO `chat_model` VALUES (1941174478724440066, '000000', 'chat', 'deepseek/deepseek-r1-0528-qwen3-8b', 'DeepSeek-R1-0528-Qwen3-8B 是基于 Qwen3 8B Base 模型，通过融合 DeepSeek-R1-0528 的思维链（Chain-of-Thought）优化训练而成的高性能推理模型。在 AIME 2024 评测中，该模型以开源模型身份达到最先进（SOTA）水平，性能较原版 Qwen3 8B 提升 10%，并展现出与 2350 亿参数的 Qwen3-235B-thinking 相当的推理能力。', 0, '2', '0', NULL, 'https://api.ppinfra.com/v3/openai/chat/completions', 'sk_5oBTA76IPExaU0UBXTa8M-Hih4PUsd5f2WoNPnqn6Qg', NULL, 103, 1, '2025-07-05 00:37:16', 1, '2025-07-05 00:37:16', 'DeepSeek-R1-0528-Qwen3-8B 是基于 Qwen3 8B Base 模型，通过融合 DeepSeek-R1-0528 的思维链（Chain-of-Thought）优化训练而成的高性能推理模型。在 AIME 2024 评测中，该模型以开源模型身份达到最先进（SOTA）水平，性能较原版 Qwen3 8B 提升 10%，并展现出与 2350 亿参数的 Qwen3-235B-thinking 相当的推理能力。');

-- ----------------------------
-- Table structure for chat_pay_order
-- ----------------------------
DROP TABLE IF EXISTS `chat_pay_order`;
CREATE TABLE `chat_pay_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `order_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单名称',
  `amount` decimal(10, 2) NOT NULL COMMENT '金额',
  `payment_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付状态',
  `payment_method` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付方式',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户ID',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '支付订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_pay_order
-- ----------------------------

-- ----------------------------
-- Table structure for chat_session
-- ----------------------------
DROP TABLE IF EXISTS `chat_session`;
CREATE TABLE `chat_session`  (
  `id` bigint NOT NULL COMMENT '主键',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  `session_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '会话标题',
  `session_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '会话内容',
  `create_dept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会话管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_session
-- ----------------------------

-- ----------------------------
-- Table structure for chat_usage_token
-- ----------------------------
DROP TABLE IF EXISTS `chat_usage_token`;
CREATE TABLE `chat_usage_token`  (
  `id` bigint NOT NULL COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户',
  `token` int NULL DEFAULT NULL COMMENT '待结算token',
  `model_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模型名称',
  `total_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '累计使用token',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户token使用详情' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_usage_token
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1906673888229167105, 1906673887579049985, 'id', '主键', 'bigint(20)', 'Integer', 'id', '1', '1', '1', '0', '1', '1', '0', 'EQ', 'input', '', 1, 103, 1, '2025-03-31 19:44:14', 1, '2025-05-23 09:13:04');
INSERT INTO `gen_table_column` VALUES (1906673888229167106, 1906673887579049985, 'category', '配置类型', 'varchar(255)', 'String', 'category', '0', '0', '1', '0', '0', '1', '1', 'EQ', 'input', '', 2, 103, 1, '2025-03-31 19:44:14', 1, '2025-05-23 09:13:04');
INSERT INTO `gen_table_column` VALUES (1906673888229167107, 1906673887579049985, 'config_name', '配置名称', 'varchar(255)', 'String', 'configName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 103, 1, '2025-03-31 19:44:14', 1, '2025-05-23 09:13:04');
INSERT INTO `gen_table_column` VALUES (1906673888229167108, 1906673887579049985, 'config_value', '配置值', 'text', 'String', 'configValue', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', 4, 103, 1, '2025-03-31 19:44:14', 1, '2025-05-23 09:13:04');
INSERT INTO `gen_table_column` VALUES (1906673888229167109, 1906673887579049985, 'config_dict', '说明', 'varchar(255)', 'String', 'configDict', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 103, 1, '2025-03-31 19:44:14', 1, '2025-05-23 09:13:04');
INSERT INTO `gen_table_column` VALUES (1906673888229167110, 1906673887579049985, 'create_dept', '创建部门', 'bigint(20)', 'Long', 'createDept', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'input', '', 6, 103, 1, '2025-03-31 19:44:14', 1, '2025-05-23 09:13:04');
INSERT INTO `gen_table_column` VALUES (1906673888229167111, 1906673887579049985, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'datetime', '', 7, 103, 1, '2025-03-31 19:44:14', 1, '2025-05-23 09:13:04');
INSERT INTO `gen_table_column` VALUES (1906673888229167112, 1906673887579049985, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'input', '', 8, 103, 1, '2025-03-31 19:44:14', 1, '2025-05-23 09:13:04');
INSERT INTO `gen_table_column` VALUES (1906673888229167113, 1906673887579049985, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'input', '', 9, 103, 1, '2025-03-31 19:44:14', 1, '2025-05-23 09:13:04');
INSERT INTO `gen_table_column` VALUES (1906673888229167114, 1906673887579049985, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'datetime', '', 10, 103, 1, '2025-03-31 19:44:14', 1, '2025-05-23 09:13:04');
INSERT INTO `gen_table_column` VALUES (1906673888229167115, 1906673887579049985, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'textarea', '', 11, 103, 1, '2025-03-31 19:44:14', 1, '2025-05-23 09:13:04');
INSERT INTO `gen_table_column` VALUES (1906673888229167116, 1906673887579049985, 'version', '版本', 'int(11)', 'Long', 'version', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'input', '', 12, 103, 1, '2025-03-31 19:44:14', 1, '2025-05-23 09:13:04');
INSERT INTO `gen_table_column` VALUES (1906673888292081665, 1906673887579049985, 'del_flag', '删除标志（0代表存在 1代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'input', '', 13, 103, 1, '2025-03-31 19:44:14', 1, '2025-05-23 09:13:04');
INSERT INTO `gen_table_column` VALUES (1906673888292081666, 1906673887579049985, 'update_ip', '更新IP', 'varchar(128)', 'String', 'updateIp', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 14, 103, 1, '2025-03-31 19:44:14', 1, '2025-05-23 09:13:04');
INSERT INTO `gen_table_column` VALUES (1906673888292081667, 1906673887579049985, 'tenant_id', '租户Id', 'bigint(20)', 'Long', 'tenantId', '0', '0', '1', '0', '0', '0', '0', 'EQ', 'input', '', 15, 103, 1, '2025-03-31 19:44:14', 1, '2025-05-23 09:13:04');

-- ----------------------------
-- Table structure for knowledge_attach
-- ----------------------------
DROP TABLE IF EXISTS `knowledge_attach`;
CREATE TABLE `knowledge_attach`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `kid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '知识库ID',
  `doc_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文档ID',
  `doc_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文档名称',
  `doc_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文档类型',
  `oss_id` int NULL DEFAULT NULL COMMENT '对象存储ID',
  `pic_status` tinyint(1) NOT NULL DEFAULT 10 COMMENT '拆解图片状态10未开始，20进行中，30已完成',
  `pic_anys_status` tinyint(1) NOT NULL DEFAULT 10 COMMENT '分析图片状态10未开始，20进行中，30已完成',
  `vector_status` tinyint(1) NOT NULL DEFAULT 10 COMMENT '写入向量数据库状态10未开始，20进行中，30已完成',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '文档内容',
  `create_dept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_kname`(`kid` ASC, `doc_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1941675048744857603 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '知识库附件' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of knowledge_attach
-- ----------------------------
INSERT INTO `knowledge_attach` VALUES (1941675048744857602, '1941674988518846466', 'dMRhdm7Eel', 'Python 编程基础学习文档.pdf', 'pdf', NULL, 10, 10, 10, '环境搭建\r\n 安装 Python：前往 Python 官方网站（https://www.python.org/）下载适合你操作系统的 Python 安装包，\r\n建议安装最新稳定版的 Python 3.x 系列。安装过程中可勾选添加到系统路径，方便后续在命令行中使用。\r\n 选择编辑器：推荐使用 PyCharm，它功能强大，适合大型项目开发；也可使用 VSCode，轻量级且插件丰富。\r\n安装完成后，配置好 Python 解释器路径。\r\n基础语法\r\n 变量和数据类型 1：了解如何创建变量，掌握整数、浮点数、字符串、列表、元组、字典和集合等基本数据类\r\n型的定义与特点，以及它们之间的转换方法。\r\n 运算符 1：学习算术操作符（如 +、-、*、/ 等）、比较操作符（如 >、<、== 等）和逻辑操作符（如 and、\r\nor、not），能够运用它们进行变量之间的运算和比较。\r\n 流程控制 1：学会使用 if、else、elif 条件语句进行分支判断，以及 for、while 循环语句来实现重复执行的\r\n逻辑，掌握 break、continue 等关键字在循环中的作用。\r\n函数与模块\r\n 函数 1：掌握函数的定义和调用方法，理解参数传递方式（值传递、引用传递）、返回值的概念，以及函数的\r\n作用域规则，学会使用默认参数、可变参数等高级特性。\r\n 模块 1：了解 Python 标准库，学会使用 import 语句导入模块，掌握 import、from...import 等不同的导入\r\n方式，能够使用模块中的函数和类，还可以创建自己的模块，实现代码的复用。\r\n数据结构操作\r\n 列表、元组和集合 1：熟练掌握列表的增删改查操作，如 append、insert、pop 等方法；了解元组的不可变\r\n性；掌握集合的去重特性和常见集合运算（并集、交集、差集等）。\r\n 字典 1：学会创建和访问字典，掌握字典的键值对操作，如添加元素、修改元素、删除元素，以及遍历字典的\r\n各种方式。\r\n文件操作 1\r\n 学会使用 open 函数打开文件，掌握文件的读取模式（r）、写入模式（w）、追加模式（a）等，能够进行文\r\n件的读取（read、readline 等方法）、写入（write 方法）操作，以及关闭文件，了解 with 语句在文件操作\r\n中的优势，用于自动管理文件资源。\r\n面向对象编程 1\r\n 理解类和对象的概念，学会定义类，包括类的属性和方法，掌握对象的创建和使用。了解继承和多态的概念，\r\n能够通过继承创建子类，重写父类方法，实现多态性，提升代码的可维护性和扩展性。\r\n异常处理 1\r\n 掌握 try、except 语句的用法，能够捕获常见的异常类型（如 TypeError、FileNotFoundError 等），并进行\r\n相应的处理，使程序在遇到错误时更加健壮，还可以自定义异常类，以满足特定的业务需求。\r\n正则表达式 1\r\n 了解正则表达式的基本语法，掌握常见的元字符（如.、*、+、? 等）和字符类（如 \\d、\\w 等），能够使用\r\n正则表达式进行字符串的模式匹配、搜索和替换操作，常用于处理文本数据、验证输入等场景。\r\n基本算法和数据结构 1\r\n 了解一些基本的算法，如排序算法（冒泡排序、选择排序、插入排序等）和搜索算法（顺序搜索、二分搜索），\r\n掌握栈、队列等基本数据结构的原理和操作方法，为后续学习更复杂的算法和数据结构奠定基础。\r\n你可以根据以上内容自行整理成 PDF 文件，若有需要，也可以使用一些在线文档转换工具，将上述内容复制粘贴到工\r\n具中，转换为 PDF 格式。\r\n', '103', '1941157755342352386', '2025-07-06 09:46:21', 1941157755342352386, '2025-07-06 09:46:21', NULL);

-- ----------------------------
-- Table structure for knowledge_fragment
-- ----------------------------
DROP TABLE IF EXISTS `knowledge_fragment`;
CREATE TABLE `knowledge_fragment`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `kid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '知识库ID',
  `doc_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文档ID',
  `fid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '知识片段ID',
  `idx` int NOT NULL COMMENT '片段索引下标',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文档内容',
  `create_dept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1941675048677748742 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '知识片段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of knowledge_fragment
-- ----------------------------
INSERT INTO `knowledge_fragment` VALUES (1941675048614834177, '1941674988518846466', 'dMRhdm7Eel', '8yvwYsF1ft', 0, '环境搭建\r\n 安装 Python：前往 Python 官方网站（https://www.python.org/）下载适合你操作系统的 Python 安装包，\r\n建议安装最新稳定版的 Python 3.x 系列。安装过程中可勾选添加到系统路径，方便后续在命令行中使用。\r\n 选择编辑器：推荐使用 PyCharm，它功能强大，适合大型项目开发；也可使用 VSCode，轻量级且插件丰富。\r\n安装完成后，配置好 Python 解释器路径。\r\n基础语法\r\n 变量和数据类型 1：了解如何创建变量，掌握整数、浮点数、字符串、列表、元组、字典和集合等基本数据类\r\n型的定义与特点，以及它们之间的转换方法。\r\n 运算符 1：学习算术操作符（如 +、-、*、/ 等）、', '103', '1941157755342352386', '2025-07-06 09:46:21', 1941157755342352386, '2025-07-06 09:46:21', NULL);
INSERT INTO `knowledge_fragment` VALUES (1941675048614834178, '1941674988518846466', 'dMRhdm7Eel', 'dhs5tX3UjG', 1, '合等基本数据类\r\n型的定义与特点，以及它们之间的转换方法。\r\n 运算符 1：学习算术操作符（如 +、-、*、/ 等）、比较操作符（如 >、<、== 等）和逻辑操作符（如 and、\r\nor、not），能够运用它们进行变量之间的运算和比较。\r\n 流程控制 1：学会使用 if、else、elif 条件语句进行分支判断，以及 for、while 循环语句来实现重复执行的\r\n逻辑，掌握 break、continue 等关键字在循环中的作用。\r\n函数与模块\r\n 函数 1：掌握函数的定义和调用方法，理解参数传递方式（值传递、引用传递）、返回值的概念，以及函数的\r\n作用域规则，学会使用默认参数、可变参数等高级特性。\r\n 模块 1：了解 Python 标准库，学会使用 import 语句导入模块，掌握 import、fr', '103', '1941157755342352386', '2025-07-06 09:46:21', 1941157755342352386, '2025-07-06 09:46:21', NULL);
INSERT INTO `knowledge_fragment` VALUES (1941675048677748738, '1941674988518846466', 'dMRhdm7Eel', 'wK7BpAXWCP', 2, '等高级特性。\r\n 模块 1：了解 Python 标准库，学会使用 import 语句导入模块，掌握 import、from...import 等不同的导入\r\n方式，能够使用模块中的函数和类，还可以创建自己的模块，实现代码的复用。\r\n数据结构操作\r\n 列表、元组和集合 1：熟练掌握列表的增删改查操作，如 append、insert、pop 等方法；了解元组的不可变\r\n性；掌握集合的去重特性和常见集合运算（并集、交集、差集等）。\r\n 字典 1：学会创建和访问字典，掌握字典的键值对操作，如添加元素、修改元素、删除元素，以及遍历字典的\r\n各种方式。\r\n文件操作 1\r\n 学会使用 open 函数打开文件，掌握文件的读取模式（r）、写入模式（w）、追加模式（a）等，能够进行文\r\n件的读取（read、readline', '103', '1941157755342352386', '2025-07-06 09:46:21', 1941157755342352386, '2025-07-06 09:46:21', NULL);
INSERT INTO `knowledge_fragment` VALUES (1941675048677748739, '1941674988518846466', 'dMRhdm7Eel', '3cmltBef9H', 3, '打开文件，掌握文件的读取模式（r）、写入模式（w）、追加模式（a）等，能够进行文\r\n件的读取（read、readline 等方法）、写入（write 方法）操作，以及关闭文件，了解 with 语句在文件操作\r\n中的优势，用于自动管理文件资源。\r\n面向对象编程 1\r\n 理解类和对象的概念，学会定义类，包括类的属性和方法，掌握对象的创建和使用。了解继承和多态的概念，\r\n能够通过继承创建子类，重写父类方法，实现多态性，提升代码的可维护性和扩展性。\r\n异常处理 1\r\n 掌握 try、except 语句的用法，能够捕获常见的异常类型（如 TypeError、FileNotFoundError 等），并进行\r\n相应的处理，使程序在遇到错误时更加健壮，还可以自定义异常类，以满足特定的业务需求。\r\n正则表达式 1\r\n 了', '103', '1941157755342352386', '2025-07-06 09:46:21', 1941157755342352386, '2025-07-06 09:46:21', NULL);
INSERT INTO `knowledge_fragment` VALUES (1941675048677748740, '1941674988518846466', 'dMRhdm7Eel', 'kQWiGPLTiJ', 4, '并进行\r\n相应的处理，使程序在遇到错误时更加健壮，还可以自定义异常类，以满足特定的业务需求。\r\n正则表达式 1\r\n 了解正则表达式的基本语法，掌握常见的元字符（如.、*、+、? 等）和字符类（如 \\d、\\w 等），能够使用\r\n正则表达式进行字符串的模式匹配、搜索和替换操作，常用于处理文本数据、验证输入等场景。\r\n基本算法和数据结构 1\r\n 了解一些基本的算法，如排序算法（冒泡排序、选择排序、插入排序等）和搜索算法（顺序搜索、二分搜索），\r\n掌握栈、队列等基本数据结构的原理和操作方法，为后续学习更复杂的算法和数据结构奠定基础。\r\n你可以根据以上内容自行整理成 PDF 文件，若有需要，也可以使用一些在线文档转换工具，将上述内容复制粘贴到工\r\n具中，转换为 PDF 格式。\r\n', '103', '1941157755342352386', '2025-07-06 09:46:21', 1941157755342352386, '2025-07-06 09:46:21', NULL);
INSERT INTO `knowledge_fragment` VALUES (1941675048677748741, '1941674988518846466', 'dMRhdm7Eel', 'w7UAAcEeE9', 5, '用一些在线文档转换工具，将上述内容复制粘贴到工\r\n具中，转换为 PDF 格式。\r\n', '103', '1941157755342352386', '2025-07-06 09:46:21', 1941157755342352386, '2025-07-06 09:46:21', NULL);

-- ----------------------------
-- Table structure for knowledge_info
-- ----------------------------
DROP TABLE IF EXISTS `knowledge_info`;
CREATE TABLE `knowledge_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `kid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '知识库ID',
  `uid` bigint NOT NULL DEFAULT 0 COMMENT '用户ID',
  `kname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '知识库名称',
  `share` tinyint NULL DEFAULT NULL COMMENT '是否公开知识库（0 否 1是）',
  `description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `knowledge_separator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '知识分隔符',
  `question_separator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提问分隔符',
  `overlap_char` int NULL DEFAULT NULL COMMENT '重叠字符数',
  `retrieve_limit` int NULL DEFAULT NULL COMMENT '知识库中检索的条数',
  `text_block_size` int NULL DEFAULT NULL COMMENT '文本块大小',
  `vector_model_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '向量库',
  `embedding_model_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '向量模型',
  `system_prompt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '系统提示词',
  `create_dept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_kid`(`kid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1941674988518846467 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '知识库' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of knowledge_info
-- ----------------------------
INSERT INTO `knowledge_info` VALUES (1941674988518846466, 'r4C8lEkmRA', 1941157755342352386, 'Python学习', 0, 'Python学习', '', '', 30, 5, 300, 'weaviate', 'baai/bge-m3', NULL, '103', '1941157755342352386', '2025-07-06 09:46:07', 1941157755342352386, '2025-07-06 09:46:07', NULL);

-- ----------------------------
-- Table structure for prompt_template
-- ----------------------------
DROP TABLE IF EXISTS `prompt_template`;
CREATE TABLE `prompt_template`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `template_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提示词模板名称',
  `template_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '提示词模板内容',
  `category` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提示词分类，knowledge 知识库类型，chat 对话类型，draw绘画类型 ...',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '提示词模板表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of prompt_template
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` bigint NOT NULL COMMENT '参数主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '000000', '主框架页-默认皮肤样式名称', 'skin-purple', 'skin-blue', 'N', 103, 1, '2023-05-14 15:19:42', 1, '2025-03-28 22:30:49', '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '000000', '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'N', 103, 1, '2023-05-14 15:19:42', 1, '2025-03-28 10:40:44', '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '000000', '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 103, 1, '2023-05-14 15:19:42', 1, '2025-03-28 10:40:50', '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (5, '000000', '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 103, 1, '2023-05-14 15:19:42', 1, '2025-03-28 10:40:57', '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (11, '000000', 'OSS预览列表资源开关', 'sys.oss.previewListResource', 'true', 'Y', 103, 1, '2023-05-14 15:19:42', NULL, NULL, 'true:开启, false:关闭');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL COMMENT '部门id',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, '000000', 0, '0', '熊猫科技', 0, 'ageerle', '15888888888', 'ageerle@163.com', '0', '0', 103, 1, '2023-05-14 15:19:39', 1, '2023-12-29 11:18:24');
INSERT INTO `sys_dept` VALUES (101, '000000', 100, '0,100', '深圳总公司', 1, '疯狂的狮子Li', '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2023-05-14 15:19:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (102, '000000', 100, '0,100', '长沙分公司', 2, '疯狂的狮子Li', '15888888888', 'xxx@qq.com', '0', '2', 103, 1, '2023-05-14 15:19:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (103, '000000', 101, '0,100,101', '研发部门', 1, '疯狂的狮子Li', '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2023-05-14 15:19:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (104, '000000', 101, '0,100,101', '市场部门', 2, '疯狂的狮子Li', '15888888888', 'xxx@qq.com', '0', '2', 103, 1, '2023-05-14 15:19:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (105, '000000', 101, '0,100,101', '测试部门', 3, '疯狂的狮子Li', '15888888888', 'xxx@qq.com', '0', '2', 103, 1, '2023-05-14 15:19:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (106, '000000', 101, '0,100,101', '财务部门', 4, '疯狂的狮子Li', '15888888888', 'xxx@qq.com', '0', '2', 103, 1, '2023-05-14 15:19:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (107, '000000', 101, '0,100,101', '运维部门', 5, '疯狂的狮子Li', '15888888888', 'xxx@qq.com', '0', '2', 103, 1, '2023-05-14 15:19:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (108, '000000', 102, '0,100,102', '市场部门', 1, '疯狂的狮子Li', '15888888888', 'xxx@qq.com', '0', '2', 103, 1, '2023-05-14 15:19:39', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL COMMENT '字典编码',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, '000000', 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, '000000', 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, '000000', 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, '000000', 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, '000000', 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, '000000', 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, '000000', 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (12, '000000', 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, '000000', 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, '000000', 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, '000000', 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, '000000', 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, '000000', 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, '000000', 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (19, '000000', 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (20, '000000', 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (21, '000000', 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (22, '000000', 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (23, '000000', 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (24, '000000', 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (25, '000000', 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (26, '000000', 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (27, '000000', 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (28, '000000', 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (29, '000000', 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (1775756996568993793, '000000', 1, '免费用户', '0', 'sys_user_grade', '', 'info', 'N', '0', 103, 1, '2024-04-04 13:27:15', 1, '2024-04-04 13:30:09', '');
INSERT INTO `sys_dict_data` VALUES (1775757116970684418, '000000', 2, '高级会员', '1', 'sys_user_grade', '', 'success', 'N', '0', 103, 1, '2024-04-04 13:27:43', 1, '2024-04-04 13:30:15', '');
INSERT INTO `sys_dict_data` VALUES (1776109770934677506, '000000', 0, 'token计费', '1', 'sys_model_billing', '', 'primary', 'N', '0', 103, 1, '2024-04-05 12:49:03', 1, '2024-04-21 00:05:41', '');
INSERT INTO `sys_dict_data` VALUES (1776109853377916929, '000000', 0, '次数计费', '2', 'sys_model_billing', '', 'success', 'N', '0', 103, 1, '2024-04-05 12:49:22', 1, '2024-04-05 12:49:22', '');
INSERT INTO `sys_dict_data` VALUES (1780264338471858177, '000000', 0, '未支付', '1', 'pay_state', '', 'info', 'N', '0', 103, 1, '2024-04-16 23:57:49', 1, '2024-04-16 23:58:29', '');
INSERT INTO `sys_dict_data` VALUES (1780264431589601282, '000000', 2, '已支付', '2', 'pay_state', '', 'success', 'N', '0', 103, 1, '2024-04-16 23:58:11', 1, '2024-04-16 23:58:21', '');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL COMMENT '字典主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `tenant_id`(`tenant_id` ASC, `dict_type` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '000000', '用户性别', 'sys_user_sex', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '000000', '菜单状态', 'sys_show_hide', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '000000', '系统开关', 'sys_normal_disable', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (6, '000000', '系统是否', 'sys_yes_no', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '000000', '通知类型', 'sys_notice_type', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '000000', '通知状态', 'sys_notice_status', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '000000', '操作类型', 'sys_oper_type', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '000000', '系统状态', 'sys_common_status', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (1729685494468083714, '911866', '用户性别', 'sys_user_sex', '0', 103, 1, '2023-05-14 15:19:41', 1, '2023-05-14 15:19:41', '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (1729685494468083715, '911866', '菜单状态', 'sys_show_hide', '0', 103, 1, '2023-05-14 15:19:41', 1, '2023-05-14 15:19:41', '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (1729685494468083716, '911866', '系统开关', 'sys_normal_disable', '0', 103, 1, '2023-05-14 15:19:41', 1, '2023-05-14 15:19:41', '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (1729685494468083717, '911866', '系统是否', 'sys_yes_no', '0', 103, 1, '2023-05-14 15:19:41', 1, '2023-05-14 15:19:41', '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (1729685494468083718, '911866', '通知类型', 'sys_notice_type', '0', 103, 1, '2023-05-14 15:19:41', 1, '2023-05-14 15:19:41', '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (1729685494468083719, '911866', '通知状态', 'sys_notice_status', '0', 103, 1, '2023-05-14 15:19:41', 1, '2023-05-14 15:19:41', '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (1729685494468083720, '911866', '操作类型', 'sys_oper_type', '0', 103, 1, '2023-05-14 15:19:41', 1, '2023-05-14 15:19:41', '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (1729685494468083721, '911866', '系统状态', 'sys_common_status', '0', 103, 1, '2023-05-14 15:19:41', 1, '2023-05-14 15:19:41', '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (1775756736895438849, '000000', '用户等级', 'sys_user_grade', '0', 103, 1, '2024-04-04 13:26:13', 1, '2024-04-04 13:26:13', '');
INSERT INTO `sys_dict_type` VALUES (1776109665045278721, '000000', '模型计费方式', 'sys_model_billing', '0', 103, 1, '2024-04-05 12:48:37', 1, '2024-04-08 11:22:18', '模型计费方式');
INSERT INTO `sys_dict_type` VALUES (1780263881368219649, '000000', '支付状态', 'pay_state', '0', 103, 1, '2024-04-16 23:56:00', 1, '2025-03-29 15:21:57', '支付状态');
INSERT INTO `sys_dict_type` VALUES (1904565568803217409, '000000', '状态类型', 'status_type', '0', 103, 1, '2025-03-26 00:06:31', 1, '2025-03-26 00:06:31', NULL);

-- ----------------------------
-- Table structure for sys_file_info
-- ----------------------------
DROP TABLE IF EXISTS `sys_file_info`;
CREATE TABLE `sys_file_info`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文件id',
  `url` varchar(512) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '文件访问地址',
  `size` bigint NULL DEFAULT NULL COMMENT '文件大小，单位字节',
  `filename` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `original_filename` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '原始文件名',
  `base_path` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '基础存储路径',
  `path` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '存储路径',
  `ext` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '文件扩展名',
  `user_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '文件所属用户',
  `file_type` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '文件类型',
  `attr` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '附加属性',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `version` int NULL DEFAULT NULL COMMENT '版本',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `update_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新IP',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户Id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '文件记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_file_info
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL COMMENT '访问ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (1941160822787862530, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-04 23:43:00');
INSERT INTO `sys_logininfor` VALUES (1941160830668959745, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-04 23:43:02');
INSERT INTO `sys_logininfor` VALUES (1941166163080572929, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-05 00:04:13');
INSERT INTO `sys_logininfor` VALUES (1941166198350475265, '000000', 'gly001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-05 00:04:21');
INSERT INTO `sys_logininfor` VALUES (1941166619466985473, '000000', 'gly001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-05 00:06:02');
INSERT INTO `sys_logininfor` VALUES (1941166630779023361, '000000', 'gly001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-05 00:06:05');
INSERT INTO `sys_logininfor` VALUES (1941166647954698242, '000000', 'gly001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-05 00:06:09');
INSERT INTO `sys_logininfor` VALUES (1941166656699822082, '000000', 'xs001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-05 00:06:11');
INSERT INTO `sys_logininfor` VALUES (1941166878452674561, '000000', 'xs001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-05 00:07:04');
INSERT INTO `sys_logininfor` VALUES (1941166896433655810, '000000', 'js001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-05 00:07:08');
INSERT INTO `sys_logininfor` VALUES (1941167108501860353, '000000', 'js001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-05 00:07:58');
INSERT INTO `sys_logininfor` VALUES (1941167126809997313, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-05 00:08:03');
INSERT INTO `sys_logininfor` VALUES (1941167295723008001, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-05 00:08:43');
INSERT INTO `sys_logininfor` VALUES (1941168721471795202, '000000', 'js001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-05 00:14:23');
INSERT INTO `sys_logininfor` VALUES (1941172882309423106, '000000', 'js001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-05 00:30:55');
INSERT INTO `sys_logininfor` VALUES (1941172896461004801, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2025-07-05 00:30:58');
INSERT INTO `sys_logininfor` VALUES (1941172926685159426, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-05 00:31:06');
INSERT INTO `sys_logininfor` VALUES (1941174509170892801, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-05 00:37:23');
INSERT INTO `sys_logininfor` VALUES (1941174527927820290, '000000', 'xs001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-05 00:37:27');
INSERT INTO `sys_logininfor` VALUES (1941174871596507137, '000000', 'xs001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-05 00:38:49');
INSERT INTO `sys_logininfor` VALUES (1941174890319880193, '000000', 'js001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-05 00:38:54');
INSERT INTO `sys_logininfor` VALUES (1941176433265909761, '000000', 'js001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-05 00:45:02');
INSERT INTO `sys_logininfor` VALUES (1941176444947046402, '000000', 'xs001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-05 00:45:04');
INSERT INTO `sys_logininfor` VALUES (1941309154877284353, '000000', 'xs001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-05 09:32:25');
INSERT INTO `sys_logininfor` VALUES (1941309203048865793, '000000', 'js001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-05 09:32:36');
INSERT INTO `sys_logininfor` VALUES (1941379310882205698, '000000', 'js001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-05 14:11:11');
INSERT INTO `sys_logininfor` VALUES (1941379347234238466, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2025-07-05 14:11:20');
INSERT INTO `sys_logininfor` VALUES (1941379368155426817, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-05 14:11:25');
INSERT INTO `sys_logininfor` VALUES (1941379518097600514, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-05 14:12:01');
INSERT INTO `sys_logininfor` VALUES (1941379533058682881, '000000', 'xs001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-05 14:12:04');
INSERT INTO `sys_logininfor` VALUES (1941388666419855361, '000000', 'xs001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-05 14:48:22');
INSERT INTO `sys_logininfor` VALUES (1941388686338605058, '000000', 'js001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-05 14:48:27');
INSERT INTO `sys_logininfor` VALUES (1941418831225073666, '000000', 'js001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-05 16:48:14');
INSERT INTO `sys_logininfor` VALUES (1941418873142947842, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-05 16:48:24');
INSERT INTO `sys_logininfor` VALUES (1941425010890309633, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-05 17:12:47');
INSERT INTO `sys_logininfor` VALUES (1941425088799506433, '000000', 'js001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-05 17:13:06');
INSERT INTO `sys_logininfor` VALUES (1941427173234388993, '000000', 'js001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-05 17:21:23');
INSERT INTO `sys_logininfor` VALUES (1941427190628167681, '000000', 'xs001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-05 17:21:27');
INSERT INTO `sys_logininfor` VALUES (1941490470415577089, '000000', 'xs001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-05 21:32:54');
INSERT INTO `sys_logininfor` VALUES (1941491038030737409, '000000', 'js001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-05 21:35:09');
INSERT INTO `sys_logininfor` VALUES (1941491900987813890, '000000', 'js001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-05 21:38:35');
INSERT INTO `sys_logininfor` VALUES (1941492007724462081, '000000', 'js001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-05 21:39:00');
INSERT INTO `sys_logininfor` VALUES (1941492537934819330, '000000', 'js001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-05 21:41:07');
INSERT INTO `sys_logininfor` VALUES (1941492566414143490, '000000', 'xs001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-05 21:41:14');
INSERT INTO `sys_logininfor` VALUES (1941493137007259649, '000000', 'xs001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-05 21:43:30');
INSERT INTO `sys_logininfor` VALUES (1941493164547059713, '000000', 'js001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-05 21:43:36');
INSERT INTO `sys_logininfor` VALUES (1941668614950957058, '000000', 'js001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-06 09:20:47');
INSERT INTO `sys_logininfor` VALUES (1941668648010461185, '000000', 'xs001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-06 09:20:55');
INSERT INTO `sys_logininfor` VALUES (1941671334059520001, '000000', 'xs001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-06 09:31:35');
INSERT INTO `sys_logininfor` VALUES (1941671688461430785, '000000', 'xs001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-06 09:33:00');
INSERT INTO `sys_logininfor` VALUES (1941671735068536834, '000000', 'xs001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-06 09:33:11');
INSERT INTO `sys_logininfor` VALUES (1941671876915703809, '000000', 'js001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-06 09:33:45');
INSERT INTO `sys_logininfor` VALUES (1941672494396944386, '000000', 'js001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-06 09:36:12');
INSERT INTO `sys_logininfor` VALUES (1941672523023069186, '000000', 'xs001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-06 09:36:19');
INSERT INTO `sys_logininfor` VALUES (1941673306082848769, '000000', 'xs001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-06 09:39:25');
INSERT INTO `sys_logininfor` VALUES (1941673548345847810, '000000', 'js001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-06 09:40:23');
INSERT INTO `sys_logininfor` VALUES (1941674034314686465, '000000', 'js001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-06 09:42:19');
INSERT INTO `sys_logininfor` VALUES (1941674066526941185, '000000', 'xs001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-06 09:42:27');
INSERT INTO `sys_logininfor` VALUES (1941674824211181569, '000000', 'xs001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-07-06 09:45:27');
INSERT INTO `sys_logininfor` VALUES (1941674852615008257, '000000', 'gly001', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-06 09:45:34');
INSERT INTO `sys_logininfor` VALUES (1941843696793010178, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-07-06 20:56:30');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query_param` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '显示状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 2, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'eos-icons:system-group', 103, 1, '2023-05-14 15:19:39', 1, '2024-10-06 21:08:06', '系统管理目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 0, 905, 'user', 'system/user/index', '', 1, 0, 'M', '0', '0', 'system:user:list', 'ph:user-fill', 103, 1, '2023-05-14 15:19:39', 1, '2025-07-05 00:03:13', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'ri:user-3-fill', 103, 1, '2023-05-14 15:19:39', 1, '2024-10-07 21:04:59', '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'typcn:th-menu-outline', 103, 1, '2023-05-14 15:19:39', 1, '2024-10-07 21:06:06', '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '1', '1', 'system:dept:list', 'mdi:company', 103, 1, '2023-05-14 15:19:39', 1, '2024-10-07 21:07:38', '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '1', '1', 'system:post:list', 'post', 103, 1, '2023-05-14 15:19:39', 1, '2024-04-04 22:36:15', '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'fluent-mdl2:dictionary', 103, 1, '2023-05-14 15:19:40', 1, '2024-10-07 21:14:33', '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '系统参数', 1, 10, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'tdesign:system-code', 103, 1, '2023-05-14 15:19:40', 1, '2024-10-07 21:11:07', '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 14, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'icon-park-solid:volume-notice', 103, 1, '2023-05-14 15:19:40', 1, '2024-10-07 21:11:42', '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'icon-park-solid:log', 103, 1, '2023-05-14 15:19:40', 1, '2024-10-07 21:10:41', '日志管理菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 1, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'octicon:cache-24', 103, 1, '2023-05-14 15:19:40', 1, '2024-10-07 21:09:44', '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'icon-park-solid:log', 103, 1, '2023-05-14 15:19:40', 1, '2024-10-07 21:13:20', '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'icon-park-solid:log', 103, 1, '2023-05-14 15:19:40', 1, '2024-10-07 21:13:33', '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1001, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '日志导出', 500, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1775500307898949634, '运营管理', 0, 0, 'operate', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'icon-park-outline:appointment', 103, 1, '2024-04-03 20:27:15', 1, '2024-10-06 21:10:18', '');
INSERT INTO `sys_menu` VALUES (1775895273104068610, '系统模型', 1775500307898949634, 2, 'model', 'system/model/index', NULL, 1, 0, 'C', '0', '0', 'system:model:list', 'ph:list-fill', 103, 1, '2024-04-05 12:00:38', 1, '2024-10-07 21:36:00', '系统模型菜单');
INSERT INTO `sys_menu` VALUES (1775895273104068611, '系统模型查询', 1775895273104068610, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:model:query', '#', 103, 1, '2024-04-05 12:00:38', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1775895273104068612, '系统模型新增', 1775895273104068610, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:model:add', '#', 103, 1, '2024-04-05 12:00:38', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1775895273104068613, '系统模型修改', 1775895273104068610, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:model:edit', '#', 103, 1, '2024-04-05 12:00:38', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1775895273104068614, '系统模型删除', 1775895273104068610, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:model:remove', '#', 103, 1, '2024-04-05 12:00:38', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1775895273104068615, '系统模型导出', 1775895273104068610, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:model:export', '#', 103, 1, '2024-04-05 12:00:38', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1780240077690507266, '聊天消息', 1775500307898949634, 5, 'chatMessage', 'system/message/index', NULL, 1, 0, 'C', '0', '0', 'system:message:list', 'bx:chat', 103, 1, '2024-04-16 22:24:48', 1, '2024-10-07 21:38:49', '聊天消息菜单');
INSERT INTO `sys_menu` VALUES (1780240077690507267, '聊天消息查询', 1780240077690507266, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:message:query', '#', 103, 1, '2024-04-16 22:24:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1780240077690507268, '聊天消息新增', 1780240077690507266, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:message:add', '#', 103, 1, '2024-04-16 22:24:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1780240077690507269, '聊天消息修改', 1780240077690507266, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:message:edit', '#', 103, 1, '2024-04-16 22:24:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1780240077690507270, '聊天消息删除', 1780240077690507266, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:message:remove', '#', 103, 1, '2024-04-16 22:24:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1780240077690507271, '聊天消息导出', 1780240077690507266, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:message:export', '#', 103, 1, '2024-04-16 22:24:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1780255628576018433, '支付订单', 1775500307898949634, 6, 'order', 'system/payOrder/index', NULL, 1, 0, 'C', '0', '0', 'system:order:list', 'material-symbols:order-approve', 103, 1, '2024-04-16 23:32:48', 1, '2025-03-30 21:12:38', '支付订单菜单');
INSERT INTO `sys_menu` VALUES (1780255628576018434, '支付订单查询', 1780255628576018433, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:orders:query', '#', 103, 1, '2024-04-16 23:32:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1780255628576018435, '支付订单新增', 1780255628576018433, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:orders:add', '#', 103, 1, '2024-04-16 23:32:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1780255628576018436, '支付订单修改', 1780255628576018433, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:orders:edit', '#', 103, 1, '2024-04-16 23:32:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1780255628576018437, '支付订单删除', 1780255628576018433, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:orders:remove', '#', 103, 1, '2024-04-16 23:32:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1780255628576018438, '支付订单导出', 1780255628576018433, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:orders:export', '#', 103, 1, '2024-04-16 23:32:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1843281231381852162, '文件管理', 1775500307898949634, 20, 'file', 'system/oss/index', NULL, 1, 0, 'C', '0', '0', NULL, 'material-symbols-light:folder', 103, 1, '2024-10-07 21:24:27', 1, '2024-12-27 23:03:04', '');
INSERT INTO `sys_menu` VALUES (1898286496441393153, '知识库管理', 0, 901, 'knowledgeBase', 'system/knowledgeBase/index', NULL, 1, 0, 'M', '0', '0', '', 'garden:knowledge-base-26', 103, 1, '2025-03-08 16:15:44', 1, '2025-07-05 00:02:50', '');
INSERT INTO `sys_menu` VALUES (1906199640746344450, '系统工具', 0, 10, 'tool', '', NULL, 1, 0, 'M', '1', '1', NULL, 'carbon:tool-kit', 103, 1, '2025-03-30 12:19:44', 1, '2025-07-05 00:01:14', '');
INSERT INTO `sys_menu` VALUES (1906200030325882882, '代码生成', 1906199640746344450, 2, 'gen', 'tool/gen/index', NULL, 1, 0, 'C', '1', '1', 'tool:gen:list', 'tabler:code', 103, 1, '2025-03-30 12:21:17', 1, '2025-07-05 00:01:10', '');
INSERT INTO `sys_menu` VALUES (1906674838461321217, '配置信息', 1775500307898949634, 13, 'configurationManage', 'system/configurationManage/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'mdi:archive-cog-outline', 103, 1, '2025-03-31 19:48:48', 1, '2025-03-31 19:59:58', '配置信息菜单');
INSERT INTO `sys_menu` VALUES (1906674838461321218, '配置信息查询', 1906674838461321217, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:config:query', '#', 103, 1, '2025-03-31 19:48:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1906674838461321219, '配置信息新增', 1906674838461321217, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:config:add', '#', 103, 1, '2025-03-31 19:48:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1906674838461321220, '配置信息修改', 1906674838461321217, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:config:edit', '#', 103, 1, '2025-03-31 19:48:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1906674838461321221, '配置信息删除', 1906674838461321217, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:config:remove', '#', 103, 1, '2025-03-31 19:48:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1906674838461321222, '配置信息导出', 1906674838461321217, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:config:export', '#', 103, 1, '2025-03-31 19:48:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1941163475630616577, '学习助手', 0, 1000, 'http://localhost:5172/', '', NULL, 0, 0, 'M', '0', '0', NULL, 'carbon:ai', 103, 1, '2025-07-04 23:53:32', 1, '2025-07-06 20:56:53', '');
INSERT INTO `sys_menu` VALUES (1941163916410023938, '在线测评', 0, 1010, 'evaluation', 'demo/exam/index', NULL, 1, 0, 'M', '0', '0', NULL, 'basil:document-outline', 103, 1, '2025-07-04 23:55:17', 1, '2025-07-04 23:55:23', '');
INSERT INTO `sys_menu` VALUES (1941164492061470721, '智能备课', 0, 2000, 'teachingPlan', 'demo/teachingPlan/index', NULL, 1, 0, 'M', '0', '0', NULL, 'streamline-logos:discourse-logo-block', 103, 1, '2025-07-04 23:57:35', 1, '2025-07-04 23:57:50', '');
INSERT INTO `sys_menu` VALUES (1941164928248115201, '题目生成', 0, 2020, 'generatePaper', 'demo/paper/index', NULL, 1, 0, 'M', '0', '0', NULL, 'basil:document-outline', 103, 1, '2025-07-04 23:59:19', 1, '2025-07-05 00:08:38', '');
INSERT INTO `sys_menu` VALUES (1941165160469950466, '学情分析', 0, 2030, 'learningAnalysis', 'demo/learningAnalysis/index', NULL, 1, 0, 'M', '0', '0', NULL, 'ix:piechart-filled', 103, 1, '2025-07-05 00:00:14', 1, '2025-07-05 00:00:18', '');
INSERT INTO `sys_menu` VALUES (1941165681591250946, '大屏展示', 0, 900, 'analytics', 'demo/analytics/index', NULL, 1, 0, 'M', '0', '0', NULL, 'ix:report-linechart', 103, 1, '2025-07-05 00:02:18', 1, '2025-07-05 00:02:18', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` bigint NOT NULL COMMENT '公告ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1789324923280932865, '000000', '公告', '1', 0x3C703E3C7374726F6E67207374796C653D22636F6C6F723A20236666393930303B223EE69CACE7BD91E7AB99E4B88EE4BBBBE4BD95E585B6E4BB96E585ACE58FB8E68896E59586E6A087E6B2A1E69C89E4BBBBE4BD95E585B3E88194E68896E59088E4BD9CE585B3E7B3BB3C2F7374726F6E673E3C2F703E0A3C703E3C7370616E207374796C653D22636F6C6F723A20236536303030303B223E4149E4B99FE4BC9AE78AAFE99499E38082E8AFB7E58BBFE5B086E585B6E794A8E4BA8EE9878DE8A681E79BAEE79A843C2F7370616E3E3C2F703E0A3C703E3C7370616E207374796C653D22636F6C6F723A20236666393930303B223EE68891E4BBACE79BAEE5898DE6ADA3E59CA8E4BFAEE5A48DE68891E4BBACE7BD91E7AB99E4B88AE79A84E99499E8AFAFE5B9B6E694B9E8BF9BE7BB86E88A82E38082E5A682E69E9CE682A8E69C89E4BBBBE4BD95E79691E997AEEFBC8CE8AFB7E9809AE8BF87E4BBA5E4B88BE696B9E5BC8FE88194E7B3BBE68891E4BBACEFBC9A61676565726C65403136332E636F6D313434343434353535353C2F7370616E3E3C2F703E0A3C703E266E6273703B3C2F703E, '0', 103, 1, '2024-05-12 00:01:20', 1, '2025-03-11 19:31:59', '');

-- ----------------------------
-- Table structure for sys_notice_state
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice_state`;
CREATE TABLE `sys_notice_state`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `notice_id` bigint NOT NULL COMMENT '公告ID',
  `read_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '阅读状态（0未读 1已读）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户阅读状态表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice_state
-- ----------------------------

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL COMMENT '日志主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (1941156997863632898, '00000', '角色管理', 1, 'org.ruoyi.system.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '', '/system/role', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"roleId\":\"1941156997268041730\",\"roleName\":\"教师\",\"roleKey\":\"teacher\",\"roleSort\":100,\"dataScope\":null,\"menuCheckStrictly\":null,\"deptCheckStrictly\":null,\"status\":\"0\",\"remark\":\"\",\"menuIds\":[],\"deptIds\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-04 23:27:48', 235);
INSERT INTO `sys_oper_log` VALUES (1941157085608472578, '00000', '角色管理', 1, 'org.ruoyi.system.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '', '/system/role', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"roleId\":\"1941157085310676993\",\"roleName\":\"学生\",\"roleKey\":\"student\",\"roleSort\":101,\"dataScope\":null,\"menuCheckStrictly\":null,\"deptCheckStrictly\":null,\"status\":\"0\",\"remark\":\"\",\"menuIds\":[],\"deptIds\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-04 23:28:09', 80);
INSERT INTO `sys_oper_log` VALUES (1941157377360064514, '00000', '用户管理', 1, 'org.ruoyi.system.controller.system.SysUserController.add()', 'POST', 1, 'admin', '', '/system/user', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"userId\":\"1941157377100017665\",\"deptId\":103,\"userName\":\"js001\",\"nickName\":\"张薇薇教授\",\"userType\":null,\"email\":\"8*******@qq.com\",\"phonenumber\":null,\"sex\":\"0\",\"userPlan\":null,\"status\":\"0\",\"avatar\":null,\"remark\":\"教师角色\",\"domainName\":null,\"roleIds\":[\"1941156997268041730\"],\"postIds\":[],\"roleId\":null,\"openId\":null,\"userGrade\":null,\"userBalance\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-04 23:29:18', 146);
INSERT INTO `sys_oper_log` VALUES (1941157519081402370, '00000', '用户管理', 1, 'org.ruoyi.system.controller.system.SysUserController.add()', 'POST', 1, 'admin', '', '/system/user', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"userId\":null,\"deptId\":null,\"userName\":\"xs001\",\"nickName\":\"张启灵\",\"userType\":null,\"email\":\"8*******@qq.com\",\"phonenumber\":null,\"sex\":\"0\",\"userPlan\":null,\"status\":\"0\",\"avatar\":null,\"remark\":\"学生角色\",\"domainName\":null,\"roleIds\":[\"1941157085310676993\"],\"postIds\":null,\"roleId\":null,\"openId\":null,\"userGrade\":null,\"userBalance\":null,\"superAdmin\":false}', '{\"code\":500,\"msg\":\"新增用户\'xs001\'失败，邮箱账号已存在\",\"data\":null}', 0, '', '2025-07-04 23:29:52', 8);
INSERT INTO `sys_oper_log` VALUES (1941157542603059201, '00000', '用户管理', 1, 'org.ruoyi.system.controller.system.SysUserController.add()', 'POST', 1, 'admin', '', '/system/user', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"userId\":\"1941157542410121217\",\"deptId\":103,\"userName\":\"xs001\",\"nickName\":\"张启灵\",\"userType\":null,\"email\":\"8********@qq.com\",\"phonenumber\":null,\"sex\":\"0\",\"userPlan\":null,\"status\":\"0\",\"avatar\":null,\"remark\":\"学生角色\",\"domainName\":null,\"roleIds\":[\"1941157085310676993\"],\"postIds\":null,\"roleId\":null,\"openId\":null,\"userGrade\":null,\"userBalance\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-04 23:29:58', 101);
INSERT INTO `sys_oper_log` VALUES (1941157755472375809, '00000', '用户管理', 1, 'org.ruoyi.system.controller.system.SysUserController.add()', 'POST', 1, 'admin', '', '/system/user', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"userId\":\"1941157755342352386\",\"deptId\":103,\"userName\":\"gly001\",\"nickName\":\"管理员\",\"userType\":null,\"email\":\"8********@qq.com\",\"phonenumber\":null,\"sex\":\"0\",\"userPlan\":null,\"status\":\"0\",\"avatar\":null,\"remark\":\"管理员账户\",\"domainName\":null,\"roleIds\":[\"1729685491108446210\"],\"postIds\":null,\"roleId\":null,\"openId\":null,\"userGrade\":null,\"userBalance\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-04 23:30:49', 101);
INSERT INTO `sys_oper_log` VALUES (1941163475693531138, '00000', '菜单管理', 1, 'org.ruoyi.system.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '', '/system/menu', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":0,\"menuName\":\"学习助手\",\"orderNum\":1000,\"path\":\"http://localhost:1002/\",\"component\":\"\",\"queryParam\":null,\"isFrame\":\"0\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"icon\":\"carbon:ai\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-04 23:53:32', 51);
INSERT INTO `sys_oper_log` VALUES (1941163916477132802, '00000', '菜单管理', 1, 'org.ruoyi.system.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '', '/system/menu', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":0,\"menuName\":\"在线测评\",\"orderNum\":1010,\"path\":\"evaluation\",\"component\":\"demo/exam/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"icon\":\"basil:document-outline\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-04 23:55:17', 22);
INSERT INTO `sys_oper_log` VALUES (1941163939742937089, '00000', '菜单管理', 2, 'org.ruoyi.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/system/menu', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1941163916410023938\",\"parentId\":0,\"menuName\":\"在线测评\",\"orderNum\":1010,\"path\":\"evaluation\",\"component\":\"demo/exam/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"icon\":\"basil:document-outline\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-04 23:55:23', 22);
INSERT INTO `sys_oper_log` VALUES (1941164492124385281, '00000', '菜单管理', 1, 'org.ruoyi.system.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '', '/system/menu', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":0,\"menuName\":\"智能备课\",\"orderNum\":1000,\"path\":\"teachingPlan\",\"component\":\"demo/teachingPlan/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"icon\":\"streamline-logos:discourse-logo-block\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-04 23:57:35', 15);
INSERT INTO `sys_oper_log` VALUES (1941164527239098370, '00000', '菜单管理', 2, 'org.ruoyi.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/system/menu', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1941164492061470721\",\"parentId\":0,\"menuName\":\"智能备课\",\"orderNum\":2000,\"path\":\"teachingPlan\",\"component\":\"demo/teachingPlan/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"icon\":\"streamline-logos:discourse-logo-block\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-04 23:57:43', 17);
INSERT INTO `sys_oper_log` VALUES (1941164556532117505, '00000', '菜单管理', 2, 'org.ruoyi.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/system/menu', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1941164492061470721\",\"parentId\":0,\"menuName\":\"智能备课\",\"orderNum\":2000,\"path\":\"teachingPlan\",\"component\":\"demo/teachingPlan/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"icon\":\"streamline-logos:discourse-logo-block\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-04 23:57:50', 17);
INSERT INTO `sys_oper_log` VALUES (1941164928311029762, '00000', '菜单管理', 1, 'org.ruoyi.system.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '', '/system/menu', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":0,\"menuName\":\"题目生成\",\"orderNum\":2020,\"path\":\"generatePaper\",\"component\":\"demo/topic/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"icon\":\"basil:document-outline\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-04 23:59:19', 28);
INSERT INTO `sys_oper_log` VALUES (1941164949735534594, '00000', '菜单管理', 2, 'org.ruoyi.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/system/menu', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1941164928248115201\",\"parentId\":0,\"menuName\":\"题目生成\",\"orderNum\":2020,\"path\":\"generatePaper\",\"component\":\"demo/topic/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"icon\":\"basil:document-outline\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-04 23:59:24', 16);
INSERT INTO `sys_oper_log` VALUES (1941165160532865026, '00000', '菜单管理', 1, 'org.ruoyi.system.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '', '/system/menu', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":0,\"menuName\":\"学情分析\",\"orderNum\":2030,\"path\":\"learningAnalysis\",\"component\":\"demo/learningAnalysis/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"icon\":\"ix:piechart-filled\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-05 00:00:14', 17);
INSERT INTO `sys_oper_log` VALUES (1941165176144064514, '00000', '菜单管理', 2, 'org.ruoyi.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/system/menu', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1941165160469950466\",\"parentId\":0,\"menuName\":\"学情分析\",\"orderNum\":2030,\"path\":\"learningAnalysis\",\"component\":\"demo/learningAnalysis/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"icon\":\"ix:piechart-filled\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-05 00:00:18', 16);
INSERT INTO `sys_oper_log` VALUES (1941165396877701121, '00000', '菜单管理', 2, 'org.ruoyi.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/system/menu', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1906200030325882882\",\"parentId\":\"1906199640746344450\",\"menuName\":\"代码生成\",\"orderNum\":2,\"path\":\"gen\",\"component\":\"tool/gen/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"1\",\"status\":\"1\",\"perms\":\"tool:gen:list\",\"icon\":\"tabler:code\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-05 00:01:10', 23);
INSERT INTO `sys_oper_log` VALUES (1941165412983828482, '00000', '菜单管理', 2, 'org.ruoyi.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/system/menu', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1906199640746344450\",\"parentId\":0,\"menuName\":\"系统工具\",\"orderNum\":10,\"path\":\"tool\",\"component\":\"\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"1\",\"status\":\"1\",\"icon\":\"carbon:tool-kit\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-05 00:01:14', 16);
INSERT INTO `sys_oper_log` VALUES (1941165681654165505, '00000', '菜单管理', 1, 'org.ruoyi.system.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '', '/system/menu', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":null,\"parentId\":0,\"menuName\":\"大屏展示\",\"orderNum\":900,\"path\":\"analytics\",\"component\":\"demo/analytics/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"icon\":\"ix:report-linechart\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-05 00:02:18', 17);
INSERT INTO `sys_oper_log` VALUES (1941165814424858626, '00000', '菜单管理', 2, 'org.ruoyi.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/system/menu', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1898286496441393153\",\"parentId\":0,\"menuName\":\"知识库管理\",\"orderNum\":901,\"path\":\"knowledgeBase\",\"component\":\"system/knowledgeBase/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"\",\"icon\":\"garden:knowledge-base-26\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-05 00:02:50', 24);
INSERT INTO `sys_oper_log` VALUES (1941165909526507521, '00000', '菜单管理', 2, 'org.ruoyi.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/system/menu', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":100,\"parentId\":0,\"menuName\":\"用户管理\",\"orderNum\":905,\"path\":\"user\",\"component\":\"system/user/index\",\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"system:user:list\",\"icon\":\"ph:user-fill\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-05 00:03:13', 19);
INSERT INTO `sys_oper_log` VALUES (1941166008470138881, '00000', '角色管理', 2, 'org.ruoyi.system.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '', '/system/role', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"roleId\":\"1729685491108446210\",\"roleName\":\"管理员\",\"roleKey\":\"admin\",\"roleSort\":4,\"dataScope\":null,\"menuCheckStrictly\":true,\"deptCheckStrictly\":null,\"status\":\"0\",\"remark\":\"\",\"menuIds\":[\"1941165681591250946\",\"1898286496441393153\",100,1001,1002,1003,1004,1005,1006,1007],\"deptIds\":null,\"superAdmin\":false}', '', 1, '非Web上下文无法获取Request', '2025-07-05 00:03:36', 117);
INSERT INTO `sys_oper_log` VALUES (1941166103282380801, '00000', '角色管理', 2, 'org.ruoyi.system.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '', '/system/role', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"roleId\":\"1941156997268041730\",\"roleName\":\"教师\",\"roleKey\":\"teacher\",\"roleSort\":100,\"dataScope\":null,\"menuCheckStrictly\":true,\"deptCheckStrictly\":null,\"status\":\"0\",\"remark\":\"\",\"menuIds\":[\"1941164492061470721\",\"1941164928248115201\",\"1941165160469950466\"],\"deptIds\":null,\"superAdmin\":false}', '', 1, '非Web上下文无法获取Request', '2025-07-05 00:03:59', 38);
INSERT INTO `sys_oper_log` VALUES (1941166123536674817, '00000', '角色管理', 2, 'org.ruoyi.system.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '', '/system/role', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"roleId\":\"1941157085310676993\",\"roleName\":\"学生\",\"roleKey\":\"student\",\"roleSort\":101,\"dataScope\":null,\"menuCheckStrictly\":true,\"deptCheckStrictly\":null,\"status\":\"0\",\"remark\":\"\",\"menuIds\":[\"1941163475630616577\",\"1941163916410023938\"],\"deptIds\":null,\"superAdmin\":false}', '', 1, '非Web上下文无法获取Request', '2025-07-05 00:04:04', 36);
INSERT INTO `sys_oper_log` VALUES (1941167275749732354, '00000', '菜单管理', 2, 'org.ruoyi.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/system/menu', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1941164928248115201\",\"parentId\":0,\"menuName\":\"题目生成\",\"orderNum\":2020,\"path\":\"generatePaper\",\"component\":\"demo/paper/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"icon\":\"basil:document-outline\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-05 00:08:38', 23);
INSERT INTO `sys_oper_log` VALUES (1941171657279074306, '000000', 'A7试卷管理', 1, 'org.ruoyi.controller.PaperController.save()', 'POST', 1, 'js001', '', '/a7/paper', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"paperName\":\"A7暑期练习-001\",\"createName\":\"张薇薇教授\",\"paperDifficulty\":\"中等\",\"paperType\":\"全部题型\",\"paperSubject\":\"Python基础学习\",\"topicNumber\":5,\"answerTime\":30,\"collection\":null,\"startCreateTime\":null,\"endCreateTime\":null,\"topics\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941171655605547010\",\"paperId\":\"1941171655542632450\",\"topicName\":\"以下代码的输出结果是什么？\\n```python\\nx = {\'a\': 1, \'b\': 2}\\nprint(\'a\' in x)\\n```\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"在Python中，使用\'in\'运算符检查字典中是否包含某个键。如果字典包含指定的键，则返回True，否则返回False。在这个例子中，字典x包含键\'a\'，所以\'a\' in x返回True。\",\"collection\":null,\"startCreateTime\":null,\"topicOptions\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"topicId\":\"1941171655605547010\",\"sorted\":\"A\",\"optionContent\":\"True\",\"rightAnswer\":true},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"topicId\":null,\"sorted\":\"B\",\"optionContent\":\"False\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"topicId\":null,\"sorted\":\"C\",\"optionContent\":\"1\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"topicId\":null,\"sorted\":\"D\",\"optionContent\":\"错误\",\"rightAnswer\":false}]},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"paperId\":null,\"topicName\":\"以下代码的输出结果是什么？\\n```python\\nx = [1, 2, 3]\\ny = x.copy()\\ny.append(4)\\nprint(x)\\n```\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"列表的copy()方法创建的是一个浅拷贝，它复制了列表本身，但不会递归地复制列表中的元素。在这个例子中，x和y是两个不同的列表对象，所以当通过y修改列表时，x不会受到影响。因此，x的值仍然是[1, 2, 3]。\",\"collection\":null,\"startCreateTime\":null,\"topicOptions\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,', '', 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'topic_id\' in \'field list\'\r\n### The error may exist in org/ruoyi/teaching/mapper/TopicOptionMapper.java (best guess)\r\n### The error may involve org.ruoyi.teaching.mapper.TopicOptionMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO a7_topic_option  ( id, topic_id, sorted, option_content, right_answer, create_dept, create_by, create_time, update_by, update_time )  VALUES (  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?  )\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'topic_id\' in \'field list\'\n; bad SQL grammar []', '2025-07-05 00:26:03', 437);
INSERT INTO `sys_oper_log` VALUES (1941172303176724481, '000000', 'A7试卷管理', 1, 'org.ruoyi.controller.PaperController.save()', 'POST', 1, 'js001', '', '/a7/paper', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"paperName\":\"A7暑期练习-001\",\"createName\":\"张薇薇教授\",\"paperDifficulty\":\"中等\",\"paperType\":\"全部题型\",\"paperSubject\":\"Python基础学习\",\"topicNumber\":5,\"answerTime\":30,\"collection\":null,\"startCreateTime\":null,\"endCreateTime\":null,\"topics\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941172302140731393\",\"paperId\":\"1941172302014902274\",\"topicName\":\"以下代码的输出结果是什么？\\n```python\\nx = {\'a\': 1, \'b\': 2}\\nprint(\'a\' in x)\\n```\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"在Python中，使用\'in\'运算符检查字典中是否包含某个键。如果字典包含指定的键，则返回True，否则返回False。在这个例子中，字典x包含键\'a\'，所以\'a\' in x返回True。\",\"collection\":null,\"startCreateTime\":null,\"topicOptions\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941172302207840258\",\"topicId\":\"1941172302140731393\",\"sorted\":\"A\",\"optionContent\":\"True\",\"rightAnswer\":true},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941172302270754818\",\"topicId\":\"1941172302140731393\",\"sorted\":\"B\",\"optionContent\":\"False\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941172302270754819\",\"topicId\":\"1941172302140731393\",\"sorted\":\"C\",\"optionContent\":\"1\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941172302337863682\",\"topicId\":\"1941172302140731393\",\"sorted\":\"D\",\"optionContent\":\"错误\",\"rightAnswer\":false}]},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941172302400778241\",\"paperId\":\"1941172302014902274\",\"topicName\":\"以下哪个不是Python的内置数据类型？\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"Python的内置数据类型包括整数(int)、浮点数(float)、字符串(str)、列表(list)、元组(tuple)、集合(set)、字典(dict)和布尔值(bool)等。\'array\'不是Python的内置数据类型，而是NumPy库中的数据结构。\",\"collection\":null,\"startCreat', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-05 00:28:37', 270);
INSERT INTO `sys_oper_log` VALUES (1941174478917378050, '00000', '聊天模型', 1, 'org.ruoyi.chat.controller.chat.ChatModelController.add()', 'POST', 1, 'admin', '', '/system/model', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941174478724440066\",\"category\":\"chat\",\"modelName\":\"deepseek/deepseek-r1-0528-qwen3-8b\",\"modelDescribe\":\"DeepSeek-R1-0528-Qwen3-8B 是基于 Qwen3 8B Base 模型，通过融合 DeepSeek-R1-0528 的思维链（Chain-of-Thought）优化训练而成的高性能推理模型。在 AIME 2024 评测中，该模型以开源模型身份达到最先进（SOTA）水平，性能较原版 Qwen3 8B 提升 10%，并展现出与 2350 亿参数的 Qwen3-235B-thinking 相当的推理能力。\",\"modelPrice\":0.0,\"modelType\":\"2\",\"modelShow\":\"0\",\"systemPrompt\":null,\"apiHost\":\"https://api.ppinfra.com/v3/openai/chat/completions\",\"apiKey\":\"sk_5oBTA76IPExaU0UBXTa8M-Hih4PUsd5f2WoNPnqn6Qg\",\"remark\":\"DeepSeek-R1-0528-Qwen3-8B 是基于 Qwen3 8B Base 模型，通过融合 DeepSeek-R1-0528 的思维链（Chain-of-Thought）优化训练而成的高性能推理模型。在 AIME 2024 评测中，该模型以开源模型身份达到最先进（SOTA）水平，性能较原版 Qwen3 8B 提升 10%，并展现出与 2350 亿参数的 Qwen3-235B-thinking 相当的推理能力。\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-05 00:37:16', 33);
INSERT INTO `sys_oper_log` VALUES (1941175389844709378, '000000', 'A7试卷管理', 1, 'org.ruoyi.controller.PaperController.save()', 'POST', 1, 'js001', '', '/a7/paper', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"paperName\":\"A7暑期练习，001\",\"createName\":\"张薇薇教授\",\"paperDifficulty\":\"基础\",\"paperType\":\"全部题型\",\"paperSubject\":\"Python基础\",\"topicNumber\":5,\"answerTime\":35,\"collection\":null,\"startCreateTime\":null,\"endCreateTime\":null,\"topics\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941175388762578946\",\"paperId\":\"1941175388624166913\",\"topicName\":\"以下哪个是Python的合法标识符？\",\"topicDifficulty\":\"基础\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"Python标识符的规则是：只能包含字母、数字和下划线，不能以数字开头，不能是Python的关键字。\'my_var\'符合这些规则，是合法的标识符。\'1var\'以数字开头，\'my-var\'包含连字符，\'if\'是Python的关键字，它们都不是合法的标识符。\",\"collection\":null,\"startCreateTime\":null,\"topicOptions\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941175388817104898\",\"topicId\":\"1941175388762578946\",\"sorted\":\"A\",\"optionContent\":\"1var\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941175388947128321\",\"topicId\":\"1941175388762578946\",\"sorted\":\"B\",\"optionContent\":\"my-var\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941175388947128322\",\"topicId\":\"1941175388762578946\",\"sorted\":\"C\",\"optionContent\":\"my_var\",\"rightAnswer\":true},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941175389010042882\",\"topicId\":\"1941175388762578946\",\"sorted\":\"D\",\"optionContent\":\"if\",\"rightAnswer\":false}]},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941175389089734657\",\"paperId\":\"1941175388624166913\",\"topicName\":\"以下代码的输出结果是什么？\\n```python\\nx = [1, 2, 3]\\ny = x.copy()\\ny.append(4)\\nprint(x)\\n```\",\"topicDifficulty\":\"基础\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"列表的copy()方法创建的是一个浅拷贝，它复制了列表本身，但不会递归地复制列表中的元素。在这个例子中，x和y是两个不同的列表对象，所以当通过y修改列表时，x不会受到影响。因此，x的值仍然是[1, 2, 3]。\",\"col', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-05 00:40:53', 299);
INSERT INTO `sys_oper_log` VALUES (1941379485704990722, '00000', '角色管理', 2, 'org.ruoyi.system.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '', '/system/role', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"roleId\":\"1941157085310676993\",\"roleName\":\"学生\",\"roleKey\":\"student\",\"roleSort\":101,\"dataScope\":null,\"menuCheckStrictly\":true,\"deptCheckStrictly\":null,\"status\":\"0\",\"remark\":\"\",\"menuIds\":[\"1941163475630616577\",\"1941163916410023938\",\"1941164928248115201\"],\"deptIds\":null,\"superAdmin\":false}', '', 1, '非Web上下文无法获取Request', '2025-07-05 14:11:53', 193);
INSERT INTO `sys_oper_log` VALUES (1941384954439921666, '000000', 'A7试卷管理', 1, 'org.ruoyi.controller.PaperController.save()', 'POST', 1, 'xs001', '', '/a7/paper', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"paperName\":\"1\",\"createRole\":null,\"createName\":\"张启灵\",\"paperDifficulty\":\"中等\",\"paperType\":\"全部题型\",\"paperSubject\":\"2\",\"topicNumber\":5,\"answerTime\":3,\"collection\":null,\"startCreateTime\":null,\"endCreateTime\":null,\"topics\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941384952632176641\",\"paperId\":\"1941384952321798145\",\"topicName\":\"以下代码的输出结果是什么？\\n```python\\nx = [1, 2, 3]\\nprint(x[-1])\\n```\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"在Python中，负数索引表示从列表末尾开始计数。索引-1表示最后一个元素，索引-2表示倒数第二个元素，依此类推。所以x[-1]返回列表x的最后一个元素，即3。\",\"collection\":null,\"startCreateTime\":null,\"topicOptions\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941384952695091202\",\"topicId\":\"1941384952632176641\",\"sorted\":\"A\",\"optionContent\":\"1\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941384952758005762\",\"topicId\":\"1941384952632176641\",\"sorted\":\"B\",\"optionContent\":\"2\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941384952825114626\",\"topicId\":\"1941384952632176641\",\"sorted\":\"C\",\"optionContent\":\"3\",\"rightAnswer\":true},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941384952888029185\",\"topicId\":\"1941384952632176641\",\"sorted\":\"D\",\"optionContent\":\"以上都不对\",\"rightAnswer\":false}]},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941384952959332354\",\"paperId\":\"1941384952321798145\",\"topicName\":\"以下代码的输出结果是什么？\\n```python\\nx = 10\\ndef func():\\n    x = 20\\n    print(x)\\nfunc()\\nprint(x)\\n```\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"在Python中，函数内部定义的变量是局部变量，只在函数内部有效。所以当在函数内部执行\'x = 20\'时，它创建了一个新的局部变量x，而不会影响函数外部的全局变量x。因此，函数内部打印的是局部变量x的值20，函数外部打印的是全局变量', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-05 14:33:37', 1748);
INSERT INTO `sys_oper_log` VALUES (1941386190362771458, '000000', 'A7试卷管理', 1, 'org.ruoyi.controller.PaperController.save()', 'POST', 1, 'xs001', '', '/a7/paper', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":\"2025-07-05 00:40:53\",\"updateBy\":null,\"updateTime\":null,\"id\":null,\"paperName\":\"2\",\"createRole\":\"teacher\",\"createName\":\"张启灵\",\"paperDifficulty\":\"中等\",\"paperType\":\"全部题型\",\"paperSubject\":\"2\",\"topicNumber\":5,\"answerTime\":2,\"collection\":false,\"startCreateTime\":null,\"endCreateTime\":null,\"topics\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941386188286590978\",\"paperId\":\"1941386187489673217\",\"topicName\":\"以下代码的输出结果是什么？\\n```python\\nx = [1, 2, 3]\\nprint(x[-1])\\n```\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"在Python中，负数索引表示从列表末尾开始计数。索引-1表示最后一个元素，索引-2表示倒数第二个元素，依此类推。所以x[-1]返回列表x的最后一个元素，即3。\",\"collection\":null,\"startCreateTime\":null,\"topicOptions\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941386188487917569\",\"topicId\":\"1941386188286590978\",\"sorted\":\"A\",\"optionContent\":\"1\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941386188550832130\",\"topicId\":\"1941386188286590978\",\"sorted\":\"B\",\"optionContent\":\"2\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941386188676661249\",\"topicId\":\"1941386188286590978\",\"sorted\":\"C\",\"optionContent\":\"3\",\"rightAnswer\":true},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941386188747964418\",\"topicId\":\"1941386188286590978\",\"sorted\":\"D\",\"optionContent\":\"以上都不对\",\"rightAnswer\":false}]},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941386188806684674\",\"paperId\":\"1941386187489673217\",\"topicName\":\"以下哪个不是Python的内置数据类型？\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"Python的内置数据类型包括整数(int)、浮点数(float)、字符串(str)、列表(list)、元组(tuple)、集合(set)、字典(dict)和布尔值(bool)等。\'array\'不是Python的内置数据类型，而是NumPy库中的数据结构。\",\"collection\":null,\"startCreateTime\":n', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-05 14:38:32', 70595);
INSERT INTO `sys_oper_log` VALUES (1941388610266513409, '000000', 'A7试卷管理', 1, 'org.ruoyi.controller.PaperController.save()', 'POST', 1, 'xs001', '', '/a7/paper', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"paperName\":\"2\",\"createRole\":\"student\",\"createName\":\"张启灵\",\"paperDifficulty\":\"中等\",\"paperType\":\"全部题型\",\"paperSubject\":\"2\",\"topicNumber\":5,\"answerTime\":2,\"collection\":null,\"startCreateTime\":null,\"endCreateTime\":null,\"topics\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941388608794312705\",\"paperId\":\"1941388608723009538\",\"topicName\":\"以下代码的输出结果是什么？\\n```python\\nx = [1, 2, 3]\\ny = x.copy()\\ny.append(4)\\nprint(x)\\n```\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"列表的copy()方法创建的是一个浅拷贝，它复制了列表本身，但不会递归地复制列表中的元素。在这个例子中，x和y是两个不同的列表对象，所以当通过y修改列表时，x不会受到影响。因此，x的值仍然是[1, 2, 3]。\",\"collection\":null,\"startCreateTime\":null,\"topicOptions\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941388608920141826\",\"topicId\":\"1941388608794312705\",\"sorted\":\"A\",\"optionContent\":\"[1, 2, 3]\",\"rightAnswer\":true},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941388608983056386\",\"topicId\":\"1941388608794312705\",\"sorted\":\"B\",\"optionContent\":\"[1, 2, 3, 4]\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941388608983056387\",\"topicId\":\"1941388608794312705\",\"sorted\":\"C\",\"optionContent\":\"[1, 2, 4]\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941388609113079810\",\"topicId\":\"1941388608794312705\",\"sorted\":\"D\",\"optionContent\":\"以上都不对\",\"rightAnswer\":false}]},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941388609175994369\",\"paperId\":\"1941388608723009538\",\"topicName\":\"以下哪个不是Python的内置数据类型？\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"Python的内置数据类型包括整数(int)、浮点数(float)、字符串(str)、列表(list)、元组(tuple)、集合(set)、字典(dict)和布尔值(bool)等。\'array\'不是Python的内置数据', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-05 14:48:09', 384);
INSERT INTO `sys_oper_log` VALUES (1941491540827123713, '000000', 'A7试卷管理', 1, 'org.ruoyi.controller.PaperController.save()', 'POST', 1, 'js001', '', '/a7/paper', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"paperName\":\"A7暑期练习，001\",\"createRole\":\"teacher\",\"createName\":\"张薇薇教授\",\"paperDifficulty\":\"中等\",\"paperType\":\"全部题型\",\"paperSubject\":\"Python基础\",\"topicNumber\":5,\"answerTime\":35,\"collection\":null,\"startCreateTime\":null,\"endCreateTime\":null,\"topics\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"paperId\":\"1941491539245871106\",\"topicName\":\"执行以下代码的输出结果是？\\n```java\\nString s1 = \\\"abc\\\";\\nString s2 = new String(\\\"abc\\\");\\nSystem.out.println(s1 == s2);\\nSystem.out.println(s1.equals(s2));\\n```\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"`s1` 使用字符串字面量创建，存储在常量池；`s2` 使用 new 关键字创建，存储在堆内存。\\n`==` 比较的是引用地址（不同），`equals()` 比较的是字符串内容（相同），因此输出 `false` 和 `true`。\",\"collection\":null,\"startCreateTime\":null,\"topicOptions\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"topicId\":null,\"sorted\":\"A\",\"optionContent\":\"true\\ntrue\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"topicId\":null,\"sorted\":\"B\",\"optionContent\":\"false\\nfalse\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"topicId\":null,\"sorted\":\"C\",\"optionContent\":\"true\\nfalse\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"topicId\":null,\"sorted\":\"D\",\"optionContent\":\"false\\ntrue\",\"rightAnswer\":true}]},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"paperId\":null,\"topicName\":\"以下代码的输出结果是？\\n```java\\nint[] arr = {1, 2, 3, 4};\\nfor (int i = 0; i < arr.length; i++) {\\n    if (i == 2) break;\\n    System.out.print(arr[i] + \\\" \\\");\\n}\\n```\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"循环从 i=0 开始，当 i=2 时执行 `break` 跳出循环。\\n因此，i=0 输出 1，i=1 ', '', 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'topic_name\' at row 1\r\n### The error may exist in org/ruoyi/teaching/mapper/TopicMapper.java (best guess)\r\n### The error may involve org.ruoyi.teaching.mapper.TopicMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO a7_topic  ( id, paper_id, topic_name, topic_difficulty, topic_type,  topic_answer,  create_dept, create_by, create_time, update_by, update_time )  VALUES (  ?, ?, ?, ?, ?,  ?,  ?, ?, ?, ?, ?  )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'topic_name\' at row 1\n; Data truncation: Data too long for column \'topic_name\' at row 1', '2025-07-05 21:37:09', 365);
INSERT INTO `sys_oper_log` VALUES (1941492483744411649, '000000', 'A7试卷管理', 1, 'org.ruoyi.controller.PaperController.save()', 'POST', 1, 'js001', '', '/a7/paper', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"paperName\":\"暑期练习，002\",\"createRole\":\"teacher\",\"createName\":\"张薇薇教授\",\"paperDifficulty\":\"中等\",\"paperType\":\"全部题型\",\"paperSubject\":\"Python基础\",\"topicNumber\":5,\"answerTime\":35,\"collection\":null,\"startCreateTime\":null,\"endCreateTime\":null,\"topics\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941492482523869185\",\"paperId\":\"1941492482456760322\",\"topicName\":\"以下哪个集合类是线程安全的？\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"Vector 和 Hashtable 是 Java 早期提供的线程安全集合类，通过 synchronized 实现同步。\\n而 ArrayList、HashMap 是非线程安全的；ConcurrentHashMap 是 Java 1.5 后提供的高性能线程安全 Map。\",\"collection\":null,\"startCreateTime\":null,\"topicOptions\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941492482586783745\",\"topicId\":\"1941492482523869185\",\"sorted\":\"A\",\"optionContent\":\"ArrayList\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941492482649698305\",\"topicId\":\"1941492482523869185\",\"sorted\":\"B\",\"optionContent\":\"Vector\",\"rightAnswer\":true},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941492482716807170\",\"topicId\":\"1941492482523869185\",\"sorted\":\"C\",\"optionContent\":\"HashMap\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941492482716807171\",\"topicId\":\"1941492482523869185\",\"sorted\":\"D\",\"optionContent\":\"LinkedList\",\"rightAnswer\":false}]},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941492482779721730\",\"paperId\":\"1941492482456760322\",\"topicName\":\"Java 中接口和抽象类的区别正确的是？\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"接口（interface）只能包含抽象方法和常量（默认 public static final），不能有构造方法；\\n抽象类（abstract class）可以包含抽象方法和具体方法，也可以有构造方法；\\n类可以实现多个接口，但只能继承一个抽象类。\",\"collec', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-05 21:40:54', 319);
INSERT INTO `sys_oper_log` VALUES (1941492709733511170, '000000', 'A7试卷管理', 2, 'org.ruoyi.controller.PaperController.saveAnswer()', 'POST', 1, 'xs001', '', '/a7/paper/saveAnswer/1941492482456760322', '127.0.0.1', '内网IP', '\"1941492482456760322\" [{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941492709603487745\",\"userId\":\"1941157542410121217\",\"paperId\":\"1941492482456760322\",\"topicId\":\"1941492482523869185\",\"topicWrite\":\"A\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941492709603487746\",\"userId\":\"1941157542410121217\",\"paperId\":\"1941492482456760322\",\"topicId\":\"1941492482779721730\",\"topicWrite\":\"A\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941492709603487747\",\"userId\":\"1941157542410121217\",\"paperId\":\"1941492482456760322\",\"topicId\":\"1941492483098488833\",\"topicWrite\":\"A\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941492709603487748\",\"userId\":\"1941157542410121217\",\"paperId\":\"1941492482456760322\",\"topicId\":\"1941492483358535683\",\"topicWrite\":\"A\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941492709670596609\",\"userId\":\"1941157542410121217\",\"paperId\":\"1941492482456760322\",\"topicId\":\"1941492483681497089\",\"topicWrite\":\"def merge_dicts(dict1, dict2):\\n    # 创建一个新字典，初始化为dict1的副本\\n    result = dict1.copy()\\n    \\n    # 遍历dict2中的每个键值对\\n    for key, value in dict2.items():\\n        # 如果key已经在result中，则将对应的值相加\\n        if key in result:\\n            result[key] += value\\n        else:\\n            # 否则，直接将键值对添加到result中\\n            result[key] = value\\n    \\n    return result\",\"rightAnswer\":true}]', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-05 21:41:48', 77);
INSERT INTO `sys_oper_log` VALUES (1941668848686936065, '000000', 'A7试卷管理', 1, 'org.ruoyi.controller.PaperController.save()', 'POST', 1, 'xs001', '', '/a7/paper', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"paperName\":\"1\",\"createRole\":\"student\",\"createName\":\"张启灵\",\"paperDifficulty\":\"中等\",\"paperType\":\"全部题型\",\"paperSubject\":\"java\",\"topicNumber\":5,\"answerTime\":30,\"collection\":null,\"startCreateTime\":null,\"endCreateTime\":null,\"topics\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941668847529308162\",\"paperId\":\"1941668847466393602\",\"topicName\":\"执行以下代码的输出结果是？\\n```java\\nString s1 = \\\"abc\\\";\\nString s2 = new String(\\\"abc\\\");\\nSystem.out.println(s1 == s2);\\nSystem.out.println(s1.equals(s2));\\n```\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"`s1` 使用字符串字面量创建，存储在常量池；`s2` 使用 new 关键字创建，存储在堆内存。\\n`==` 比较的是引用地址（不同），`equals()` 比较的是字符串内容（相同），因此输出 `false` 和 `true`。\",\"collection\":null,\"startCreateTime\":null,\"topicOptions\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941668847592222721\",\"topicId\":\"1941668847529308162\",\"sorted\":\"A\",\"optionContent\":\"true\\ntrue\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941668847659331585\",\"topicId\":\"1941668847529308162\",\"sorted\":\"B\",\"optionContent\":\"false\\nfalse\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941668847659331586\",\"topicId\":\"1941668847529308162\",\"sorted\":\"C\",\"optionContent\":\"true\\nfalse\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941668847722246145\",\"topicId\":\"1941668847529308162\",\"sorted\":\"D\",\"optionContent\":\"false\\ntrue\",\"rightAnswer\":true}]},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941668847785160706\",\"paperId\":\"1941668847466393602\",\"topicName\":\"Java 中访问修饰符的作用范围由大到小排序正确的是？\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"Java 访问修饰符的', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-06 09:21:43', 309);
INSERT INTO `sys_oper_log` VALUES (1941668986763423745, '000000', 'A7试卷管理', 2, 'org.ruoyi.controller.PaperController.saveAnswer()', 'POST', 1, 'xs001', '', '/a7/paper/saveAnswer/1941668847466393602', '127.0.0.1', '内网IP', '\"1941668847466393602\" [{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941668986637594626\",\"userId\":\"1941157542410121217\",\"paperId\":\"1941668847466393602\",\"topicId\":\"1941668847529308162\",\"topicWrite\":\"A\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941668986637594627\",\"userId\":\"1941157542410121217\",\"paperId\":\"1941668847466393602\",\"topicId\":\"1941668847785160706\",\"topicWrite\":\"B\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941668986637594628\",\"userId\":\"1941157542410121217\",\"paperId\":\"1941668847466393602\",\"topicId\":\"1941668848045207553\",\"topicWrite\":\"C\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941668986700509186\",\"userId\":\"1941157542410121217\",\"paperId\":\"1941668847466393602\",\"topicId\":\"1941668848301060099\",\"topicWrite\":\"D\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941668986700509187\",\"userId\":\"1941157542410121217\",\"paperId\":\"1941668847466393602\",\"topicId\":\"1941668848619827202\",\"topicWrite\":\"def merge_dicts(dict1, dict2):\\n    # 创建一个新字典，初始化为dict1的副本\\n    result = dict1.copy()\\n    \\n    # 遍历dict2中的每个键值对\\n    for key, value in dict2.items():\\n        # 如果key已经在result中，则将对应的值相加\\n        if key in result:\\n            result[key] += value\\n        else:\\n            # 否则，直接将键值对添加到result中\\n            result[key] = value\\n    \\n    return result\",\"rightAnswer\":true}]', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-06 09:22:16', 47);
INSERT INTO `sys_oper_log` VALUES (1941672408766033922, '000000', 'A7试卷管理', 1, 'org.ruoyi.controller.PaperController.save()', 'POST', 1, 'js001', '', '/a7/paper', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"paperName\":\"暑期练习，001\",\"createRole\":\"teacher\",\"createName\":\"张薇薇教授\",\"paperDifficulty\":\"中等\",\"paperType\":\"全部题型\",\"paperSubject\":\"Python基础\",\"topicNumber\":5,\"answerTime\":25,\"collection\":null,\"startCreateTime\":null,\"endCreateTime\":null,\"topics\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941672407604211714\",\"paperId\":\"1941672407558074369\",\"topicName\":\"以下代码的输出结果是什么？\\n```python\\nx = {\'a\': 1, \'b\': 2}\\nprint(\'a\' in x)\\n```\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"在Python中，使用\'in\'运算符检查字典中是否包含某个键。如果字典包含指定的键，则返回True，否则返回False。在这个例子中，字典x包含键\'a\'，所以\'a\' in x返回True。\",\"collection\":null,\"startCreateTime\":null,\"topicOptions\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941672407667126273\",\"topicId\":\"1941672407604211714\",\"sorted\":\"A\",\"optionContent\":\"True\",\"rightAnswer\":true},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941672407730040834\",\"topicId\":\"1941672407604211714\",\"sorted\":\"B\",\"optionContent\":\"False\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941672407797149698\",\"topicId\":\"1941672407604211714\",\"sorted\":\"C\",\"optionContent\":\"1\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941672407797149699\",\"topicId\":\"1941672407604211714\",\"sorted\":\"D\",\"optionContent\":\"错误\",\"rightAnswer\":false}]},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941672407860064257\",\"paperId\":\"1941672407558074369\",\"topicName\":\"以下代码的输出结果是什么？\\n```python\\nx = [1, 2, 3]\\ny = x.copy()\\ny.append(4)\\nprint(x)\\n```\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"列表的copy()方法创建的是一个浅拷贝，它复制了列表本身，但不会递归地复制列表中的元素。在这个例子中，x和y是两个不同的列表对象，所以当通过y修改列表时，x', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-06 09:35:51', 305);
INSERT INTO `sys_oper_log` VALUES (1941672807061336065, '000000', 'A7试卷管理', 1, 'org.ruoyi.controller.PaperController.save()', 'POST', 1, 'xs001', '', '/a7/paper', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"paperName\":\"暑期练习，自己做\",\"createRole\":\"student\",\"createName\":\"张启灵\",\"paperDifficulty\":\"中等\",\"paperType\":\"全部题型\",\"paperSubject\":\"java基础\",\"topicNumber\":5,\"answerTime\":15,\"collection\":null,\"startCreateTime\":null,\"endCreateTime\":null,\"topics\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941672806033731586\",\"paperId\":\"1941672805966622721\",\"topicName\":\"以下代码的输出结果是？\\n```java\\nint[] arr = {1, 2, 3, 4};\\nfor (int i = 0; i < arr.length; i++) {\\n    if (i == 2) break;\\n    System.out.print(arr[i] + \\\" \\\");\\n}\\n```\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"循环从 i=0 开始，当 i=2 时执行 `break` 跳出循环。\\n因此，i=0 输出 1，i=1 输出 2，i=2 时跳出，最终输出 `1 2`。\",\"collection\":null,\"startCreateTime\":null,\"topicOptions\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941672806033731587\",\"topicId\":\"1941672806033731586\",\"sorted\":\"A\",\"optionContent\":\"1 2 3\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941672806096646146\",\"topicId\":\"1941672806033731586\",\"sorted\":\"B\",\"optionContent\":\"1 2\",\"rightAnswer\":true},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941672806159560706\",\"topicId\":\"1941672806033731586\",\"sorted\":\"C\",\"optionContent\":\"1 2 3 4\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941672806222475266\",\"topicId\":\"1941672806033731586\",\"sorted\":\"D\",\"optionContent\":\"1\",\"rightAnswer\":false}]},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941672806285389826\",\"paperId\":\"1941672805966622721\",\"topicName\":\"执行以下代码的输出结果是？\\n```java\\nint x = 5;\\nint y = x++;\\nSystem.out.println(x + \\\",\\\" + y);\\n```\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-06 09:37:26', 283);
INSERT INTO `sys_oper_log` VALUES (1941673996339458049, '000000', 'A7试卷管理', 1, 'org.ruoyi.controller.PaperController.save()', 'POST', 1, 'js001', '', '/a7/paper', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"paperName\":\"暑期练习，001\",\"createRole\":\"teacher\",\"createName\":\"张薇薇教授\",\"paperDifficulty\":\"中等\",\"paperType\":\"全部题型\",\"paperSubject\":\"Python基础\",\"topicNumber\":5,\"answerTime\":30,\"collection\":null,\"startCreateTime\":null,\"endCreateTime\":null,\"topics\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941673995244744706\",\"paperId\":\"1941673995177635842\",\"topicName\":\"以下代码的输出结果是什么？\\n```python\\nx = {\'a\': 1, \'b\': 2}\\nprint(\'a\' in x)\\n```\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"在Python中，使用\'in\'运算符检查字典中是否包含某个键。如果字典包含指定的键，则返回True，否则返回False。在这个例子中，字典x包含键\'a\'，所以\'a\' in x返回True。\",\"collection\":null,\"startCreateTime\":null,\"topicOptions\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941673995307659265\",\"topicId\":\"1941673995244744706\",\"sorted\":\"A\",\"optionContent\":\"True\",\"rightAnswer\":true},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941673995307659266\",\"topicId\":\"1941673995244744706\",\"sorted\":\"B\",\"optionContent\":\"False\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941673995374768129\",\"topicId\":\"1941673995244744706\",\"sorted\":\"C\",\"optionContent\":\"1\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941673995441876994\",\"topicId\":\"1941673995244744706\",\"sorted\":\"D\",\"optionContent\":\"错误\",\"rightAnswer\":false}]},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941673995508985857\",\"paperId\":\"1941673995177635842\",\"topicName\":\"以下哪个函数可以用于将字符串转换为整数？\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"int()是Python的内置函数，用于将字符串或数字转换为整数。str()用于将对象转换为字符串，float()用于将对象转换为浮点数，chr()用于将Unicode码点转换为字符。\",\"collection\":null,\"startCreateTime\":null,\"topi', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-06 09:42:10', 291);
INSERT INTO `sys_oper_log` VALUES (1941674287713562625, '000000', 'A7试卷管理', 1, 'org.ruoyi.controller.PaperController.save()', 'POST', 1, 'xs001', '', '/a7/paper', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"paperName\":\"暑期练习，自己做\",\"createRole\":\"student\",\"createName\":\"张启灵\",\"paperDifficulty\":\"中等\",\"paperType\":\"全部题型\",\"paperSubject\":\"java基础\",\"topicNumber\":5,\"answerTime\":25,\"collection\":null,\"startCreateTime\":null,\"endCreateTime\":null,\"topics\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941674286681763841\",\"paperId\":\"1941674286618849281\",\"topicName\":\"Java 中访问修饰符的作用范围由大到小排序正确的是？\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"Java 访问修饰符的作用范围：\\n1. public：所有类可见\\n2. protected：同包或子类可见\\n3. 默认（无修饰符）：同包可见\\n4. private：仅当前类可见\",\"collection\":null,\"startCreateTime\":null,\"topicOptions\":[{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941674286681763842\",\"topicId\":\"1941674286681763841\",\"sorted\":\"A\",\"optionContent\":\"public > protected > private > 默认\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941674286744678401\",\"topicId\":\"1941674286681763841\",\"sorted\":\"B\",\"optionContent\":\"public > 默认 > protected > private\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941674286811787265\",\"topicId\":\"1941674286681763841\",\"sorted\":\"C\",\"optionContent\":\"public > protected > 默认 > private\",\"rightAnswer\":true},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941674286878896130\",\"topicId\":\"1941674286681763841\",\"sorted\":\"D\",\"optionContent\":\"protected > public > 默认 > private\",\"rightAnswer\":false}]},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941674286878896131\",\"paperId\":\"1941674286618849281\",\"topicName\":\"以下哪个关键字用于跳出多层循环？\",\"topicDifficulty\":\"中等\",\"topicType\":\"选择题\",\"topicContent\":null,\"topicAnswer\":\"`break` 只能跳出当前一层循环；`continue` 跳过当前循环的剩余步骤；\\n`return` 用于方法返回；而 **标签 + br', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-06 09:43:19', 277);
INSERT INTO `sys_oper_log` VALUES (1941674433012641794, '000000', 'A7试卷管理', 2, 'org.ruoyi.controller.PaperController.saveAnswer()', 'POST', 1, 'xs001', '', '/a7/paper/saveAnswer/1941673995177635842', '127.0.0.1', '内网IP', '\"1941673995177635842\" [{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941674432886812673\",\"userId\":\"1941157542410121217\",\"paperId\":\"1941673995177635842\",\"topicId\":\"1941673995244744706\",\"topicWrite\":\"B\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941674432886812674\",\"userId\":\"1941157542410121217\",\"paperId\":\"1941673995177635842\",\"topicId\":\"1941673995508985857\",\"topicWrite\":\"B\",\"rightAnswer\":true},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941674432886812675\",\"userId\":\"1941157542410121217\",\"paperId\":\"1941673995177635842\",\"topicId\":\"1941673995764838402\",\"topicWrite\":\"B\",\"rightAnswer\":false},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941674432886812676\",\"userId\":\"1941157542410121217\",\"paperId\":\"1941673995177635842\",\"topicId\":\"1941673996020690946\",\"topicWrite\":\"C\",\"rightAnswer\":true},{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":\"1941674432949727234\",\"userId\":\"1941157542410121217\",\"paperId\":\"1941673995177635842\",\"topicId\":\"1941673996276543489\",\"topicWrite\":\"def merge_dicts(dict1, dict2):\\n    # 创建一个新字典，初始化为dict1的副本\\n    result = dict1.copy()\\n    \\n    # 遍历dict2中的每个键值对\\n    for key, value in dict2.items():\\n        # 如果key已经在result中，则将对应的值相加\\n        if key in result:\\n            result[key] += value\\n        else:\\n            # 否则，直接将键值对添加到result中\\n            result[key] = value\\n    \\n    return result\",\"rightAnswer\":true}]', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-06 09:43:54', 44);
INSERT INTO `sys_oper_log` VALUES (1941674988841807873, '000000', '知识库', 1, 'org.ruoyi.chat.controller.knowledge.KnowledgeController.save()', 'POST', 1, 'gly001', '', '/knowledge/save', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"id\":null,\"kid\":null,\"uid\":null,\"kname\":\"Python学习\",\"share\":0,\"description\":\"Python学习\",\"knowledgeSeparator\":\"\",\"questionSeparator\":\"\",\"overlapChar\":30,\"retrieveLimit\":5,\"textBlockSize\":300,\"vectorModelName\":\"weaviate\",\"embeddingModelName\":\"baai/bge-m3\",\"systemPrompt\":null,\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-06 09:46:07', 92);
INSERT INTO `sys_oper_log` VALUES (1941675119179804673, '000000', '用户管理', 2, 'org.ruoyi.system.controller.system.SysUserController.changeStatus()', 'PUT', 1, 'gly001', '', '/system/user/changeStatus', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":\"2025-07-04 23:29:18\",\"updateBy\":null,\"updateTime\":null,\"userId\":\"1941157377100017665\",\"deptId\":103,\"userName\":\"js001\",\"nickName\":\"张薇薇教授\",\"userType\":null,\"email\":\"8*******@qq.com\",\"phonenumber\":\"\",\"sex\":\"0\",\"userPlan\":null,\"status\":\"1\",\"avatar\":null,\"remark\":\"教师角色\",\"domainName\":null,\"roleIds\":null,\"postIds\":null,\"roleId\":null,\"openId\":null,\"userGrade\":\"0\",\"userBalance\":0.0,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-06 09:46:38', 35);
INSERT INTO `sys_oper_log` VALUES (1941675123478966273, '000000', '用户管理', 2, 'org.ruoyi.system.controller.system.SysUserController.changeStatus()', 'PUT', 1, 'gly001', '', '/system/user/changeStatus', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":\"2025-07-04 23:29:18\",\"updateBy\":null,\"updateTime\":null,\"userId\":\"1941157377100017665\",\"deptId\":103,\"userName\":\"js001\",\"nickName\":\"张薇薇教授\",\"userType\":null,\"email\":\"8*******@qq.com\",\"phonenumber\":\"\",\"sex\":\"0\",\"userPlan\":null,\"status\":\"0\",\"avatar\":null,\"remark\":\"教师角色\",\"domainName\":null,\"roleIds\":null,\"postIds\":null,\"roleId\":null,\"openId\":null,\"userGrade\":\"0\",\"userBalance\":0.0,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-06 09:46:39', 17);
INSERT INTO `sys_oper_log` VALUES (1941843794549653506, '00000', '菜单管理', 2, 'org.ruoyi.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/system/menu', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1941163475630616577\",\"parentId\":0,\"menuName\":\"学习助手\",\"orderNum\":1000,\"path\":\"http://localhost:5172/\",\"component\":\"\",\"queryParam\":null,\"isFrame\":\"0\",\"isCache\":\"0\",\"menuType\":\"M\",\"visible\":\"0\",\"status\":\"0\",\"icon\":\"carbon:ai\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-07-06 20:56:53', 43);

-- ----------------------------
-- Table structure for sys_oss
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss`;
CREATE TABLE `sys_oss`  (
  `oss_id` bigint NOT NULL COMMENT '对象存储主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文件名',
  `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '原名',
  `file_suffix` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文件后缀名',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'URL地址',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '上传人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `service` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'minio' COMMENT '服务商',
  PRIMARY KEY (`oss_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'OSS对象存储表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oss
-- ----------------------------
INSERT INTO `sys_oss` VALUES (1925801916342902786, '000000', '2025/05/23/097e4eb1fc414872a5d082c1e01ab573.jpg', '59816c7c28fba2c18ec79f8b8e09581a_1.jpg', '.jpg', 'https://ruoyi-ai-1254149996.cos.ap-guangzhou.myqcloud.com/2025/05/23/097e4eb1fc414872a5d082c1e01ab573.jpg', 103, '2025-05-23 14:32:11', 1, '2025-05-23 14:32:11', 1, 'qcloud');

-- ----------------------------
-- Table structure for sys_oss_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss_config`;
CREATE TABLE `sys_oss_config`  (
  `oss_config_id` bigint NOT NULL COMMENT '主建',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `config_key` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '配置key',
  `access_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'accessKey',
  `secret_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '秘钥',
  `bucket_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '桶名称',
  `prefix` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '前缀',
  `endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '访问站点',
  `domain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '自定义域名',
  `is_https` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否https（Y=是,N=否）',
  `region` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '域',
  `access_policy` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '桶权限类型(0=private 1=public 2=custom)',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否默认（0=是,1=否）',
  `ext1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '扩展字段',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`oss_config_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '对象存储配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oss_config
-- ----------------------------
INSERT INTO `sys_oss_config` VALUES (1, '000000', 'minio', 'ruoyi', 'ruoyi123', 'ruoyi', '', '127.0.0.1:9000', '', 'N', '', '1', '1', '', 103, 1, '2023-05-14 15:19:42', 1, '2025-03-26 16:25:55', NULL);
INSERT INTO `sys_oss_config` VALUES (2, '000000', 'qiniu', 'ruoyi', 'ruoyi123', 'ruoyi', '', 's3-cn-north-1.qiniucs.com', '', 'N', '', '1', '1', '', 103, 1, '2023-05-14 15:19:42', 1, '2025-05-23 14:31:40', NULL);
INSERT INTO `sys_oss_config` VALUES (3, '000000', 'aliyun', 'ruoyi', 'ruoyi123', 'ruoyi', '', 'oss-cn-beijing.aliyuncs.com', '', 'N', '', '1', '1', '', 103, 1, '2023-05-14 15:19:42', 1, '2025-03-13 13:13:04', NULL);
INSERT INTO `sys_oss_config` VALUES (4, '000000', 'qcloud', 'xx', 'xx', 'xxx', '', 'cos.ap-guangzhou.myqcloud.com', '', 'Y', 'ap-guangzhou', '1', '0', '', 103, 1, '2023-05-14 15:19:42', 1, '2025-05-23 14:31:41', '');

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, '000000', 'ceo', '董事长', 1, '0', 103, 1, '2023-05-14 15:19:39', NULL, NULL, '');
INSERT INTO `sys_post` VALUES (2, '000000', 'se', '项目经理', 2, '0', 103, 1, '2023-05-14 15:19:39', NULL, NULL, '');
INSERT INTO `sys_post` VALUES (3, '000000', 'hr', '人力资源', 3, '0', 103, 1, '2023-05-14 15:19:39', NULL, NULL, '');
INSERT INTO `sys_post` VALUES (4, '000000', 'user', '普通员工', 4, '0', 103, 1, '2023-05-14 15:19:39', NULL, NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '000000', '超级管理员', 'superadmin', 1, '1', 1, 1, '0', '0', 103, 1, '2023-05-14 15:19:39', NULL, NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '000000', '普通角色', 'common', 2, '2', 0, 1, '0', '0', 103, 1, '2023-05-14 15:19:39', 1, '2025-03-31 19:41:35', '普通角色');
INSERT INTO `sys_role` VALUES (3, '000000', '本部门及以下', 'test1', 3, '4', 1, 1, '0', '0', 103, 1, '2023-05-14 15:20:00', 1, '2025-03-17 09:29:25', NULL);
INSERT INTO `sys_role` VALUES (4, '000000', '仅本人', 'test2', 4, '5', 1, 1, '0', '0', 103, 1, '2023-05-14 15:20:00', 1, '2025-03-24 10:56:45', NULL);
INSERT INTO `sys_role` VALUES (1661661183933177857, '000000', '小程序管理员', 'xcxadmin', 1, '1', 1, 1, '0', '0', 103, 1, '2023-05-25 17:11:13', 1, '2025-03-31 19:45:38', '');
INSERT INTO `sys_role` VALUES (1729685491108446210, '911866', '管理员', 'admin', 4, '1', 1, 1, '0', '0', 103, 1, '2023-11-29 10:15:32', 1, '2025-07-05 00:03:36', '');
INSERT INTO `sys_role` VALUES (1941156997268041730, '000000', '教师', 'teacher', 100, '1', 1, 1, '0', '0', 103, 1, '2025-07-04 23:27:48', 1, '2025-07-05 00:03:59', '');
INSERT INTO `sys_role` VALUES (1941157085310676993, '000000', '学生', 'student', 101, '1', 1, 1, '0', '0', 103, 1, '2025-07-04 23:28:09', 1, '2025-07-05 14:11:53', '');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1775500307898949634);
INSERT INTO `sys_role_menu` VALUES (2, 1775895273104068610);
INSERT INTO `sys_role_menu` VALUES (2, 1775895273104068611);
INSERT INTO `sys_role_menu` VALUES (2, 1775895273104068612);
INSERT INTO `sys_role_menu` VALUES (2, 1775895273104068613);
INSERT INTO `sys_role_menu` VALUES (2, 1775895273104068614);
INSERT INTO `sys_role_menu` VALUES (2, 1775895273104068615);
INSERT INTO `sys_role_menu` VALUES (2, 1780240077690507266);
INSERT INTO `sys_role_menu` VALUES (2, 1780240077690507267);
INSERT INTO `sys_role_menu` VALUES (2, 1780240077690507268);
INSERT INTO `sys_role_menu` VALUES (2, 1780240077690507269);
INSERT INTO `sys_role_menu` VALUES (2, 1780240077690507270);
INSERT INTO `sys_role_menu` VALUES (2, 1780240077690507271);
INSERT INTO `sys_role_menu` VALUES (2, 1780255628576018433);
INSERT INTO `sys_role_menu` VALUES (2, 1780255628576018434);
INSERT INTO `sys_role_menu` VALUES (2, 1780255628576018435);
INSERT INTO `sys_role_menu` VALUES (2, 1780255628576018436);
INSERT INTO `sys_role_menu` VALUES (2, 1780255628576018437);
INSERT INTO `sys_role_menu` VALUES (2, 1780255628576018438);
INSERT INTO `sys_role_menu` VALUES (2, 1786379590171156481);
INSERT INTO `sys_role_menu` VALUES (2, 1786379590171156482);
INSERT INTO `sys_role_menu` VALUES (2, 1786379590171156483);
INSERT INTO `sys_role_menu` VALUES (2, 1786379590171156484);
INSERT INTO `sys_role_menu` VALUES (2, 1786379590171156485);
INSERT INTO `sys_role_menu` VALUES (2, 1786379590171156486);
INSERT INTO `sys_role_menu` VALUES (2, 1787078000285122561);
INSERT INTO `sys_role_menu` VALUES (2, 1810594719028834305);
INSERT INTO `sys_role_menu` VALUES (2, 1810594719028834306);
INSERT INTO `sys_role_menu` VALUES (2, 1810594719028834307);
INSERT INTO `sys_role_menu` VALUES (2, 1810594719028834308);
INSERT INTO `sys_role_menu` VALUES (2, 1810594719028834309);
INSERT INTO `sys_role_menu` VALUES (2, 1810594719028834310);
INSERT INTO `sys_role_menu` VALUES (2, 1843281231381852162);
INSERT INTO `sys_role_menu` VALUES (2, 1860690448695549953);
INSERT INTO `sys_role_menu` VALUES (2, 1898286496441393153);
INSERT INTO `sys_role_menu` VALUES (2, 1900172314827739137);
INSERT INTO `sys_role_menu` VALUES (2, 1902184523796742145);
INSERT INTO `sys_role_menu` VALUES (2, 1906199640746344450);
INSERT INTO `sys_role_menu` VALUES (2, 1906200030325882882);
INSERT INTO `sys_role_menu` VALUES (2, 1906336170039103490);
INSERT INTO `sys_role_menu` VALUES (2, 1906336170039103491);
INSERT INTO `sys_role_menu` VALUES (2, 1906336170039103492);
INSERT INTO `sys_role_menu` VALUES (2, 1906336170039103493);
INSERT INTO `sys_role_menu` VALUES (2, 1906336170039103494);
INSERT INTO `sys_role_menu` VALUES (2, 1906336170039103495);
INSERT INTO `sys_role_menu` VALUES (2, 1906358690184294402);
INSERT INTO `sys_role_menu` VALUES (2, 1906358690184294403);
INSERT INTO `sys_role_menu` VALUES (2, 1906358690184294404);
INSERT INTO `sys_role_menu` VALUES (2, 1906358690184294405);
INSERT INTO `sys_role_menu` VALUES (2, 1906358690184294406);
INSERT INTO `sys_role_menu` VALUES (2, 1906358690184294407);
INSERT INTO `sys_role_menu` VALUES (3, 1);
INSERT INTO `sys_role_menu` VALUES (3, 100);
INSERT INTO `sys_role_menu` VALUES (3, 101);
INSERT INTO `sys_role_menu` VALUES (3, 102);
INSERT INTO `sys_role_menu` VALUES (3, 103);
INSERT INTO `sys_role_menu` VALUES (3, 104);
INSERT INTO `sys_role_menu` VALUES (3, 105);
INSERT INTO `sys_role_menu` VALUES (3, 106);
INSERT INTO `sys_role_menu` VALUES (3, 107);
INSERT INTO `sys_role_menu` VALUES (3, 108);
INSERT INTO `sys_role_menu` VALUES (3, 500);
INSERT INTO `sys_role_menu` VALUES (3, 501);
INSERT INTO `sys_role_menu` VALUES (3, 1001);
INSERT INTO `sys_role_menu` VALUES (3, 1002);
INSERT INTO `sys_role_menu` VALUES (3, 1003);
INSERT INTO `sys_role_menu` VALUES (3, 1004);
INSERT INTO `sys_role_menu` VALUES (3, 1005);
INSERT INTO `sys_role_menu` VALUES (3, 1006);
INSERT INTO `sys_role_menu` VALUES (3, 1007);
INSERT INTO `sys_role_menu` VALUES (3, 1008);
INSERT INTO `sys_role_menu` VALUES (3, 1009);
INSERT INTO `sys_role_menu` VALUES (3, 1010);
INSERT INTO `sys_role_menu` VALUES (3, 1011);
INSERT INTO `sys_role_menu` VALUES (3, 1012);
INSERT INTO `sys_role_menu` VALUES (3, 1013);
INSERT INTO `sys_role_menu` VALUES (3, 1014);
INSERT INTO `sys_role_menu` VALUES (3, 1015);
INSERT INTO `sys_role_menu` VALUES (3, 1016);
INSERT INTO `sys_role_menu` VALUES (3, 1017);
INSERT INTO `sys_role_menu` VALUES (3, 1018);
INSERT INTO `sys_role_menu` VALUES (3, 1019);
INSERT INTO `sys_role_menu` VALUES (3, 1020);
INSERT INTO `sys_role_menu` VALUES (3, 1021);
INSERT INTO `sys_role_menu` VALUES (3, 1022);
INSERT INTO `sys_role_menu` VALUES (3, 1023);
INSERT INTO `sys_role_menu` VALUES (3, 1024);
INSERT INTO `sys_role_menu` VALUES (3, 1025);
INSERT INTO `sys_role_menu` VALUES (3, 1026);
INSERT INTO `sys_role_menu` VALUES (3, 1027);
INSERT INTO `sys_role_menu` VALUES (3, 1028);
INSERT INTO `sys_role_menu` VALUES (3, 1029);
INSERT INTO `sys_role_menu` VALUES (3, 1030);
INSERT INTO `sys_role_menu` VALUES (3, 1031);
INSERT INTO `sys_role_menu` VALUES (3, 1032);
INSERT INTO `sys_role_menu` VALUES (3, 1033);
INSERT INTO `sys_role_menu` VALUES (3, 1034);
INSERT INTO `sys_role_menu` VALUES (3, 1035);
INSERT INTO `sys_role_menu` VALUES (3, 1036);
INSERT INTO `sys_role_menu` VALUES (3, 1037);
INSERT INTO `sys_role_menu` VALUES (3, 1038);
INSERT INTO `sys_role_menu` VALUES (3, 1039);
INSERT INTO `sys_role_menu` VALUES (3, 1040);
INSERT INTO `sys_role_menu` VALUES (3, 1041);
INSERT INTO `sys_role_menu` VALUES (3, 1042);
INSERT INTO `sys_role_menu` VALUES (3, 1043);
INSERT INTO `sys_role_menu` VALUES (3, 1044);
INSERT INTO `sys_role_menu` VALUES (3, 1045);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 100);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 101);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 102);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 103);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 104);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 105);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 106);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 107);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 108);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 113);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 500);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 501);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1001);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1002);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1003);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1004);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1005);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1006);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1007);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1008);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1009);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1010);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1011);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1012);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1013);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1014);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1015);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1016);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1017);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1018);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1019);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1020);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1021);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1022);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1023);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1024);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1025);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1026);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1027);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1028);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1029);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1030);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1031);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1032);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1033);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1034);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1035);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1036);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1037);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1038);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1039);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1040);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1041);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1042);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1043);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1044);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1045);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1050);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1775500307898949634);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1775895273104068610);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1775895273104068611);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1775895273104068612);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1775895273104068613);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1775895273104068614);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1775895273104068615);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780240077690507266);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780240077690507267);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780240077690507268);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780240077690507269);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780240077690507270);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780240077690507271);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780255628576018433);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780255628576018434);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780255628576018435);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780255628576018436);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780255628576018437);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780255628576018438);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1786379590171156481);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1786379590171156482);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1786379590171156483);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1786379590171156484);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1786379590171156485);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1786379590171156486);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1787078000285122561);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1810594719028834305);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1810594719028834306);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1810594719028834307);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1810594719028834308);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1810594719028834309);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1810594719028834310);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1843281231381852162);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1898286496441393153);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1900172314827739137);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1902184523796742145);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906199640746344450);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906200030325882882);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906336170039103490);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906336170039103491);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906336170039103492);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906336170039103493);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906336170039103494);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906336170039103495);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906358690184294402);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906358690184294403);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906358690184294404);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906358690184294405);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906358690184294406);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906358690184294407);
INSERT INTO `sys_role_menu` VALUES (1729685491108446210, 100);
INSERT INTO `sys_role_menu` VALUES (1729685491108446210, 1001);
INSERT INTO `sys_role_menu` VALUES (1729685491108446210, 1002);
INSERT INTO `sys_role_menu` VALUES (1729685491108446210, 1003);
INSERT INTO `sys_role_menu` VALUES (1729685491108446210, 1004);
INSERT INTO `sys_role_menu` VALUES (1729685491108446210, 1005);
INSERT INTO `sys_role_menu` VALUES (1729685491108446210, 1006);
INSERT INTO `sys_role_menu` VALUES (1729685491108446210, 1007);
INSERT INTO `sys_role_menu` VALUES (1729685491108446210, 1898286496441393153);
INSERT INTO `sys_role_menu` VALUES (1729685491108446210, 1941165681591250946);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 100);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1001);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1002);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1003);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1004);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1005);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1006);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1007);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1775500307898949634);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1775895273104068610);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1775895273104068611);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1775895273104068612);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1775895273104068613);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1775895273104068614);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1775895273104068615);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780240077690507266);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780240077690507267);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780240077690507268);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780240077690507269);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780240077690507270);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780240077690507271);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780255628576018433);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780255628576018434);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780255628576018435);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780255628576018436);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780255628576018437);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780255628576018438);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1786379590171156481);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1786379590171156482);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1786379590171156483);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1786379590171156484);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1786379590171156485);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1786379590171156486);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1787078000285122561);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1810594719028834305);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1810594719028834306);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1810594719028834307);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1810594719028834308);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1810594719028834309);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1810594719028834310);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1843281231381852162);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1860690448695549953);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1898286496441393153);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1900172314827739137);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1902184523796742145);
INSERT INTO `sys_role_menu` VALUES (1941156997268041730, 1941164492061470721);
INSERT INTO `sys_role_menu` VALUES (1941156997268041730, 1941164928248115201);
INSERT INTO `sys_role_menu` VALUES (1941156997268041730, 1941165160469950466);
INSERT INTO `sys_role_menu` VALUES (1941157085310676993, 1941163475630616577);
INSERT INTO `sys_role_menu` VALUES (1941157085310676993, 1941163916410023938);
INSERT INTO `sys_role_menu` VALUES (1941157085310676993, 1941164928248115201);

-- ----------------------------
-- Table structure for sys_tenant
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant`;
CREATE TABLE `sys_tenant`  (
  `id` bigint NOT NULL COMMENT 'id',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户编号',
  `contact_user_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `company_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '企业名称',
  `license_number` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '统一社会信用代码',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `intro` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '企业简介',
  `domain` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '域名',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `package_id` bigint NULL DEFAULT NULL COMMENT '租户套餐编号',
  `expire_time` datetime NULL DEFAULT NULL COMMENT '过期时间',
  `account_count` int NULL DEFAULT -1 COMMENT '用户数量（-1不限制）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '租户状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '租户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_tenant
-- ----------------------------
INSERT INTO `sys_tenant` VALUES (1, '000000', '管理组', '15888888888', 'XXX有限公司', NULL, NULL, '多租户通用后台管理管理系统', NULL, NULL, NULL, NULL, -1, '0', '0', 103, 1, '2023-05-14 15:19:39', NULL, NULL);
INSERT INTO `sys_tenant` VALUES (1729685490647072769, '911866', '测试', '11111111111', '5126', '', '', '', '', '', 1729685389795033090, NULL, 1, '0', '2', 103, 1, '2023-11-29 10:15:32', 1, '2023-11-29 10:15:32');

-- ----------------------------
-- Table structure for sys_tenant_package
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant_package`;
CREATE TABLE `sys_tenant_package`  (
  `package_id` bigint NOT NULL COMMENT '租户套餐id',
  `package_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '套餐名称',
  `menu_ids` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联菜单id',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`package_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '租户套餐表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_tenant_package
-- ----------------------------
INSERT INTO `sys_tenant_package` VALUES (1729685389795033090, '测试', '1689205943360188417, 1689243466220355585, 1689201668374556674, 1689243465037561858', '', 1, '0', '2', 103, 1, '2023-11-29 10:15:08', 1, '2023-11-29 10:15:08');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `open_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '微信用户标识',
  `user_grade` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户等级',
  `user_balance` double(20, 2) NULL DEFAULT 0.00 COMMENT '账户余额',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'sys_user' COMMENT '用户类型（sys_user系统用户）',
  `user_plan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Free' COMMENT '用户套餐',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像地址',
  `wx_avatar` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '微信头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `domain_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '注册域名',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, NULL, '1', 855.40, '00000', 103, 'admin', 'admin', 'sys_user', 'Free', 'ageerle@163.com', '15888888888', '0', 'http://static.ibaoyu.wang/image/logo2.png', NULL, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-07-06 20:56:30', NULL, 103, 1, '2023-05-14 15:19:39', 1, '2025-07-06 20:56:30', '管理员');
INSERT INTO `sys_user` VALUES (1905928435494330370, NULL, '1', 100.00, '000000', 103, 'ageerle@163.com', '熊猫助手', 'sys_user', 'Free', 'ageerle@163.com', '', '0', NULL, NULL, '$2a$10$8WO.FFcmu4L/DhzpfM4rbee0HRK6gIYIs2KsRXkc4ckjudbzchvPi', '0', '2', '', NULL, NULL, 103, 1, '2025-03-29 18:22:04', 1, '2025-03-31 10:15:11', '备用账号');
INSERT INTO `sys_user` VALUES (1941157377100017665, NULL, '0', 0.00, '000000', 103, 'js001', '张薇薇教授', 'sys_user', 'Free', '84009609@qq.com', '', '0', NULL, NULL, '$2a$10$qNZKqFQC7AsOK32EojJKG.4l5JXaJCSvZepl.e4VKn2sdMgjvoigq', '0', '0', '127.0.0.1', '2025-07-06 09:40:23', NULL, 103, 1, '2025-07-04 23:29:18', 1941157377100017665, '2025-07-06 09:40:23', '教师角色');
INSERT INTO `sys_user` VALUES (1941157542410121217, NULL, '0', 0.00, '000000', 103, 'xs001', '张启灵', 'sys_user', 'Free', '840096091@qq.com', '', '0', NULL, NULL, '$2a$10$rc8tcwjEmrzBpohOO1PXT.NKUurPL/recvWTaP/eJYnSC.2VqTmia', '0', '0', '127.0.0.1', '2025-07-06 09:42:27', NULL, 103, 1, '2025-07-04 23:29:58', 1941157542410121217, '2025-07-06 09:42:27', '学生角色');
INSERT INTO `sys_user` VALUES (1941157755342352386, NULL, '0', 0.00, '000000', 103, 'gly001', '管理员', 'sys_user', 'Free', '840096092@qq.com', '', '0', NULL, NULL, '$2a$10$LmVSapgcw5xfQU8QQvO6NO8gyduYajRepAkseciWK01N5Irg.EeFe', '0', '0', '127.0.0.1', '2025-07-06 09:45:34', NULL, 103, 1, '2025-07-04 23:30:49', 1941157755342352386, '2025-07-06 09:45:34', '管理员账户');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);
INSERT INTO `sys_user_post` VALUES (1661660085084250114, 2);
INSERT INTO `sys_user_post` VALUES (1661660804847788034, 1);
INSERT INTO `sys_user_post` VALUES (1925795787894333441, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (3, 3);
INSERT INTO `sys_user_role` VALUES (4, 4);
INSERT INTO `sys_user_role` VALUES (1661646824293031937, 1661661183933177857);
INSERT INTO `sys_user_role` VALUES (1661660085084250114, 1661661183933177857);
INSERT INTO `sys_user_role` VALUES (1661660804847788034, 2);
INSERT INTO `sys_user_role` VALUES (1713427806956404738, 1);
INSERT INTO `sys_user_role` VALUES (1713439839684689921, 1);
INSERT INTO `sys_user_role` VALUES (1713440206715650049, 1);
INSERT INTO `sys_user_role` VALUES (1714267685998907393, 1);
INSERT INTO `sys_user_role` VALUES (1714269581270667265, 1);
INSERT INTO `sys_user_role` VALUES (1714270420659949569, 1);
INSERT INTO `sys_user_role` VALUES (1714455864827723777, 1);
INSERT INTO `sys_user_role` VALUES (1714536425072115714, 1);
INSERT INTO `sys_user_role` VALUES (1714819715117105153, 1);
INSERT INTO `sys_user_role` VALUES (1714820415783976961, 1);
INSERT INTO `sys_user_role` VALUES (1714820611611836417, 1);
INSERT INTO `sys_user_role` VALUES (1714820755698761729, 1);
INSERT INTO `sys_user_role` VALUES (1714823588305190914, 1);
INSERT INTO `sys_user_role` VALUES (1714829502936530945, 1);
INSERT INTO `sys_user_role` VALUES (1714898663033290754, 1);
INSERT INTO `sys_user_role` VALUES (1714942733206175746, 1);
INSERT INTO `sys_user_role` VALUES (1714943378361434113, 1);
INSERT INTO `sys_user_role` VALUES (1714943388671033346, 1);
INSERT INTO `sys_user_role` VALUES (1714945928464711682, 1);
INSERT INTO `sys_user_role` VALUES (1714946100850606082, 1);
INSERT INTO `sys_user_role` VALUES (1714952355237347329, 1);
INSERT INTO `sys_user_role` VALUES (1714954192279584770, 1);
INSERT INTO `sys_user_role` VALUES (1714960721598758913, 1);
INSERT INTO `sys_user_role` VALUES (1714961357132283906, 1);
INSERT INTO `sys_user_role` VALUES (1714963426656403458, 1);
INSERT INTO `sys_user_role` VALUES (1714980339130318850, 1);
INSERT INTO `sys_user_role` VALUES (1714985002550444034, 1);
INSERT INTO `sys_user_role` VALUES (1714996959085084674, 1);
INSERT INTO `sys_user_role` VALUES (1715000784541990913, 1);
INSERT INTO `sys_user_role` VALUES (1715160830886297602, 1);
INSERT INTO `sys_user_role` VALUES (1715174792021426177, 1);
INSERT INTO `sys_user_role` VALUES (1715176760861278209, 1);
INSERT INTO `sys_user_role` VALUES (1715187418688405506, 1);
INSERT INTO `sys_user_role` VALUES (1715263570077564930, 1);
INSERT INTO `sys_user_role` VALUES (1715273299113820162, 1);
INSERT INTO `sys_user_role` VALUES (1715289765028577281, 1);
INSERT INTO `sys_user_role` VALUES (1715642509052624897, 1);
INSERT INTO `sys_user_role` VALUES (1715645217792868353, 1);
INSERT INTO `sys_user_role` VALUES (1715655140035543041, 1);
INSERT INTO `sys_user_role` VALUES (1715688813166346242, 1);
INSERT INTO `sys_user_role` VALUES (1715695623109623810, 1);
INSERT INTO `sys_user_role` VALUES (1716076523383177217, 1);
INSERT INTO `sys_user_role` VALUES (1716077329079615490, 1);
INSERT INTO `sys_user_role` VALUES (1716316658037178370, 1);
INSERT INTO `sys_user_role` VALUES (1716375479287824386, 1);
INSERT INTO `sys_user_role` VALUES (1716376929359380482, 1);
INSERT INTO `sys_user_role` VALUES (1716449431389487106, 1);
INSERT INTO `sys_user_role` VALUES (1716626232627707906, 1);
INSERT INTO `sys_user_role` VALUES (1716668774639484929, 1);
INSERT INTO `sys_user_role` VALUES (1716723582348050434, 1);
INSERT INTO `sys_user_role` VALUES (1717010625036828674, 1);
INSERT INTO `sys_user_role` VALUES (1717112818712723458, 1);
INSERT INTO `sys_user_role` VALUES (1717171039955599361, 1);
INSERT INTO `sys_user_role` VALUES (1717382776042569730, 1);
INSERT INTO `sys_user_role` VALUES (1717383874597896194, 1);
INSERT INTO `sys_user_role` VALUES (1717463477270102018, 1);
INSERT INTO `sys_user_role` VALUES (1717550755342467074, 1);
INSERT INTO `sys_user_role` VALUES (1718643906618605569, 1);
INSERT INTO `sys_user_role` VALUES (1719357065528623105, 1);
INSERT INTO `sys_user_role` VALUES (1719629669720145921, 1);
INSERT INTO `sys_user_role` VALUES (1719631746265530370, 1);
INSERT INTO `sys_user_role` VALUES (1719969371128086529, 1);
INSERT INTO `sys_user_role` VALUES (1719994192431955970, 1);
INSERT INTO `sys_user_role` VALUES (1720001597920264194, 1);
INSERT INTO `sys_user_role` VALUES (1720054174099718145, 1);
INSERT INTO `sys_user_role` VALUES (1720373256426635265, 1);
INSERT INTO `sys_user_role` VALUES (1720615324298264578, 1);
INSERT INTO `sys_user_role` VALUES (1720966085100191746, 1);
INSERT INTO `sys_user_role` VALUES (1721433118342397954, 1);
INSERT INTO `sys_user_role` VALUES (1721798759096270850, 1);
INSERT INTO `sys_user_role` VALUES (1721869407395332097, 1);
INSERT INTO `sys_user_role` VALUES (1721869952080232450, 1);
INSERT INTO `sys_user_role` VALUES (1722083875718737921, 1);
INSERT INTO `sys_user_role` VALUES (1722126825769185282, 1);
INSERT INTO `sys_user_role` VALUES (1722453238653169665, 1);
INSERT INTO `sys_user_role` VALUES (1722501722198552577, 1);
INSERT INTO `sys_user_role` VALUES (1722546398997819394, 1);
INSERT INTO `sys_user_role` VALUES (1722635856464097281, 1);
INSERT INTO `sys_user_role` VALUES (1722652602847768578, 1);
INSERT INTO `sys_user_role` VALUES (1722787874222682114, 1);
INSERT INTO `sys_user_role` VALUES (1722799180870889473, 1);
INSERT INTO `sys_user_role` VALUES (1722872660475817986, 1);
INSERT INTO `sys_user_role` VALUES (1722874592401600514, 1);
INSERT INTO `sys_user_role` VALUES (1722883137289367554, 1);
INSERT INTO `sys_user_role` VALUES (1722918534182645762, 1);
INSERT INTO `sys_user_role` VALUES (1723173295586848769, 1);
INSERT INTO `sys_user_role` VALUES (1723222687891107841, 1);
INSERT INTO `sys_user_role` VALUES (1723224404040921089, 1);
INSERT INTO `sys_user_role` VALUES (1723225015520112641, 1);
INSERT INTO `sys_user_role` VALUES (1723278284531478529, 1);
INSERT INTO `sys_user_role` VALUES (1723330835209564161, 1);
INSERT INTO `sys_user_role` VALUES (1723708198137147393, 1);
INSERT INTO `sys_user_role` VALUES (1723754683843260417, 1);
INSERT INTO `sys_user_role` VALUES (1723878185250369537, 1);
INSERT INTO `sys_user_role` VALUES (1723940614634254337, 1);
INSERT INTO `sys_user_role` VALUES (1723975861757325314, 1);
INSERT INTO `sys_user_role` VALUES (1724306907803725826, 1);
INSERT INTO `sys_user_role` VALUES (1724308252862492673, 1);
INSERT INTO `sys_user_role` VALUES (1724382895124295681, 1);
INSERT INTO `sys_user_role` VALUES (1724727778758406145, 1);
INSERT INTO `sys_user_role` VALUES (1724815478295425026, 1);
INSERT INTO `sys_user_role` VALUES (1725026071145107458, 1);
INSERT INTO `sys_user_role` VALUES (1725026978817658881, 1);
INSERT INTO `sys_user_role` VALUES (1725043562961457154, 1);
INSERT INTO `sys_user_role` VALUES (1725058936893362178, 1);
INSERT INTO `sys_user_role` VALUES (1725363117009162242, 1);
INSERT INTO `sys_user_role` VALUES (1725538633251049474, 1);
INSERT INTO `sys_user_role` VALUES (1725564937467875329, 1);
INSERT INTO `sys_user_role` VALUES (1725891713243021314, 1);
INSERT INTO `sys_user_role` VALUES (1725905000621932546, 1);
INSERT INTO `sys_user_role` VALUES (1726440708294049793, 1);
INSERT INTO `sys_user_role` VALUES (1726443526979584002, 1);
INSERT INTO `sys_user_role` VALUES (1726445663797116929, 1);
INSERT INTO `sys_user_role` VALUES (1726452867329687553, 1);
INSERT INTO `sys_user_role` VALUES (1726472827451998209, 1);
INSERT INTO `sys_user_role` VALUES (1726479651370696705, 1);
INSERT INTO `sys_user_role` VALUES (1726487492674195458, 1);
INSERT INTO `sys_user_role` VALUES (1726496513055784961, 1);
INSERT INTO `sys_user_role` VALUES (1726498781398302722, 1);
INSERT INTO `sys_user_role` VALUES (1726506873632587778, 1);
INSERT INTO `sys_user_role` VALUES (1726529248394739714, 1);
INSERT INTO `sys_user_role` VALUES (1726578079102664705, 1);
INSERT INTO `sys_user_role` VALUES (1726582181383634946, 1);
INSERT INTO `sys_user_role` VALUES (1726583555672506369, 1);
INSERT INTO `sys_user_role` VALUES (1726596448690372609, 1);
INSERT INTO `sys_user_role` VALUES (1726599361261207553, 1);
INSERT INTO `sys_user_role` VALUES (1726604511749079041, 1);
INSERT INTO `sys_user_role` VALUES (1726606973822304258, 1);
INSERT INTO `sys_user_role` VALUES (1726609379524083713, 1);
INSERT INTO `sys_user_role` VALUES (1726616151265640450, 1);
INSERT INTO `sys_user_role` VALUES (1726775811478126594, 1);
INSERT INTO `sys_user_role` VALUES (1726795490141667329, 1);
INSERT INTO `sys_user_role` VALUES (1726798403169681410, 1);
INSERT INTO `sys_user_role` VALUES (1726830794655399937, 1);
INSERT INTO `sys_user_role` VALUES (1726862038013313026, 1);
INSERT INTO `sys_user_role` VALUES (1726919220696186882, 1);
INSERT INTO `sys_user_role` VALUES (1727140184050630658, 1);
INSERT INTO `sys_user_role` VALUES (1727506163368722433, 1);
INSERT INTO `sys_user_role` VALUES (1727518983086931969, 1);
INSERT INTO `sys_user_role` VALUES (1727580969606840321, 1);
INSERT INTO `sys_user_role` VALUES (1727590505323429890, 1);
INSERT INTO `sys_user_role` VALUES (1727918393172164609, 1);
INSERT INTO `sys_user_role` VALUES (1728249002000121857, 1);
INSERT INTO `sys_user_role` VALUES (1728680561446486017, 1);
INSERT INTO `sys_user_role` VALUES (1728964404182577153, 1);
INSERT INTO `sys_user_role` VALUES (1729020459675611137, 1);
INSERT INTO `sys_user_role` VALUES (1729051002043691009, 1);
INSERT INTO `sys_user_role` VALUES (1729423744832172033, 1);
INSERT INTO `sys_user_role` VALUES (1729429590291050497, 1);
INSERT INTO `sys_user_role` VALUES (1729685493222375426, 1729685491108446210);
INSERT INTO `sys_user_role` VALUES (1730050324466036738, 1);
INSERT INTO `sys_user_role` VALUES (1730102403335254018, 1);
INSERT INTO `sys_user_role` VALUES (1730129923250122754, 1);
INSERT INTO `sys_user_role` VALUES (1730155108925763586, 1);
INSERT INTO `sys_user_role` VALUES (1730273428207366145, 1);
INSERT INTO `sys_user_role` VALUES (1730498722784669697, 1);
INSERT INTO `sys_user_role` VALUES (1730815105229713410, 1);
INSERT INTO `sys_user_role` VALUES (1730858886951923714, 1);
INSERT INTO `sys_user_role` VALUES (1731357405659824130, 1);
INSERT INTO `sys_user_role` VALUES (1731475532557090818, 1);
INSERT INTO `sys_user_role` VALUES (1731480953627901953, 1);
INSERT INTO `sys_user_role` VALUES (1731502381106495490, 1);
INSERT INTO `sys_user_role` VALUES (1731524458442162177, 1);
INSERT INTO `sys_user_role` VALUES (1731524630094053377, 1);
INSERT INTO `sys_user_role` VALUES (1731524650293821441, 1);
INSERT INTO `sys_user_role` VALUES (1731529253710233601, 1);
INSERT INTO `sys_user_role` VALUES (1731559936046432258, 1);
INSERT INTO `sys_user_role` VALUES (1731564032228884482, 1);
INSERT INTO `sys_user_role` VALUES (1731565926737281026, 1);
INSERT INTO `sys_user_role` VALUES (1731566918589513729, 1);
INSERT INTO `sys_user_role` VALUES (1731567740094283778, 1);
INSERT INTO `sys_user_role` VALUES (1731575439263563777, 1);
INSERT INTO `sys_user_role` VALUES (1731583864055824385, 1);
INSERT INTO `sys_user_role` VALUES (1731588155382464513, 1);
INSERT INTO `sys_user_role` VALUES (1731589827840212993, 1);
INSERT INTO `sys_user_role` VALUES (1731635461435719682, 1);
INSERT INTO `sys_user_role` VALUES (1731668049902731266, 1);
INSERT INTO `sys_user_role` VALUES (1731922694168412162, 1);
INSERT INTO `sys_user_role` VALUES (1731944975456305153, 1);
INSERT INTO `sys_user_role` VALUES (1731949019394506753, 1);
INSERT INTO `sys_user_role` VALUES (1731951425054343170, 1);
INSERT INTO `sys_user_role` VALUES (1732000242621513729, 1);
INSERT INTO `sys_user_role` VALUES (1732027163380056066, 1);
INSERT INTO `sys_user_role` VALUES (1732289382269353985, 1);
INSERT INTO `sys_user_role` VALUES (1732289439282528258, 1);
INSERT INTO `sys_user_role` VALUES (1732289699585228801, 1);
INSERT INTO `sys_user_role` VALUES (1732290827173527553, 1);
INSERT INTO `sys_user_role` VALUES (1732291549344595969, 1);
INSERT INTO `sys_user_role` VALUES (1732293265184030721, 1);
INSERT INTO `sys_user_role` VALUES (1732329664117506049, 1);
INSERT INTO `sys_user_role` VALUES (1732334104450990081, 1);
INSERT INTO `sys_user_role` VALUES (1732578671045672962, 1);
INSERT INTO `sys_user_role` VALUES (1732584047426174978, 1);
INSERT INTO `sys_user_role` VALUES (1732608690321129474, 1);
INSERT INTO `sys_user_role` VALUES (1732678147815014401, 1);
INSERT INTO `sys_user_role` VALUES (1732731410102910977, 1);
INSERT INTO `sys_user_role` VALUES (1733005266763939841, 1);
INSERT INTO `sys_user_role` VALUES (1733016149837774850, 1);
INSERT INTO `sys_user_role` VALUES (1733053523871432705, 1);
INSERT INTO `sys_user_role` VALUES (1733061400367497218, 1);
INSERT INTO `sys_user_role` VALUES (1733167090469732353, 1);
INSERT INTO `sys_user_role` VALUES (1733298702729641986, 1);
INSERT INTO `sys_user_role` VALUES (1733488544511983617, 1);
INSERT INTO `sys_user_role` VALUES (1733720554119659521, 1);
INSERT INTO `sys_user_role` VALUES (1733846657777827842, 1);
INSERT INTO `sys_user_role` VALUES (1733859832720031745, 1);
INSERT INTO `sys_user_role` VALUES (1734137817339559938, 1);
INSERT INTO `sys_user_role` VALUES (1734227535762849793, 1);
INSERT INTO `sys_user_role` VALUES (1734492373726560257, 1);
INSERT INTO `sys_user_role` VALUES (1734508040978726914, 1);
INSERT INTO `sys_user_role` VALUES (1734513545461661697, 1);
INSERT INTO `sys_user_role` VALUES (1734581580998451202, 1);
INSERT INTO `sys_user_role` VALUES (1734751884580298754, 1);
INSERT INTO `sys_user_role` VALUES (1734781716483612674, 1);
INSERT INTO `sys_user_role` VALUES (1734833221987278849, 1);
INSERT INTO `sys_user_role` VALUES (1734834063154946050, 1);
INSERT INTO `sys_user_role` VALUES (1734880697666576386, 1);
INSERT INTO `sys_user_role` VALUES (1734891995888427009, 1);
INSERT INTO `sys_user_role` VALUES (1735132534701367297, 1);
INSERT INTO `sys_user_role` VALUES (1735242647239991298, 1);
INSERT INTO `sys_user_role` VALUES (1735486862444273666, 1);
INSERT INTO `sys_user_role` VALUES (1735487912727355394, 1);
INSERT INTO `sys_user_role` VALUES (1735542352767426561, 1);
INSERT INTO `sys_user_role` VALUES (1735551915889598466, 1);
INSERT INTO `sys_user_role` VALUES (1735616653411557377, 1);
INSERT INTO `sys_user_role` VALUES (1735835864146714626, 1);
INSERT INTO `sys_user_role` VALUES (1735953007769100289, 1);
INSERT INTO `sys_user_role` VALUES (1735960189784891393, 1);
INSERT INTO `sys_user_role` VALUES (1736265950381547522, 1);
INSERT INTO `sys_user_role` VALUES (1736577606684844034, 1);
INSERT INTO `sys_user_role` VALUES (1736638822375563266, 1);
INSERT INTO `sys_user_role` VALUES (1736779069306511361, 1);
INSERT INTO `sys_user_role` VALUES (1737028378602053634, 1);
INSERT INTO `sys_user_role` VALUES (1737271234797314050, 1);
INSERT INTO `sys_user_role` VALUES (1737315322405920770, 1);
INSERT INTO `sys_user_role` VALUES (1737445221154234370, 1);
INSERT INTO `sys_user_role` VALUES (1737452907568635906, 1);
INSERT INTO `sys_user_role` VALUES (1737453186955419649, 1);
INSERT INTO `sys_user_role` VALUES (1737717777685880833, 1);
INSERT INTO `sys_user_role` VALUES (1737768515594166274, 1);
INSERT INTO `sys_user_role` VALUES (1738108912170246145, 1);
INSERT INTO `sys_user_role` VALUES (1738118086488825858, 1);
INSERT INTO `sys_user_role` VALUES (1738520430804279297, 1);
INSERT INTO `sys_user_role` VALUES (1738802060248817666, 1);
INSERT INTO `sys_user_role` VALUES (1738812447119712257, 1);
INSERT INTO `sys_user_role` VALUES (1738941480197234689, 1);
INSERT INTO `sys_user_role` VALUES (1738963430776840194, 1);
INSERT INTO `sys_user_role` VALUES (1739121784341995522, 1);
INSERT INTO `sys_user_role` VALUES (1739166931951886338, 1);
INSERT INTO `sys_user_role` VALUES (1739272055240073217, 1);
INSERT INTO `sys_user_role` VALUES (1739451838930427905, 1);
INSERT INTO `sys_user_role` VALUES (1739452037375533057, 1);
INSERT INTO `sys_user_role` VALUES (1739452376946384898, 1);
INSERT INTO `sys_user_role` VALUES (1739484503888961537, 1);
INSERT INTO `sys_user_role` VALUES (1739485282335006722, 1);
INSERT INTO `sys_user_role` VALUES (1739577551431999490, 1);
INSERT INTO `sys_user_role` VALUES (1739825609910591489, 1);
INSERT INTO `sys_user_role` VALUES (1739916453439152130, 1);
INSERT INTO `sys_user_role` VALUES (1740188388454629378, 1);
INSERT INTO `sys_user_role` VALUES (1741339991320580097, 1);
INSERT INTO `sys_user_role` VALUES (1741803737633542145, 1);
INSERT INTO `sys_user_role` VALUES (1741823858229923841, 1);
INSERT INTO `sys_user_role` VALUES (1741845883943227393, 1);
INSERT INTO `sys_user_role` VALUES (1742179775941201921, 1);
INSERT INTO `sys_user_role` VALUES (1742437553771458562, 1);
INSERT INTO `sys_user_role` VALUES (1742451201315254273, 1);
INSERT INTO `sys_user_role` VALUES (1742469913120419841, 1);
INSERT INTO `sys_user_role` VALUES (1742798283280568321, 1);
INSERT INTO `sys_user_role` VALUES (1742798987701342210, 1);
INSERT INTO `sys_user_role` VALUES (1742799476950126594, 1);
INSERT INTO `sys_user_role` VALUES (1742799839619010562, 1);
INSERT INTO `sys_user_role` VALUES (1742801019527057410, 1);
INSERT INTO `sys_user_role` VALUES (1742804073915699202, 1);
INSERT INTO `sys_user_role` VALUES (1742821280687149058, 1);
INSERT INTO `sys_user_role` VALUES (1742821467476283394, 1);
INSERT INTO `sys_user_role` VALUES (1742822775600009217, 1);
INSERT INTO `sys_user_role` VALUES (1742823890928357377, 1);
INSERT INTO `sys_user_role` VALUES (1742838225297821697, 1);
INSERT INTO `sys_user_role` VALUES (1742902317295423490, 1);
INSERT INTO `sys_user_role` VALUES (1742910854243373058, 1);
INSERT INTO `sys_user_role` VALUES (1742961994725150721, 1);
INSERT INTO `sys_user_role` VALUES (1742969861079388161, 1);
INSERT INTO `sys_user_role` VALUES (1743068363130228737, 1);
INSERT INTO `sys_user_role` VALUES (1743075924621479938, 1);
INSERT INTO `sys_user_role` VALUES (1743079200725225474, 1);
INSERT INTO `sys_user_role` VALUES (1743085878682144769, 1);
INSERT INTO `sys_user_role` VALUES (1743110774967586818, 1);
INSERT INTO `sys_user_role` VALUES (1743162481042870274, 1);
INSERT INTO `sys_user_role` VALUES (1743166491284033537, 1);
INSERT INTO `sys_user_role` VALUES (1743251016219447297, 1);
INSERT INTO `sys_user_role` VALUES (1743469820367142914, 1);
INSERT INTO `sys_user_role` VALUES (1743514389280522242, 1);
INSERT INTO `sys_user_role` VALUES (1743519646916083714, 1);
INSERT INTO `sys_user_role` VALUES (1743670356026654722, 1);
INSERT INTO `sys_user_role` VALUES (1743892570516815874, 1);
INSERT INTO `sys_user_role` VALUES (1743952049409146882, 1);
INSERT INTO `sys_user_role` VALUES (1744268693259993089, 1);
INSERT INTO `sys_user_role` VALUES (1744351384550567938, 1);
INSERT INTO `sys_user_role` VALUES (1744561041202278402, 1);
INSERT INTO `sys_user_role` VALUES (1744574752277196801, 1);
INSERT INTO `sys_user_role` VALUES (1744619123995373569, 1);
INSERT INTO `sys_user_role` VALUES (1744627110742913025, 1);
INSERT INTO `sys_user_role` VALUES (1744634408357916673, 1);
INSERT INTO `sys_user_role` VALUES (1744645281965207554, 1);
INSERT INTO `sys_user_role` VALUES (1744724410316156930, 1);
INSERT INTO `sys_user_role` VALUES (1744892307919400962, 1);
INSERT INTO `sys_user_role` VALUES (1744903174606090241, 1);
INSERT INTO `sys_user_role` VALUES (1744904968014983169, 1);
INSERT INTO `sys_user_role` VALUES (1744905787204497410, 1);
INSERT INTO `sys_user_role` VALUES (1744911513595473921, 1);
INSERT INTO `sys_user_role` VALUES (1744912178359103490, 1);
INSERT INTO `sys_user_role` VALUES (1744912486720139266, 1);
INSERT INTO `sys_user_role` VALUES (1744915552240463874, 1);
INSERT INTO `sys_user_role` VALUES (1744923917133869058, 1);
INSERT INTO `sys_user_role` VALUES (1744971513579761666, 1);
INSERT INTO `sys_user_role` VALUES (1744984070818426882, 1);
INSERT INTO `sys_user_role` VALUES (1744984147393835010, 1);
INSERT INTO `sys_user_role` VALUES (1744992401243041793, 1);
INSERT INTO `sys_user_role` VALUES (1745011131444424706, 1);
INSERT INTO `sys_user_role` VALUES (1745061549180514306, 1);
INSERT INTO `sys_user_role` VALUES (1745346479991091201, 1);
INSERT INTO `sys_user_role` VALUES (1745346822607007745, 1);
INSERT INTO `sys_user_role` VALUES (1745368346374217730, 1);
INSERT INTO `sys_user_role` VALUES (1745424741765259266, 1);
INSERT INTO `sys_user_role` VALUES (1745426757090582530, 1);
INSERT INTO `sys_user_role` VALUES (1745620173124575234, 1);
INSERT INTO `sys_user_role` VALUES (1745623876426571777, 1);
INSERT INTO `sys_user_role` VALUES (1745654577691664386, 1);
INSERT INTO `sys_user_role` VALUES (1745663259879972865, 1);
INSERT INTO `sys_user_role` VALUES (1745686038692012034, 1);
INSERT INTO `sys_user_role` VALUES (1745738268480675842, 1);
INSERT INTO `sys_user_role` VALUES (1745790952546017281, 1);
INSERT INTO `sys_user_role` VALUES (1746397384551211009, 1);
INSERT INTO `sys_user_role` VALUES (1746400980533551105, 1);
INSERT INTO `sys_user_role` VALUES (1746522414111039489, 1);
INSERT INTO `sys_user_role` VALUES (1746873386528223234, 1);
INSERT INTO `sys_user_role` VALUES (1747067318369333249, 1);
INSERT INTO `sys_user_role` VALUES (1747071365822361602, 1);
INSERT INTO `sys_user_role` VALUES (1747153912031948801, 1);
INSERT INTO `sys_user_role` VALUES (1747197655195922434, 1);
INSERT INTO `sys_user_role` VALUES (1747519480203390977, 1);
INSERT INTO `sys_user_role` VALUES (1747521265550831618, 1);
INSERT INTO `sys_user_role` VALUES (1747523421662162945, 1);
INSERT INTO `sys_user_role` VALUES (1747797864993075201, 1);
INSERT INTO `sys_user_role` VALUES (1747800427213697025, 1);
INSERT INTO `sys_user_role` VALUES (1747910191046275073, 1);
INSERT INTO `sys_user_role` VALUES (1747923453217419265, 1);
INSERT INTO `sys_user_role` VALUES (1748187110132232193, 1);
INSERT INTO `sys_user_role` VALUES (1748260926648823809, 1);
INSERT INTO `sys_user_role` VALUES (1748276826697445377, 1);
INSERT INTO `sys_user_role` VALUES (1748312313952808962, 1);
INSERT INTO `sys_user_role` VALUES (1748635584837529601, 1);
INSERT INTO `sys_user_role` VALUES (1748642479459610625, 1);
INSERT INTO `sys_user_role` VALUES (1748663294624346114, 1);
INSERT INTO `sys_user_role` VALUES (1748703876608503810, 1);
INSERT INTO `sys_user_role` VALUES (1748704145589219329, 1);
INSERT INTO `sys_user_role` VALUES (1748708285178523649, 1);
INSERT INTO `sys_user_role` VALUES (1748728575929430017, 1);
INSERT INTO `sys_user_role` VALUES (1748761666442047490, 1);
INSERT INTO `sys_user_role` VALUES (1748925826178035713, 1);
INSERT INTO `sys_user_role` VALUES (1749259130492235778, 1);
INSERT INTO `sys_user_role` VALUES (1749280237328871426, 1);
INSERT INTO `sys_user_role` VALUES (1749289400549322754, 1);
INSERT INTO `sys_user_role` VALUES (1749327661225291778, 1);
INSERT INTO `sys_user_role` VALUES (1749365593797636097, 1);
INSERT INTO `sys_user_role` VALUES (1749407786692325378, 1);
INSERT INTO `sys_user_role` VALUES (1749519043344805890, 1);
INSERT INTO `sys_user_role` VALUES (1749683041063219202, 1);
INSERT INTO `sys_user_role` VALUES (1749683546774646786, 1);
INSERT INTO `sys_user_role` VALUES (1749691765567860737, 1);
INSERT INTO `sys_user_role` VALUES (1749705571236917249, 1);
INSERT INTO `sys_user_role` VALUES (1749740828837359618, 1);
INSERT INTO `sys_user_role` VALUES (1749741179162406914, 1);
INSERT INTO `sys_user_role` VALUES (1749741340039131137, 1);
INSERT INTO `sys_user_role` VALUES (1749747618241130497, 1);
INSERT INTO `sys_user_role` VALUES (1749747701439344641, 1);
INSERT INTO `sys_user_role` VALUES (1749786825391157250, 1);
INSERT INTO `sys_user_role` VALUES (1749789665819963394, 1);
INSERT INTO `sys_user_role` VALUES (1749797707705823234, 1);
INSERT INTO `sys_user_role` VALUES (1749974903762210818, 1);
INSERT INTO `sys_user_role` VALUES (1749982777750081537, 1);
INSERT INTO `sys_user_role` VALUES (1749990634667134978, 1);
INSERT INTO `sys_user_role` VALUES (1749991325137653761, 1);
INSERT INTO `sys_user_role` VALUES (1749992779328016386, 1);
INSERT INTO `sys_user_role` VALUES (1749993573204905985, 1);
INSERT INTO `sys_user_role` VALUES (1749994406877351937, 1);
INSERT INTO `sys_user_role` VALUES (1749995279187726337, 1);
INSERT INTO `sys_user_role` VALUES (1749995486029828097, 1);
INSERT INTO `sys_user_role` VALUES (1749995707686211586, 1);
INSERT INTO `sys_user_role` VALUES (1750000406883749890, 1);
INSERT INTO `sys_user_role` VALUES (1750000942706085889, 1);
INSERT INTO `sys_user_role` VALUES (1750005079111913473, 1);
INSERT INTO `sys_user_role` VALUES (1750428606466117633, 1);
INSERT INTO `sys_user_role` VALUES (1750553534423126017, 1);
INSERT INTO `sys_user_role` VALUES (1750690119441469441, 1);
INSERT INTO `sys_user_role` VALUES (1750723725312413698, 1);
INSERT INTO `sys_user_role` VALUES (1750724537434525697, 1);
INSERT INTO `sys_user_role` VALUES (1750743381616119810, 1);
INSERT INTO `sys_user_role` VALUES (1750822931356192769, 1);
INSERT INTO `sys_user_role` VALUES (1750823004563574785, 1);
INSERT INTO `sys_user_role` VALUES (1751548639330177026, 1);
INSERT INTO `sys_user_role` VALUES (1751796140318658561, 1);
INSERT INTO `sys_user_role` VALUES (1751889049818763265, 1);
INSERT INTO `sys_user_role` VALUES (1751896081141600258, 1);
INSERT INTO `sys_user_role` VALUES (1751949653564723201, 1);
INSERT INTO `sys_user_role` VALUES (1751955373517443073, 1);
INSERT INTO `sys_user_role` VALUES (1751980511470292993, 1);
INSERT INTO `sys_user_role` VALUES (1752128867307884546, 1);
INSERT INTO `sys_user_role` VALUES (1752128948195037185, 1);
INSERT INTO `sys_user_role` VALUES (1752138835683708930, 1);
INSERT INTO `sys_user_role` VALUES (1752148500127682561, 1);
INSERT INTO `sys_user_role` VALUES (1752276638077816834, 1);
INSERT INTO `sys_user_role` VALUES (1752299834210521089, 1);
INSERT INTO `sys_user_role` VALUES (1752306117726703618, 1);
INSERT INTO `sys_user_role` VALUES (1752504006021222402, 1);
INSERT INTO `sys_user_role` VALUES (1752602885546840066, 1);
INSERT INTO `sys_user_role` VALUES (1752724639351050242, 1);
INSERT INTO `sys_user_role` VALUES (1753215436756357122, 1);
INSERT INTO `sys_user_role` VALUES (1753402656570216449, 1);
INSERT INTO `sys_user_role` VALUES (1753486557368029185, 1);
INSERT INTO `sys_user_role` VALUES (1753797902466551809, 1);
INSERT INTO `sys_user_role` VALUES (1753967757819908098, 1);
INSERT INTO `sys_user_role` VALUES (1754016754462887938, 1);
INSERT INTO `sys_user_role` VALUES (1754029247868440577, 1);
INSERT INTO `sys_user_role` VALUES (1754413960445562882, 1);
INSERT INTO `sys_user_role` VALUES (1754424078633537538, 1);
INSERT INTO `sys_user_role` VALUES (1754764137119354881, 1);
INSERT INTO `sys_user_role` VALUES (1755042084761899009, 1);
INSERT INTO `sys_user_role` VALUES (1755047141691625473, 1);
INSERT INTO `sys_user_role` VALUES (1756274975479173121, 1);
INSERT INTO `sys_user_role` VALUES (1756308183021260801, 1);
INSERT INTO `sys_user_role` VALUES (1757325877958938626, 1);
INSERT INTO `sys_user_role` VALUES (1758445439802675202, 1);
INSERT INTO `sys_user_role` VALUES (1759032628991234049, 1);
INSERT INTO `sys_user_role` VALUES (1759050804781125634, 1);
INSERT INTO `sys_user_role` VALUES (1759089524834045954, 1);
INSERT INTO `sys_user_role` VALUES (1759092949802029057, 1);
INSERT INTO `sys_user_role` VALUES (1759100324189573121, 1);
INSERT INTO `sys_user_role` VALUES (1759103449889771521, 1);
INSERT INTO `sys_user_role` VALUES (1759147026191749121, 1);
INSERT INTO `sys_user_role` VALUES (1759413482020147202, 1);
INSERT INTO `sys_user_role` VALUES (1759427862430486529, 1);
INSERT INTO `sys_user_role` VALUES (1759428010174844929, 1);
INSERT INTO `sys_user_role` VALUES (1759496088514465794, 1);
INSERT INTO `sys_user_role` VALUES (1759764705965510657, 1);
INSERT INTO `sys_user_role` VALUES (1759777481207320578, 1);
INSERT INTO `sys_user_role` VALUES (1759806155667279873, 1);
INSERT INTO `sys_user_role` VALUES (1759812015655227394, 1);
INSERT INTO `sys_user_role` VALUES (1759815447778693121, 1);
INSERT INTO `sys_user_role` VALUES (1759832486966726658, 1);
INSERT INTO `sys_user_role` VALUES (1759858071113830402, 1);
INSERT INTO `sys_user_role` VALUES (1759863475847827458, 1);
INSERT INTO `sys_user_role` VALUES (1759868018195173378, 1);
INSERT INTO `sys_user_role` VALUES (1759869729374736385, 1);
INSERT INTO `sys_user_role` VALUES (1760186079276175362, 1);
INSERT INTO `sys_user_role` VALUES (1760319626808922114, 1);
INSERT INTO `sys_user_role` VALUES (1760347236137963522, 1);
INSERT INTO `sys_user_role` VALUES (1760358546837868546, 1);
INSERT INTO `sys_user_role` VALUES (1760377107434180609, 1);
INSERT INTO `sys_user_role` VALUES (1760472305161998338, 1);
INSERT INTO `sys_user_role` VALUES (1760472829932343298, 1);
INSERT INTO `sys_user_role` VALUES (1760477732188721153, 1);
INSERT INTO `sys_user_role` VALUES (1760502088176504833, 1);
INSERT INTO `sys_user_role` VALUES (1760508166310203394, 1);
INSERT INTO `sys_user_role` VALUES (1760511294409543681, 1);
INSERT INTO `sys_user_role` VALUES (1760562604135682049, 1);
INSERT INTO `sys_user_role` VALUES (1760841877480280066, 1);
INSERT INTO `sys_user_role` VALUES (1760896840365510658, 1);
INSERT INTO `sys_user_role` VALUES (1760903600501428226, 1);
INSERT INTO `sys_user_role` VALUES (1761404022634844162, 1);
INSERT INTO `sys_user_role` VALUES (1761954868732891138, 1);
INSERT INTO `sys_user_role` VALUES (1761955584197267458, 1);
INSERT INTO `sys_user_role` VALUES (1762003524345401345, 1);
INSERT INTO `sys_user_role` VALUES (1762004833618366465, 1);
INSERT INTO `sys_user_role` VALUES (1762010183880937474, 1);
INSERT INTO `sys_user_role` VALUES (1762298283890839554, 1);
INSERT INTO `sys_user_role` VALUES (1762363188014747649, 1);
INSERT INTO `sys_user_role` VALUES (1762389902388367361, 1);
INSERT INTO `sys_user_role` VALUES (1762401081961746434, 1);
INSERT INTO `sys_user_role` VALUES (1762481911417540610, 1);
INSERT INTO `sys_user_role` VALUES (1762482221645041665, 1);
INSERT INTO `sys_user_role` VALUES (1762482243174404097, 1);
INSERT INTO `sys_user_role` VALUES (1762483838461153282, 1);
INSERT INTO `sys_user_role` VALUES (1762487212380262401, 1);
INSERT INTO `sys_user_role` VALUES (1762498553535008770, 1);
INSERT INTO `sys_user_role` VALUES (1762636163465138177, 1);
INSERT INTO `sys_user_role` VALUES (1762655625413185537, 1);
INSERT INTO `sys_user_role` VALUES (1762656108559257601, 1);
INSERT INTO `sys_user_role` VALUES (1762673833499217922, 1);
INSERT INTO `sys_user_role` VALUES (1762677825344163842, 1);
INSERT INTO `sys_user_role` VALUES (1762677876015550465, 1);
INSERT INTO `sys_user_role` VALUES (1762678082262061057, 1);
INSERT INTO `sys_user_role` VALUES (1762678138012749825, 1);
INSERT INTO `sys_user_role` VALUES (1762678144652333057, 1);
INSERT INTO `sys_user_role` VALUES (1762678174192816129, 1);
INSERT INTO `sys_user_role` VALUES (1762678472563019777, 1);
INSERT INTO `sys_user_role` VALUES (1762678534596775938, 1);
INSERT INTO `sys_user_role` VALUES (1762678534894571521, 1);
INSERT INTO `sys_user_role` VALUES (1762678581635895298, 1);
INSERT INTO `sys_user_role` VALUES (1762678844920745985, 1);
INSERT INTO `sys_user_role` VALUES (1762679194973163522, 1);
INSERT INTO `sys_user_role` VALUES (1762679425299173378, 1);
INSERT INTO `sys_user_role` VALUES (1762679810776682498, 1);
INSERT INTO `sys_user_role` VALUES (1762679862656028674, 1);
INSERT INTO `sys_user_role` VALUES (1762679937360777217, 1);
INSERT INTO `sys_user_role` VALUES (1762680184698884098, 1);
INSERT INTO `sys_user_role` VALUES (1762680290076577794, 1);
INSERT INTO `sys_user_role` VALUES (1762680350055124993, 1);
INSERT INTO `sys_user_role` VALUES (1762681014038614017, 1);
INSERT INTO `sys_user_role` VALUES (1762681042207559681, 1);
INSERT INTO `sys_user_role` VALUES (1762681082732924929, 1);
INSERT INTO `sys_user_role` VALUES (1762681088869191682, 1);
INSERT INTO `sys_user_role` VALUES (1762681283195490306, 1);
INSERT INTO `sys_user_role` VALUES (1762681876752420865, 1);
INSERT INTO `sys_user_role` VALUES (1762681980129431553, 1);
INSERT INTO `sys_user_role` VALUES (1762682038488977410, 1);
INSERT INTO `sys_user_role` VALUES (1762682208211488769, 1);
INSERT INTO `sys_user_role` VALUES (1762683406603833346, 1);
INSERT INTO `sys_user_role` VALUES (1762683500048732162, 1);
INSERT INTO `sys_user_role` VALUES (1762683740843724801, 1);
INSERT INTO `sys_user_role` VALUES (1762683806404890625, 1);
INSERT INTO `sys_user_role` VALUES (1762684131715108865, 1);
INSERT INTO `sys_user_role` VALUES (1762684408442703874, 1);
INSERT INTO `sys_user_role` VALUES (1762684686994821121, 1);
INSERT INTO `sys_user_role` VALUES (1762686405808017409, 1);
INSERT INTO `sys_user_role` VALUES (1762687370061729794, 1);
INSERT INTO `sys_user_role` VALUES (1762687537527705602, 1);
INSERT INTO `sys_user_role` VALUES (1762687814947360769, 1);
INSERT INTO `sys_user_role` VALUES (1762688734347186177, 1);
INSERT INTO `sys_user_role` VALUES (1762690035701305346, 1);
INSERT INTO `sys_user_role` VALUES (1762690104575971330, 1);
INSERT INTO `sys_user_role` VALUES (1762691273243283457, 1);
INSERT INTO `sys_user_role` VALUES (1762691277462753282, 1);
INSERT INTO `sys_user_role` VALUES (1762692468406013954, 1);
INSERT INTO `sys_user_role` VALUES (1762693304498573314, 1);
INSERT INTO `sys_user_role` VALUES (1762693710704332801, 1);
INSERT INTO `sys_user_role` VALUES (1762694382220791809, 1);
INSERT INTO `sys_user_role` VALUES (1762696242545610754, 1);
INSERT INTO `sys_user_role` VALUES (1762696275626086402, 1);
INSERT INTO `sys_user_role` VALUES (1762696945854894082, 1);
INSERT INTO `sys_user_role` VALUES (1762698940057702402, 1);
INSERT INTO `sys_user_role` VALUES (1762699511732948994, 1);
INSERT INTO `sys_user_role` VALUES (1762701338956320769, 1);
INSERT INTO `sys_user_role` VALUES (1762701352860438530, 1);
INSERT INTO `sys_user_role` VALUES (1762703221934575617, 1);
INSERT INTO `sys_user_role` VALUES (1762705239214444546, 1);
INSERT INTO `sys_user_role` VALUES (1762705858788642817, 1);
INSERT INTO `sys_user_role` VALUES (1762706220585111553, 1);
INSERT INTO `sys_user_role` VALUES (1762707979655237633, 1);
INSERT INTO `sys_user_role` VALUES (1762709372369686529, 1);
INSERT INTO `sys_user_role` VALUES (1762717698755186689, 1);
INSERT INTO `sys_user_role` VALUES (1762719280540471297, 1);
INSERT INTO `sys_user_role` VALUES (1762719395619590146, 1);
INSERT INTO `sys_user_role` VALUES (1762721161459322881, 1);
INSERT INTO `sys_user_role` VALUES (1762721300685049857, 1);
INSERT INTO `sys_user_role` VALUES (1762724284441612290, 1);
INSERT INTO `sys_user_role` VALUES (1762728759105474561, 1);
INSERT INTO `sys_user_role` VALUES (1762732886506131458, 1);
INSERT INTO `sys_user_role` VALUES (1762744418904354818, 1);
INSERT INTO `sys_user_role` VALUES (1762749711537188865, 1);
INSERT INTO `sys_user_role` VALUES (1762749741056700418, 1);
INSERT INTO `sys_user_role` VALUES (1762750396991320065, 1);
INSERT INTO `sys_user_role` VALUES (1762752966828797954, 1);
INSERT INTO `sys_user_role` VALUES (1762753464445218817, 1);
INSERT INTO `sys_user_role` VALUES (1762753558548623362, 1);
INSERT INTO `sys_user_role` VALUES (1762755306625478657, 1);
INSERT INTO `sys_user_role` VALUES (1762756726481268737, 1);
INSERT INTO `sys_user_role` VALUES (1762756744172843010, 1);
INSERT INTO `sys_user_role` VALUES (1762760948073410562, 1);
INSERT INTO `sys_user_role` VALUES (1762768424588062721, 1);
INSERT INTO `sys_user_role` VALUES (1762770353779159041, 1);
INSERT INTO `sys_user_role` VALUES (1762770690174922754, 1);
INSERT INTO `sys_user_role` VALUES (1762773352299671554, 1);
INSERT INTO `sys_user_role` VALUES (1762809323107954689, 1);
INSERT INTO `sys_user_role` VALUES (1762839585439133698, 1);
INSERT INTO `sys_user_role` VALUES (1762854389474177026, 1);
INSERT INTO `sys_user_role` VALUES (1762962461110611969, 1);
INSERT INTO `sys_user_role` VALUES (1763011242199920642, 1);
INSERT INTO `sys_user_role` VALUES (1763014994155843586, 1);
INSERT INTO `sys_user_role` VALUES (1763017291741048833, 1);
INSERT INTO `sys_user_role` VALUES (1763021759299760129, 1);
INSERT INTO `sys_user_role` VALUES (1763033286434140162, 1);
INSERT INTO `sys_user_role` VALUES (1763034914528735233, 1);
INSERT INTO `sys_user_role` VALUES (1763039329885138945, 1);
INSERT INTO `sys_user_role` VALUES (1763046791925248001, 1);
INSERT INTO `sys_user_role` VALUES (1763059898533851137, 1);
INSERT INTO `sys_user_role` VALUES (1763074956366229505, 1);
INSERT INTO `sys_user_role` VALUES (1763083906738335746, 1);
INSERT INTO `sys_user_role` VALUES (1763087371808059394, 1);
INSERT INTO `sys_user_role` VALUES (1763110723763351554, 1);
INSERT INTO `sys_user_role` VALUES (1763119583433633794, 1);
INSERT INTO `sys_user_role` VALUES (1763121912195100674, 1);
INSERT INTO `sys_user_role` VALUES (1763150617374142466, 1);
INSERT INTO `sys_user_role` VALUES (1763219512067928065, 1);
INSERT INTO `sys_user_role` VALUES (1763232955600777217, 1);
INSERT INTO `sys_user_role` VALUES (1763234635201425410, 1);
INSERT INTO `sys_user_role` VALUES (1763246126281568257, 1);
INSERT INTO `sys_user_role` VALUES (1763323873230106626, 1);
INSERT INTO `sys_user_role` VALUES (1763384782623387650, 1);
INSERT INTO `sys_user_role` VALUES (1763386804647014401, 1);
INSERT INTO `sys_user_role` VALUES (1763396269777661953, 1);
INSERT INTO `sys_user_role` VALUES (1763405607485353985, 1);
INSERT INTO `sys_user_role` VALUES (1763432831823425537, 1);
INSERT INTO `sys_user_role` VALUES (1763453676952268802, 1);
INSERT INTO `sys_user_role` VALUES (1763456811204653057, 1);
INSERT INTO `sys_user_role` VALUES (1763461579713064962, 1);
INSERT INTO `sys_user_role` VALUES (1763491204732379137, 1);
INSERT INTO `sys_user_role` VALUES (1763497378051612674, 1);
INSERT INTO `sys_user_role` VALUES (1763559058706096130, 1);
INSERT INTO `sys_user_role` VALUES (1763577018824876033, 1);
INSERT INTO `sys_user_role` VALUES (1763633124087521281, 1);
INSERT INTO `sys_user_role` VALUES (1763886812869775362, 1);
INSERT INTO `sys_user_role` VALUES (1763913997563285506, 1);
INSERT INTO `sys_user_role` VALUES (1764173595432013826, 1);
INSERT INTO `sys_user_role` VALUES (1764261292183998465, 1);
INSERT INTO `sys_user_role` VALUES (1764287995094585346, 1);
INSERT INTO `sys_user_role` VALUES (1764461290695774209, 1);
INSERT INTO `sys_user_role` VALUES (1764474718197993473, 1);
INSERT INTO `sys_user_role` VALUES (1764482496870305794, 1);
INSERT INTO `sys_user_role` VALUES (1764495637402439682, 1);
INSERT INTO `sys_user_role` VALUES (1764498159743619073, 1);
INSERT INTO `sys_user_role` VALUES (1764498751559913473, 1);
INSERT INTO `sys_user_role` VALUES (1764514945641828354, 1);
INSERT INTO `sys_user_role` VALUES (1764519088087453698, 1);
INSERT INTO `sys_user_role` VALUES (1764520899728986114, 1);
INSERT INTO `sys_user_role` VALUES (1764525084016988161, 1);
INSERT INTO `sys_user_role` VALUES (1764539443405475842, 1);
INSERT INTO `sys_user_role` VALUES (1764564174649249794, 1);
INSERT INTO `sys_user_role` VALUES (1764583176607977474, 1);
INSERT INTO `sys_user_role` VALUES (1764607755468505089, 1);
INSERT INTO `sys_user_role` VALUES (1764634462757920770, 1);
INSERT INTO `sys_user_role` VALUES (1764827973771915265, 1);
INSERT INTO `sys_user_role` VALUES (1764831906313596929, 1);
INSERT INTO `sys_user_role` VALUES (1764857801929715713, 1);
INSERT INTO `sys_user_role` VALUES (1764882243925913602, 1);
INSERT INTO `sys_user_role` VALUES (1764897874259816449, 1);
INSERT INTO `sys_user_role` VALUES (1764945289142677505, 1);
INSERT INTO `sys_user_role` VALUES (1764973230396354562, 1);
INSERT INTO `sys_user_role` VALUES (1765026702110044161, 1);
INSERT INTO `sys_user_role` VALUES (1765029529888829441, 1);
INSERT INTO `sys_user_role` VALUES (1765032464647532546, 1);
INSERT INTO `sys_user_role` VALUES (1765189908342321154, 1);
INSERT INTO `sys_user_role` VALUES (1765214567611838465, 1);
INSERT INTO `sys_user_role` VALUES (1765219002413035521, 1);
INSERT INTO `sys_user_role` VALUES (1765220951434801153, 1);
INSERT INTO `sys_user_role` VALUES (1765248990147325954, 1);
INSERT INTO `sys_user_role` VALUES (1765249652247572481, 1);
INSERT INTO `sys_user_role` VALUES (1765256689840893953, 1);
INSERT INTO `sys_user_role` VALUES (1765258070287003649, 1);
INSERT INTO `sys_user_role` VALUES (1765276219292069890, 1);
INSERT INTO `sys_user_role` VALUES (1765276256986279938, 1);
INSERT INTO `sys_user_role` VALUES (1765288006737539074, 1);
INSERT INTO `sys_user_role` VALUES (1765312970979094529, 1);
INSERT INTO `sys_user_role` VALUES (1765626857976840193, 1);
INSERT INTO `sys_user_role` VALUES (1765662415604236289, 1);
INSERT INTO `sys_user_role` VALUES (1765673187432546306, 1);
INSERT INTO `sys_user_role` VALUES (1765733893087510530, 1);
INSERT INTO `sys_user_role` VALUES (1765927148689326081, 1);
INSERT INTO `sys_user_role` VALUES (1765946481549279233, 1);
INSERT INTO `sys_user_role` VALUES (1765987575418880002, 1);
INSERT INTO `sys_user_role` VALUES (1765991619675848705, 1);
INSERT INTO `sys_user_role` VALUES (1765997037533822977, 1);
INSERT INTO `sys_user_role` VALUES (1766008273063411714, 1);
INSERT INTO `sys_user_role` VALUES (1766011496348286978, 1);
INSERT INTO `sys_user_role` VALUES (1766017335771561986, 1);
INSERT INTO `sys_user_role` VALUES (1766020112446947329, 1);
INSERT INTO `sys_user_role` VALUES (1766085955713269762, 1);
INSERT INTO `sys_user_role` VALUES (1766102635604639746, 1);
INSERT INTO `sys_user_role` VALUES (1766323008493355009, 1);
INSERT INTO `sys_user_role` VALUES (1766387294112612353, 1);
INSERT INTO `sys_user_role` VALUES (1766842982618136577, 1);
INSERT INTO `sys_user_role` VALUES (1767018925722730497, 1);
INSERT INTO `sys_user_role` VALUES (1767098572703563778, 1);
INSERT INTO `sys_user_role` VALUES (1767193870939488258, 1);
INSERT INTO `sys_user_role` VALUES (1767371461667356673, 1);
INSERT INTO `sys_user_role` VALUES (1767472876167397377, 1);
INSERT INTO `sys_user_role` VALUES (1767484503956684801, 1);
INSERT INTO `sys_user_role` VALUES (1767494435045146626, 1);
INSERT INTO `sys_user_role` VALUES (1767502928200368129, 1);
INSERT INTO `sys_user_role` VALUES (1767790695329333250, 1);
INSERT INTO `sys_user_role` VALUES (1767797421759823874, 1);
INSERT INTO `sys_user_role` VALUES (1767867514107756545, 1);
INSERT INTO `sys_user_role` VALUES (1768123513418842114, 1);
INSERT INTO `sys_user_role` VALUES (1768125846164897794, 1);
INSERT INTO `sys_user_role` VALUES (1768137512021688322, 1);
INSERT INTO `sys_user_role` VALUES (1768172797870768129, 1);
INSERT INTO `sys_user_role` VALUES (1768257272084463617, 1);
INSERT INTO `sys_user_role` VALUES (1768452168263172097, 1);
INSERT INTO `sys_user_role` VALUES (1768487959811096578, 1);
INSERT INTO `sys_user_role` VALUES (1768522172358754306, 1);
INSERT INTO `sys_user_role` VALUES (1768523379651411969, 1);
INSERT INTO `sys_user_role` VALUES (1768528826072596482, 1);
INSERT INTO `sys_user_role` VALUES (1768554562896560130, 1);
INSERT INTO `sys_user_role` VALUES (1768560191165988866, 1);
INSERT INTO `sys_user_role` VALUES (1768560307197214722, 1);
INSERT INTO `sys_user_role` VALUES (1768561334289989633, 1);
INSERT INTO `sys_user_role` VALUES (1768565063735083009, 1);
INSERT INTO `sys_user_role` VALUES (1768570261782167553, 1);
INSERT INTO `sys_user_role` VALUES (1768598711431626753, 1);
INSERT INTO `sys_user_role` VALUES (1768635967806668802, 1);
INSERT INTO `sys_user_role` VALUES (1768887604487946241, 1);
INSERT INTO `sys_user_role` VALUES (1768911351987077122, 1);
INSERT INTO `sys_user_role` VALUES (1769186172289449986, 1);
INSERT INTO `sys_user_role` VALUES (1769408371134857218, 1);
INSERT INTO `sys_user_role` VALUES (1769520576635371521, 1);
INSERT INTO `sys_user_role` VALUES (1769561862704758786, 1);
INSERT INTO `sys_user_role` VALUES (1769569234722521089, 1);
INSERT INTO `sys_user_role` VALUES (1769607528399273986, 1);
INSERT INTO `sys_user_role` VALUES (1769617177890553857, 1);
INSERT INTO `sys_user_role` VALUES (1769663440459694082, 1);
INSERT INTO `sys_user_role` VALUES (1769908456541233154, 1);
INSERT INTO `sys_user_role` VALUES (1769957357877043201, 1);
INSERT INTO `sys_user_role` VALUES (1770021611783168002, 1);
INSERT INTO `sys_user_role` VALUES (1770063295095087106, 1);
INSERT INTO `sys_user_role` VALUES (1770063700436819970, 1);
INSERT INTO `sys_user_role` VALUES (1770281104395837442, 1);
INSERT INTO `sys_user_role` VALUES (1770288338521661441, 1);
INSERT INTO `sys_user_role` VALUES (1770322814056333313, 1);
INSERT INTO `sys_user_role` VALUES (1770338641849679874, 1);
INSERT INTO `sys_user_role` VALUES (1770351581952802817, 1);
INSERT INTO `sys_user_role` VALUES (1770357305466486786, 1);
INSERT INTO `sys_user_role` VALUES (1770364755406028802, 1);
INSERT INTO `sys_user_role` VALUES (1770381062524436482, 1);
INSERT INTO `sys_user_role` VALUES (1770470677998534657, 1);
INSERT INTO `sys_user_role` VALUES (1770642413331218434, 1);
INSERT INTO `sys_user_role` VALUES (1770648858382630914, 1);
INSERT INTO `sys_user_role` VALUES (1770715116272680962, 1);
INSERT INTO `sys_user_role` VALUES (1770720646688997377, 1);
INSERT INTO `sys_user_role` VALUES (1770726609303175170, 1);
INSERT INTO `sys_user_role` VALUES (1770757521378181121, 1);
INSERT INTO `sys_user_role` VALUES (1770759021907214338, 1);
INSERT INTO `sys_user_role` VALUES (1771002145573240833, 1);
INSERT INTO `sys_user_role` VALUES (1771019340902629377, 1);
INSERT INTO `sys_user_role` VALUES (1771085212270788610, 1);
INSERT INTO `sys_user_role` VALUES (1771091102206066689, 1);
INSERT INTO `sys_user_role` VALUES (1771105696307806210, 1);
INSERT INTO `sys_user_role` VALUES (1771529088861274114, 1);
INSERT INTO `sys_user_role` VALUES (1772148936234565634, 1);
INSERT INTO `sys_user_role` VALUES (1772170742823714818, 1);
INSERT INTO `sys_user_role` VALUES (1772173596070313986, 1);
INSERT INTO `sys_user_role` VALUES (1772181791232819201, 1);
INSERT INTO `sys_user_role` VALUES (1772807697592832001, 1);
INSERT INTO `sys_user_role` VALUES (1772821509767254018, 1);
INSERT INTO `sys_user_role` VALUES (1772947270113251330, 1);
INSERT INTO `sys_user_role` VALUES (1773149840576434178, 1);
INSERT INTO `sys_user_role` VALUES (1773180693536919554, 1);
INSERT INTO `sys_user_role` VALUES (1773192472325345282, 1);
INSERT INTO `sys_user_role` VALUES (1773200350612377601, 1);
INSERT INTO `sys_user_role` VALUES (1773307685607395329, 1);
INSERT INTO `sys_user_role` VALUES (1773529379840282625, 1);
INSERT INTO `sys_user_role` VALUES (1773543535003914241, 1);
INSERT INTO `sys_user_role` VALUES (1773615949826052097, 1);
INSERT INTO `sys_user_role` VALUES (1773714968015278082, 1);
INSERT INTO `sys_user_role` VALUES (1773741523022123010, 1);
INSERT INTO `sys_user_role` VALUES (1773774290929848321, 1);
INSERT INTO `sys_user_role` VALUES (1773969452180258818, 1);
INSERT INTO `sys_user_role` VALUES (1774094144111198210, 1);
INSERT INTO `sys_user_role` VALUES (1774326191970926594, 1);
INSERT INTO `sys_user_role` VALUES (1774595110106685441, 1);
INSERT INTO `sys_user_role` VALUES (1774603290157113346, 1);
INSERT INTO `sys_user_role` VALUES (1774671916088287233, 1);
INSERT INTO `sys_user_role` VALUES (1774712059876728833, 1);
INSERT INTO `sys_user_role` VALUES (1775005868787359746, 1);
INSERT INTO `sys_user_role` VALUES (1775039514470637569, 1);
INSERT INTO `sys_user_role` VALUES (1775046202846208002, 1);
INSERT INTO `sys_user_role` VALUES (1775055115012399106, 1);
INSERT INTO `sys_user_role` VALUES (1775058985780371458, 1);
INSERT INTO `sys_user_role` VALUES (1775066829695082497, 1);
INSERT INTO `sys_user_role` VALUES (1775078808497283074, 1);
INSERT INTO `sys_user_role` VALUES (1775109977754427393, 1);
INSERT INTO `sys_user_role` VALUES (1775109977771204609, 1);
INSERT INTO `sys_user_role` VALUES (1775192704981786626, 1);
INSERT INTO `sys_user_role` VALUES (1775421589681987586, 1);
INSERT INTO `sys_user_role` VALUES (1776124571507613697, 1);
INSERT INTO `sys_user_role` VALUES (1776550027549597698, 1);
INSERT INTO `sys_user_role` VALUES (1776815081159254018, 1);
INSERT INTO `sys_user_role` VALUES (1776827459129171969, 1);
INSERT INTO `sys_user_role` VALUES (1776861348769947650, 1);
INSERT INTO `sys_user_role` VALUES (1776864185373548546, 1);
INSERT INTO `sys_user_role` VALUES (1776871215274516482, 1);
INSERT INTO `sys_user_role` VALUES (1776872376396275714, 1);
INSERT INTO `sys_user_role` VALUES (1776889562355589122, 1);
INSERT INTO `sys_user_role` VALUES (1777118704363757570, 1);
INSERT INTO `sys_user_role` VALUES (1777126438664527874, 1);
INSERT INTO `sys_user_role` VALUES (1777157190659727362, 1);
INSERT INTO `sys_user_role` VALUES (1777217669537062914, 1);
INSERT INTO `sys_user_role` VALUES (1777220647320936449, 1);
INSERT INTO `sys_user_role` VALUES (1777252116550508545, 1);
INSERT INTO `sys_user_role` VALUES (1777260896986193921, 1);
INSERT INTO `sys_user_role` VALUES (1777296499484254210, 1);
INSERT INTO `sys_user_role` VALUES (1777301747972038657, 1);
INSERT INTO `sys_user_role` VALUES (1777363539016409089, 1);
INSERT INTO `sys_user_role` VALUES (1777483372982820866, 1);
INSERT INTO `sys_user_role` VALUES (1777537906459402242, 1);
INSERT INTO `sys_user_role` VALUES (1777610641428570114, 1);
INSERT INTO `sys_user_role` VALUES (1777613556604067842, 1);
INSERT INTO `sys_user_role` VALUES (1777718773123244034, 1);
INSERT INTO `sys_user_role` VALUES (1777743939492503554, 1);
INSERT INTO `sys_user_role` VALUES (1777887539056467969, 1);
INSERT INTO `sys_user_role` VALUES (1777887799262699521, 1);
INSERT INTO `sys_user_role` VALUES (1777890253115088897, 1);
INSERT INTO `sys_user_role` VALUES (1777909423068274689, 1);
INSERT INTO `sys_user_role` VALUES (1777930481544585218, 1);
INSERT INTO `sys_user_role` VALUES (1777954050559303681, 1);
INSERT INTO `sys_user_role` VALUES (1778078614597525506, 1);
INSERT INTO `sys_user_role` VALUES (1778307871026307073, 1);
INSERT INTO `sys_user_role` VALUES (1778341191034462209, 1);
INSERT INTO `sys_user_role` VALUES (1778352526686281729, 1);
INSERT INTO `sys_user_role` VALUES (1778591039688138754, 1);
INSERT INTO `sys_user_role` VALUES (1778625241280274433, 1);
INSERT INTO `sys_user_role` VALUES (1778645603636338689, 1);
INSERT INTO `sys_user_role` VALUES (1779329016437530626, 1);
INSERT INTO `sys_user_role` VALUES (1779509451201306625, 1);
INSERT INTO `sys_user_role` VALUES (1781359789389049858, 1);
INSERT INTO `sys_user_role` VALUES (1781463900025450497, 1);
INSERT INTO `sys_user_role` VALUES (1781519961809940482, 1);
INSERT INTO `sys_user_role` VALUES (1781570458679963650, 1);
INSERT INTO `sys_user_role` VALUES (1781679536911609858, 1);
INSERT INTO `sys_user_role` VALUES (1781680345497923586, 1);
INSERT INTO `sys_user_role` VALUES (1781938051479711745, 1);
INSERT INTO `sys_user_role` VALUES (1781979644345659393, 1);
INSERT INTO `sys_user_role` VALUES (1781982608724537345, 1);
INSERT INTO `sys_user_role` VALUES (1782339521316294658, 1);
INSERT INTO `sys_user_role` VALUES (1782584811885596674, 1);
INSERT INTO `sys_user_role` VALUES (1782597966938411009, 1);
INSERT INTO `sys_user_role` VALUES (1782598345608564738, 1);
INSERT INTO `sys_user_role` VALUES (1782599696132509698, 1);
INSERT INTO `sys_user_role` VALUES (1782655923667505153, 1);
INSERT INTO `sys_user_role` VALUES (1782658558470557698, 1);
INSERT INTO `sys_user_role` VALUES (1782697212870037505, 1);
INSERT INTO `sys_user_role` VALUES (1782711689380270082, 1);
INSERT INTO `sys_user_role` VALUES (1782733890905083906, 1);
INSERT INTO `sys_user_role` VALUES (1782734018948796418, 1);
INSERT INTO `sys_user_role` VALUES (1782741134992379906, 1);
INSERT INTO `sys_user_role` VALUES (1782926062560382978, 1);
INSERT INTO `sys_user_role` VALUES (1782941277477834753, 1);
INSERT INTO `sys_user_role` VALUES (1782982532157050881, 1);
INSERT INTO `sys_user_role` VALUES (1783068876598317057, 1);
INSERT INTO `sys_user_role` VALUES (1783086777506107393, 1);
INSERT INTO `sys_user_role` VALUES (1783144268357079041, 1);
INSERT INTO `sys_user_role` VALUES (1783297415947915265, 1);
INSERT INTO `sys_user_role` VALUES (1783310569679523841, 1);
INSERT INTO `sys_user_role` VALUES (1783326930816372738, 1);
INSERT INTO `sys_user_role` VALUES (1783358421143293953, 1);
INSERT INTO `sys_user_role` VALUES (1783421941125910530, 1);
INSERT INTO `sys_user_role` VALUES (1783439451980206081, 1);
INSERT INTO `sys_user_role` VALUES (1783471940098494466, 1);
INSERT INTO `sys_user_role` VALUES (1783777388311777281, 1);
INSERT INTO `sys_user_role` VALUES (1783796572785643521, 1);
INSERT INTO `sys_user_role` VALUES (1783877442208960514, 1);
INSERT INTO `sys_user_role` VALUES (1784199358216048642, 1);
INSERT INTO `sys_user_role` VALUES (1784389326918029313, 1);
INSERT INTO `sys_user_role` VALUES (1784400528377286657, 1);
INSERT INTO `sys_user_role` VALUES (1784435756558880770, 1);
INSERT INTO `sys_user_role` VALUES (1784457537797656577, 1);
INSERT INTO `sys_user_role` VALUES (1784521057603538945, 1);
INSERT INTO `sys_user_role` VALUES (1784522252246724609, 1);
INSERT INTO `sys_user_role` VALUES (1784548227567202306, 1);
INSERT INTO `sys_user_role` VALUES (1784569508068995073, 1);
INSERT INTO `sys_user_role` VALUES (1784777389905162242, 1);
INSERT INTO `sys_user_role` VALUES (1784783910114308097, 1);
INSERT INTO `sys_user_role` VALUES (1784821184902344705, 1);
INSERT INTO `sys_user_role` VALUES (1784838825360633858, 1);
INSERT INTO `sys_user_role` VALUES (1784870260805087233, 1);
INSERT INTO `sys_user_role` VALUES (1784910451020279810, 1);
INSERT INTO `sys_user_role` VALUES (1785130539233193985, 1);
INSERT INTO `sys_user_role` VALUES (1785240710601125890, 1);
INSERT INTO `sys_user_role` VALUES (1785360485289439233, 1);
INSERT INTO `sys_user_role` VALUES (1785588726424023041, 1);
INSERT INTO `sys_user_role` VALUES (1785975035152019458, 1);
INSERT INTO `sys_user_role` VALUES (1786448824117735425, 1);
INSERT INTO `sys_user_role` VALUES (1787036511853850625, 1);
INSERT INTO `sys_user_role` VALUES (1787040098730356738, 1);
INSERT INTO `sys_user_role` VALUES (1787442869522636802, 1);
INSERT INTO `sys_user_role` VALUES (1787802087576530946, 1);
INSERT INTO `sys_user_role` VALUES (1787878100067119105, 1);
INSERT INTO `sys_user_role` VALUES (1788016335816716290, 1);
INSERT INTO `sys_user_role` VALUES (1788135951385718786, 1);
INSERT INTO `sys_user_role` VALUES (1788136924611047425, 1);
INSERT INTO `sys_user_role` VALUES (1788564791958401026, 1);
INSERT INTO `sys_user_role` VALUES (1788861563763126273, 1);
INSERT INTO `sys_user_role` VALUES (1789104577664217090, 1);
INSERT INTO `sys_user_role` VALUES (1789215891946434561, 1);
INSERT INTO `sys_user_role` VALUES (1789891068120231937, 1);
INSERT INTO `sys_user_role` VALUES (1789916787885961218, 1);
INSERT INTO `sys_user_role` VALUES (1790285085844664322, 1);
INSERT INTO `sys_user_role` VALUES (1790395963663413250, 1);
INSERT INTO `sys_user_role` VALUES (1790626495441698817, 1);
INSERT INTO `sys_user_role` VALUES (1790733204311015425, 1);
INSERT INTO `sys_user_role` VALUES (1790747738857832449, 1);
INSERT INTO `sys_user_role` VALUES (1790893072141549570, 1);
INSERT INTO `sys_user_role` VALUES (1790953693902045186, 1);
INSERT INTO `sys_user_role` VALUES (1790986267617689601, 1);
INSERT INTO `sys_user_role` VALUES (1791058271444172801, 1);
INSERT INTO `sys_user_role` VALUES (1791123542645178370, 1);
INSERT INTO `sys_user_role` VALUES (1791170948304764929, 1);
INSERT INTO `sys_user_role` VALUES (1791173160204533762, 1);
INSERT INTO `sys_user_role` VALUES (1791181681805524994, 1);
INSERT INTO `sys_user_role` VALUES (1791184448041287681, 1);
INSERT INTO `sys_user_role` VALUES (1791281872491544578, 1);
INSERT INTO `sys_user_role` VALUES (1791281970680201217, 1);
INSERT INTO `sys_user_role` VALUES (1791283037744693249, 1);
INSERT INTO `sys_user_role` VALUES (1791285337913589762, 1);
INSERT INTO `sys_user_role` VALUES (1791289816255856641, 1);
INSERT INTO `sys_user_role` VALUES (1791296357612683266, 1);
INSERT INTO `sys_user_role` VALUES (1791299213191315457, 1);
INSERT INTO `sys_user_role` VALUES (1791308308178829314, 1);
INSERT INTO `sys_user_role` VALUES (1791318977032781826, 1);
INSERT INTO `sys_user_role` VALUES (1791371260403687425, 1);
INSERT INTO `sys_user_role` VALUES (1791387421707116546, 1);
INSERT INTO `sys_user_role` VALUES (1791447204858470402, 1);
INSERT INTO `sys_user_role` VALUES (1791729117863124993, 1);
INSERT INTO `sys_user_role` VALUES (1793165965818912770, 1);
INSERT INTO `sys_user_role` VALUES (1793568337082740737, 1);
INSERT INTO `sys_user_role` VALUES (1794560044937154561, 1);
INSERT INTO `sys_user_role` VALUES (1794749939555143681, 1);
INSERT INTO `sys_user_role` VALUES (1795107096276410369, 1);
INSERT INTO `sys_user_role` VALUES (1795403915137032194, 1);
INSERT INTO `sys_user_role` VALUES (1795789913440296962, 1);
INSERT INTO `sys_user_role` VALUES (1796141206390349825, 1);
INSERT INTO `sys_user_role` VALUES (1796355287995031553, 1);
INSERT INTO `sys_user_role` VALUES (1796407753490997250, 1);
INSERT INTO `sys_user_role` VALUES (1796463188688412674, 1);
INSERT INTO `sys_user_role` VALUES (1796906411999272961, 1);
INSERT INTO `sys_user_role` VALUES (1797537246867791874, 1);
INSERT INTO `sys_user_role` VALUES (1797817711835127809, 1);
INSERT INTO `sys_user_role` VALUES (1797909973524979713, 1);
INSERT INTO `sys_user_role` VALUES (1798175479586791425, 1);
INSERT INTO `sys_user_role` VALUES (1798235243616313345, 1);
INSERT INTO `sys_user_role` VALUES (1798520237534388226, 1);
INSERT INTO `sys_user_role` VALUES (1798712494199840770, 1);
INSERT INTO `sys_user_role` VALUES (1799280384053518338, 1);
INSERT INTO `sys_user_role` VALUES (1799744018567307266, 1);
INSERT INTO `sys_user_role` VALUES (1800533174780338178, 1);
INSERT INTO `sys_user_role` VALUES (1800536812638609409, 1);
INSERT INTO `sys_user_role` VALUES (1800674959565430786, 1);
INSERT INTO `sys_user_role` VALUES (1801079442480996354, 1);
INSERT INTO `sys_user_role` VALUES (1801092008536088577, 1);
INSERT INTO `sys_user_role` VALUES (1801164484339212289, 1);
INSERT INTO `sys_user_role` VALUES (1801390702451924994, 1);
INSERT INTO `sys_user_role` VALUES (1801448239394103297, 1);
INSERT INTO `sys_user_role` VALUES (1801450423980564482, 1);
INSERT INTO `sys_user_role` VALUES (1801600035647299585, 1);
INSERT INTO `sys_user_role` VALUES (1801917626890756098, 1);
INSERT INTO `sys_user_role` VALUES (1802151483346952194, 1);
INSERT INTO `sys_user_role` VALUES (1802185387541962754, 1);
INSERT INTO `sys_user_role` VALUES (1802352201437716481, 1);
INSERT INTO `sys_user_role` VALUES (1802595299652706305, 1);
INSERT INTO `sys_user_role` VALUES (1802615605641519105, 1);
INSERT INTO `sys_user_role` VALUES (1802884960002416641, 1);
INSERT INTO `sys_user_role` VALUES (1803244799710896130, 1);
INSERT INTO `sys_user_role` VALUES (1803310345022251010, 1);
INSERT INTO `sys_user_role` VALUES (1803350775793360898, 1);
INSERT INTO `sys_user_role` VALUES (1803952381528145922, 1);
INSERT INTO `sys_user_role` VALUES (1804409446046400513, 1);
INSERT INTO `sys_user_role` VALUES (1804412156426616834, 1);
INSERT INTO `sys_user_role` VALUES (1805074712967282689, 1);
INSERT INTO `sys_user_role` VALUES (1806151742303535105, 1);
INSERT INTO `sys_user_role` VALUES (1806589360086482945, 1);
INSERT INTO `sys_user_role` VALUES (1806743654970458113, 1);
INSERT INTO `sys_user_role` VALUES (1807019618258419713, 1);
INSERT INTO `sys_user_role` VALUES (1807670449198628866, 1);
INSERT INTO `sys_user_role` VALUES (1808432476074573826, 1);
INSERT INTO `sys_user_role` VALUES (1809093167261450242, 1);
INSERT INTO `sys_user_role` VALUES (1809123002226606082, 1);
INSERT INTO `sys_user_role` VALUES (1811926844047654913, 1);
INSERT INTO `sys_user_role` VALUES (1813103212164841473, 1);
INSERT INTO `sys_user_role` VALUES (1815634871045087233, 1);
INSERT INTO `sys_user_role` VALUES (1816485229208297473, 1);
INSERT INTO `sys_user_role` VALUES (1821084376519434241, 1);
INSERT INTO `sys_user_role` VALUES (1821169552259833858, 1);
INSERT INTO `sys_user_role` VALUES (1821804728467873793, 1);
INSERT INTO `sys_user_role` VALUES (1822834793930637314, 1);
INSERT INTO `sys_user_role` VALUES (1822959243497914370, 1);
INSERT INTO `sys_user_role` VALUES (1826249520908156930, 1);
INSERT INTO `sys_user_role` VALUES (1829035060720123905, 1);
INSERT INTO `sys_user_role` VALUES (1831211798115991553, 1);
INSERT INTO `sys_user_role` VALUES (1831273555001950210, 1);
INSERT INTO `sys_user_role` VALUES (1834083211252416513, 1);
INSERT INTO `sys_user_role` VALUES (1838475187125043201, 1);
INSERT INTO `sys_user_role` VALUES (1846455089220632577, 1);
INSERT INTO `sys_user_role` VALUES (1847910185208987649, 1);
INSERT INTO `sys_user_role` VALUES (1871910972567822337, 1);
INSERT INTO `sys_user_role` VALUES (1897620177094057985, 1);
INSERT INTO `sys_user_role` VALUES (1925795787894333441, 1729685491108446210);
INSERT INTO `sys_user_role` VALUES (1941157377100017665, 1941156997268041730);
INSERT INTO `sys_user_role` VALUES (1941157542410121217, 1941157085310676993);
INSERT INTO `sys_user_role` VALUES (1941157755342352386, 1729685491108446210);

SET FOREIGN_KEY_CHECKS = 1;
