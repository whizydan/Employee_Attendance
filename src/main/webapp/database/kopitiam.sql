-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 30, 2023 at 05:10 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kopitiam`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `name` varchar(300) NOT NULL,
  `password` varchar(300) NOT NULL,
  `email` varchar(70) NOT NULL,
  `role` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_on` varchar(100) NOT NULL,
  `photo` varchar(200) NOT NULL DEFAULT 'person.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `name`, `password`, `email`, `role`, `status`, `created_on`, `photo`) VALUES
(1, 'james mayor', 'touchdown', 'james@gmail.com', 0, 0, '11-12-2023', 'person.png');

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `id` int(11) NOT NULL,
  `date` varchar(50) NOT NULL,
  `confidence_score` varchar(100) NOT NULL,
  `staffId` varchar(5) NOT NULL,
  `clock` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `attendance`
--

INSERT INTO `attendance` (`id`, `date`, `confidence_score`, `staffId`, `clock`) VALUES
(35, 'Thu 30 Nov 2023, 06:14:27', '77.0258159019428', '17', 'in'),
(36, 'Thu 30 Nov 2023, 06:14:39', '80.1338945591759', '17', 'out'),
(37, 'Thu 30 Nov 2023, 06:14:51', '75.51787744726838', '18', 'in'),
(38, 'Thu 30 Nov 2023, 06:15:03', '85.15848293694106', '18', 'out'),
(39, 'Thu 30 Nov 2023, 06:15:18', '67.06262583403048', '19', 'in'),
(40, 'Thu 30 Nov 2023, 06:28:04', '64.91170489328354', '17', 'in'),
(41, 'Thu 30 Nov 2023, 06:28:16', '80.04388419571822', '17', 'out'),
(42, 'Thu 30 Nov 2023, 06:28:26', '97.85834222054325', '18', 'in'),
(43, 'Thu 30 Nov 2023, 06:28:38', '73.91882542458276', '18', 'out');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `code` varchar(30) NOT NULL,
  `description` text NOT NULL,
  `added_by` varchar(30) NOT NULL,
  `name` varchar(70) NOT NULL,
  `photo` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `code`, `description`, `added_by`, `name`, `photo`) VALUES
(10, 'DO65', 'These are items that are baked or fried with dough', 'james@gmail.com', 'Dough Products', 'pngwing.com.png'),
(11, 'DD45', 'These are items which are beverages', 'james@gmail.com', 'Drinks', 'pngwing.com (2).png');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `productId` varchar(10) NOT NULL,
  `vendorId` varchar(10) NOT NULL,
  `quantity` int(11) NOT NULL,
  `date` varchar(30) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `productId`, `vendorId`, `quantity`, `date`, `price`) VALUES
(8, 'null', '3', 20, '25-11-2023', 0);

-- --------------------------------------------------------

--
-- Table structure for table `payment_modes`
--

CREATE TABLE `payment_modes` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(70) NOT NULL,
  `code` varchar(15) NOT NULL,
  `brand` varchar(50) NOT NULL,
  `category` varchar(20) NOT NULL,
  `expiry` varchar(20) NOT NULL,
  `photo` text NOT NULL,
  `price` int(11) NOT NULL,
  `vendor` varchar(30) NOT NULL,
  `unit` varchar(20) NOT NULL,
  `quantity` int(30) NOT NULL,
  `added_by` varchar(30) NOT NULL,
  `sub_category` varchar(30) NOT NULL,
  `tax` int(11) NOT NULL,
  `status` varchar(30) NOT NULL,
  `description` text NOT NULL,
  `date` varchar(30) NOT NULL,
  `discount` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `code`, `brand`, `category`, `expiry`, `photo`, `price`, `vendor`, `unit`, `quantity`, `added_by`, `sub_category`, `tax`, `status`, `description`, `date`, `discount`) VALUES
