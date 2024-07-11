/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80034
 Source Host           : localhost:3306
 Source Schema         : online_feedback_system

 Target Server Type    : MySQL
 Target Server Version : 80034
 File Encoding         : 65001

 Date: 10/05/2024 14:55:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ass_mark_detail
-- ----------------------------
DROP TABLE IF EXISTS `ass_mark_detail`;
CREATE TABLE `ass_mark_detail`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `ass_submission_id` int(0) NOT NULL,
  `criterion_id` int(0) NOT NULL,
  `mark` int(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_criterion_id_2`(`criterion_id`) USING BTREE,
  INDEX `FK_ass_id_2`(`ass_submission_id`) USING BTREE,
  CONSTRAINT `FK_ass_id_2` FOREIGN KEY (`ass_submission_id`) REFERENCES `ass_submission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_criterion_id_2` FOREIGN KEY (`criterion_id`) REFERENCES `criterion` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 303 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ass_mark_detail
-- ----------------------------
INSERT INTO `ass_mark_detail` VALUES (1, 1, 1, 5);
INSERT INTO `ass_mark_detail` VALUES (2, 1, 2, 8);
INSERT INTO `ass_mark_detail` VALUES (3, 1, 3, 3);
INSERT INTO `ass_mark_detail` VALUES (4, 1, 4, 0);
INSERT INTO `ass_mark_detail` VALUES (5, 1, 5, 3);
INSERT INTO `ass_mark_detail` VALUES (6, 1, 6, 4);
INSERT INTO `ass_mark_detail` VALUES (7, 1, 7, 3);
INSERT INTO `ass_mark_detail` VALUES (8, 1, 8, 6);
INSERT INTO `ass_mark_detail` VALUES (9, 1, 9, 5);
INSERT INTO `ass_mark_detail` VALUES (10, 1, 10, 5);
INSERT INTO `ass_mark_detail` VALUES (11, 1, 11, 5);
INSERT INTO `ass_mark_detail` VALUES (12, 1, 12, 6);
INSERT INTO `ass_mark_detail` VALUES (13, 1, 13, 6);
INSERT INTO `ass_mark_detail` VALUES (14, 1, 14, 3);
INSERT INTO `ass_mark_detail` VALUES (15, 1, 15, 2);
INSERT INTO `ass_mark_detail` VALUES (16, 1, 16, 5);
INSERT INTO `ass_mark_detail` VALUES (17, 1, 17, 2);
INSERT INTO `ass_mark_detail` VALUES (18, 1, 18, 6);
INSERT INTO `ass_mark_detail` VALUES (19, 1, 19, 3);
INSERT INTO `ass_mark_detail` VALUES (20, 1, 20, 1);
INSERT INTO `ass_mark_detail` VALUES (21, 1, 21, 1);
INSERT INTO `ass_mark_detail` VALUES (22, 1, 22, 2);
INSERT INTO `ass_mark_detail` VALUES (23, 1, 23, 3);
INSERT INTO `ass_mark_detail` VALUES (24, 2, 1, 5);
INSERT INTO `ass_mark_detail` VALUES (25, 2, 2, 8);
INSERT INTO `ass_mark_detail` VALUES (26, 2, 3, 3);
INSERT INTO `ass_mark_detail` VALUES (27, 2, 4, 0);
INSERT INTO `ass_mark_detail` VALUES (28, 2, 5, 3);
INSERT INTO `ass_mark_detail` VALUES (29, 2, 6, 4);
INSERT INTO `ass_mark_detail` VALUES (30, 2, 7, 3);
INSERT INTO `ass_mark_detail` VALUES (31, 2, 8, 6);
INSERT INTO `ass_mark_detail` VALUES (32, 2, 9, 5);
INSERT INTO `ass_mark_detail` VALUES (33, 2, 10, 5);
INSERT INTO `ass_mark_detail` VALUES (34, 2, 11, 5);
INSERT INTO `ass_mark_detail` VALUES (35, 2, 12, 6);
INSERT INTO `ass_mark_detail` VALUES (36, 2, 13, 3);
INSERT INTO `ass_mark_detail` VALUES (37, 2, 14, 3);
INSERT INTO `ass_mark_detail` VALUES (38, 2, 15, 2);
INSERT INTO `ass_mark_detail` VALUES (39, 2, 16, 0);
INSERT INTO `ass_mark_detail` VALUES (40, 2, 17, 2);
INSERT INTO `ass_mark_detail` VALUES (41, 2, 18, 4);
INSERT INTO `ass_mark_detail` VALUES (42, 2, 19, 2);
INSERT INTO `ass_mark_detail` VALUES (43, 2, 20, 0);
INSERT INTO `ass_mark_detail` VALUES (44, 2, 21, 1);
INSERT INTO `ass_mark_detail` VALUES (45, 2, 22, 1);
INSERT INTO `ass_mark_detail` VALUES (46, 2, 23, 2);
INSERT INTO `ass_mark_detail` VALUES (47, 3, 1, 10);
INSERT INTO `ass_mark_detail` VALUES (48, 3, 2, 8);
INSERT INTO `ass_mark_detail` VALUES (49, 3, 3, 3);
INSERT INTO `ass_mark_detail` VALUES (50, 3, 4, 0);
INSERT INTO `ass_mark_detail` VALUES (51, 3, 5, 3);
INSERT INTO `ass_mark_detail` VALUES (52, 3, 6, 1);
INSERT INTO `ass_mark_detail` VALUES (53, 3, 7, 3);
INSERT INTO `ass_mark_detail` VALUES (54, 3, 8, 6);
INSERT INTO `ass_mark_detail` VALUES (55, 3, 9, 1);
INSERT INTO `ass_mark_detail` VALUES (56, 3, 10, 1);
INSERT INTO `ass_mark_detail` VALUES (57, 3, 11, 5);
INSERT INTO `ass_mark_detail` VALUES (58, 3, 12, 6);
INSERT INTO `ass_mark_detail` VALUES (59, 3, 13, 3);
INSERT INTO `ass_mark_detail` VALUES (60, 3, 14, 3);
INSERT INTO `ass_mark_detail` VALUES (61, 3, 15, 2);
INSERT INTO `ass_mark_detail` VALUES (62, 3, 16, 3);
INSERT INTO `ass_mark_detail` VALUES (63, 3, 17, 2);
INSERT INTO `ass_mark_detail` VALUES (64, 3, 18, 0);
INSERT INTO `ass_mark_detail` VALUES (65, 3, 19, 0);
INSERT INTO `ass_mark_detail` VALUES (66, 3, 20, 0);
INSERT INTO `ass_mark_detail` VALUES (67, 3, 21, 1);
INSERT INTO `ass_mark_detail` VALUES (68, 3, 22, 2);
INSERT INTO `ass_mark_detail` VALUES (69, 3, 23, 0);
INSERT INTO `ass_mark_detail` VALUES (70, 4, 1, 10);
INSERT INTO `ass_mark_detail` VALUES (71, 4, 2, 8);
INSERT INTO `ass_mark_detail` VALUES (72, 4, 3, 3);
INSERT INTO `ass_mark_detail` VALUES (73, 4, 4, 2);
INSERT INTO `ass_mark_detail` VALUES (74, 4, 5, 3);
INSERT INTO `ass_mark_detail` VALUES (75, 4, 6, 4);
INSERT INTO `ass_mark_detail` VALUES (76, 4, 7, 4);
INSERT INTO `ass_mark_detail` VALUES (77, 4, 8, 6);
INSERT INTO `ass_mark_detail` VALUES (78, 4, 9, 5);
INSERT INTO `ass_mark_detail` VALUES (79, 4, 10, 5);
INSERT INTO `ass_mark_detail` VALUES (80, 4, 11, 5);
INSERT INTO `ass_mark_detail` VALUES (81, 4, 12, 6);
INSERT INTO `ass_mark_detail` VALUES (82, 4, 13, 3);
INSERT INTO `ass_mark_detail` VALUES (83, 4, 14, 3);
INSERT INTO `ass_mark_detail` VALUES (84, 4, 15, 2);
INSERT INTO `ass_mark_detail` VALUES (85, 4, 16, 1);
INSERT INTO `ass_mark_detail` VALUES (86, 4, 17, 2);
INSERT INTO `ass_mark_detail` VALUES (87, 4, 18, 4);
INSERT INTO `ass_mark_detail` VALUES (88, 4, 19, 1);
INSERT INTO `ass_mark_detail` VALUES (89, 4, 20, 1);
INSERT INTO `ass_mark_detail` VALUES (90, 4, 21, 1);
INSERT INTO `ass_mark_detail` VALUES (91, 4, 22, 2);
INSERT INTO `ass_mark_detail` VALUES (92, 4, 23, 3);
INSERT INTO `ass_mark_detail` VALUES (93, 5, 1, 10);
INSERT INTO `ass_mark_detail` VALUES (94, 5, 2, 8);
INSERT INTO `ass_mark_detail` VALUES (95, 5, 3, 0);
INSERT INTO `ass_mark_detail` VALUES (96, 5, 4, 0);
INSERT INTO `ass_mark_detail` VALUES (97, 5, 5, 0);
INSERT INTO `ass_mark_detail` VALUES (98, 5, 6, 0);
INSERT INTO `ass_mark_detail` VALUES (99, 5, 7, 0);
INSERT INTO `ass_mark_detail` VALUES (100, 5, 8, 6);
INSERT INTO `ass_mark_detail` VALUES (101, 5, 9, 5);
INSERT INTO `ass_mark_detail` VALUES (102, 5, 10, 5);
INSERT INTO `ass_mark_detail` VALUES (103, 5, 11, 5);
INSERT INTO `ass_mark_detail` VALUES (104, 5, 12, 6);
INSERT INTO `ass_mark_detail` VALUES (105, 5, 13, 1);
INSERT INTO `ass_mark_detail` VALUES (106, 5, 14, 3);
INSERT INTO `ass_mark_detail` VALUES (107, 5, 15, 0);
INSERT INTO `ass_mark_detail` VALUES (108, 5, 16, 0);
INSERT INTO `ass_mark_detail` VALUES (109, 5, 17, 0);
INSERT INTO `ass_mark_detail` VALUES (110, 5, 18, 6);
INSERT INTO `ass_mark_detail` VALUES (111, 5, 19, 2);
INSERT INTO `ass_mark_detail` VALUES (112, 5, 20, 0);
INSERT INTO `ass_mark_detail` VALUES (113, 5, 21, 1);
INSERT INTO `ass_mark_detail` VALUES (114, 5, 22, 1);
INSERT INTO `ass_mark_detail` VALUES (115, 5, 23, 1);
INSERT INTO `ass_mark_detail` VALUES (116, 6, 1, 3);
INSERT INTO `ass_mark_detail` VALUES (117, 6, 2, 8);
INSERT INTO `ass_mark_detail` VALUES (118, 6, 3, 0);
INSERT INTO `ass_mark_detail` VALUES (119, 6, 4, 0);
INSERT INTO `ass_mark_detail` VALUES (120, 6, 5, 0);
INSERT INTO `ass_mark_detail` VALUES (121, 6, 6, 0);
INSERT INTO `ass_mark_detail` VALUES (122, 6, 7, 2);
INSERT INTO `ass_mark_detail` VALUES (123, 6, 8, 6);
INSERT INTO `ass_mark_detail` VALUES (124, 6, 9, 0);
INSERT INTO `ass_mark_detail` VALUES (125, 6, 10, 2);
INSERT INTO `ass_mark_detail` VALUES (126, 6, 11, 0);
INSERT INTO `ass_mark_detail` VALUES (127, 6, 12, 0);
INSERT INTO `ass_mark_detail` VALUES (128, 6, 13, 0);
INSERT INTO `ass_mark_detail` VALUES (129, 6, 14, 3);
INSERT INTO `ass_mark_detail` VALUES (130, 6, 15, 1);
INSERT INTO `ass_mark_detail` VALUES (131, 6, 16, 0);
INSERT INTO `ass_mark_detail` VALUES (132, 6, 17, 0);
INSERT INTO `ass_mark_detail` VALUES (133, 6, 18, 3);
INSERT INTO `ass_mark_detail` VALUES (134, 6, 19, 2);
INSERT INTO `ass_mark_detail` VALUES (135, 6, 20, 0);
INSERT INTO `ass_mark_detail` VALUES (136, 6, 21, 1);
INSERT INTO `ass_mark_detail` VALUES (137, 6, 22, 1);
INSERT INTO `ass_mark_detail` VALUES (138, 6, 23, 2);
INSERT INTO `ass_mark_detail` VALUES (139, 7, 1, 10);
INSERT INTO `ass_mark_detail` VALUES (140, 7, 2, 8);
INSERT INTO `ass_mark_detail` VALUES (141, 7, 3, 0);
INSERT INTO `ass_mark_detail` VALUES (142, 7, 4, 0);
INSERT INTO `ass_mark_detail` VALUES (143, 7, 5, 0);
INSERT INTO `ass_mark_detail` VALUES (144, 7, 6, 0);
INSERT INTO `ass_mark_detail` VALUES (145, 7, 7, 0);
INSERT INTO `ass_mark_detail` VALUES (146, 7, 8, 1);
INSERT INTO `ass_mark_detail` VALUES (147, 7, 9, 0);
INSERT INTO `ass_mark_detail` VALUES (148, 7, 10, 0);
INSERT INTO `ass_mark_detail` VALUES (149, 7, 11, 0);
INSERT INTO `ass_mark_detail` VALUES (150, 7, 12, 0);
INSERT INTO `ass_mark_detail` VALUES (151, 7, 13, 0);
INSERT INTO `ass_mark_detail` VALUES (152, 7, 14, 0);
INSERT INTO `ass_mark_detail` VALUES (153, 7, 15, 1);
INSERT INTO `ass_mark_detail` VALUES (154, 7, 16, 0);
INSERT INTO `ass_mark_detail` VALUES (155, 7, 17, 0);
INSERT INTO `ass_mark_detail` VALUES (156, 7, 18, 0);
INSERT INTO `ass_mark_detail` VALUES (157, 7, 19, 1);
INSERT INTO `ass_mark_detail` VALUES (158, 7, 20, 0);
INSERT INTO `ass_mark_detail` VALUES (159, 7, 21, 0);
INSERT INTO `ass_mark_detail` VALUES (160, 7, 22, 2);
INSERT INTO `ass_mark_detail` VALUES (161, 7, 23, 0);
INSERT INTO `ass_mark_detail` VALUES (162, 8, 1, 10);
INSERT INTO `ass_mark_detail` VALUES (163, 8, 2, 8);
INSERT INTO `ass_mark_detail` VALUES (164, 8, 3, 3);
INSERT INTO `ass_mark_detail` VALUES (165, 8, 4, 0);
INSERT INTO `ass_mark_detail` VALUES (166, 8, 5, 3);
INSERT INTO `ass_mark_detail` VALUES (167, 8, 6, 0);
INSERT INTO `ass_mark_detail` VALUES (168, 8, 7, 2);
INSERT INTO `ass_mark_detail` VALUES (169, 8, 8, 6);
INSERT INTO `ass_mark_detail` VALUES (170, 8, 9, 0);
INSERT INTO `ass_mark_detail` VALUES (171, 8, 10, 5);
INSERT INTO `ass_mark_detail` VALUES (172, 8, 11, 5);
INSERT INTO `ass_mark_detail` VALUES (173, 8, 12, 6);
INSERT INTO `ass_mark_detail` VALUES (174, 8, 13, 0);
INSERT INTO `ass_mark_detail` VALUES (175, 8, 14, 3);
INSERT INTO `ass_mark_detail` VALUES (176, 8, 15, 0);
INSERT INTO `ass_mark_detail` VALUES (177, 8, 16, 0);
INSERT INTO `ass_mark_detail` VALUES (178, 8, 17, 0);
INSERT INTO `ass_mark_detail` VALUES (179, 8, 18, 1);
INSERT INTO `ass_mark_detail` VALUES (180, 8, 19, 2);
INSERT INTO `ass_mark_detail` VALUES (181, 8, 20, 0);
INSERT INTO `ass_mark_detail` VALUES (182, 8, 21, 1);
INSERT INTO `ass_mark_detail` VALUES (183, 8, 22, 1);
INSERT INTO `ass_mark_detail` VALUES (184, 8, 23, 1);
INSERT INTO `ass_mark_detail` VALUES (185, 9, 1, 5);
INSERT INTO `ass_mark_detail` VALUES (186, 9, 2, 3);
INSERT INTO `ass_mark_detail` VALUES (187, 9, 3, 3);
INSERT INTO `ass_mark_detail` VALUES (188, 9, 4, 0);
INSERT INTO `ass_mark_detail` VALUES (189, 9, 5, 3);
INSERT INTO `ass_mark_detail` VALUES (190, 9, 6, 2);
INSERT INTO `ass_mark_detail` VALUES (191, 9, 7, 0);
INSERT INTO `ass_mark_detail` VALUES (192, 9, 8, 2);
INSERT INTO `ass_mark_detail` VALUES (193, 9, 9, 0);
INSERT INTO `ass_mark_detail` VALUES (194, 9, 10, 0);
INSERT INTO `ass_mark_detail` VALUES (195, 9, 11, 0);
INSERT INTO `ass_mark_detail` VALUES (196, 9, 12, 0);
INSERT INTO `ass_mark_detail` VALUES (197, 9, 13, 0);
INSERT INTO `ass_mark_detail` VALUES (198, 9, 14, 2);
INSERT INTO `ass_mark_detail` VALUES (199, 9, 15, 0);
INSERT INTO `ass_mark_detail` VALUES (200, 9, 16, 0);
INSERT INTO `ass_mark_detail` VALUES (201, 9, 17, 0);
INSERT INTO `ass_mark_detail` VALUES (202, 9, 18, 0);
INSERT INTO `ass_mark_detail` VALUES (203, 9, 19, 2);
INSERT INTO `ass_mark_detail` VALUES (204, 9, 20, 0);
INSERT INTO `ass_mark_detail` VALUES (205, 9, 21, 0);
INSERT INTO `ass_mark_detail` VALUES (206, 9, 22, 1);
INSERT INTO `ass_mark_detail` VALUES (207, 9, 23, 2);
INSERT INTO `ass_mark_detail` VALUES (208, 10, 1, 10);
INSERT INTO `ass_mark_detail` VALUES (209, 10, 2, 8);
INSERT INTO `ass_mark_detail` VALUES (210, 10, 3, 1);
INSERT INTO `ass_mark_detail` VALUES (211, 10, 4, 0);
INSERT INTO `ass_mark_detail` VALUES (212, 10, 5, 0);
INSERT INTO `ass_mark_detail` VALUES (213, 10, 6, 0);
INSERT INTO `ass_mark_detail` VALUES (214, 10, 7, 0);
INSERT INTO `ass_mark_detail` VALUES (215, 10, 8, 6);
INSERT INTO `ass_mark_detail` VALUES (216, 10, 9, 0);
INSERT INTO `ass_mark_detail` VALUES (217, 10, 10, 0);
INSERT INTO `ass_mark_detail` VALUES (218, 10, 11, 0);
INSERT INTO `ass_mark_detail` VALUES (219, 10, 12, 0);
INSERT INTO `ass_mark_detail` VALUES (220, 10, 13, 0);
INSERT INTO `ass_mark_detail` VALUES (221, 10, 14, 2);
INSERT INTO `ass_mark_detail` VALUES (222, 10, 15, 0);
INSERT INTO `ass_mark_detail` VALUES (223, 10, 16, 1);
INSERT INTO `ass_mark_detail` VALUES (224, 10, 17, 0);
INSERT INTO `ass_mark_detail` VALUES (225, 10, 18, 1);
INSERT INTO `ass_mark_detail` VALUES (226, 10, 19, 3);
INSERT INTO `ass_mark_detail` VALUES (227, 10, 20, 0);
INSERT INTO `ass_mark_detail` VALUES (228, 10, 21, 1);
INSERT INTO `ass_mark_detail` VALUES (229, 10, 22, 2);
INSERT INTO `ass_mark_detail` VALUES (230, 10, 23, 2);
INSERT INTO `ass_mark_detail` VALUES (231, 11, 1, 10);
INSERT INTO `ass_mark_detail` VALUES (232, 11, 2, 8);
INSERT INTO `ass_mark_detail` VALUES (233, 11, 3, 3);
INSERT INTO `ass_mark_detail` VALUES (234, 11, 4, 0);
INSERT INTO `ass_mark_detail` VALUES (235, 11, 5, 3);
INSERT INTO `ass_mark_detail` VALUES (236, 11, 6, 0);
INSERT INTO `ass_mark_detail` VALUES (237, 11, 7, 4);
INSERT INTO `ass_mark_detail` VALUES (238, 11, 8, 6);
INSERT INTO `ass_mark_detail` VALUES (239, 11, 9, 5);
INSERT INTO `ass_mark_detail` VALUES (240, 11, 10, 5);
INSERT INTO `ass_mark_detail` VALUES (241, 11, 11, 5);
INSERT INTO `ass_mark_detail` VALUES (242, 11, 12, 6);
INSERT INTO `ass_mark_detail` VALUES (243, 11, 13, 6);
INSERT INTO `ass_mark_detail` VALUES (244, 11, 14, 3);
INSERT INTO `ass_mark_detail` VALUES (245, 11, 15, 2);
INSERT INTO `ass_mark_detail` VALUES (246, 11, 16, 0);
INSERT INTO `ass_mark_detail` VALUES (247, 11, 17, 2);
INSERT INTO `ass_mark_detail` VALUES (248, 11, 18, 6);
INSERT INTO `ass_mark_detail` VALUES (249, 11, 19, 2);
INSERT INTO `ass_mark_detail` VALUES (250, 11, 20, 0);
INSERT INTO `ass_mark_detail` VALUES (251, 11, 21, 1);
INSERT INTO `ass_mark_detail` VALUES (252, 11, 22, 2);
INSERT INTO `ass_mark_detail` VALUES (253, 11, 23, 4);
INSERT INTO `ass_mark_detail` VALUES (254, 12, 1, 10);
INSERT INTO `ass_mark_detail` VALUES (255, 12, 2, 8);
INSERT INTO `ass_mark_detail` VALUES (256, 12, 3, 3);
INSERT INTO `ass_mark_detail` VALUES (257, 12, 4, 2);
INSERT INTO `ass_mark_detail` VALUES (258, 12, 5, 3);
INSERT INTO `ass_mark_detail` VALUES (259, 12, 6, 4);
INSERT INTO `ass_mark_detail` VALUES (260, 12, 7, 4);
INSERT INTO `ass_mark_detail` VALUES (261, 12, 8, 6);
INSERT INTO `ass_mark_detail` VALUES (262, 12, 9, 1);
INSERT INTO `ass_mark_detail` VALUES (263, 12, 10, 2);
INSERT INTO `ass_mark_detail` VALUES (264, 12, 11, 5);
INSERT INTO `ass_mark_detail` VALUES (265, 12, 12, 6);
INSERT INTO `ass_mark_detail` VALUES (266, 12, 13, 3);
INSERT INTO `ass_mark_detail` VALUES (267, 12, 14, 5);
INSERT INTO `ass_mark_detail` VALUES (268, 12, 15, 2);
INSERT INTO `ass_mark_detail` VALUES (269, 12, 16, 3);
INSERT INTO `ass_mark_detail` VALUES (270, 12, 17, 2);
INSERT INTO `ass_mark_detail` VALUES (271, 12, 18, 6);
INSERT INTO `ass_mark_detail` VALUES (272, 12, 19, 1);
INSERT INTO `ass_mark_detail` VALUES (273, 12, 20, 0);
INSERT INTO `ass_mark_detail` VALUES (274, 12, 21, 1);
INSERT INTO `ass_mark_detail` VALUES (275, 12, 22, 1);
INSERT INTO `ass_mark_detail` VALUES (276, 12, 23, 0);
INSERT INTO `ass_mark_detail` VALUES (277, 13, 1, 10);
INSERT INTO `ass_mark_detail` VALUES (278, 13, 2, 8);
INSERT INTO `ass_mark_detail` VALUES (279, 13, 3, 2);
INSERT INTO `ass_mark_detail` VALUES (280, 13, 4, 0);
INSERT INTO `ass_mark_detail` VALUES (281, 13, 5, 2);
INSERT INTO `ass_mark_detail` VALUES (282, 13, 6, 0);
INSERT INTO `ass_mark_detail` VALUES (283, 13, 7, 2);
INSERT INTO `ass_mark_detail` VALUES (284, 13, 8, 6);
INSERT INTO `ass_mark_detail` VALUES (285, 13, 9, 0);
INSERT INTO `ass_mark_detail` VALUES (286, 13, 10, 5);
INSERT INTO `ass_mark_detail` VALUES (287, 13, 11, 5);
INSERT INTO `ass_mark_detail` VALUES (288, 13, 12, 6);
INSERT INTO `ass_mark_detail` VALUES (289, 13, 13, 0);
INSERT INTO `ass_mark_detail` VALUES (290, 13, 14, 3);
INSERT INTO `ass_mark_detail` VALUES (291, 13, 15, 2);
INSERT INTO `ass_mark_detail` VALUES (292, 13, 16, 3);
INSERT INTO `ass_mark_detail` VALUES (293, 13, 17, 2);
INSERT INTO `ass_mark_detail` VALUES (294, 13, 18, 0);
INSERT INTO `ass_mark_detail` VALUES (295, 13, 19, 2);
INSERT INTO `ass_mark_detail` VALUES (296, 13, 20, 0);
INSERT INTO `ass_mark_detail` VALUES (297, 13, 21, 1);
INSERT INTO `ass_mark_detail` VALUES (298, 13, 22, 1);
INSERT INTO `ass_mark_detail` VALUES (299, 13, 23, 2);
INSERT INTO `ass_mark_detail` VALUES (300, 14, 1, 1);
INSERT INTO `ass_mark_detail` VALUES (301, 14, 2, 3);
INSERT INTO `ass_mark_detail` VALUES (302, 14, 3, 4);

-- ----------------------------
-- Table structure for ass_submission
-- ----------------------------
DROP TABLE IF EXISTS `ass_submission`;
CREATE TABLE `ass_submission`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `ass_id` int(0) NOT NULL,
  `student_id` int(0) NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_final` int(0) NOT NULL,
  `submit_time` datetime(6) NOT NULL,
  `category_offence` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_student_id_2`(`student_id`) USING BTREE,
  INDEX `FK_ass_id_3`(`ass_id`) USING BTREE,
  CONSTRAINT `FK_ass_id_3` FOREIGN KEY (`ass_id`) REFERENCES `assignment` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_student_id_2` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 68 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ass_submission
-- ----------------------------
INSERT INTO `ass_submission` VALUES (1, 1, 201500001, 'hsgggggg', 1, '2024-02-06 13:43:12.000000', NULL);
INSERT INTO `ass_submission` VALUES (2, 1, 201412345, 'psffff50', 1, '2024-02-06 13:43:12.000000', NULL);
INSERT INTO `ass_submission` VALUES (3, 1, 201698763, 'pseeeee4', 1, '2024-02-06 13:43:12.000000', NULL);
INSERT INTO `ass_submission` VALUES (4, 1, 201523456, 'psdddddd', 1, '2024-02-06 13:43:12.000000', NULL);
INSERT INTO `ass_submission` VALUES (5, 1, 201687654, 'sgcccc30', 1, '2024-02-06 13:43:12.000000', NULL);
INSERT INTO `ass_submission` VALUES (6, 1, 201434567, 'sgbbbbb2', 1, '2024-02-06 13:43:12.000000', NULL);
INSERT INTO `ass_submission` VALUES (7, 1, 201545678, 'sgaaaaaa', 1, '2024-02-06 13:43:12.000000', 'C');
INSERT INTO `ass_submission` VALUES (8, 1, 201676543, 'LATE/sgmmmmm9', 1, '2024-02-07 21:43:12.000000', NULL);
INSERT INTO `ass_submission` VALUES (9, 1, 201365432, 'LATE/sgllll80', 1, '2024-02-08 21:43:12.000000', NULL);
INSERT INTO `ass_submission` VALUES (10, 1, 201478901, 'LATE/sgkkkkkk', 1, '2024-02-09 21:43:12.000000', NULL);
INSERT INTO `ass_submission` VALUES (11, 1, 201677771, 'LATE/psjjjj70', 1, '2024-02-10 16:43:12.000000', NULL);
INSERT INTO `ass_submission` VALUES (12, 1, 201568682, 'LATE/psiiiii6', 1, '2024-02-10 21:43:12.000000', NULL);
INSERT INTO `ass_submission` VALUES (13, 1, 201322334, 'LATE/hshhhhhh', 1, '2024-02-15 21:43:12.000000', NULL);
INSERT INTO `ass_submission` VALUES (14, 1, 201676885, '', 1, '2024-04-10 14:51:08.000000', NULL);
INSERT INTO `ass_submission` VALUES (15, 5, 201523456, 'test', 0, '2024-04-14 15:34:48.000000', NULL);

-- ----------------------------
-- Table structure for assignment
-- ----------------------------
DROP TABLE IF EXISTS `assignment`;
CREATE TABLE `assignment`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `module_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `start_time` datetime(3) NULL DEFAULT NULL,
  `end_time` datetime(3) NULL DEFAULT NULL,
  `penalty` int(0) NULL DEFAULT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_module_code`(`module_code`) USING BTREE,
  CONSTRAINT `FK_module_code` FOREIGN KEY (`module_code`) REFERENCES `module` (`module_code`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of assignment
-- ----------------------------
INSERT INTO `assignment` VALUES (1, 'Assignment_1', 'COMP284', NULL, '2024-02-06 17:00:00.000', 5, 'COMP284-1');
INSERT INTO `assignment` VALUES (2, 'Assignment 2', 'COMP284', '2024-02-22 11:03:53.000', '2024-04-04 11:04:11.000', 5, NULL);
INSERT INTO `assignment` VALUES (3, 'test ongoing', 'COMP284', '2024-04-19 00:50:40.000', '2024-05-24 00:50:42.000', 5, NULL);
INSERT INTO `assignment` VALUES (4, 'test future', 'COMP284', '2024-05-22 00:51:09.000', '2024-06-27 00:51:13.000', 5, NULL);
INSERT INTO `assignment` VALUES (5, 'test', 'COMP284', '2024-05-28 20:57:38.000', '2024-05-31 20:57:41.000', 5, NULL);
INSERT INTO `assignment` VALUES (6, 'non-registered test', 'COMP333', '2024-02-01 00:47:25.000', '2024-05-10 00:47:27.000', 5, NULL);
INSERT INTO `assignment` VALUES (7, 'test', 'COMP390', '2024-04-16 12:53:20.000', '2024-05-10 12:53:28.000', 5, NULL);

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `generate_lower_bound` int(0) NOT NULL,
  `generate_upper_bound` int(0) NOT NULL,
  `criterion_id` int(0) NOT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_criterion_id`(`criterion_id`) USING BTREE,
  CONSTRAINT `FK_criterion_id` FOREIGN KEY (`criterion_id`) REFERENCES `criterion` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (2, 3, 3, 1, 'works but wrong name and world readable');
INSERT INTO `comment` VALUES (3, 4, 4, 1, 'wrong name and correct rights');
INSERT INTO `comment` VALUES (4, 5, 5, 1, 'correct name but world readable');
INSERT INTO `comment` VALUES (5, 0, 2, 2, 'Web page');
INSERT INTO `comment` VALUES (6, 2, 8, 2, 'Lack of CGI.pm or plain HTML');
INSERT INTO `comment` VALUES (7, 2, 2, 3, 'error message when check non-empty query');
INSERT INTO `comment` VALUES (8, 3, 3, 3, 'Correctly checks for non-empty query');
INSERT INTO `comment` VALUES (9, 0, 0, 3, 'error message');
INSERT INTO `comment` VALUES (10, 3, 3, 4, 'A measure against code injection via the query is taken');
INSERT INTO `comment` VALUES (11, 2, 2, 5, 'Correctly checks for non-empty number. But without error message when checkk fails');
INSERT INTO `comment` VALUES (20, 0, 2, 1, 'Code doesn\'t work');
INSERT INTO `comment` VALUES (23, 6, 10, 1, 'congratulation!!');
INSERT INTO `comment` VALUES (39, 0, 10, 25, '1');
INSERT INTO `comment` VALUES (40, 11, 20, 25, '2');
INSERT INTO `comment` VALUES (41, 0, 10, 24, '1');
INSERT INTO `comment` VALUES (42, 11, 20, 24, '2');

-- ----------------------------
-- Table structure for criterion
-- ----------------------------
DROP TABLE IF EXISTS `criterion`;
CREATE TABLE `criterion`  (
  `id` int(0) NOT NULL,
  `rubric_id` int(0) NOT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `value` int(0) NULL DEFAULT NULL,
  `criterion_index` int(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_rubric_id`(`rubric_id`) USING BTREE,
  CONSTRAINT `FK_rubric_id` FOREIGN KEY (`rubric_id`) REFERENCES `rubric` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of criterion
-- ----------------------------
INSERT INTO `criterion` VALUES (1, 1, 'Perl Script accessible and executable [Access rights should not be too liberal (doesn\'t work < 3, works but wrong name and world readable = 3 marks, wrong name and correct rights = 4 marks, correct name but world readable = 5 marks)]    																		', 10, 1);
INSERT INTO `criterion` VALUES (2, 2, 'Web page (2 marks) with two text fields and a submit button (3 x 2 marks if CGI.pm is used, 3 x 1 mark if plain HTML is used) 																				\r\n', 8, 2);
INSERT INTO `criterion` VALUES (3, 2, 'Correctly checks for non-empty query (2 marks) plus error message if check fails (1 mark)																				\r\n', 3, 3);
INSERT INTO `criterion` VALUES (4, 2, 'A measure against code injection via the query is taken (a check, application of escapeHTML to query, or similar)', 3, 4);
INSERT INTO `criterion` VALUES (5, 2, 'Correctly checks for non-empty number (2 marks) plus error messages if check fails (1 mark)																				\r\n', 3, 5);
INSERT INTO `criterion` VALUES (6, 2, 'Correctly checks for natural number greater or equal to 0 (3 marks) plus  error messages if check fails (1 mark) [check might be combined with the previous one]																				\r\n', 4, 6);
INSERT INTO `criterion` VALUES (7, 2, 'Incorrect inputs are not processed (2 marks) and no error messages are shown if no inputs have been entered yet (2 marks)																				\r\n', 4, 7);
INSERT INTO `criterion` VALUES (8, 3, 'Correctly retrieves data from DBLP including correct construction of the URL for the retrieval', 6, 8);
INSERT INTO `criterion` VALUES (9, 3, 'Correctly counts total number of publications																				\r\n', 5, 9);
INSERT INTO `criterion` VALUES (10, 3, 'Correctly identifies each author by extracting all authors using a regular expression or by using an XML parser', 5, 10);
INSERT INTO `criterion` VALUES (11, 3, 'Correctly counts publications for each author', 5, 11);
INSERT INTO `criterion` VALUES (12, 3, 'Appropriate data structures are used e.g. Associative array aka hash (and no additional unnecessary data structures)																				\r\n', 6, 12);
INSERT INTO `criterion` VALUES (13, 3, 'Authors are sorted correctly by number of publications (if sorted twice only 4 marks), subtract 1 mark if identical lists are not reversed																				\r\n', 6, 13);
INSERT INTO `criterion` VALUES (14, 4, 'There is a results page (3 marks), header includes utf8 (1 marks) and “binmode utf-8” is used for STDOUT (1 marks) => names of authors appear correctly', 5, 14);
INSERT INTO `criterion` VALUES (15, 4, 'Results page contains original query', 2, 15);
INSERT INTO `criterion` VALUES (16, 4, 'Results page contains the XML data retrieved (1 mark), optimally, tags are visible (2 marks) and white space / linebreaks are preserved (2 marks)																				\r\n', 5, 16);
INSERT INTO `criterion` VALUES (17, 4, 'Results page contains the total number of publications																				\r\n', 2, 17);
INSERT INTO `criterion` VALUES (18, 4, 'Results page contains two tables with author statistics (2 x 3 marks if CGI.pm is used, 2 x 2 mark if plain HTML is used)																				\r\n', 6, 18);
INSERT INTO `criterion` VALUES (19, 5, 'comments  (3 = at least 66% of statements have a comment, 2 = at least 33% ... 1 = between 1% and 33% ..., 0 = no comments)              																				\r\n', 3, 19);
INSERT INTO `criterion` VALUES (20, 5, 'references  (number of references / URLs in the code, up to 2)', 2, 20);
INSERT INTO `criterion` VALUES (21, 5, 'line breaks  (0 = more than one statement on a line somewhere, 1 = all statements are on separate lines)', 1, 21);
INSERT INTO `criterion` VALUES (22, 5, 'Indentation (0 = every statement starts in column 1; 1 = inconsistent indentation; 2 = everything is consistently indented)																				\r\n', 2, 22);
INSERT INTO `criterion` VALUES (23, 5, 'quality of code (1 mark if only one page/script is used + 1 mark for `styling’ the web page + 1 mark for defining and using subroutines + 1 more marks for `special’ effort)																				\r\n', 4, 23);
INSERT INTO `criterion` VALUES (24, 6, 'test criterion1', 25, 1);
INSERT INTO `criterion` VALUES (25, 6, 'test criterion2', 25, 2);
INSERT INTO `criterion` VALUES (26, 6, 'test criterion3', 25, 3);
INSERT INTO `criterion` VALUES (27, 6, 'test criterion4', 25, 4);

-- ----------------------------
-- Table structure for module
-- ----------------------------
DROP TABLE IF EXISTS `module`;
CREATE TABLE `module`  (
  `module_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `module_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `year_start` int(0) NOT NULL,
  `year_end` int(0) NOT NULL,
  PRIMARY KEY (`module_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of module
-- ----------------------------
INSERT INTO `module` VALUES ('COMP101', 'Linear algebra', 2021, 2022);
INSERT INTO `module` VALUES ('COMP111', 'Introduction to Computer Science', 2021, 2022);
INSERT INTO `module` VALUES ('COMP212', 'Software Engineering', 2022, 2023);
INSERT INTO `module` VALUES ('COMP220', 'Artificial Intelligence', 2022, 2023);
INSERT INTO `module` VALUES ('COMP284', 'Web Development', 2022, 2023);
INSERT INTO `module` VALUES ('COMP315', 'Cloud Computing', 2023, 2024);
INSERT INTO `module` VALUES ('COMP319', 'Software EngineeringⅡ', 2023, 2024);
INSERT INTO `module` VALUES ('COMP333', 'Test', 2023, 2024);
INSERT INTO `module` VALUES ('COMP390', 'Final Year Project', 2023, 2024);

-- ----------------------------
-- Table structure for module_student
-- ----------------------------
DROP TABLE IF EXISTS `module_student`;
CREATE TABLE `module_student`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `module_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `student_id` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_student_id`(`student_id`) USING BTREE,
  INDEX `FK_module_code_3`(`module_code`) USING BTREE,
  CONSTRAINT `FK_module_code_3` FOREIGN KEY (`module_code`) REFERENCES `module` (`module_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_student_id` FOREIGN KEY (`student_id`) REFERENCES `student` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of module_student
-- ----------------------------
INSERT INTO `module_student` VALUES (1, 'COMP284', 201322334);
INSERT INTO `module_student` VALUES (2, 'COMP284', 201365432);
INSERT INTO `module_student` VALUES (3, 'COMP284', 201412345);
INSERT INTO `module_student` VALUES (4, 'COMP284', 201434567);
INSERT INTO `module_student` VALUES (5, 'COMP284', 201478901);
INSERT INTO `module_student` VALUES (6, 'COMP284', 201500001);
INSERT INTO `module_student` VALUES (7, 'COMP284', 201523456);
INSERT INTO `module_student` VALUES (8, 'COMP284', 201545678);
INSERT INTO `module_student` VALUES (9, 'COMP284', 201568682);
INSERT INTO `module_student` VALUES (10, 'COMP284', 201676543);
INSERT INTO `module_student` VALUES (11, 'COMP284', 201677771);
INSERT INTO `module_student` VALUES (12, 'COMP284', 201687654);
INSERT INTO `module_student` VALUES (13, 'COMP284', 201698763);
INSERT INTO `module_student` VALUES (14, 'COMP315', 201698763);
INSERT INTO `module_student` VALUES (16, 'COMP390', 201676885);
INSERT INTO `module_student` VALUES (17, 'COMP284', 201676885);

-- ----------------------------
-- Table structure for module_teacher
-- ----------------------------
DROP TABLE IF EXISTS `module_teacher`;
CREATE TABLE `module_teacher`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `module_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `teacher_id` int(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_teacher_id_2`(`teacher_id`) USING BTREE,
  INDEX `FK_module_code_2`(`module_code`) USING BTREE,
  CONSTRAINT `FK_module_code_2` FOREIGN KEY (`module_code`) REFERENCES `module` (`module_code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_teacher_id_2` FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of module_teacher
-- ----------------------------
INSERT INTO `module_teacher` VALUES (2, 'COMP284', 201676887);
INSERT INTO `module_teacher` VALUES (3, 'COMP315', 201676886);
INSERT INTO `module_teacher` VALUES (4, 'COMP284', 201676886);
INSERT INTO `module_teacher` VALUES (8, 'COMP101', 201676886);
INSERT INTO `module_teacher` VALUES (9, 'COMP111', 201676886);
INSERT INTO `module_teacher` VALUES (10, 'COMP319', 201676886);
INSERT INTO `module_teacher` VALUES (11, 'COMP212', 201676886);
INSERT INTO `module_teacher` VALUES (12, 'COMP315', 201676886);
INSERT INTO `module_teacher` VALUES (13, 'COMP220', 201676886);
INSERT INTO `module_teacher` VALUES (14, 'COMP333', 201676887);
INSERT INTO `module_teacher` VALUES (15, 'COMP284', 201612345);
INSERT INTO `module_teacher` VALUES (16, 'COMP333', 201612345);

-- ----------------------------
-- Table structure for program
-- ----------------------------
DROP TABLE IF EXISTS `program`;
CREATE TABLE `program`  (
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of program
-- ----------------------------
INSERT INTO `program` VALUES ('');
INSERT INTO `program` VALUES ('G401');
INSERT INTO `program` VALUES ('G403');
INSERT INTO `program` VALUES ('G40A');
INSERT INTO `program` VALUES ('G61Z');
INSERT INTO `program` VALUES ('GN34');
INSERT INTO `program` VALUES ('GZ10');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`role`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('Student');
INSERT INTO `role` VALUES ('Teacher');

-- ----------------------------
-- Table structure for rubric
-- ----------------------------
DROP TABLE IF EXISTS `rubric`;
CREATE TABLE `rubric`  (
  `id` int(0) NOT NULL,
  `ass_id` int(0) NOT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_ass_id`(`ass_id`) USING BTREE,
  CONSTRAINT `FK_ass_id` FOREIGN KEY (`ass_id`) REFERENCES `assignment` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of rubric
-- ----------------------------
INSERT INTO `rubric` VALUES (1, 1, 'System accessible and executable\r\n');
INSERT INTO `rubric` VALUES (2, 1, 'Input handling\r\n');
INSERT INTO `rubric` VALUES (3, 1, 'Retrieving data and computing statistics\r\n\r\n');
INSERT INTO `rubric` VALUES (4, 1, 'Creating web page with results\r\n');
INSERT INTO `rubric` VALUES (5, 1, 'Formatting, commenting and quality of code\r\n\r\n');
INSERT INTO `rubric` VALUES (6, 5, 'test rubric');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `id` int(0) NOT NULL,
  `name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `year` int(0) NULL DEFAULT NULL,
  `program_code` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_program_code`(`program_code`) USING BTREE,
  CONSTRAINT `FK_program_code` FOREIGN KEY (`program_code`) REFERENCES `program` (`code`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_user_id` FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES (201322334, 's13', 2, 'G403');
INSERT INTO `student` VALUES (201365432, 's9', 2, 'G61Z');
INSERT INTO `student` VALUES (201412345, 's2', 2, 'G61Z');
INSERT INTO `student` VALUES (201434567, 's6', 2, 'GN34');
INSERT INTO `student` VALUES (201478901, 's10', 2, 'G40A');
INSERT INTO `student` VALUES (201500001, 's1', 2, 'G403');
INSERT INTO `student` VALUES (201523456, 's4', 2, 'GZ10');
INSERT INTO `student` VALUES (201545678, 's7', 2, 'G401');
INSERT INTO `student` VALUES (201568682, 's12', 2, 'G40A');
INSERT INTO `student` VALUES (201676543, 's8', 2, 'G40A');
INSERT INTO `student` VALUES (201676885, 'test', 2, 'G401');
INSERT INTO `student` VALUES (201677771, 's11', 2, 'G61Z');
INSERT INTO `student` VALUES (201687654, 's5', 2, 'G40A');
INSERT INTO `student` VALUES (201698763, 's3', 2, 'G40A');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher`  (
  `id` int(0) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  CONSTRAINT `FK_teacher_id` FOREIGN KEY (`id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES (201612345, 'test teacher');
INSERT INTO `teacher` VALUES (201676886, 'qky');
INSERT INTO `teacher` VALUES (201676887, 't1');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(0) NOT NULL,
  `password` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_enabled` bit(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_role`(`role`) USING BTREE,
  CONSTRAINT `FK_role` FOREIGN KEY (`role`) REFERENCES `role` (`role`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (201322334, 'hshhhhhh', 'Student', NULL);
INSERT INTO `user` VALUES (201365432, 'sgllll80', 'Student', NULL);
INSERT INTO `user` VALUES (201412345, 'psffff50', 'Student', NULL);
INSERT INTO `user` VALUES (201434567, 'sgbbbbb2', 'Student', NULL);
INSERT INTO `user` VALUES (201478901, 'sgkkkkkk', 'Student', NULL);
INSERT INTO `user` VALUES (201500001, 'hsgggggg', 'Student', NULL);
INSERT INTO `user` VALUES (201523456, 'psdddddd', 'Student', NULL);
INSERT INTO `user` VALUES (201545678, 'sgaaaaaa', 'Student', NULL);
INSERT INTO `user` VALUES (201568682, 'psiiiii6', 'Student', NULL);
INSERT INTO `user` VALUES (201612345, '123', 'Teacher', NULL);
INSERT INTO `user` VALUES (201676543, 'sgmmmmm9', 'Student', NULL);
INSERT INTO `user` VALUES (201676885, '123', 'Student', NULL);
INSERT INTO `user` VALUES (201676886, '123', 'Teacher', NULL);
INSERT INTO `user` VALUES (201676887, '123', 'Teacher', NULL);
INSERT INTO `user` VALUES (201677771, 'psjjjj70', 'Student', NULL);
INSERT INTO `user` VALUES (201687654, 'sgcccc30', 'Student', NULL);
INSERT INTO `user` VALUES (201698763, 'pseeeee4', 'Student', NULL);

SET FOREIGN_KEY_CHECKS = 1;
