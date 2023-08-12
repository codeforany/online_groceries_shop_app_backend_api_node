-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 12, 2023 at 07:09 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.1.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `groceries`
--

-- --------------------------------------------------------

--
-- Table structure for table `address_detail`
--

CREATE TABLE `address_detail` (
  `address_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(50) NOT NULL DEFAULT '',
  `phone` varchar(20) NOT NULL DEFAULT '',
  `address` varchar(200) NOT NULL DEFAULT '',
  `city` varchar(75) NOT NULL DEFAULT '',
  `state` varchar(75) NOT NULL DEFAULT '',
  `type_name` varchar(50) NOT NULL DEFAULT '',
  `postal_code` varchar(20) NOT NULL DEFAULT '',
  `is_default` int(1) NOT NULL DEFAULT 0,
  `status` int(1) NOT NULL DEFAULT 1,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `address_detail`
--

INSERT INTO `address_detail` (`address_id`, `user_id`, `name`, `phone`, `address`, `city`, `state`, `type_name`, `postal_code`, `is_default`, `status`, `created_date`, `modify_date`) VALUES
(1, 2, 'My Home', '9876543211', 'New Nat Stge Bldg, S Bapat Marg, Mahim', 'Mumbai', 'Maharashtra', 'Home', '400016', 0, 1, '2023-08-07 10:33:23', '2023-08-07 23:29:54'),
(2, 2, 'My Home', '98765432102', '246/ A, Dhutpeshwar Bldg, Girgaon Road, Near Gai Wadi, Girgaon', 'Mumbai', 'Maharashtra', 'Home', '400004', 1, 1, '2023-08-07 10:38:58', '2023-08-07 23:29:00'),
(3, 2, '1', '123', 'asd', 'asdasd', 'dsfsdfsf', 'Office', '987654123', 0, 2, '2023-08-07 23:15:27', '2023-08-07 23:17:23'),
(4, 2, 'Office1', '9875222', 'Shop 15, Dda Shopping Complex, Azadpur', 'Delhi', 'Delhi', 'Office', '110033', 0, 1, '2023-08-07 23:18:09', '2023-08-10 11:43:16'),
(5, 2, 'Add', '986565635225', '444 ASD ASD asdasdasd', 'Surat', 'Gujarat', 'Home', '456546', 0, 1, '2023-08-10 11:39:37', '2023-08-10 11:39:37');

-- --------------------------------------------------------

--
-- Table structure for table `area_detail`
--

CREATE TABLE `area_detail` (
  `area_id` int(11) NOT NULL,
  `zone_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(100) NOT NULL DEFAULT '',
  `status` int(1) NOT NULL DEFAULT 1,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `area_detail`
--

INSERT INTO `area_detail` (`area_id`, `zone_id`, `name`, `status`, `created_date`, `modify_date`) VALUES
(1, 2, 'Area 1', 1, '2023-07-28 16:32:06', '2023-07-28 16:33:46'),
(2, 2, 'Area 2', 1, '2023-07-28 16:37:51', '2023-07-28 16:37:51'),
(3, 1, 'Area 2', 1, '2023-07-28 16:37:55', '2023-07-28 16:37:55'),
(4, 1, 'Area 1', 1, '2023-07-28 16:37:59', '2023-07-28 16:37:59'),
(5, 1, 'Area 3', 1, '2023-07-28 16:38:02', '2023-07-28 16:38:02');

-- --------------------------------------------------------

--
-- Table structure for table `brand_detail`
--

CREATE TABLE `brand_detail` (
  `brand_id` int(11) NOT NULL,
  `brand_name` varchar(150) NOT NULL DEFAULT '',
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '1: active, 2: deleted',
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `brand_detail`
--

INSERT INTO `brand_detail` (`brand_id`, `brand_name`, `status`, `created_date`, `modify_date`) VALUES
(1, 'bigs', 1, '2023-07-26 15:16:50', '2023-07-26 15:18:39');

-- --------------------------------------------------------

--
-- Table structure for table `cart_detail`
--

CREATE TABLE `cart_detail` (
  `cart_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `prod_id` int(11) NOT NULL DEFAULT 0,
  `qty` int(11) NOT NULL DEFAULT 1,
  `status` int(1) NOT NULL DEFAULT 1,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cart_detail`
--

INSERT INTO `cart_detail` (`cart_id`, `user_id`, `prod_id`, `qty`, `status`, `created_date`, `modify_date`) VALUES
(1, 2, 5, 0, 2, '2023-08-06 16:50:58', '2023-08-06 16:53:08'),
(2, 2, 6, 1, 2, '2023-08-06 16:52:48', '2023-08-06 16:54:53'),
(3, 2, 5, 1, 2, '2023-08-08 08:18:57', '2023-08-08 08:19:29'),
(4, 2, 5, 3, 2, '2023-08-08 09:37:44', '2023-08-08 10:12:44'),
(5, 2, 11, 1, 2, '2023-08-08 09:38:01', '2023-08-08 10:12:45'),
(6, 2, 10, 3, 2, '2023-08-08 09:38:02', '2023-08-08 10:12:47'),
(7, 2, 5, 1, 2, '2023-08-08 10:13:04', '2023-08-08 11:45:08'),
(8, 2, 6, 1, 2, '2023-08-08 10:13:06', '2023-08-08 11:45:09'),
(9, 2, 6, 1, 2, '2023-08-08 10:13:08', '2023-08-08 10:13:14'),
(10, 7, 5, 1, 2, '2023-08-08 11:18:33', '2023-08-08 11:31:27'),
(11, 7, 5, 4, 2, '2023-08-08 11:19:31', '2023-08-08 11:44:17'),
(12, 7, 6, 1, 2, '2023-08-08 11:19:55', '2023-08-08 11:37:50'),
(13, 7, 7, 0, 2, '2023-08-08 11:21:24', '2023-08-08 11:32:58'),
(14, 7, 5, 1, 2, '2023-08-08 11:46:21', '2023-08-08 11:47:03'),
(15, 7, 5, 1, 2, '2023-08-08 11:47:08', '2023-08-08 11:47:13'),
(16, 7, 5, 2, 1, '2023-08-08 11:50:56', '2023-08-08 11:59:41'),
(17, 7, 6, 3, 1, '2023-08-08 11:51:03', '2023-08-08 11:51:03'),
(18, 2, 5, 1, 2, '2023-08-08 11:53:14', '2023-08-10 10:26:51'),
(19, 7, 5, 1, 1, '2023-08-10 10:37:12', '2023-08-10 10:37:12'),
(20, 7, 6, 1, 1, '2023-08-10 10:37:14', '2023-08-10 10:37:14'),
(21, 7, 6, 1, 1, '2023-08-10 10:37:16', '2023-08-10 10:37:16'),
(22, 2, 5, 3, 2, '2023-08-10 10:38:03', '2023-08-10 10:39:14'),
(23, 2, 6, 2, 2, '2023-08-10 10:38:10', '2023-08-10 10:39:14'),
(24, 2, 5, 1, 2, '2023-08-10 17:56:55', '2023-08-10 19:23:38'),
(25, 2, 6, 1, 2, '2023-08-10 17:56:57', '2023-08-10 19:23:38'),
(26, 2, 5, 1, 2, '2023-08-10 19:24:33', '2023-08-10 19:25:02'),
(27, 2, 6, 1, 2, '2023-08-10 19:24:35', '2023-08-10 19:25:02'),
(28, 2, 6, 1, 2, '2023-08-10 19:24:37', '2023-08-10 19:25:02'),
(29, 2, 5, 1, 2, '2023-08-10 19:27:56', '2023-08-10 19:28:26'),
(30, 2, 5, 1, 2, '2023-08-10 19:28:53', '2023-08-10 19:29:26'),
(31, 2, 5, 1, 2, '2023-08-10 19:31:36', '2023-08-10 19:32:02'),
(32, 2, 5, 1, 2, '2023-08-10 19:34:46', '2023-08-10 19:34:55'),
(33, 2, 5, 2, 2, '2023-08-10 19:35:51', '2023-08-10 19:41:14'),
(34, 2, 6, 2, 2, '2023-08-10 19:35:54', '2023-08-10 19:41:14'),
(35, 2, 7, 1, 2, '2023-08-10 19:36:04', '2023-08-10 19:41:14'),
(36, 2, 5, 1, 1, '2023-08-11 16:32:23', '2023-08-11 16:32:23');

-- --------------------------------------------------------

--
-- Table structure for table `category_detail`
--

CREATE TABLE `category_detail` (
  `cat_id` int(11) NOT NULL,
  `cat_name` varchar(100) NOT NULL DEFAULT '',
  `image` varchar(75) NOT NULL DEFAULT '',
  `color` varchar(10) NOT NULL DEFAULT '000000',
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '1 = active, 2 = delete',
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `category_detail`
--

INSERT INTO `category_detail` (`cat_id`, `cat_name`, `image`, `color`, `status`, `created_date`, `modify_date`) VALUES
(1, 'Frash Fruits & Vegetable', 'category/20230726155407547qM5gSxkrCh.png', '53B175', 1, '2023-07-26 15:54:07', '2023-07-26 15:57:30'),
(2, 'Cooking Oil & Ghee', 'category/202307261555485548dKi8yJisIn.png', 'F8A44C', 1, '2023-07-26 15:54:43', '2023-07-26 15:55:48'),
(3, 'Meat & Fish', 'category/20230731100233233AOuWmq6r64.png', 'F7A593', 1, '2023-07-31 10:02:33', '2023-07-31 10:02:33'),
(4, 'Bakery & Snacks', 'category/20230731100257257bPdXFaneYu.png', 'D3B0E0', 1, '2023-07-31 10:02:57', '2023-07-31 10:02:57'),
(5, 'Dairy & Eggs', 'category/20230731100322322vK4gHfIwCI.png', 'FDE598', 1, '2023-07-31 10:03:22', '2023-07-31 10:03:22'),
(6, 'Beverages', 'category/20230731100347347lrk8CyW57u.png', 'B7DFF5', 1, '2023-07-31 10:03:47', '2023-07-31 10:03:47');

-- --------------------------------------------------------

--
-- Table structure for table `favorite_detail`
--

CREATE TABLE `favorite_detail` (
  `fav_id` int(11) NOT NULL,
  `prod_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `status` int(1) NOT NULL DEFAULT 1,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `favorite_detail`
--

INSERT INTO `favorite_detail` (`fav_id`, `prod_id`, `user_id`, `status`, `created_date`, `modify_date`) VALUES
(1, 5, 5, 1, '2023-08-02 15:19:57', '2023-08-02 15:19:57'),
(9, 10, 2, 1, '2023-08-03 00:57:23', '2023-08-03 00:57:23'),
(11, 6, 2, 1, '2023-08-06 17:19:23', '2023-08-06 17:19:23'),
(12, 5, 2, 1, '2023-08-06 19:09:56', '2023-08-06 19:09:56'),
(13, 7, 2, 1, '2023-08-06 19:15:55', '2023-08-06 19:15:55');

-- --------------------------------------------------------

--
-- Table structure for table `image_detail`
--

CREATE TABLE `image_detail` (
  `img_id` int(11) NOT NULL,
  `prod_id` int(11) NOT NULL DEFAULT 0,
  `image` varchar(75) NOT NULL DEFAULT '',
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '1 = active, 2 = delete',
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `image_detail`
--

INSERT INTO `image_detail` (`img_id`, `prod_id`, `image`, `status`, `created_date`, `modify_date`) VALUES
(4, 5, 'product/202307310947354735xuruflIucc.png', 1, '2023-07-31 09:47:35', '2023-07-31 09:47:35'),
(5, 6, 'product/202307310951365136W6nJvPCdzQ.png', 1, '2023-07-31 09:51:36', '2023-07-31 09:51:36'),
(6, 7, 'product/202307310958175817ytVf7AVIOl.png', 1, '2023-07-31 09:58:17', '2023-07-31 09:58:17'),
(7, 8, 'product/202307311010091094RZ1nWHTug.png', 1, '2023-07-31 10:10:09', '2023-07-31 10:10:09'),
(8, 9, 'product/202307311011551155pIjIPWIb4w.png', 1, '2023-07-31 10:11:55', '2023-07-31 10:11:55'),
(9, 10, 'product/20230731101409149FomkojOsMt.png', 1, '2023-07-31 10:14:09', '2023-07-31 10:14:09'),
(10, 11, 'product/202307311018321832QsO9noUdBS.png', 1, '2023-07-31 10:18:32', '2023-07-31 10:18:32'),
(11, 12, 'product/202307311022232223jrsJiejIQu.png', 1, '2023-07-31 10:22:23', '2023-07-31 10:22:23');

-- --------------------------------------------------------

--
-- Table structure for table `notification_detail`
--

CREATE TABLE `notification_detail` (
  `notification_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `ref_id` int(11) NOT NULL DEFAULT 0,
  `title` varchar(100) NOT NULL DEFAULT '',
  `message` varchar(500) NOT NULL DEFAULT '',
  `notification_type` int(1) NOT NULL DEFAULT 1,
  `status` int(1) NOT NULL DEFAULT 1,
  `is_read` int(1) NOT NULL DEFAULT 1 COMMENT '1 = new, 2 = read',
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `notification_detail`
--

INSERT INTO `notification_detail` (`notification_id`, `user_id`, `ref_id`, `title`, `message`, `notification_type`, `status`, `is_read`, `created_date`, `modify_date`) VALUES
(1, 2, 2, 'Order Accepted', 'your order #2 accepted.', 2, 1, 1, '2023-08-12 10:35:43', '2023-08-12 10:35:43'),
(2, 2, 2, 'Order Accepted', 'your order #2 accepted.', 2, 1, 1, '2023-08-12 10:36:02', '2023-08-12 10:36:02'),
(3, 2, 3, 'Order Delivered', 'your order #3 delivered.', 2, 1, 1, '2023-08-12 10:36:34', '2023-08-12 10:36:34'),
(4, 2, 3, 'Order Delivered', 'your order #3 delivered.', 2, 1, 1, '2023-08-12 10:37:29', '2023-08-12 10:37:29'),
(5, 2, 2, 'Order Delivered', 'your order #2 delivered.', 2, 1, 1, '2023-08-12 10:38:17', '2023-08-12 10:38:17');

-- --------------------------------------------------------

--
-- Table structure for table `nutrition_detail`
--

CREATE TABLE `nutrition_detail` (
  `nutrition_id` int(11) NOT NULL,
  `prod_id` int(11) NOT NULL DEFAULT 0,
  `nutrition_name` varchar(120) NOT NULL DEFAULT '',
  `nutrition_value` varchar(50) NOT NULL DEFAULT '',
  `status` int(1) NOT NULL DEFAULT 1,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `nutrition_detail`
--

INSERT INTO `nutrition_detail` (`nutrition_id`, `prod_id`, `nutrition_name`, `nutrition_value`, `status`, `created_date`, `modify_date`) VALUES
(1, 4, 'Calories', '104', 1, '2023-07-27 15:43:18', '2023-07-27 15:43:18'),
(2, 4, 'Fat', '0.3g', 1, '2023-07-27 15:43:18', '2023-07-27 15:43:18'),
(3, 4, 'Sodium', '3mg', 2, '2023-07-27 16:06:59', '2023-07-27 16:09:58'),
(4, 5, 'Calories', '89', 1, '2023-07-31 09:47:35', '2023-07-31 09:47:35'),
(5, 5, 'Fat', '0.3g', 1, '2023-07-31 09:47:35', '2023-07-31 09:47:35'),
(6, 5, 'Water', '75%', 1, '2023-07-31 09:47:35', '2023-07-31 09:47:35'),
(7, 5, 'Protein', '1.1g', 1, '2023-07-31 09:47:35', '2023-07-31 09:47:35'),
(8, 5, 'Carbs', '22.8g', 1, '2023-07-31 09:47:35', '2023-07-31 09:47:35'),
(9, 5, 'Sugar', '12.2g', 1, '2023-07-31 09:47:35', '2023-07-31 09:47:35'),
(10, 5, 'Fiber', '2.6g', 1, '2023-07-31 09:47:35', '2023-07-31 09:47:35'),
(11, 6, 'Calories', '94.6', 1, '2023-07-31 09:51:36', '2023-07-31 09:51:36'),
(12, 6, 'Fat', '0.3g', 1, '2023-07-31 09:51:36', '2023-07-31 09:51:36'),
(13, 6, 'Water', '156g', 1, '2023-07-31 09:51:36', '2023-07-31 09:51:36'),
(14, 6, 'Protein', '0.43g', 1, '2023-07-31 09:51:36', '2023-07-31 09:51:36'),
(15, 6, 'Carbs', '25.1g', 1, '2023-07-31 09:51:36', '2023-07-31 09:51:36'),
(16, 6, 'Sugar', '18.9g', 1, '2023-07-31 09:51:36', '2023-07-31 09:51:36'),
(17, 6, 'Fiber', '4.37g', 1, '2023-07-31 09:51:36', '2023-07-31 09:51:36'),
(18, 7, 'Calories', '66.6', 1, '2023-07-31 09:58:17', '2023-07-31 09:58:17'),
(19, 7, 'Fat', '0.2g', 1, '2023-07-31 09:58:17', '2023-07-31 09:58:17'),
(20, 7, 'Water', '86%', 1, '2023-07-31 09:58:17', '2023-07-31 09:58:17'),
(21, 7, 'Protein', '1.3g', 1, '2023-07-31 09:58:17', '2023-07-31 09:58:17'),
(22, 7, 'Carbs', '14.8g', 1, '2023-07-31 09:58:17', '2023-07-31 09:58:17'),
(23, 7, 'Sugar', '12g', 1, '2023-07-31 09:58:17', '2023-07-31 09:58:17'),
(24, 7, 'Fiber', '0.2g', 1, '2023-07-31 09:58:17', '2023-07-31 09:58:17'),
(25, 7, 'Vitamin C', '92% of the Daily Value (DV)', 1, '2023-07-31 09:58:17', '2023-07-31 09:58:17'),
(26, 7, 'Folate', '9% of the DV', 1, '2023-07-31 09:58:17', '2023-07-31 09:58:17'),
(27, 7, 'Calcium', '5% of the DV', 1, '2023-07-31 09:58:17', '2023-07-31 09:58:17'),
(28, 7, 'Potassium', '5% of the DV', 1, '2023-07-31 09:58:17', '2023-07-31 09:58:17'),
(29, 8, 'Calories', '217', 1, '2023-07-31 10:10:09', '2023-07-31 10:10:09'),
(30, 8, 'Fat', '11.8g', 1, '2023-07-31 10:10:09', '2023-07-31 10:10:09'),
(31, 8, 'Water', '61%', 1, '2023-07-31 10:10:09', '2023-07-31 10:10:09'),
(32, 8, 'Protein', '26.1g', 1, '2023-07-31 10:10:09', '2023-07-31 10:10:09'),
(33, 8, 'Carbs', '0g', 1, '2023-07-31 10:10:09', '2023-07-31 10:10:09'),
(34, 8, 'Sugar', '0g', 1, '2023-07-31 10:10:09', '2023-07-31 10:10:09'),
(35, 8, 'Fiber', '0g', 1, '2023-07-31 10:10:09', '2023-07-31 10:10:09'),
(36, 9, 'Calories', '284', 1, '2023-07-31 10:11:55', '2023-07-31 10:11:55'),
(37, 9, 'Fat', '6.2g', 1, '2023-07-31 10:11:55', '2023-07-31 10:11:55'),
(38, 9, 'Water', '61%', 1, '2023-07-31 10:11:55', '2023-07-31 10:11:55'),
(39, 9, 'Protein', '53.4g', 1, '2023-07-31 10:11:55', '2023-07-31 10:11:55'),
(40, 9, 'Carbs', '0g', 1, '2023-07-31 10:11:55', '2023-07-31 10:11:55'),
(41, 9, 'Sugar', '0g', 1, '2023-07-31 10:11:55', '2023-07-31 10:11:55'),
(42, 9, 'Fiber', '0g', 1, '2023-07-31 10:11:55', '2023-07-31 10:11:55'),
(43, 10, 'Calories', '31', 1, '2023-07-31 10:14:09', '2023-07-31 10:14:09'),
(44, 10, 'Fat', '0.3g', 1, '2023-07-31 10:14:09', '2023-07-31 10:14:09'),
(45, 10, 'Water', '92%', 1, '2023-07-31 10:14:09', '2023-07-31 10:14:09'),
(46, 10, 'Protein', '1g', 1, '2023-07-31 10:14:09', '2023-07-31 10:14:09'),
(47, 10, 'Carbs', '6g', 1, '2023-07-31 10:14:09', '2023-07-31 10:14:09'),
(48, 10, 'Sugar', '4.2g', 1, '2023-07-31 10:14:09', '2023-07-31 10:14:09'),
(49, 10, 'Fiber', '2.1g', 1, '2023-07-31 10:14:09', '2023-07-31 10:14:09'),
(50, 11, 'Calories', '9', 1, '2023-07-31 10:18:32', '2023-07-31 10:18:32'),
(51, 11, 'Fat', '0g', 1, '2023-07-31 10:18:32', '2023-07-31 10:18:32'),
(52, 11, 'Protein', '0.2g', 1, '2023-07-31 10:18:32', '2023-07-31 10:18:32'),
(53, 11, 'Carbs', '2g', 1, '2023-07-31 10:18:32', '2023-07-31 10:18:32'),
(54, 11, 'Sugar', '0.2g', 1, '2023-07-31 10:18:32', '2023-07-31 10:18:32'),
(55, 11, 'Fiber', '0.2g', 1, '2023-07-31 10:18:32', '2023-07-31 10:18:32'),
(56, 11, 'Sodium', '1.4mg', 1, '2023-07-31 10:18:32', '2023-07-31 10:18:32'),
(57, 11, 'Magnesium', '4.7mg', 1, '2023-07-31 10:18:32', '2023-07-31 10:18:32'),
(58, 11, 'Potassium', '45.6mg', 1, '2023-07-31 10:18:32', '2023-07-31 10:18:32'),
(59, 12, 'Calories', '4.5', 1, '2023-07-31 10:22:23', '2023-07-31 10:22:23'),
(60, 12, 'Fat', '0g', 1, '2023-07-31 10:22:23', '2023-07-31 10:22:23'),
(61, 12, 'Protein', '0.2g', 1, '2023-07-31 10:22:23', '2023-07-31 10:22:23'),
(62, 12, 'Carbs', '1g', 1, '2023-07-31 10:22:23', '2023-07-31 10:22:23'),
(63, 12, 'Sugar', '0g', 1, '2023-07-31 10:22:23', '2023-07-31 10:22:23'),
(64, 12, 'Fiber', '0.1g', 1, '2023-07-31 10:22:23', '2023-07-31 10:22:23'),
(65, 12, 'Sodium', '0.5mg', 1, '2023-07-31 10:22:23', '2023-07-31 10:22:23'),
(66, 12, 'Zinc', '0.04mg', 1, '2023-07-31 10:22:23', '2023-07-31 10:22:23');

-- --------------------------------------------------------

--
-- Table structure for table `offer_detail`
--

CREATE TABLE `offer_detail` (
  `offer_id` int(11) NOT NULL,
  `prod_id` int(11) NOT NULL DEFAULT 0,
  `price` double NOT NULL DEFAULT 0,
  `start_date` datetime NOT NULL DEFAULT current_timestamp(),
  `end_date` datetime NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL DEFAULT 1,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `offer_detail`
--

INSERT INTO `offer_detail` (`offer_id`, `prod_id`, `price`, `start_date`, `end_date`, `status`, `created_date`, `modify_date`) VALUES
(1, 5, 2.49, '2023-07-31 00:00:00', '2023-08-30 00:00:00', 1, '2023-07-31 10:58:27', '2023-07-31 10:59:54'),
(2, 6, 1.49, '2023-07-31 00:00:00', '2023-08-30 00:00:00', 1, '2023-07-31 10:59:08', '2023-07-31 10:59:08');

-- --------------------------------------------------------

--
-- Table structure for table `order_detail`
--

CREATE TABLE `order_detail` (
  `order_id` int(11) NOT NULL,
  `cart_id` varchar(500) NOT NULL DEFAULT '' COMMENT '1,2,3,4,5',
  `user_id` int(11) NOT NULL DEFAULT 0,
  `address_id` int(11) NOT NULL DEFAULT 0,
  `total_price` double NOT NULL DEFAULT 0,
  `user_pay_price` double NOT NULL DEFAULT 0,
  `discount_price` double NOT NULL DEFAULT 0,
  `deliver_price` double NOT NULL DEFAULT 0,
  `promo_code_id` varchar(20) NOT NULL DEFAULT '',
  `deliver_type` int(1) NOT NULL DEFAULT 1 COMMENT '1: Deliver, 2: Collection',
  `payment_type` int(1) NOT NULL DEFAULT 1 COMMENT '1: COD, 2: Online',
  `payment_status` int(1) NOT NULL DEFAULT 1 COMMENT '1: waiting, 2: done, 3: fail, 4: refund',
  `order_status` int(1) NOT NULL DEFAULT 1 COMMENT '1: new, 2: order_accept, 3: order_delivered, 4: cancel, 5: order declined',
  `status` int(1) NOT NULL DEFAULT 1,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order_detail`
--

INSERT INTO `order_detail` (`order_id`, `cart_id`, `user_id`, `address_id`, `total_price`, `user_pay_price`, `discount_price`, `deliver_price`, `promo_code_id`, `deliver_type`, `payment_type`, `payment_status`, `order_status`, `status`, `created_date`, `modify_date`) VALUES
(2, '18', 2, 2, 2.49, 4.2410000000000005, 0.24900000000000003, 2, '1', 1, 1, 1, 3, 1, '2023-08-10 10:22:46', '2023-08-12 10:38:17'),
(3, '18', 2, 2, 2.49, 4.2410000000000005, 0.24900000000000003, 2, '1', 1, 1, 1, 3, 1, '2023-08-10 10:26:51', '2023-08-12 10:37:29'),
(4, '22,23', 2, 2, 10.450000000000001, 11.405000000000001, 1.0450000000000002, 2, '1', 1, 2, 2, 1, 1, '2023-08-10 10:39:14', '2023-08-10 10:43:38'),
(5, '24,25', 2, 1, 3.9800000000000004, 5.582000000000001, 0.3980000000000001, 2, '1', 1, 2, 1, 1, 1, '2023-08-10 19:23:38', '2023-08-10 19:23:38'),
(6, '26,27,28', 2, 1, 5.470000000000001, 6.923000000000001, 0.547, 2, '1', 1, 1, 1, 1, 1, '2023-08-10 19:25:02', '2023-08-10 19:25:02'),
(7, '29', 2, 1, 2.49, 4.49, 0, 2, '', 1, 1, 1, 1, 1, '2023-08-10 19:28:26', '2023-08-10 19:28:26'),
(8, '30', 2, 1, 2.49, 4.49, 0, 2, '', 1, 1, 1, 1, 1, '2023-08-10 19:29:26', '2023-08-10 19:29:26'),
(9, '31', 2, 1, 2.49, 4.2410000000000005, 0.24900000000000003, 2, '1', 1, 1, 1, 1, 1, '2023-08-10 19:32:02', '2023-08-10 19:32:02'),
(10, '32', 2, 1, 2.49, 4.49, 0, 2, '', 1, 1, 1, 1, 1, '2023-08-10 19:34:55', '2023-08-10 19:34:55'),
(11, '33,34,35', 2, 1, 8.950000000000001, 10.055000000000001, 0.8950000000000001, 2, '1', 1, 1, 1, 1, 1, '2023-08-10 19:41:14', '2023-08-10 19:41:14');

-- --------------------------------------------------------

--
-- Table structure for table `order_payment_detail`
--

CREATE TABLE `order_payment_detail` (
  `transaction_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `transaction_payload` varchar(5000) NOT NULL DEFAULT '',
  `payment_transaction_id` varchar(100) NOT NULL DEFAULT '',
  `status` int(11) NOT NULL DEFAULT 1,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order_payment_detail`
--

INSERT INTO `order_payment_detail` (`transaction_id`, `order_id`, `transaction_payload`, `payment_transaction_id`, `status`, `created_date`, `modify_date`) VALUES
(1, 4, '{\"status\":\"1\",\"payment_transaction_id\":\"2122312312313\" }', '2122312312313', 1, '2023-08-10 10:41:55', '2023-08-10 10:41:55'),
(2, 4, '{\"status\":\"1\",\"payment_transaction_id\":\"2122312312313\" }', '2122312312313', 1, '2023-08-10 10:42:48', '2023-08-10 10:42:48'),
(3, 4, '{\"status\":\"1\",\"payment_transaction_id\":\"2122312312313\" }', '2122312312313', 1, '2023-08-10 10:43:38', '2023-08-10 10:43:38');

-- --------------------------------------------------------

--
-- Table structure for table `payment_method_detail`
--

CREATE TABLE `payment_method_detail` (
  `pay_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL DEFAULT '',
  `card_number` varchar(50) NOT NULL DEFAULT '',
  `card_month` varchar(3) NOT NULL DEFAULT '',
  `card_year` varchar(5) NOT NULL DEFAULT '',
  `status` int(1) NOT NULL DEFAULT 1,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment_method_detail`
--

INSERT INTO `payment_method_detail` (`pay_id`, `user_id`, `name`, `card_number`, `card_month`, `card_year`, `status`, `created_date`, `modify_date`) VALUES
(1, 2, 'Card1', '4242424242424242', '12', '28', 1, '2023-08-09 10:10:43', '2023-08-09 10:10:43'),
(2, 2, 'Card1', '4242424242424243', '12', '28', 1, '2023-08-09 10:11:55', '2023-08-09 10:11:55'),
(3, 2, 'Ca', '4242424242424242', '08', '2025', 1, '2023-08-09 20:58:35', '2023-08-09 20:58:35');

-- --------------------------------------------------------

--
-- Table structure for table `product_detail`
--

CREATE TABLE `product_detail` (
  `prod_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL DEFAULT 0,
  `brand_id` int(11) NOT NULL DEFAULT 0,
  `type_id` int(11) NOT NULL DEFAULT 0,
  `name` varchar(200) NOT NULL DEFAULT '',
  `detail` varchar(5000) NOT NULL DEFAULT '',
  `unit_name` varchar(50) NOT NULL DEFAULT '',
  `unit_value` varchar(20) NOT NULL DEFAULT '',
  `nutrition_weight` varchar(20) NOT NULL DEFAULT '100g',
  `price` double NOT NULL DEFAULT 0,
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '1: active, 2: delete',
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product_detail`
--

INSERT INTO `product_detail` (`prod_id`, `cat_id`, `brand_id`, `type_id`, `name`, `detail`, `unit_name`, `unit_value`, `nutrition_weight`, `price`, `status`, `created_date`, `modify_date`) VALUES
(5, 1, 1, 1, 'Organic Banana', 'banana, fruit of the genus Musa, of the family Musaceae, one of the most important fruit crops of the world. The banana is grown in the tropics, and, though it is most widely consumed in those regions, it is valued worldwide for its flavour, nutritional value, and availability throughout the year', 'pcs', '7', '200g', 2.99, 1, '2023-07-31 09:47:35', '2023-07-31 09:47:35'),
(6, 1, 1, 1, 'Red Apple', 'Apples contain key nutrients, including fiber and antioxidants. They may offer health benefits, including lowering blood sugar levels and benefitting heart health.', 'kg', '1', '182g', 1.99, 1, '2023-07-31 09:51:36', '2023-07-31 09:51:36'),
(7, 1, 1, 1, 'Oranges', 'Many types of oranges are high in fiber and beneficial vitamins, like vitamin C. They also contain antioxidants which can have various health benefits, including supporting immune function.', 'kg', '1', '140g', 0.99, 1, '2023-07-31 09:58:17', '2023-07-31 09:58:17'),
(8, 3, 1, 1, 'Beef Bone', 'When consumed in moderation, beef can improve muscle growth and maintenance. It’s also rich in iron and zinc. But high consumption of beef has been linked to an increased risk for heart disease and cancer.', 'kg', '1', '100g', 3.99, 1, '2023-07-31 10:10:09', '2023-07-31 10:10:09'),
(9, 3, 1, 1, 'Broiler Chicken', 'When consumed in moderation, beef can improve muscle growth and maintenance. It’s also rich in iron and zinc. But high consumption of beef has been linked to an increased risk for heart disease and cancer.', 'kg', '1', '100g', 3.99, 1, '2023-07-31 10:11:55', '2023-07-31 10:11:55'),
(10, 1, 1, 1, 'Bell Peppers', 'Bell peppers (Capsicum annuum) are fruits that belong to the nightshade family. They are low in calories and rich in vitamin C and other antioxidants, making them an excellent addition to a healthy diet.', 'gm', '250', '100g', 1.99, 1, '2023-07-31 10:14:09', '2023-07-31 10:14:09'),
(11, 1, 1, 1, 'Ginger', 'Ginger may have numerous health benefits due to its anti-inflammatory, anti-nausea, and other properties. It may help you lose weight, manage arthritis, reduce menstrual symptoms, and more.', 'gm', '250', '11g', 2.99, 1, '2023-07-31 10:18:32', '2023-07-31 10:18:32');

-- --------------------------------------------------------

--
-- Table structure for table `promo_code_detail`
--

CREATE TABLE `promo_code_detail` (
  `promo_code_id` int(11) NOT NULL,
  `code` varchar(20) NOT NULL DEFAULT '',
  `title` varchar(200) NOT NULL DEFAULT '',
  `description` varchar(5000) NOT NULL DEFAULT '',
  `type` int(1) NOT NULL DEFAULT 1 COMMENT '1 = Per% , 2 = Fix Amount',
  `min_order_amount` double NOT NULL DEFAULT 0,
  `max_discount_amount` double NOT NULL DEFAULT 500,
  `offer_price` decimal(10,0) NOT NULL DEFAULT 0,
  `start_date` datetime NOT NULL DEFAULT current_timestamp(),
  `end_date` datetime NOT NULL DEFAULT current_timestamp(),
  `status` int(1) NOT NULL DEFAULT 1,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `promo_code_detail`
--

INSERT INTO `promo_code_detail` (`promo_code_id`, `code`, `title`, `description`, `type`, `min_order_amount`, `max_discount_amount`, `offer_price`, `start_date`, `end_date`, `status`, `created_date`, `modify_date`) VALUES
(1, 'CGREFILL', 'UPTO 90% OFF', 'Now Explore Premium Dry Fruits & Nuts At Happilo. Flat 34% Off On Order. No Minimum Purchase Criteria. Explore Various Types Of Nuts, Dried Fruits, Seeds, Berries, Family Packs, Combos And More Starting From Rs.99 Only. Just Click On the Link And Visit The Offer Page To Explore More', 1, 2, 50, '10', '2023-08-08 00:00:00', '2023-09-08 00:00:00', 1, '2023-08-08 08:57:31', '2023-08-08 09:16:31'),
(2, 'ADREFILL', 'UPTO 50% OFF', 'Now Explore Premium Dry Fruits & Nuts At Happilo. Flat 34% Off On Order. No Minimum Purchase Criteria. Explore Various Types Of Nuts, Dried Fruits, Seeds, Berries, Family Packs, Combos And More Starting From Rs.99 Only. Just Click On the Link And Visit The Offer Page To Explore More', 1, 10, 50, '10', '2023-08-08 00:00:00', '2023-09-08 00:00:00', 1, '2023-08-08 08:57:31', '2023-08-08 09:16:31');

-- --------------------------------------------------------

--
-- Table structure for table `review_detail`
--

CREATE TABLE `review_detail` (
  `review_id` int(11) NOT NULL,
  `prod_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `rate` varchar(5) NOT NULL DEFAULT '',
  `message` varchar(1000) NOT NULL DEFAULT '',
  `status` int(1) NOT NULL DEFAULT 1,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `type_detail`
--

CREATE TABLE `type_detail` (
  `type_id` int(11) NOT NULL,
  `type_name` varchar(100) NOT NULL DEFAULT '',
  `image` varchar(75) NOT NULL DEFAULT '',
  `color` varchar(8) NOT NULL DEFAULT '000000',
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '1 = active, 2 =delete',
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `type_detail`
--

INSERT INTO `type_detail` (`type_id`, `type_name`, `image`, `color`, `status`, `created_date`, `modify_date`) VALUES
(1, 'Pulses', 'type/202307261610181018aVOpgmY1W1.png', 'F8A44C', 1, '2023-07-26 16:10:18', '2023-07-26 16:12:39'),
(2, 'Pulses', 'type/202307310959535953siLWeCJ71I.png', 'F8A44C', 2, '2023-07-31 09:59:53', '2023-07-31 09:59:53'),
(3, 'Rice', 'type/202307311000160168a0737aEiC.png', '53B175', 1, '2023-07-31 10:00:16', '2023-07-31 10:00:16');

-- --------------------------------------------------------

--
-- Table structure for table `user_detail`
--

CREATE TABLE `user_detail` (
  `user_id` int(11) NOT NULL,
  `username` varchar(75) NOT NULL DEFAULT '',
  `user_type` int(1) NOT NULL DEFAULT 1 COMMENT '1= user , 2 = admin',
  `name` varchar(100) NOT NULL DEFAULT '',
  `email` varchar(100) NOT NULL DEFAULT '',
  `mobile` varchar(15) NOT NULL DEFAULT '',
  `mobile_code` varchar(6) NOT NULL DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '',
  `area_id` int(11) NOT NULL DEFAULT 0,
  `auth_token` varchar(100) NOT NULL DEFAULT '',
  `dervice_token` varchar(150) NOT NULL DEFAULT '',
  `reset_code` varchar(6) NOT NULL DEFAULT '0000',
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '1: active, 2 = delete',
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_detail`
--

INSERT INTO `user_detail` (`user_id`, `username`, `user_type`, `name`, `email`, `mobile`, `mobile_code`, `password`, `area_id`, `auth_token`, `dervice_token`, `reset_code`, `status`, `created_date`, `modify_date`) VALUES
(1, 'admin', 2, 'admin', 'admin@admin.com', '', '', '', 0, 'L3ROzNF2KBvQ07o0D4qi', '', '0000', 1, '2023-07-26 14:57:59', '2023-07-26 14:57:59'),
(2, 'testuser', 1, '', 'test@gmail.com', '', '', '123456', 0, 'leu2kpOaiwHeFVS5EKKo', '', '0000', 1, '2023-07-25 10:57:32', '2023-08-10 10:49:49'),
(5, 'User1', 1, '', 'user1@gmail.com', '', '', '123456', 0, 'pJYFk5XGrCrGZl92K5qu', '', '0000', 1, '2023-07-29 16:55:36', '2023-07-29 16:55:36'),
(6, 'user1', 1, '', 'user2@gmail.com', '', '', '123456', 0, 'g0mtdJJqF9Xn7iDjQmNN', '', '0000', 1, '2023-08-02 11:01:46', '2023-08-02 11:01:46'),
(7, 'user6', 1, '', 'test7@gmail.com', '', '', '123456', 0, 'hNytj5vmrr9DmzaSXsyw', '', '0000', 1, '2023-08-02 11:33:19', '2023-08-06 23:42:01');

-- --------------------------------------------------------

--
-- Table structure for table `zone_detail`
--

CREATE TABLE `zone_detail` (
  `zone_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `status` int(1) NOT NULL DEFAULT 1,
  `created_date` datetime NOT NULL DEFAULT current_timestamp(),
  `modify_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `zone_detail`
--

INSERT INTO `zone_detail` (`zone_id`, `name`, `status`, `created_date`, `modify_date`) VALUES
(1, 'Zone 1', 1, '2023-07-28 16:22:28', '2023-07-28 16:24:16'),
(2, 'Zone 2', 1, '2023-07-28 16:22:34', '2023-07-28 16:22:34');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address_detail`
--
ALTER TABLE `address_detail`
  ADD PRIMARY KEY (`address_id`);

--
-- Indexes for table `area_detail`
--
ALTER TABLE `area_detail`
  ADD PRIMARY KEY (`area_id`);

--
-- Indexes for table `brand_detail`
--
ALTER TABLE `brand_detail`
  ADD PRIMARY KEY (`brand_id`);

--
-- Indexes for table `cart_detail`
--
ALTER TABLE `cart_detail`
  ADD PRIMARY KEY (`cart_id`);

--
-- Indexes for table `category_detail`
--
ALTER TABLE `category_detail`
  ADD PRIMARY KEY (`cat_id`);

--
-- Indexes for table `favorite_detail`
--
ALTER TABLE `favorite_detail`
  ADD PRIMARY KEY (`fav_id`);

--
-- Indexes for table `image_detail`
--
ALTER TABLE `image_detail`
  ADD PRIMARY KEY (`img_id`);

--
-- Indexes for table `notification_detail`
--
ALTER TABLE `notification_detail`
  ADD PRIMARY KEY (`notification_id`);

--
-- Indexes for table `nutrition_detail`
--
ALTER TABLE `nutrition_detail`
  ADD PRIMARY KEY (`nutrition_id`);

--
-- Indexes for table `offer_detail`
--
ALTER TABLE `offer_detail`
  ADD PRIMARY KEY (`offer_id`);

--
-- Indexes for table `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`order_id`);

--
-- Indexes for table `order_payment_detail`
--
ALTER TABLE `order_payment_detail`
  ADD PRIMARY KEY (`transaction_id`);

--
-- Indexes for table `payment_method_detail`
--
ALTER TABLE `payment_method_detail`
  ADD PRIMARY KEY (`pay_id`);

--
-- Indexes for table `product_detail`
--
ALTER TABLE `product_detail`
  ADD PRIMARY KEY (`prod_id`);

--
-- Indexes for table `promo_code_detail`
--
ALTER TABLE `promo_code_detail`
  ADD PRIMARY KEY (`promo_code_id`);

--
-- Indexes for table `review_detail`
--
ALTER TABLE `review_detail`
  ADD PRIMARY KEY (`review_id`);

--
-- Indexes for table `type_detail`
--
ALTER TABLE `type_detail`
  ADD PRIMARY KEY (`type_id`);

--
-- Indexes for table `user_detail`
--
ALTER TABLE `user_detail`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `zone_detail`
--
ALTER TABLE `zone_detail`
  ADD PRIMARY KEY (`zone_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address_detail`
--
ALTER TABLE `address_detail`
  MODIFY `address_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `area_detail`
--
ALTER TABLE `area_detail`
  MODIFY `area_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `brand_detail`
--
ALTER TABLE `brand_detail`
  MODIFY `brand_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cart_detail`
--
ALTER TABLE `cart_detail`
  MODIFY `cart_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `category_detail`
--
ALTER TABLE `category_detail`
  MODIFY `cat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `favorite_detail`
--
ALTER TABLE `favorite_detail`
  MODIFY `fav_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `image_detail`
--
ALTER TABLE `image_detail`
  MODIFY `img_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `notification_detail`
--
ALTER TABLE `notification_detail`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `nutrition_detail`
--
ALTER TABLE `nutrition_detail`
  MODIFY `nutrition_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;

--
-- AUTO_INCREMENT for table `offer_detail`
--
ALTER TABLE `offer_detail`
  MODIFY `offer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `order_payment_detail`
--
ALTER TABLE `order_payment_detail`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `payment_method_detail`
--
ALTER TABLE `payment_method_detail`
  MODIFY `pay_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `product_detail`
--
ALTER TABLE `product_detail`
  MODIFY `prod_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `promo_code_detail`
--
ALTER TABLE `promo_code_detail`
  MODIFY `promo_code_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `review_detail`
--
ALTER TABLE `review_detail`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `type_detail`
--
ALTER TABLE `type_detail`
  MODIFY `type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user_detail`
--
ALTER TABLE `user_detail`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `zone_detail`
--
ALTER TABLE `zone_detail`
  MODIFY `zone_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
