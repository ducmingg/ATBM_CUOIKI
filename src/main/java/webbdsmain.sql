/*
 Navicat Premium Dump SQL

 Source Server         : webbds
 Source Server Type    : MySQL
 Source Server Version : 80004 (8.0.4-rc-log)
 Source Host           : localhost:3306
 Source Schema         : webbds

 Target Server Type    : MySQL
 Target Server Version : 80004 (8.0.4-rc-log)
 File Encoding         : 65001

 Date: 03/12/2024 23:39:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `cart_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`cart_id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES (9, 1);
INSERT INTO `cart` VALUES (1, 2);
INSERT INTO `cart` VALUES (14, 5);
INSERT INTO `cart` VALUES (22, 6);
INSERT INTO `cart` VALUES (12, 12);
INSERT INTO `cart` VALUES (20, 24);
INSERT INTO `cart` VALUES (7, 25);
INSERT INTO `cart` VALUES (10, 26);
INSERT INTO `cart` VALUES (11, 27);
INSERT INTO `cart` VALUES (17, 31);

-- ----------------------------
-- Table structure for cartitems
-- ----------------------------
DROP TABLE IF EXISTS `cartitems`;
CREATE TABLE `cartitems`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cart_id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `area` decimal(10, 2) NOT NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `quantity` int(11) NULL DEFAULT 1,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cart_id`(`cart_id` ASC) USING BTREE,
  INDEX `property_id`(`property_id` ASC) USING BTREE,
  CONSTRAINT `cartitems_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `cartitems_ibfk_2` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 125 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cartitems
-- ----------------------------
INSERT INTO `cartitems` VALUES (121, 22, 2, 'Tòa Nhà Green Living', 20.00, 75.00, 'https://th.bing.com/th/id/R.34c8f70790800b575da91a903a59a330?rik=cIaknJyiuEHEfA&pid=ImgRaw&r=0', 1, '234 Lê Văn Sỹ, Bình Tân, TP HCM');

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `comment_id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `comment_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `property_id`(`property_id` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (11, 5, 5, 'wqewqewqeqwe', '2024-11-09 19:48:47');
INSERT INTO `comments` VALUES (12, 5, 5, '123123', '2024-11-09 19:52:43');
INSERT INTO `comments` VALUES (14, 1, 5, '123123', '2024-11-09 20:39:00');
INSERT INTO `comments` VALUES (16, 1, 6, 'dep', '2024-11-09 20:49:23');
INSERT INTO `comments` VALUES (17, 1, 6, 'qua dep qua hay', '2024-11-09 20:49:28');
INSERT INTO `comments` VALUES (18, 1, 6, 'nai so`', '2024-11-09 20:49:33');
INSERT INTO `comments` VALUES (19, 2, 6, 'dep qa\r\n', '2024-11-09 20:50:34');
INSERT INTO `comments` VALUES (20, 2, 6, 'qa dep', '2024-11-09 20:50:41');
INSERT INTO `comments` VALUES (21, 1, 2, 'hehehe dep qa qa dep hihi', '2024-11-12 22:08:29');
INSERT INTO `comments` VALUES (22, 7, 6, 'dep du ta   ', '2024-11-26 20:19:22');

-- ----------------------------
-- Table structure for orderitems
-- ----------------------------
DROP TABLE IF EXISTS `orderitems`;
CREATE TABLE `orderitems`  (
  `order_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NULL DEFAULT NULL,
  `property_id` int(11) NULL DEFAULT NULL,
  `quantity` int(11) NULL DEFAULT 1,
  `price` double NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`order_item_id`) USING BTREE,
  INDEX `order_id`(`order_id` ASC) USING BTREE,
  INDEX `property_id`(`property_id` ASC) USING BTREE,
  CONSTRAINT `orderitems_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `orderitems_ibfk_2` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orderitems
-- ----------------------------
INSERT INTO `orderitems` VALUES (29, 34, 1, 1, 100, 'Tòa Nhà Sky Tower');
INSERT INTO `orderitems` VALUES (30, 34, 2, 1, 20, 'Tòa Nhà Green Living');
INSERT INTO `orderitems` VALUES (31, 35, 1, 1, 100, 'Tòa Nhà Sky Tower');
INSERT INTO `orderitems` VALUES (32, 35, 2, 1, 20, 'Tòa Nhà Green Living');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `order_date` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (34, 6, '2024-12-02 21:45:55');
INSERT INTO `orders` VALUES (35, 6, '2024-12-02 22:11:04');

-- ----------------------------
-- Table structure for posters
-- ----------------------------
DROP TABLE IF EXISTS `posters`;
CREATE TABLE `posters`  (
  `poster_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`poster_id`) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE,
  INDEX `fk_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of posters
-- ----------------------------
INSERT INTO `posters` VALUES (1, 'Nguyễn Văn A', 'nguyenvana@example.com', '0123456789', '2024-11-05 22:43:50', '2024-12-03 20:16:57', 'https://media.yeah1.com/files/ngoctran/2022/07/01/289693821_582015943280803_2102006602626651935_n-205941.jpg', 1);
INSERT INTO `posters` VALUES (2, 'Trần Thị B', 'tranthib@example.com', '0987654321', '2024-11-05 22:43:50', '2024-12-03 20:16:59', 'https://th.bing.com/th/id/OIP.wq2tdv0O83VJsCilZpsQIQHaHa?https://images.genius.com/0bfbff035ddb4ae1ad83ddd2f835c3f9.1000x1000x1.jpg', 2);
INSERT INTO `posters` VALUES (3, 'Lê Hoàng C', 'lehoangc@example.com', '0912345678', '2024-11-05 22:43:50', '2024-12-03 20:17:00', 'https://th.bing.com/th/id/OIP.jKHBRVWDytTl9XLqRRQ7kAAAAA?rs=1&pid=ImgDetMain', 3);
INSERT INTO `posters` VALUES (7, 'Nguyễn Văn D', 'nguyenvand@example.com', '123456780', '2024-11-06 22:27:32', '2024-12-03 20:17:02', 'https://th.bing.com/th/id/R.497a35676bc7987716d1b52c2845792e?rik=Otbhf5DIl5aIxA&pid=ImgRaw&r=0', 4);
INSERT INTO `posters` VALUES (8, 'Lê Thị E', 'lethie@example.com', '987654320', '2024-11-06 22:27:32', '2024-12-03 20:17:03', 'https://th.bing.com/th/id/OIP.B1KrBTmxkdhOM9Omwjvj7AHaHa?rs=1&pid=ImgDetMain', 5);
INSERT INTO `posters` VALUES (9, 'Trần Văn F', 'tranvanf@example.com', '456789124', '2024-11-06 22:27:32', '2024-12-03 20:17:05', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 6);
INSERT INTO `posters` VALUES (10, 'Nguyễn Thị G', 'nguyenthig@example.com', '321654987', '2024-11-06 22:27:32', '2024-12-03 20:17:10', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 8);
INSERT INTO `posters` VALUES (11, 'Lê Văn H', 'levanh@example.com', '654321789', '2024-11-06 22:27:32', '2024-12-03 20:17:12', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 9);
INSERT INTO `posters` VALUES (12, 'Trần Thị I', 'tranthi@example.com', '789456123', '2024-11-06 22:27:32', '2024-12-03 20:17:13', 'https://media.yeah1.com/files/ngoctran/2022/07/01/289693821_582015943280803_2102006602626651935_n-205941.jpg', 10);
INSERT INTO `posters` VALUES (13, 'Nguyễn Văn J', 'nguyenvanj@example.com', '159753486', '2024-11-06 22:27:32', '2024-12-03 20:17:15', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 11);
INSERT INTO `posters` VALUES (14, 'Lê Thị K', 'lethik@example.com', '753159864', '2024-11-06 22:27:32', '2024-12-03 20:17:17', 'https://media.yeah1.com/files/ngoctran/2022/07/01/289693821_582015943280803_2102006602626651935_n-205941.jpg', 12);
INSERT INTO `posters` VALUES (15, 'Trần Văn L', 'tranvanl@example.com', '258963147', '2024-11-06 22:27:32', '2024-12-03 20:17:18', 'https://th.bing.com/th/id/R.497a35676bc7987716d1b52c2845792e?rik=Otbhf5DIl5aIxA&pid=ImgRaw&r=0', 13);
INSERT INTO `posters` VALUES (16, 'Nguyễn Thị M', 'nguyenthim@example.com', '654789123', '2024-11-06 22:27:32', '2024-12-03 20:17:20', 'https://images.genius.com/0bfbff035ddb4ae1ad83ddd2f835c3f9.1000x1000x1.jpg', 14);
INSERT INTO `posters` VALUES (17, 'Nguyễn Văn N', 'nguyenvann_1@example.com', '789123456', '2024-11-06 22:57:03', '2024-12-03 20:17:21', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 15);
INSERT INTO `posters` VALUES (18, 'Trần Thị O', 'tranthio_1@example.com', '456789123', '2024-11-06 22:57:03', '2024-12-03 20:17:23', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 16);
INSERT INTO `posters` VALUES (19, 'Lê Hoàng P', 'lehoangp_1@example.com', '321654987', '2024-11-06 22:57:03', '2024-12-03 20:17:25', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 17);
INSERT INTO `posters` VALUES (20, 'Nguyễn Thị Q', 'nguyenthiq_1@example.com', '654321789', '2024-11-06 22:57:03', '2024-12-03 20:17:52', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 23);
INSERT INTO `posters` VALUES (21, 'Lê Văn R', 'levanr_1@example.com', '987654321', '2024-11-06 22:57:03', '2024-12-03 20:17:54', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 24);
INSERT INTO `posters` VALUES (22, 'Trần Văn S', 'tranvans_1@example.com', '159753486', '2024-11-06 22:57:03', '2024-12-03 20:17:57', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 25);
INSERT INTO `posters` VALUES (23, 'Nguyễn Văn T', 'nguyenvant_1@example.com', '753159864', '2024-11-06 22:57:03', '2024-12-03 20:17:59', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 26);
INSERT INTO `posters` VALUES (24, 'Lê Thị U', 'lethiu_1@example.com', '258963147', '2024-11-06 22:57:03', '2024-12-03 20:18:03', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 27);
INSERT INTO `posters` VALUES (25, 'Trần Thị V', 'tranthiv_1@example.com', '369258147', '2024-11-06 22:57:03', '2024-12-03 20:18:26', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', 31);
INSERT INTO `posters` VALUES (26, 'Nguyễn Văn W', 'nguyenvanw_1@example.com', '951753486', '2024-11-06 22:57:03', '2024-11-06 23:05:27', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (27, 'Lê Thị X', 'lethix_1@example.com', '147258369', '2024-11-06 22:57:03', '2024-11-06 23:05:28', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (28, 'Trần Văn Y', 'tranvany_1@example.com', '753951486', '2024-11-06 22:57:03', '2024-11-06 23:05:28', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (29, 'Nguyễn Thị Z', 'nguyenthi_1@example.com', '258147369', '2024-11-06 22:57:03', '2024-11-06 23:05:33', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (30, 'Lê Hoàng AA', 'lehoangaa_1@example.com', '654987321', '2024-11-06 22:57:03', '2024-11-06 23:05:34', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (31, 'Nguyễn Văn AB', 'nguyenvanab_1@example.com', '369852147', '2024-11-06 22:57:03', '2024-11-06 23:05:34', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (32, 'Trần Thị AC', 'tranthiac_1@example.com', '852963741', '2024-11-06 22:57:03', '2024-11-06 23:05:35', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (33, 'Lê Văn AD', 'levanad_1@example.com', '741852963', '2024-11-06 22:57:03', '2024-11-06 23:05:35', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (34, 'Nguyễn Văn AE', 'nguyenvanae_1@example.com', '963258147', '2024-11-06 22:57:03', '2024-11-06 23:05:36', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (35, 'Trần Thị AF', 'tranthiaf_1@example.com', '159258753', '2024-11-06 22:57:03', '2024-11-06 23:05:37', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (36, 'Lê Văn AG', 'levanag_1@example.com', '753486159', '2024-11-06 22:57:03', '2024-11-06 23:05:37', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (37, 'Nguyễn Thị AH', 'nguyenthiah_1@example.com', '258963147', '2024-11-06 22:57:03', '2024-11-06 23:05:38', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (38, 'Lê Hoàng AI', 'lehoangai_1@example.com', '369147258', '2024-11-06 22:57:03', '2024-11-06 23:05:39', 'images/hoang_ai.jpghttps://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpghttps://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (39, 'Trần Văn AJ', 'tranvanaj_1@example.com', '987654321', '2024-11-06 22:57:03', '2024-11-06 23:05:44', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (40, 'Nguyễn Thị AK', 'nguyenthiak_1@example.com', '741258963', '2024-11-06 22:57:03', '2024-11-06 23:05:46', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (41, 'Lê Văn AL', 'levanal_1@example.com', '852147963', '2024-11-06 22:57:03', '2024-11-06 23:05:46', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (42, 'Trần Thị AM', 'tranthiam_1@example.com', '963741852', '2024-11-06 22:57:03', '2024-11-06 23:05:47', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (43, 'Nguyễn Văn AN', 'nguyenvanan_1@example.com', '147258963', '2024-11-06 22:57:03', '2024-11-06 23:05:47', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (44, 'Lê Thị AO', 'lethiao_1@example.com', '321654987', '2024-11-06 22:57:03', '2024-11-06 23:05:48', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (45, 'Trần Văn AP', 'tranvanp_1@example.com', '654987321', '2024-11-06 22:57:03', '2024-11-06 23:05:49', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (46, 'Nguyễn Thị AQ', 'nguyenthaq_1@example.com', '789123456', '2024-11-06 22:57:03', '2024-11-06 23:05:50', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (47, 'Lê Văn AR', 'levanar_1@example.com', '321456987', '2024-11-06 22:57:03', '2024-11-06 23:05:50', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (48, 'Trần Thị AS', 'tranthis_1@example.com', '159753852', '2024-11-06 22:57:03', '2024-11-06 23:03:42', 'https://images.genius.com/0bfbff035ddb4ae1ad83ddd2f835c3f9.1000x1000x1.jpg', NULL);
INSERT INTO `posters` VALUES (49, 'Nguyễn Văn AT', 'nguyenvanat_1@example.com', '753159246', '2024-11-06 22:57:03', '2024-11-06 23:05:54', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (50, 'Nguyễn Văn N', 'nguyenvann@example.com', '789123456', '2024-11-06 22:49:33', '2024-11-06 23:16:22', 'https://images.genius.com/0bfbff035ddb4ae1ad83ddd2f835c3f9.1000x1000x1.jpg', NULL);
INSERT INTO `posters` VALUES (51, 'Trần Thị O', 'tranthio@example.com', '456789123', '2024-11-06 22:49:33', '2024-11-06 23:16:29', 'https://images.genius.com/0bfbff035ddb4ae1ad83ddd2f835c3f9.1000x1000x1.jpg', NULL);
INSERT INTO `posters` VALUES (52, 'Lê Hoàng P', 'lehoangp@example.com', '321654987', '2024-11-06 22:49:33', '2024-11-06 23:16:30', 'rik=Otbhf5DIl5aIxA&pid=ImgRaw&r=0', NULL);
INSERT INTO `posters` VALUES (53, 'Nguyễn Thị Q', 'nguyenthiq@example.com', '654321789', '2024-11-06 22:49:33', '2024-11-06 23:16:31', 'https://i.pinimg.com/736x/2f/f4/6e/2ff46e171122fe62bb3d296784b741ec.jpg', NULL);
INSERT INTO `posters` VALUES (54, 'Lê Văn R', 'levanr@example.com', '987654321', '2024-11-06 22:49:33', '2024-11-06 23:16:32', 'https://media.yeah1.com/files/ngoctran/2022/07/01/289693821_582015943280803_2102006602626651935_n-205941.jpg', NULL);
INSERT INTO `posters` VALUES (55, 'Trần Văn S', 'tranvans@example.com', '159753486', '2024-11-06 22:49:33', '2024-11-06 23:16:34', 'https://images.genius.com/0bfbff035ddb4ae1ad83ddd2f835c3f9.1000x1000x1.jpg', NULL);
INSERT INTO `posters` VALUES (56, 'Nguyễn Văn T', 'nguyenvant@example.com', '753159864', '2024-11-06 22:49:33', '2024-11-06 23:16:36', 'https://images.genius.com/0bfbff035ddb4ae1ad83ddd2f835c3f9.1000x1000x1.jpg', NULL);
INSERT INTO `posters` VALUES (57, 'Lê Thị U', 'lethiu@example.com', '258963147', '2024-11-06 22:49:33', '2024-11-06 23:16:38', 'https://images.genius.com/0bfbff035ddb4ae1ad83ddd2f835c3f9.1000x1000x1.jpg', NULL);
INSERT INTO `posters` VALUES (58, 'Trần Thị V', 'tranthiv@example.com', '369258147', '2024-11-06 22:49:33', '2024-11-06 23:16:39', 'https://images.genius.com/0bfbff035ddb4ae1ad83ddd2f835c3f9.1000x1000x1.jpg', NULL);
INSERT INTO `posters` VALUES (59, 'Nguyễn Văn W', 'nguyenvanw@example.com', '951753486', '2024-11-06 22:49:33', '2024-11-06 23:16:40', 'https://images.genius.com/0bfbff035ddb4ae1ad83ddd2f835c3f9.1000x1000x1.jpg', NULL);

-- ----------------------------
-- Table structure for properties
-- ----------------------------
DROP TABLE IF EXISTS `properties`;
CREATE TABLE `properties`  (
  `property_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `price` decimal(15, 2) NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `area` decimal(15, 2) NULL DEFAULT NULL,
  `poster_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`property_id`) USING BTREE,
  INDEX `fk_poster`(`poster_id` ASC) USING BTREE,
  CONSTRAINT `fk_poster` FOREIGN KEY (`poster_id`) REFERENCES `posters` (`poster_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 154 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of properties
-- ----------------------------
INSERT INTO `properties` VALUES (1, 'Tòa Nhà Sky Tower', 'Tòa nhà chọc trời hiện đại với thiết kế kiến trúc độc đáo, Sky Tower nổi bật giữa trung tâm thành phố. Với 30 tầng, tòa nhà cung cấp không gian làm việc và sinh hoạt tiện nghi, cùng với tầm nhìn tuyệt đẹp ra toàn cảnh thành phố.', 100.00, '234 Lê Văn Sỹ, Bình Tân, TP HCM', 'Nhà ở', '1', '2024-11-06 23:22:23', '2024-12-03 23:14:23', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733242462/y3wryorh9f9iyqribcgp.jpg', 50.00, 1);
INSERT INTO `properties` VALUES (2, 'Tòa Nhà Green Living', 'Tòa nhà được thiết kế theo tiêu chí xanh, tích hợp nhiều công nghệ tiết kiệm năng lượng và thân thiện với môi trường. Green Living cung cấp các căn hộ hiện đại với sân vườn và không gian xanh, mang lại cảm giác gần gũi với thiên nhiên', 20.00, '234 Lê Văn Sỹ, Bình Tân, TP HCM', 'Căn hộ', '2', '2024-11-06 23:22:23', '2024-11-08 21:16:10', 'https://th.bing.com/th/id/R.34c8f70790800b575da91a903a59a330?rik=cIaknJyiuEHEfA&pid=ImgRaw&r=0', 75.00, 2);
INSERT INTO `properties` VALUES (3, 'Tòa Nhà Luxury Residence', 'Luxury Residence là tòa nhà cao cấp với các căn hộ sang trọng và tiện nghi đẳng cấp 5 sao. Tòa nhà có hồ bơi vô cực, phòng tập gym hiện đại, và dịch vụ quản lý chuyên nghiệp, phục vụ nhu cầu sống đẳng cấp của cư dân.', 30.00, '101 Hoàng Thị Loan, Quảng Trị', 'Biệt thự', '1', '2024-11-06 23:22:23', '2024-11-08 21:16:24', 'https://th.bing.com/th/id/OIP.cpkTLIbDFzRuNgrl6vMTowHaEW?pid=ImgDet&w=474&h=278&rs=1', 100.00, 3);
INSERT INTO `properties` VALUES (4, 'Tòa Nhà Business Center', 'Tòa Nhà Business Center là trung tâm thương mại và văn phòng hiện đại, cung cấp các văn phòng cho thuê linh hoạt và các dịch vụ hỗ trợ doanh nghiệp. Với vị trí thuận lợi, tòa nhà là nơi lý tưởng cho các công ty khởi nghiệp và doanh nghiệp vừa và nhỏ.', 40.00, '999 Quốc Hương, Quận 2, TP HCM', 'Nhà phố', '2', '2024-11-06 23:22:23', '2024-11-08 21:31:32', 'https://th.bing.com/th/id/OIP.kx7Tdclm2qF2IJo1Jb3nvQHaEw?w=344&h=182&c=7&r=0&o=5&dpr=1.5&pid=1.7', 120.00, 7);
INSERT INTO `properties` VALUES (5, 'Tòa Nhà Ocean View', 'Tòa nhà nằm ngay bên bờ biển, Ocean View cung cấp các căn hộ với tầm nhìn ra biển tuyệt đẹp.', 50.00, '789 Trần Hưng Đạo, Hà Nội', 'Khu nghỉ dưỡng', '1', '2024-11-06 23:22:23', '2024-11-08 21:16:45', 'https://th.bing.com/th/id/OIP.hb6l6bIzr1y8STuOZcbquAHaHt?rs=1&pid=ImgDetMain', 80.00, 8);
INSERT INTO `properties` VALUES (6, 'Nhà phố rộng rãi có sân vườn', 'Ngôi nhà rộng rãi với sân vườn thoáng mát, gần công viên.', 30.00, '456 Đường Nguyễn Huệ, Quận 2, TP.HCM', 'house', '2', '2024-10-21 23:50:42', '2024-11-08 21:16:46', 'https://sieuthibanve.com/upload/images/202202/220757-products-2021-07-07-1625648623-oo.png', 150.00, 9);
INSERT INTO `properties` VALUES (7, 'Đất nền khu dân cư mới', 'Lô đất nền nằm trong khu dân cư đang phát triển, phù hợp đầu tư lâu dài.', 28.00, '789 Đường Nguyễn Văn Cừ, Quận 7, TP.HCM', 'land', '3', '2024-10-21 23:50:42', '2024-11-07 00:06:07', 'https://i.pinimg.com/736x/f6/44/db/f644db98d8a832188024ea769dbc7b0b--diy-art-home-design.jpg', 120.00, 10);
INSERT INTO `properties` VALUES (8, 'Mặt bằng kinh doanh tại trung tâm', 'Mặt bằng kinh doanh rộng rãi, gần các trung tâm mua sắm lớn.', 12.00, '12 Đường Nguyễn Trãi, Quận 5, TP.HCM', 'commercial', '2', '2024-10-21 23:50:42', '2024-11-08 21:35:24', 'https://th.bing.com/th/id/OIP.vWgKZ-gTouIU1anMcWSImgHaHa?pid=ImgDet&w=178&h=178&c=7&dpr=1.5', 200.00, 11);
INSERT INTO `properties` VALUES (13, 'Biệt thự ven biển Đà Nẵng', 'Biệt thự hướng biển tuyệt đẹp', 30.00, '789 Võ Nguyên Giáp, Đà Nẵng', 'apartment', '3', '2024-10-22 19:12:45', '2024-11-08 21:17:23', 'https://xdnamthienphat.vn/wp-content/uploads/2021/05/mau-thiet-ke-nha-pho-7x15m-2-tang-23.jpg', 600.00, 12);
INSERT INTO `properties` VALUES (14, 'Căn hộ mini Đà Nẵng', 'Căn hộ dành cho sinh viên', 10.00, '123 Nguyễn Văn Linh, Đà Nẵng', 'apartment', '1', '2024-10-22 19:12:45', '2024-11-06 23:39:00', 'https://i.pinimg.com/originals/ac/9e/3e/ac9e3e2fdf8fdd3784fa9fe123bec8fa.jpg', 50.00, 13);
INSERT INTO `properties` VALUES (15, 'Nhà phố quận 2', 'Nhà phố gần cầu Thủ Thiêm', 20.00, '555 Trần Nao, Quận 2, TP HCM', 'apartment', '2', '2024-10-22 19:12:45', '2024-11-08 21:18:06', 'https://media.batdongsan.vn/crop/300x200/projects/20180719154500-7456.jpg', 140.00, 14);
INSERT INTO `properties` VALUES (16, 'Nhà cấp 4 vùng quê Bạc Liêu', 'Nhà vùng quê, mở cửa thấy đồng ruộng', 100.00, '456 Điện Biên Phủ, Bạc Liêu', 'apartment', '1', '2024-10-22 19:12:45', '2024-11-06 23:38:58', 'https://th.bing.com/th/id/OIP.fjqwHfpCEbrpZXaW1cLCKAAAAA?rs=1&pid=ImgDetMain', 210.00, 15);
INSERT INTO `properties` VALUES (17, 'Biệt thự Thảo Điền', 'Biệt thự sân vườn rộng', 30.00, '999 Quốc Hương, Quận 2, TP HCM', 'apartment', '2', '2024-10-22 19:12:45', '2024-11-08 21:19:17', 'https://media.batdongsan.vn/posts/123860_672dfdb1a5abe.jpg', 450.00, 16);
INSERT INTO `properties` VALUES (18, 'Nhà liền kề Đồng Nai', 'Nhà liền kề giá tốt, gần khu công nghiệp', 10.00, '456 Biên Hòa, Đồng Nai', 'apartment', '1', '2024-10-22 19:12:45', '2024-11-06 23:38:55', 'https://i.pinimg.com/originals/c5/3f/7f/c53f7f7ed6ca13f7e70c7ca5c9a9bf0a.jpg', 180.00, 17);
INSERT INTO `properties` VALUES (19, 'Căn hộ mới ở Bình Tân', 'Căn hộ dành cho gia đình trẻ', 10.00, '234 Lê Văn Sỹ, Bình Tân, TP HCM', 'project', '3', '2024-10-22 19:12:45', '2024-11-08 21:18:32', 'https://media.batdongsan.vn/posts/123849_672de1315ce2c.jpg', 90.00, 18);
INSERT INTO `properties` VALUES (20, 'Nhà phố Vinhomes', 'Nhà phố khu đô thị Vinhomes', 20.00, '123 Vinhomes Central Park, TP HCM', 'project', '1', '2024-10-22 19:12:45', '2024-11-08 21:20:13', 'https://media.batdongsan.vn/posts/123860_672dfdb1a7b72.jpg', 190.00, 19);
INSERT INTO `properties` VALUES (21, 'Biệt thự sang trọng', 'Biệt thự đẹp với sân vườn rộng rãi', 22.00, '123 Hoàng Diệu, Đà Nẵng', 'project', '2', '2024-10-22 19:12:45', '2024-11-08 21:20:15', 'https://media.batdongsan.vn/crop/800x600/projects/20181220133156-28e6.jpg', 350.00, 20);
INSERT INTO `properties` VALUES (22, 'Căn hộ cao cấp', 'Căn hộ view biển tại Vũng Tàu', 22.00, '234 Lê Văn Sỹ, Bình Tân, TP HCM', 'project', '3', '2024-10-22 19:12:45', '2024-11-08 21:29:26', 'https://th.bing.com/th/id/OIP.Y8T-ohZfLyyLol5NP4Q0mAHaEC?w=290&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7', 250.00, 21);
INSERT INTO `properties` VALUES (23, 'Nhà phố Đà Lạt', 'Nhà phố gần chợ, thích hợp kinh doanh', 15.00, '789 Phan Đình Phùng, Đà Lạt', 'project', '1', '2024-10-22 19:12:45', '2024-11-08 21:19:12', 'https://media.batdongsan.vn/posts/123861_672e009e181ad.jpg', 150.00, 22);
INSERT INTO `properties` VALUES (24, 'Nhà cấp 4 vùng quê', 'Nhà rộng rãi tại vùng nông thôn, thích hợp nghỉ dưỡng', 17.00, '101 Hoàng Thị Loan, Quảng Trị', 'project', '1', '2024-10-22 19:12:45', '2024-11-06 23:38:46', 'https://th.bing.com/th/id/OIP.zZIVTP6fM3xDCYJTbYi5IAHaE8?rs=1&pid=ImgDetMain', 200.00, 23);
INSERT INTO `properties` VALUES (39, 'Nhà cấp 4 vùng quê', 'Nhà rộng rãi tại vùng nông thôn, thích hợp nghỉ dưỡng', 30.00, '101 Hoàng Thị Loan, Quảng Trị', 'project', '1', '2024-10-24 21:23:29', '2024-11-08 21:20:36', 'https://file4.batdongsan.com.vn/2018/12/20/hmcVYWuR/20181220140319-5dfe.jpg', 100.00, 24);
INSERT INTO `properties` VALUES (40, 'Chung cư cao cấp', 'Chung cư hiện đại, đầy đủ tiện nghi', 45.00, '456 Nguyễn Huệ, TP.HCM', '', '2', '2024-10-24 21:23:29', '2024-11-06 23:38:42', 'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2021/6/18/921746/ANH-BAT-DONG-SAN-COV.jpg', 75.00, 25);
INSERT INTO `properties` VALUES (41, 'Đất nền dự án', 'Đất nền khu vực trung tâm, tiềm năng phát triển cao', 35.00, '789 Trần Hưng Đạo, Hà Nội', '', NULL, '2024-10-24 21:23:29', '2024-11-08 21:22:39', 'https://bds.com.vn/images/products/2024/11/small/z6003905903271_a1e2cdd24a1e56f4ecb915559dbd7746.jpg', 150.00, 26);
INSERT INTO `properties` VALUES (42, 'Biệt thự ven biển', 'Biệt thự sang trọng gần biển', 50.00, '123 Lê Lợi, Đà Nẵng', '', NULL, '2024-10-24 21:23:29', '2024-11-08 21:23:00', 'https://bds.com.vn/images/products/2024/11/small/1_1730796495_1.jpg', 300.00, 27);
INSERT INTO `properties` VALUES (43, 'Nhà cấp 4 vùng quê', 'Nhà rộng rãi tại vùng nông thôn, thích hợp nghỉ dưỡng', 30.00, '101 Hoàng Thị Loan, Quảng Trị', '', NULL, '2024-10-24 21:23:35', '2024-11-08 21:22:24', 'https://bds.com.vn/images/products/2024/11/small/464691593_1970426023432173_2592127157516697485_n.jpg', 100.00, 28);
INSERT INTO `properties` VALUES (44, 'Chung cư cao cấp', 'Chung cư hiện đại, đầy đủ tiện nghi', 45.00, '456 Nguyễn Huệ, TP.HCM', '', NULL, '2024-10-24 21:23:35', '2024-11-08 21:22:31', 'https://bds.com.vn/images/products/2024/11/small/z5959499788756_2fa53d5a876abd79267e46a5f04cac98.jpg', 75.00, 29);
INSERT INTO `properties` VALUES (45, 'Đất nền dự án', 'Đất nền khu vực trung tâm, tiềm năng phát triển cao', 35.00, '789 Trần Hưng Đạo, Hà Nội', '', NULL, '2024-10-24 21:23:35', '2024-11-08 21:22:12', 'https://bds.com.vn/images/products/2024/11/small/1_1730967771_1.jpg', 150.00, 30);
INSERT INTO `properties` VALUES (46, 'Biệt thự ven biển', 'Biệt thự sang trọng gần biển', 50.00, '123 Lê Lợi, Đà Nẵng', '', NULL, '2024-10-24 21:23:35', '2024-11-08 21:23:27', 'https://bds.com.vn/images/products/2024/10/small/5a5dd070-af73-4b05-9289-cf34a904bd2c.jpg', 300.00, 31);
INSERT INTO `properties` VALUES (47, 'Nhà cấp 4 vùng quê', 'Nhà rộng rãi tại vùng nông thôn, thích hợp nghỉ dưỡng', 30.00, '101 Hoàng Thị Loan, Quảng Trị', '', NULL, '2024-10-24 21:23:36', '2024-11-08 21:23:34', 'https://bds.com.vn/images/products/2024/10/small/z5944888726512_66a2f95ec7f3718a0cd26261e4cba645.jpg', 100.00, 32);
INSERT INTO `properties` VALUES (48, 'Chung cư cao cấp', 'Chung cư hiện đại, đầy đủ tiện nghi', 45.00, '456 Nguyễn Huệ, TP.HCM', '', NULL, '2024-10-24 21:23:36', '2024-11-08 21:27:15', 'https://i1-vnexpress.vnecdn.net/2024/11/07/n1-1730972241-1164-1730972333.jpg?w=300&h=180&q=100&dpr=2&fit=crop&s=oX7Wdnzck2BxH9jYAm4myQ', 75.00, 33);
INSERT INTO `properties` VALUES (49, 'Đất nền dự án', 'Đất nền khu vực trung tâm, tiềm năng phát triển cao', 35.00, '789 Trần Hưng Đạo, Hà Nội', '', NULL, '2024-10-24 21:23:36', '2024-11-08 21:27:02', 'https://i1-vnexpress.vnecdn.net/2024/11/07/hinh-2-1730968333-4320-1730972489.jpg?w=300&h=180&q=100&dpr=2&fit=crop&s=dA6R4E7CEX7KnibKAMQ4Jw', 150.00, 34);
INSERT INTO `properties` VALUES (50, 'Biệt thự ven biển', 'Biệt thự sang trọng gần biển', 50.00, '123 Lê Lợi, Đà Nẵng', '', NULL, '2024-10-24 21:23:36', '2024-11-08 21:27:01', 'https://i1-vnexpress.vnecdn.net/2024/11/08/picture1-1731067042-5215-1731067087.jpg?w=240&h=144&q=100&dpr=2&fit=crop&s=whP10BjAdJUEa3fF5aIMLA', 300.00, 35);
INSERT INTO `properties` VALUES (51, 'Nhà cấp 4 vùng quê', 'Nhà rộng rãi tại vùng nông thôn, thích hợp nghỉ dưỡng', 30.00, '101 Hoàng Thị Loan, Quảng Trị', '', NULL, '2024-10-24 21:23:37', '2024-11-08 21:26:54', 'https://i1-vnexpress.vnecdn.net/2024/11/07/b1-1730972624-1730978274.jpg?w=240&h=144&q=100&dpr=2&fit=crop&s=47u9oceq3baYQ5R4R5Kk4Q', 100.00, 36);
INSERT INTO `properties` VALUES (52, 'Chung cư cao cấp', 'Chung cư hiện đại, đầy đủ tiện nghi', 45.00, '456 Nguyễn Huệ, TP.HCM', '', NULL, '2024-10-24 21:23:37', '2024-11-08 21:26:45', 'https://i1-kinhdoanh.vnecdn.net/2024/11/05/dji-20241003102605-0066-d-enha-8156-2437-1730813924.jpg?w=240&h=144&q=100&dpr=2&fit=crop&s=PLZ0EMsEP2IoLnNW1o-Chg', 75.00, 37);
INSERT INTO `properties` VALUES (53, 'Đất nền dự án', 'Đất nền khu vực trung tâm, tiềm năng phát triển cao', 35.00, '789 Trần Hưng Đạo, Hà Nội', '', NULL, '2024-10-24 21:23:37', '2024-11-06 23:38:22', 'https://media-cdn-v2.laodong.vn/Storage/NewsPortal/2021/6/18/921746/ANH-BAT-DONG-SAN-COV.jpg', 150.00, 38);
INSERT INTO `properties` VALUES (54, 'Biệt thự ven biển', 'Biệt thự sang trọng gần biển', 50.00, '123 Lê Lợi, Đà Nẵng', '', NULL, '2024-10-24 21:23:37', '2024-11-08 21:26:08', 'https://bds.com.vn/images/products/2022/08/small/z3682786268626_14b1157ab419ab36095581375bfe64be_1661849171_1.jpg', 300.00, 39);
INSERT INTO `properties` VALUES (55, 'Nhà cấp 4 vùng quê', 'Nhà rộng rãi tại vùng nông thôn, thích hợp nghỉ dưỡng', 30.00, '101 Hoàng Thị Loan, Quảng Trị', '', NULL, '2024-10-24 21:23:37', '2024-11-08 21:26:06', 'https://bds.com.vn/images/products/2022/08/small/289437193_144623198162827_2658448467521217615_n.jpg', 100.00, 40);
INSERT INTO `properties` VALUES (56, 'Chung cư cao cấp', 'Chung cư hiện đại, đầy đủ tiện nghi', 45.00, '456 Nguyễn Huệ, TP.HCM', '', NULL, '2024-10-24 21:23:37', '2024-11-08 21:25:52', 'https://bds.com.vn/images/products/2022/08/small/d2.jpg', 75.00, 41);
INSERT INTO `properties` VALUES (57, 'Đất nền dự án', 'Đất nền khu vực trung tâm, tiềm năng phát triển cao', 35.00, '789 Trần Hưng Đạo, Hà Nội', '', NULL, '2024-10-24 21:23:37', '2024-11-08 21:25:35', 'https://bds.com.vn/images/products/2022/08/small/z3580634621376_fa0b03bf8c05472d0dc07aae89cdb0c2.jpg', 150.00, 42);
INSERT INTO `properties` VALUES (58, 'Biệt thự ven biển', 'Biệt thự sang trọng gần biển', 50.00, '123 Lê Lợi, Đà Nẵng', '', NULL, '2024-10-24 21:23:37', '2024-11-08 21:25:27', 'https://bds.com.vn/images/products/2022/08/small/300828494_1248475849300515_6614460256427424476_n_1661563948_1.jpg', 300.00, 43);
INSERT INTO `properties` VALUES (59, 'Nhà cấp 4 vùng quê', 'Nhà rộng rãi tại vùng nông thôn, thích hợp nghỉ dưỡng', 30.00, '101 Hoàng Thị Loan, Quảng Trị', '', NULL, '2024-10-24 21:23:37', '2024-11-08 21:25:25', 'https://bds.com.vn/images/products/2022/08/small/269865788_2448898655243643_8857017111725479234_n.jpg', 100.00, 44);
INSERT INTO `properties` VALUES (60, 'Chung cư cao cấp', 'Chung cư hiện đại, đầy đủ tiện nghi', 45.00, '456 Nguyễn Huệ, TP.HCM', '', NULL, '2024-10-24 21:23:37', '2024-11-08 21:25:21', 'https://bds.com.vn/images/products/2022/08/small/z3671330558218_a3964271bf368deda97300218056c41a.jpg', 75.00, 45);
INSERT INTO `properties` VALUES (61, 'Đất nền dự án', 'Đất nền khu vực trung tâm, tiềm năng phát triển cao', 35.00, '789 Trần Hưng Đạo, Hà Nội', '', NULL, '2024-10-24 21:23:37', '2024-11-08 21:25:16', 'https://bds.com.vn/images/products/2022/08/small/1e45086b9253570d0e42.jpg', 150.00, 46);
INSERT INTO `properties` VALUES (62, 'Biệt thự ven biển', 'Biệt thự sang trọng gần biển', 50.00, '123 Lê Lợi, Đà Nẵng', '', NULL, '2024-10-24 21:23:37', '2024-11-08 21:25:09', 'https://bds.com.vn/images/products/2022/08/small/z3313876333368_62f62823413373760a90ae534066125f.jpg', 300.00, 47);
INSERT INTO `properties` VALUES (63, 'Nhà cấp 4 vùng quê', 'Nhà rộng rãi tại vùng nông thôn, thích hợp nghỉ dưỡng', 30.00, '101 Hoàng Thị Loan, Quảng Trị', '', NULL, '2024-10-24 21:23:38', '2024-11-08 21:25:05', 'https://bds.com.vn/images/products/2022/08/small/z3665708373769_a8040209d5b45e30bcefa24016a31b73.jpg', 100.00, 48);
INSERT INTO `properties` VALUES (64, 'Chung cư cao cấp', 'Chung cư hiện đại, đầy đủ tiện nghi', 45.00, '456 Nguyễn Huệ, TP.HCM', '', NULL, '2024-10-24 21:23:38', '2024-11-08 21:24:56', 'https://bds.com.vn/images/products/2022/08/small/z3593262472742_593aefd71255ecb1b3df33e4fa99d5da.jpg', 75.00, 49);
INSERT INTO `properties` VALUES (65, 'Đất nền dự án', 'Đất nền khu vực trung tâm, tiềm năng phát triển cao', 35.00, '789 Trần Hưng Đạo, Hà Nội', '', NULL, '2024-10-24 21:23:38', '2024-11-08 21:24:46', 'https://bds.com.vn/images/products/2022/08/small/6bbc2e28a1db6f8536ca.jpg', 150.00, 50);
INSERT INTO `properties` VALUES (75, 'Nhà cấp 4 vùng quê ngoè khó đó', NULL, 12.00, '365 Võ nguyên giáp', 'project', NULL, '2024-11-01 18:14:11', '2024-11-08 21:24:39', 'https://bds.com.vn/images/products/2022/08/small/298205796_611983333757177_6254216012357455482_n.jpg', 100.00, 51);
INSERT INTO `properties` VALUES (76, 'Nhà cấp 4 vùng quê ngoè khó đó', NULL, 12.00, '365 Võ nguyên giáp', NULL, NULL, '2024-11-01 18:16:38', '2024-11-08 21:24:37', 'https://bds.com.vn/images/products/2022/08/small/a12.jpg', 100.00, 52);
INSERT INTO `properties` VALUES (77, 'Nhà cấp 4 vùng quê ngoè khó đó', NULL, 12.00, '365 Võ nguyên giáp', NULL, NULL, '2024-11-01 18:19:58', '2024-11-08 21:24:27', 'https://bds.com.vn/images/products/2022/08/small/z3585908069924_946ed1c7302c4a5f3c431fea74edac7f.jpg', 100.00, 53);
INSERT INTO `properties` VALUES (79, 'Nhà cấp 4 vùng quê ngoè khó đó 123333', 'gahahahahaha123123123', 30.00, '365 Võ nguyên giáp', 'house', NULL, '2024-11-01 19:42:30', '2024-11-08 21:24:20', 'https://bds.com.vn/images/products/2022/08/small/299118248_592137952397650_2941227279989738067_n.jpg', 100.00, 54);
INSERT INTO `properties` VALUES (80, 'Nhà 1', 'Mô tả cho Nhà 1', 100.00, 'Địa chỉ Nhà 1', 'Nhà ở', '1', '2024-11-06 23:21:20', '2024-11-08 21:24:11', 'https://bds.com.vn/images/products/2023/08/small/291540197_2951683408454929_1222724089350958978_n.jpg', 50.00, 55);
INSERT INTO `properties` VALUES (81, 'Nhà 2', 'Mô tả cho Nhà 2', 200.00, 'Địa chỉ Nhà 2', 'Căn hộ', '2', '2024-11-06 23:21:20', '2024-11-08 21:24:06', 'https://bds.com.vn/images/products/2022/09/small/z3692452328082_376756e966b92cccdcd757e3c57add90.jpg', 75.00, 56);
INSERT INTO `properties` VALUES (82, 'Nhà 3', 'Mô tả cho Nhà 3', 300.00, 'Địa chỉ Nhà 3', 'Biệt thự', '3', '2024-11-06 23:21:20', '2024-11-08 21:23:56', 'https://bds.com.vn/images/products/2023/02/small/z4108552970301_8ad96c24371ea13df77a90df6464d8f5.jpg', 100.00, 57);
INSERT INTO `properties` VALUES (83, 'Nhà 4', 'Mô tả cho Nhà 4', 400.00, 'Địa chỉ Nhà 4', 'Nhà phố', '1', '2024-11-06 23:21:20', '2024-11-08 21:23:53', 'https://bds.com.vn/images/products/2022/08/small/298960119_721430909019286_4401041735667710977_n_1660707945_1.jpg', 120.00, 58);
INSERT INTO `properties` VALUES (84, 'Nhà 5', 'Mô tả cho Nhà 5', 500.00, 'Địa chỉ Nhà 5', 'Khu nghỉ dưỡng', '2', '2024-11-06 23:21:20', '2024-11-08 21:23:49', 'https://bds.com.vn/images/products/2024/10/small/z5944888726512_66a2f95ec7f3718a0cd26261e4cba645.jpg', 80.00, 59);
INSERT INTO `properties` VALUES (85, 'Rangel Crest', 'Căn hộ tiện nghi, gần trung tâm, giao thông thuận lợi.', 80.00, '123 Đường Hoa Lan, Phường 2, Quận Phú Nhuận, TP. HCM', 'Đất nền', 'Đã bán', '2024-01-26 05:35:10', '2024-11-08 21:47:00', 'https://th.bing.com/th/id/OIP.ZDwA5SFBwVRw0ROYNwxe9gAAAA?pid=ImgDet&w=178&h=133&c=7&dpr=1.5', 150.00, 1);
INSERT INTO `properties` VALUES (86, 'Campbell Hill', 'Nhà phố 2 tầng, không gian rộng, nội thất hiện đại.', 70.00, '56 Đường Lý Thường Kiệt, Phường 12, Quận Tân Bình, TP. HCM', 'Đất nền', 'Đang chờ', '2024-11-05 21:42:00', '2024-11-08 21:46:28', 'https://th.bing.com/th/id/OIP.NezsjFMyzx-pvKG4-oX92QHaFB?pid=ImgDet&w=178&h=120&c=7&dpr=1.5', 114.00, 2);
INSERT INTO `properties` VALUES (87, 'Dwayne Corners', 'Đất nền có tiềm năng, pháp lý rõ ràng.', 90.00, '789 Đường Nguyễn Văn Cừ, Quận 1, TP. HCM', 'Nhà phố', 'Đã bán', '2024-03-14 02:11:24', '2024-11-08 21:46:21', 'https://th.bing.com/th/id/OIP.98bE-LwtdH8YHQRDM6dLHAAAAA?pid=ImgDet&w=178&h=133&c=7&dpr=1.5', 103.02, 3);
INSERT INTO `properties` VALUES (88, 'Matthew Lights', 'Phòng làm việc thoáng mát, tiện nghi, giá hợp lý.', 100.00, '90 Đường Lê Lợi, Quận 3, TP. HCM', 'Văn phòng', 'Còn trống', '2024-01-02 21:02:24', '2024-11-08 21:47:04', 'https://th.bing.com/th/id/OIP.t1tIRmnWzV5B58jIEoLybAHaEn?pid=ImgDet&w=178&h=110&c=7&dpr=1.5', 45.00, 11);
INSERT INTO `properties` VALUES (89, 'Barr Land', 'Văn phòng cho thuê, vị trí đắc địa, đầy đủ nội thất.', 120.00, '102 Đường Bạch Đằng, Quận Bình Thạnh, TP. HCM', 'Căn hộ', 'Đã bán', '2024-05-21 13:34:34', '2024-11-08 21:46:11', 'https://th.bing.com/th/id/OIP.vlQojNVM49rZGVJPlD9TaAHaDn?rs=1&pid=ImgDetMain', 120.00, 15);
INSERT INTO `properties` VALUES (90, 'Johnson Dale', 'Biệt thự sân vườn, yên tĩnh, phong thủy tốt.', 140.00, '12 Đường Trường Sa, Quận Gò Vấp, TP. HCM', 'Nhà phố', 'Còn trống', '2024-02-18 07:41:20', '2024-11-08 21:46:09', 'https://3dwarehouse.sketchup.com/warehouse/v1.0/content/public/0cc2629a-51f2-4efb-8b98-cf677cbbaed8', 85.00, 16);
INSERT INTO `properties` VALUES (91, 'Miller Square', 'Căn hộ cao cấp, view đẹp, khu vực an ninh.', 200.00, '35 Đường Phan Đăng Lưu, Quận Phú Nhuận, TP. HCM', 'Căn hộ', 'Đang chờ', '2024-08-12 17:23:13', '2024-11-08 21:46:01', 'https://th.bing.com/th/id/OIP.01bKAHu5aSV__uYnQq0tCAHaEo?pid=ImgDet&w=178&h=111&c=7&dpr=1.5', 65.00, 7);
INSERT INTO `properties` VALUES (92, 'Green Ridge', 'Nhà trọ gần trường, đầy đủ tiện nghi.', 90.00, '67 Đường Võ Văn Kiệt, Quận 5, TP. HCM', 'Nhà phố', 'Đã bán', '2024-03-19 14:12:05', '2024-11-08 21:45:53', 'https://th.bing.com/th/id/OIP.rgDFlS7oTYtt7O3JnKRsFQHaHa?pid=ImgDet&w=178&h=178&c=7&dpr=1.5', 40.40, 8);
INSERT INTO `properties` VALUES (93, 'White Lake', 'Đất mặt tiền, thuận tiện kinh doanh, sổ đỏ chính chủ.', 75.00, '89 Đường Nguyễn Trãi, Quận 7, TP. HCM', 'Đất nền', 'Còn trống', '2024-07-25 16:40:59', '2024-11-08 21:45:47', 'https://th.bing.com/th/id/OIP.xuEE65aaNHyXNF0nsnTcqgHaF1?pid=ImgDet&w=178&h=140&c=7&dpr=1.5', 99.00, 9);
INSERT INTO `properties` VALUES (94, 'Sunny Valley', 'Chung cư mini, thiết kế hợp lý, gần khu mua sắm.', 76.00, '45 Đường Hoàng Sa, Quận Tân Bình, TP. HCM', 'Căn hộ', 'Đang chờ', '2024-04-09 10:55:42', '2024-11-08 21:45:44', 'https://th.bing.com/th/id/OIP.k8nATvu-4HGpIPLvIt4M2gHaE8?pid=ImgDet&w=178&h=118&c=7&dpr=1.5', 50.00, 10);
INSERT INTO `properties` VALUES (95, 'Sản phẩm 1', 'Căn hộ cao cấp với thiết kế hiện đại, đầy đủ tiện nghi. Phòng ngủ rộng rãi, phòng khách thoáng mát và view đẹp ra sông. Vị trí thuận tiện gần trung tâm thành phố.', 2500.00, 'Tòa nhà Sunrise, 120 Nguyễn Văn Cừ, Quận 1, TP.HCM', 'Căn hộ', 'Còn bán', '2024-11-09 08:13:41', '2024-11-09 08:20:08', 'https://media.batdongsan.vn/posts/14-161-25-175-z4512238441430-2a13f3f36d000fe167e92e6fe148ea45.jpg', 45.00, 59);
INSERT INTO `properties` VALUES (96, 'Sản phẩm 2', 'Nhà phố 3 tầng, thiết kế sang trọng, có sân vườn rộng, phù hợp cho gia đình có trẻ em. Khu dân cư an ninh, gần các trường học và bệnh viện.', 270.00, 'Khu dân cư Green Park, 56 Đường số 5, Phường 3, Quận Tân Bình, TP.HCM', 'Nhà phố', 'Còn bán', '2024-11-09 08:13:41', '2024-11-09 08:20:04', 'https://media.batdongsan.vn/crop/266x150/posts/14-191-32-226-315642204-6535708546446553-1811349874649622939-n.jpg', 80.00, 58);
INSERT INTO `properties` VALUES (97, 'Sản phẩm 3', 'Biệt thự với sân vườn xanh mát, hồ bơi riêng biệt. Kiến trúc theo phong cách tân cổ điển, không gian sống thoải mái, sang trọng. Địa chỉ khu dân cư cao cấp.', 230.00, 'Khu biệt thự Vinhome Central Park, 45 Lê Đức Thọ, Phường 13, Quận Gò Vấp, TP.HCM', 'Biệt thự', 'Còn bán', '2024-11-09 08:13:41', '2024-11-09 08:19:53', 'https://media.batdongsan.vn/crop/266x150/posts/103-199-56-193-ban-nha-thoai-ngoc-hau-tan-phu-2.jpg', 120.00, 57);
INSERT INTO `properties` VALUES (98, 'Sản phẩm 4', 'Căn hộ 2 phòng ngủ rộng rãi, nội thất đầy đủ, thuận tiện di chuyển đến các khu thương mại lớn. Môi trường sống lý tưởng cho gia đình trẻ.', 210.00, 'Tòa nhà Diamond Plaza, 26 Lê Duẩn, Quận 1, TP.HCM', 'Căn hộ', 'Còn bán', '2024-11-09 08:13:41', '2024-11-09 08:19:35', 'https://media.batdongsan.vn/crop/266x150/posts/42-112-79-186-1.jpg', 60.00, 56);
INSERT INTO `properties` VALUES (99, 'Sản phẩm 5', 'Nhà phố 2 mặt tiền, diện tích rộng, thuận tiện kinh doanh hoặc cho thuê. Khu vực đông đúc, tiềm năng phát triển cao trong tương lai.', 250.00, '109 Nguyễn Thị Minh Khai, Phường 6, Quận 3, TP.HCM', 'Nhà phố', 'Còn bán', '2024-11-09 08:13:41', '2024-11-09 08:19:24', 'https://media.batdongsan.vn/crop/266x150/posts/42-114-32-193-213.jpg', 95.00, 55);
INSERT INTO `properties` VALUES (100, 'Sản phẩm 6', 'Căn hộ cao cấp với không gian sống thoáng đãng, tiện ích nội khu đầy đủ như phòng gym, hồ bơi, khu vực vui chơi trẻ em. Chỉ cách trung tâm thành phố 15 phút.', 260.00, 'Tòa nhà Park Hill, 32 Lý Thường Kiệt, Quận Tân Bình, TP.HCM', 'Căn hộ', 'Còn bán', '2024-11-09 08:13:41', '2024-11-09 08:19:12', 'https://media.batdongsan.vn/crop/266x150/posts/42-114-32-193-213.jpg', 70.00, 54);
INSERT INTO `properties` VALUES (101, 'Sản phẩm 7', 'Biệt thự 5 phòng ngủ, phòng khách rộng rãi, sân vườn xanh tươi, có khu BBQ ngoài trời. Khu vực yên tĩnh, thích hợp nghỉ dưỡng hoặc sinh sống lâu dài.', 290.00, 'Khu biệt thự Riviera, 45 Trương Định, Quận 12, TP.HCM', 'Biệt thự', 'Còn bán', '2024-11-09 08:13:41', '2024-11-09 08:18:52', 'https://media.batdongsan.vn/crop/266x150/posts/123781_672d8418d4ba2.jpg', 150.00, 53);
INSERT INTO `properties` VALUES (102, 'Sản phẩm 8', 'Căn hộ 1 phòng ngủ, thích hợp cho người độc thân hoặc cặp vợ chồng trẻ. Nội thất hiện đại, đầy đủ tiện nghi, vị trí giao thông thuận tiện, gần siêu thị và trường học.', 220.00, 'Tòa nhà Central Point, 50 Bến Vân Đồn, Quận 4, TP.HCM', 'Căn hộ', 'Còn bán', '2024-11-09 08:13:41', '2024-11-09 08:18:43', 'https://media.batdongsan.vn/crop/300x200/projects/20190812150524-3adc.jpg', 55.00, 52);
INSERT INTO `properties` VALUES (103, 'Sản phẩm 9', 'Nhà phố có sân vườn, thiết kế thông minh, phù hợp với gia đình có từ 2-4 người. Vị trí gần các trung tâm mua sắm và khu công nghiệp, giao thông thuận tiện.', 240.00, 'Khu đô thị Thảo Điền, 16 Phan Đăng Lưu, Quận Bình Thạnh, TP.HCM', 'Nhà phố', 'Còn bán', '2024-11-09 08:13:41', '2024-11-09 08:18:33', 'https://media.batdongsan.vn/crop/300x200/projects/20161003150658-c2a0.jpg', 110.00, 51);
INSERT INTO `properties` VALUES (104, 'Sản phẩm 10', 'Biệt thự sang trọng với không gian sống xanh, bao quanh là cây cối, hoa lá. Hồ bơi lớn, sân tennis, rất thích hợp cho những gia đình yêu thích không gian mở.', 280.00, 'Khu đô thị Đại Quang Minh, 88 Nguyễn Văn Linh, Quận 7, TP.HCM', 'Biệt thự', 'Còn bán', '2024-11-09 08:13:41', '2024-11-09 08:18:23', 'https://th.bing.com/th/id/OIP.4C73vDmzBmuXRhfwin7-UAAAAA?pid=ImgDet&w=178&h=178&c=7&dpr=1.5', 130.00, 50);
INSERT INTO `properties` VALUES (105, 'Sản phẩm 11', 'Căn hộ 2 phòng ngủ, view sông, nội thất hiện đại, sàn gỗ, đầy đủ tiện nghi. Địa chỉ nằm trong khu dân cư cao cấp, an ninh tuyệt đối.', 210.00, 'Tòa nhà Saigon Pearl, 13 Nguyễn Hữu Cảnh, Quận Bình Thạnh, TP.HCM', 'Căn hộ', 'Còn bán', '2024-11-09 08:13:41', '2024-11-09 08:17:22', 'https://th.bing.com/th/id/R.4e1e85b4e263a09c6fb444018ad3db36?rik=XiHwG1rkBEMPsg&pid=ImgRaw&r=0', 45.00, 49);
INSERT INTO `properties` VALUES (106, 'Sản phẩm 12', 'Nhà phố mới xây, thiết kế đẹp, có garage xe hơi, nằm trong khu vực phát triển nhanh chóng. Gần trường học, chợ, bệnh viện.', 300.00, '36 Hồ Văn Huê, Phường 9, Quận Phú Nhuận, TP.HCM', 'Nhà phố', 'Còn bán', '2024-11-09 08:13:41', '2024-11-24 14:17:25', 'https://th.bing.com/th/id/OIP.T96zPyMtBXzNW2IKRKY6mQHaLG?pid=ImgDet&w=178&h=267&c=7&dpr=1.5', 100.00, 48);
INSERT INTO `properties` VALUES (107, 'Sản phẩm 13', 'Căn hộ 1 phòng ngủ, phòng khách rộng rãi, trang bị nội thất cao cấp, khu vực an ninh, gần các trung tâm mua sắm và trường học quốc tế.', 230.00, 'Tòa nhà Orchard Garden, 22 Lương Định Của, Quận 2, TP.HCM', 'Căn hộ', 'Còn bán', '2024-11-09 08:13:41', '2024-11-24 14:35:53', 'https://sieuthibanve.com/upload/images/202202/220757-products-2021-07-07-1625648623-oo.png', 80.00, 47);
INSERT INTO `properties` VALUES (108, 'Sản phẩm 14', 'Biệt thự với thiết kế theo phong cách hiện đại, không gian sống rộng rãi và thoáng đãng, phù hợp cho gia đình có nhiều thế hệ. Tiện ích đầy đủ, xung quanh có công viên.', 250.00, 'Khu biệt thự Mỹ Phước, 58 Nguyễn Văn Cừ, Quận 5, TP.HCM', 'Biệt thự', 'Còn bán', '2024-11-09 08:13:41', '2024-11-09 08:16:14', 'https://th.bing.com/th/id/OIP.KNJkDmXwLBHGpHatoO74UgHaFj?w=305&h=183&c=7&r=0&o=5&dpr=1.5&pid=1.7', 110.00, 46);
INSERT INTO `properties` VALUES (109, 'Sản phẩm 15', 'Căn hộ 3 phòng ngủ, view đẹp, không gian rộng, thiết kế hiện đại với đầy đủ tiện nghi. Khu vực sầm uất, gần trung tâm hành chính và các trung tâm thương mại.', 220.00, 'Tòa nhà Vinhomes Central Park, 36 Nguyễn Hữu Cảnh, Quận Bình Thạnh, TP.HCM', 'Căn hộ', 'Còn bán', '2024-11-09 08:13:41', '2024-11-09 08:16:01', 'https://th.bing.com/th/id/OIP.HSOPnIpOvh5rvRRzuViSgAHaE1?w=280&h=183&c=7&r=0&o=5&dpr=1.5&pid=1.7', 50.00, 45);
INSERT INTO `properties` VALUES (119, 'a', 'a', 2.30, 'a', 'a', 'a', '2024-12-03 13:39:13', '2024-12-03 13:39:13', 'a', 3.40, 1);
INSERT INTO `properties` VALUES (124, 'a', 'a', 2.30, 'a', 'a', 'a', '2024-12-03 14:17:21', '2024-12-03 14:17:21', NULL, 3.40, 1);
INSERT INTO `properties` VALUES (125, 'a', 'a', 2.30, 'a', 'a', 'a', '2024-12-03 14:23:13', '2024-12-03 14:23:13', NULL, 3.40, 1);
INSERT INTO `properties` VALUES (126, 'a', 'a', 2.30, 'a', 'a', 'a', '2024-12-03 14:25:20', '2024-12-03 14:25:20', NULL, 3.40, 1);
INSERT INTO `properties` VALUES (127, 'a', 'a', 2.30, 'a', 'a', 'a', '2024-12-03 14:33:06', '2024-12-03 14:33:06', 'amoi', 3.40, 1);
INSERT INTO `properties` VALUES (135, 'nhà mặt phố bố làm to lắm ', 'nhà này rất đẹp mọi người nên ghé qua mà xem thử nha yêu mng', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', 'for_sale', '2024-12-03 19:51:11', '2024-12-03 19:51:11', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733230271/g31wzoyzo1aixa8gwcud.png', 50.00, 1);
INSERT INTO `properties` VALUES (136, 'nhà mặt phố bố làm to lắm ', 'fs', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', 'for_sale', '2024-12-03 19:51:43', '2024-12-03 19:51:43', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733230304/wdib0t32kicp6f4pmgvp.png', 50.00, 2);
INSERT INTO `properties` VALUES (138, 'nhà mặt phố bố làm to lắm ', 'nhà này rất đẹp mọi người nên ghé qua mà xem thử nha yêu mng', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', 'for_sale', '2024-12-03 20:00:32', '2024-12-03 20:00:32', NULL, 50.00, 1);
INSERT INTO `properties` VALUES (139, 'nhà mặt phố bố làm to lắm ', 'nhà này rất đẹp mọi người nên ghé qua mà xem thử nha yêu mng', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', 'for_sale', '2024-12-03 20:02:35', '2024-12-03 20:02:35', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733230956/y1ijfxlbuvl2kxloy8ma.png', 50.00, 1);
INSERT INTO `properties` VALUES (140, 'nhà mặt phố bố làm to lắm ', 'nhà này rất đẹp mọi người nên ghé qua mà xem thử nha yêu mng', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', 'for_sale', '2024-12-03 20:03:31', '2024-12-03 20:03:31', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733231011/jzq7l4xwvhljhj0w1fx3.png', 50.00, 1);
INSERT INTO `properties` VALUES (141, 'nhà mặt phố bố làm to lắm ', 'nhà này rất đẹp mọi người nên ghé qua mà xem thử nha yêu mng', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', 'for_sale', '2024-12-03 20:04:07', '2024-12-03 20:04:07', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733231047/v53xrschkedaqfayirew.png', 50.00, 1);
INSERT INTO `properties` VALUES (142, 'nhà mặt phố bố làm to lắm ', 'fs', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', 'for_sale', '2024-12-03 20:10:21', '2024-12-03 20:10:21', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733231422/asyeswtopvaeiosnis8n.png', 50.00, 2);
INSERT INTO `properties` VALUES (143, 'nhà mặt phố bố làm to lắm ', 'fs', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', 'for_sale', '2024-12-03 20:12:33', '2024-12-03 20:12:33', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733231553/peiebfn092l5y5kklqly.png', 50.00, 2);
INSERT INTO `properties` VALUES (144, 'nhà mặt phố bố làm to lắm ', 'fs', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', 'for_sale', '2024-12-03 20:22:44', '2024-12-03 20:22:44', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733232165/uoh9jcgoykjoxmmr3tu4.png', 50.00, 1);
INSERT INTO `properties` VALUES (145, 'nhà mặt phố bố làm to lắm ', 'fs', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', 'for_sale', '2024-12-03 20:23:33', '2024-12-03 20:23:33', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733232213/sw58pfh2e8abyytrncks.png', 50.00, 1);
INSERT INTO `properties` VALUES (146, 'nhà mặt phố bố làm to lắm ', 'nhà này rất đẹp mọi người nên ghé qua mà xem thử nha yêu mng', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', 'for_sale', '2024-12-03 20:26:29', '2024-12-03 20:26:29', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733232390/mbbqj1lathknfckxbqgj.png', 50.00, 1);
INSERT INTO `properties` VALUES (147, 'nhà mặt phố bố làm to lắm ', 'nhà này rất đẹp mọi người nên ghé qua mà xem thử nha yêu mng', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', 'for_sale', '2024-12-03 20:43:27', '2024-12-03 20:43:27', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733233407/oys62o7bak7pwg0qhifs.png', 50.00, 1);
INSERT INTO `properties` VALUES (149, 'nhà mặt phố bố làm to lắm ', 'nhà này rất đẹp mọi người nên ghé qua mà xem thử nha yêu mng', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', 'for_sale', '2024-12-03 21:05:53', '2024-12-03 21:05:53', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733234753/lgdrbjzi7rfbzrzhykpu.png', 50.00, 1);
INSERT INTO `properties` VALUES (151, 'nhà mặt phố bố làm to lắm ', 'nhà này rất đẹp mọi người nên ghé qua mà xem thử nha yêu mng', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', 'for_sale', '2024-12-03 21:22:58', '2024-12-03 21:22:58', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733235779/jmfgwn8bxefiznuoxwri.jpg', 50.00, 1);
INSERT INTO `properties` VALUES (152, 'nhà mặt phố bố làm to lắm ', 'nhà này rất đẹp mọi người nên ghé qua mà xem thử nha yêu mng', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', 'for_sale', '2024-12-03 21:26:15', '2024-12-03 21:26:15', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733235976/ribv1tfjgld71ds02om3.jpg', 50.00, 1);
INSERT INTO `properties` VALUES (153, 'nhà mặt phố bố làm to lắm ', 'nhà này rất đẹp mọi người nên ghé qua mà xem thử nha yêu mng', 50.00, 'Quận 1 Thành Phố Hồ Chí Minh', 'nha dat  ', 'for_sale', '2024-12-03 21:27:26', '2024-12-03 21:27:26', 'http://res.cloudinary.com/dg0f7bdho/image/upload/v1733236047/pgnkxhgd1zsfazhge796.jpg', 50.00, 2);

-- ----------------------------
-- Table structure for property_details
-- ----------------------------
DROP TABLE IF EXISTS `property_details`;
CREATE TABLE `property_details`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) NULL DEFAULT NULL,
  `area` decimal(10, 2) NOT NULL,
  `price` decimal(15, 2) NOT NULL,
  `frontage` decimal(10, 2) NOT NULL,
  `access_road` decimal(10, 2) NOT NULL,
  `floors` int(11) NOT NULL,
  `bedrooms` int(11) NOT NULL,
  `bathrooms` int(11) NOT NULL,
  `legal_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `furniture_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `property_id`(`property_id` ASC) USING BTREE,
  CONSTRAINT `property_details_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of property_details
-- ----------------------------
INSERT INTO `property_details` VALUES (11, 1, 100.00, 200.00, 10.00, 5.00, 2, 3, 2, 'Sổ đỏ', 'Đầy đủ');
INSERT INTO `property_details` VALUES (12, 2, 150.00, 300.00, 12.00, 6.00, 3, 4, 3, 'Sổ hồng', 'Đầy đủ');
INSERT INTO `property_details` VALUES (13, 3, 80.00, 150.00, 8.00, 4.00, 1, 2, 1, 'Sổ đỏ', 'Cơ bản');
INSERT INTO `property_details` VALUES (14, 4, 120.00, 250.00, 9.50, 5.50, 2, 3, 2, 'Sổ đỏ', 'Đầy đủ');
INSERT INTO `property_details` VALUES (15, 5, 200.00, 400.00, 15.00, 7.00, 4, 5, 4, 'Sổ hồng', 'Đầy đủ');
INSERT INTO `property_details` VALUES (16, 6, 110.00, 220.00, 10.00, 6.00, 2, 3, 2, 'Sổ đỏ', 'Cơ bản');
INSERT INTO `property_details` VALUES (17, 7, 95.00, 190.00, 11.00, 5.50, 2, 3, 2, 'Sổ hồng', 'Đầy đủ');
INSERT INTO `property_details` VALUES (18, 8, 130.00, 280.00, 12.50, 6.50, 3, 4, 3, 'Sổ đỏ', 'Đầy đủ');
INSERT INTO `property_details` VALUES (19, 13, 140.00, 320.00, 13.00, 7.00, 3, 4, 3, 'Sổ hồng', 'Đầy đủ');
INSERT INTO `property_details` VALUES (20, 14, 90.00, 180.00, 8.50, 4.50, 1, 2, 1, 'Sổ đỏ', 'Cơ bản');

-- ----------------------------
-- Table structure for property_images
-- ----------------------------
DROP TABLE IF EXISTS `property_images`;
CREATE TABLE `property_images`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_id` int(11) NOT NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `property_id`(`property_id` ASC) USING BTREE,
  CONSTRAINT `property_images_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 89 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of property_images
-- ----------------------------
INSERT INTO `property_images` VALUES (14, 14, 'https://hoangquan.com.vn/vnt_upload/news/12_2020/bat-dong-san61.jpg');
INSERT INTO `property_images` VALUES (21, 12, 'https://hoangquan.com.vn/vnt_upload/news/12_2020/bat-dong-san61.jpg');
INSERT INTO `property_images` VALUES (22, 13, 'https://hoangquan.com.vn/vnt_upload/news/12_2020/bat-dong-san61.jpg');
INSERT INTO `property_images` VALUES (23, 15, 'https://hoangquan.com.vn/vnt_upload/news/12_2020/bat-dong-san61.jpg');
INSERT INTO `property_images` VALUES (24, 16, 'https://hoangquan.com.vn/vnt_upload/news/12_2020/bat-dong-san61.jpg');
INSERT INTO `property_images` VALUES (25, 79, 'https://hoangquan.com.vn/vnt_upload/news/12_2020/bat-dong-san61.jpg');
INSERT INTO `property_images` VALUES (26, 77, 'https://hoangquan.com.vn/vnt_upload/news/12_2020/bat-dong-san61.jpg');
INSERT INTO `property_images` VALUES (27, 11, 'https://hoangquan.com.vn/vnt_upload/news/12_2020/bat-dong-san61.jpg');
INSERT INTO `property_images` VALUES (28, 64, 'https://hoangquan.com.vn/vnt_upload/news/12_2020/bat-dong-san61.jpg');
INSERT INTO `property_images` VALUES (29, 63, 'https://hoangquan.com.vn/vnt_upload/news/12_2020/bat-dong-san61.jpg');
INSERT INTO `property_images` VALUES (30, 65, 'https://hoangquan.com.vn/vnt_upload/news/12_2020/bat-dong-san61.jpg');
INSERT INTO `property_images` VALUES (62, 1, 'https://sketchup.cgtips.org/wp-content/uploads/2022/06/7270.-Sketchup-House-Exterior-Model-Download-by-Trung-Nguyen-1-768x747.jpg');
INSERT INTO `property_images` VALUES (63, 1, 'https://i.pinimg.com/736x/49/40/6a/49406a0c43f4e077f51891fa49b816f3.jpg');
INSERT INTO `property_images` VALUES (64, 1, 'https://i.pinimg.com/736x/79/da/04/79da04441df6189bedfa4d5efeb054c8.jpg');
INSERT INTO `property_images` VALUES (65, 2, 'https://th.bing.com/th/id/OIP.Cxi3eQBb-t6_TUUljQbqFAHaH-?rs=1&pid=ImgDetMain');
INSERT INTO `property_images` VALUES (66, 2, 'https://th.bing.com/th/id/OIP.bMAU81ujll4vooXpZMnNBgHaHa?w=1400&h=1400&rs=1&pid=ImgDetMain');
INSERT INTO `property_images` VALUES (67, 3, 'https://th.bing.com/th/id/OIP.5rBphtYWMY2FU1XUP2QApgHaFL?rs=1&pid=ImgDetMain');
INSERT INTO `property_images` VALUES (68, 3, 'https://th.bing.com/th/id/OIP.1eVQcfd_GsuJloHRQYgaFAHaHZ?w=720&h=719&rs=1&pid=ImgDetMain');
INSERT INTO `property_images` VALUES (69, 4, 'https://th.bing.com/th/id/OIP.ZVTg3mTZih0XHZC5GqnoxgHaFV?w=220&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7');
INSERT INTO `property_images` VALUES (70, 4, 'https://suanhaphattai.com/wp-content/uploads/2015/08/hinh-anh-nha-dep-3.jpg');
INSERT INTO `property_images` VALUES (71, 4, 'https://th.bing.com/th/id/OIP.vlQojNVM49rZGVJPlD9TaAHaDn?w=309&h=180&c=7&r=0&o=5&dpr=1.5&pid=1.7');
INSERT INTO `property_images` VALUES (72, 5, 'https://tuvannhadep.com.vn/uploads/images/hinh-anh-nha-dep-10.jpg');
INSERT INTO `property_images` VALUES (73, 5, 'https://cdna.artstation.com/p/assets/images/images/024/072/144/large/hamza-hanif-22.jpg?1581244941');
INSERT INTO `property_images` VALUES (74, 6, 'https://cdna.artstation.com/p/assets/images/images/024/072/144/large/hamza-hanif-22.jpg?1581244941');
INSERT INTO `property_images` VALUES (75, 6, 'https://th.bing.com/th/id/OIP.oHIFmCfZXrktPoSEVqfdzgHaEK?w=1000&h=563&rs=1&pid=ImgDetMain');
INSERT INTO `property_images` VALUES (78, 8, 'https://th.bing.com/th/id/OIP.IFrE7PPsGb1XNmYN4azZsAHaFj?rs=1&pid=ImgDetMain');
INSERT INTO `property_images` VALUES (79, 8, 'https://th.bing.com/th/id/OIP.Rf0-pX1rHJ3EVrg8D5yQTgHaFj?rs=1&pid=ImgDetMain');
INSERT INTO `property_images` VALUES (80, 7, 'https://scr.vn/wp-content/uploads/2020/08/%E1%BA%A2nh-nh%C3%A0-%C4%91%E1%BA%B9p-xe-sang.jpg');
INSERT INTO `property_images` VALUES (81, 7, 'https://scr.vn/wp-content/uploads/2020/08/H%C3%ACnh-nh%C3%A0-%C4%91%E1%BA%B9p-v%E1%BB%9Bi-xe-sang.jpg');
INSERT INTO `property_images` VALUES (82, 13, 'https://scr.vn/wp-content/uploads/2020/08/M%E1%BA%ABu-nh%C3%A0-%C4%91%E1%BA%B9p-xe-%C4%91%E1%BA%B9p.png');
INSERT INTO `property_images` VALUES (83, 13, 'https://scr.vn/wp-content/uploads/2020/08/Nh%C3%A0-2-t%E1%BA%A7ng-%C4%91%E1%BA%B9p-v%C3%A0-xe-%C4%91%E1%BA%B9p.jpg');
INSERT INTO `property_images` VALUES (84, 14, 'https://scr.vn/wp-content/uploads/2020/08/H%C3%ACnh-nh%C3%A0-%C4%91%E1%BA%B9p-xe-sang.jpg');
INSERT INTO `property_images` VALUES (88, 1, 'https://sketchup.cgtips.org/wp-content/uploads/2022/06/7270.-Sketchup-House-Exterior-Model-Download-by-Trung-Nguyen-1-768x747.jpg');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` enum('active','inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'inactive',
  `role` enum('admin','user') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'user',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'johnn', '123', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (2, 'khoa', '123', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (3, 'khoa12', '123', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (4, 'khoa1', '123', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (5, 'john123', '123', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (6, 'admin', 'admin', '21130401@st.hcmuaf.edu.vn', NULL, 'active', 'admin');
INSERT INTO `users` VALUES (8, 'john', 'admin', '21130401@st.hcmuaf.edu.vn', NULL, 'active', 'admin');
INSERT INTO `users` VALUES (9, 'john12', '123', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (10, 'john1234', '123', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (11, 'john12345', '123', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (12, 'john123456', '123', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (13, 'john1234567', '123', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (14, 'john12345678', '123', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (15, 'john123456789', '123', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (16, 'john1234567890', '123', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (17, 'john12345678901', '123', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (23, 'khoangoquan1', '123', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (24, 'khoangoquan', '123', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (25, 'khoangoquan11', '123', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (26, 'khoangoquan123', '123', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (27, 'admin1123', 'admin', 'khoangoquan@gmail.com', NULL, 'active', 'user');
INSERT INTO `users` VALUES (31, 'admin111', 'admin', 'khoangoquan@gmail.com', NULL, 'active', 'user');

SET FOREIGN_KEY_CHECKS = 1;