(8, 'Pizza', 'PIZZA202312', 'Cheese toppings', 'Dough Products', '2023-11-29', 'pngwing.com.png', 200, 'Gannerx Traders', '1', 120, 'james@gmail.com', 'null', 2, 'Live', 'The best pizza with excellent cheese toppings.', 'Thu 30 Nov 2023, 06:22:55', '0%'),
(9, 'Burger', 'BUG202365', 'Beef Burger', 'Dough Products', '2023-11-30', 'pngwing.com (4).png', 150, 'Gannerx Traders', '1', 118, 'james@gmail.com', 'null', 2, 'Live', 'King size burger with 2 beef sices and 3 buns', 'Thu 30 Nov 2023, 06:25:15', '0%');

-- --------------------------------------------------------

--
-- Table structure for table `salary`
--

CREATE TABLE `salary` (
  `id` int(11) NOT NULL,
  `staff_id` varchar(20) NOT NULL,
  `factor` varchar(20) NOT NULL,
  `salary` int(11) NOT NULL,
  `set_salary` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `salary`
--

INSERT INTO `salary` (`id`, `staff_id`, `factor`, `salary`, `set_salary`) VALUES
(11, '17', '8', 5, 0),
(12, '18', '8', 15, 0);

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(11) NOT NULL,
  `customer_name` varchar(70) DEFAULT NULL,
  `date` varchar(70) NOT NULL,
  `ref_code` varchar(30) NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'completed',
  `total_price` int(11) NOT NULL,
  `biller` varchar(20) NOT NULL,
  `products` varchar(300) NOT NULL,
  `payment_type` varchar(30) NOT NULL,
  `description` text NOT NULL,
  `completed` varchar(10) NOT NULL DEFAULT '0',
  `qty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `customer_name`, `date`, `ref_code`, `status`, `total_price`, `biller`, `products`, `payment_type`, `description`, `completed`, `qty`) VALUES
(9, NULL, 'Thu 30 Nov 2023, 06:26:49', 'RF235', 'completed', 300, 'james@gmail.com', '9', 'Visa or Debit', '2 beef burgers', '0', 120);

-- --------------------------------------------------------

--
-- Table structure for table `sub_category`
--

CREATE TABLE `sub_category` (
  `id` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  `description` text NOT NULL,
  `added_by` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sub_category`
--

INSERT INTO `sub_category` (`id`, `name`, `description`, `added_by`) VALUES
(8, 'Hot Drinks', 'Beverages like tea and poridge', 'james@gmail.com'),
(9, 'Food', 'Snack or complete solid meal', 'james@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(300) NOT NULL,
  `password` varchar(300) NOT NULL,
  `email` varchar(70) NOT NULL,
  `role` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_on` varchar(100) NOT NULL,
  `photo` text NOT NULL DEFAULT 'person.png',
  `position` varchar(50) NOT NULL DEFAULT 'Staff'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `password`, `email`, `role`, `status`, `created_on`, `photo`, `position`) VALUES
(17, 'John Wayne', '123', 'john@gmail.com', 1, 0, '29-11-2023', 'john.jpg', 'Staff member'),
(18, 'Jane mayors', '123', 'janemayors@yahoo.com', 1, 0, '08-11-2023', 'jane.jpg', 'Leads manager'),
(19, 'Jameson Wanga', '123', 'jameswanga@hotmail.com', 1, 0, '01-11-2023', 'james.jpg', 'Store keeper'),
(20, 'Bruce Wayne', '123', 'brucewayne@gmail.com', 1, 0, '22-11-2023', 'bruce.jpg', 'Staff');

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `id` int(11) NOT NULL,
  `name` varchar(300) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(70) NOT NULL,
  `country` varchar(70) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`id`, `name`, `phone`, `email`, `country`) VALUES
(3, 'Gannerx Traders', '0793141369', 'support@gannerex.com', 'Malysia'),
(4, 'Mali Works', '0723131369', 'mali@yahoo.com', 'Malaysia'),
(5, 'Clover king limited', '076543123', 'suppliers@cloverking.com', 'China');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_modes`
--
ALTER TABLE `payment_modes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `salary`
--
ALTER TABLE `salary`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `staff_id` (`staff_id`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sub_category`
--
ALTER TABLE `sub_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `payment_modes`
--
ALTER TABLE `payment_modes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `salary`
--
ALTER TABLE `salary`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `sub_category`
--
ALTER TABLE `sub_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
