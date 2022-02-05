-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 27, 2021 at 08:23 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `projectdb`
--
CREATE DATABASE IF NOT EXISTS `projectdb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `projectdb`;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`username`, `password`) VALUES
('user', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `advertisement`
--

CREATE TABLE `advertisement` (
  `ad_id` varchar(10) NOT NULL,
  `published_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `title` varchar(32) NOT NULL,
  `location` varchar(15) NOT NULL,
  `description` varchar(150) NOT NULL,
  `property_area` int(11) NOT NULL,
  `rent` double NOT NULL,
  `username` varchar(20) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `advertisement`
--

INSERT INTO `advertisement` (`ad_id`, `published_date`, `title`, `location`, `description`, `property_area`, `rent`, `username`, `status`) VALUES
('H-00000001', '2021-10-25 17:31:38', 'Luxrury house for rent', 'Rambukkana', 'House fully completed\r\nHas air condition\r\nsurrounded by walls', 17200, 30000, 'fazal005', 1),
('H-00000002', '2021-10-25 17:31:52', 'normal house', 'Mawanella', 'Near to school\r\n500m from town', 15000, 30000, 'mush', 1),
('H-00000003', '2021-10-27 15:18:38', 'fdgd', 'Rambukkana', 'fdgfg', 5210, 20000, 'fazal005', 0),
('H-00000004', '2021-10-27 17:39:21', 'beautiful house', 'Akurana', 'beautifull and luxury house', 3659, 1000000, 'fazal005', 0),
('H-00000005', '2021-10-27 17:41:43', 'comfortable and feel relaxed', 'Akurana', 'Luxury finished and furnished.. best place to live', 8547, 300000, 'fazal005', 0),
('H-00000006', '2021-10-27 18:04:06', 'semi luxury 5 rooms', 'Akurana', 'semiluxury air conditioned at cheap price', 2558, 50000, 'fazal005', 0),
('H-00000007', '2021-10-27 18:20:41', 'house for rent', 'Akurana', 'best price ..affordable rent for 5 months', 325, 12000, 'fazal005', 0),
('R-00000001', '2021-10-25 17:32:15', 'room for students', 'Kegalle', '1000 thousand rupees for a month for one person in the room, two can share the room\r\nall facilities available -- water, electricity and internet free.', 100, 10000, 'sasi', 1),
('R-00000002', '2021-10-25 15:31:12', 'Room for School students', 'Mawanella', '100 feet rooms,\r\nfood provided for students\r\nmonthly 12000 per each', 100, 12000, 'fazal005', 0),
('R-00000003', '2021-10-27 17:04:07', 'ttttttttt', 'Kilinochchi', 'hjhgjmghjgjhfghdg', 255555, 40000, 'fazal005', 0),
('R-00000004', '2021-10-27 18:07:04', 'dual beds luxury', 'Ampara', 'luxurius airconditioned', 200, 3000, 'fazal005', 0),
('R-00000005', '2021-10-27 18:09:46', 'dual bed', 'Ampara', 'be relaxed ..spend the night comfortably', 900, 5000, 'fazal005', 0),
('R-00000006', '2021-10-27 18:11:16', 'airconditioned rooms', 'Ampara', 'best for couples to spend the vacation.. beach view', 300, 2000, 'fazal005', 0),
('S-00000001', '2021-10-26 17:02:00', 'shop', 'Kegalle', '1000 thousand rupees for a month for one person in the room, two can share the room\r\nall facilities available -- water, electricity and internet free.', 180, 25000, 'sadeek', 1),
('S-00000002', '2021-10-26 17:01:38', 'shop for rent', 'Rambukkana', 'long shop\r\n30 feet length\r\non the middle of the rambukkana town', 300, 30000, 'fazal005', 1),
('S-00000003', '2021-10-27 16:31:23', 'gggggg', 'Bandaragama', 'hiuhihoi', 52555, 1000, 'fazal005', 0),
('S-00000004', '2021-10-27 16:36:33', 'gggggg', 'Bandaragama', 'hiuhihoi', 52555, 1000, 'fazal005', 0),
('S-00000005', '2021-10-27 16:38:38', 'gggggg', 'Bandaragama', 'hiuhihoi', 52555, 1000, 'fazal005', 0),
('S-00000006', '2021-10-27 18:16:01', 'street shop', 'Colombo', 'best place for small business... more turnover', 325, 15000, 'fazal005', 0),
('S-00000007', '2021-10-27 18:17:24', 'two stairs building', 'Colombo', 'best for hotel or restaurant...cheaper price', 625, 30000, 'fazal005', 0),
('S-00000008', '2021-10-27 18:18:30', 'street shop', 'Colombo', 'best spot for a profitable business....', 100, 10000, 'fazal005', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ad_img`
--

CREATE TABLE `ad_img` (
  `img_id` varchar(64) NOT NULL,
  `img_path` varchar(100) NOT NULL,
  `ad_id` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ad_img`
--

INSERT INTO `ad_img` (`img_id`, `img_path`, `ad_id`) VALUES
('H-00000001-house1.jpeg', 'adImages/H-00000001-house1.jpeg', 'H-00000001'),
('H-00000001-modern house.jpeg', 'adImages/H-00000001-modern house.jpeg', 'H-00000001'),
('H-00000002-house2.jpg', 'adImages/H-00000002-house2.jpg', 'H-00000002'),
('R-00000001-room2.jpg', 'adImages/R-00000001-room2.jpg', 'R-00000001'),
('R-00000002-r2.jpg', 'adImages/R-00000002-r2.jpg', 'R-00000002'),
('R-00000002-r3.jpg', 'adImages/R-00000002-r3.jpg', 'R-00000002'),
('S-00000001-shop.jpeg', 'adImages/S-00000001-shop.jpeg', 'S-00000001'),
('S-00000001-shop2.jpeg', 'adImages/S-00000001-shop2.jpeg', 'S-00000001'),
('S-00000002-shop2.jpg', 'adImages/S-00000002-shop2.jpg', 'S-00000002'),
('H-00000003-ICT Grade 08.jpg', 'adImages/H-00000003-ICT Grade 08.jpg', 'H-00000003'),
('R-00000003-Screenshot (2).png', 'adImages/R-00000003-Screenshot (2).png', 'R-00000003'),
('H-00000004-3060214.jpg', 'adImages/H-00000004-3060214.jpg', 'H-00000004'),
('H-00000005-Different_New_Small_Luxury_House_4K_Wallpaper.jpg', 'adImages/H-00000005-Different_New_Small_Luxury_House_4K_Wallpaper.jpg', 'H-00000005'),
('H-00000006-wp2124316.jpg', 'adImages/H-00000006-wp2124316.jpg', 'H-00000006'),
('R-00000004-782754.jpg', 'adImages/R-00000004-782754.jpg', 'R-00000004'),
('R-00000005-wp6957260.jpg', 'adImages/R-00000005-wp6957260.jpg', 'R-00000005'),
('R-00000006-18-186991_hd-rooms.jpg', 'adImages/R-00000006-18-186991_hd-rooms.jpg', 'R-00000006'),
('S-00000006-photo-1537535214953-ebd2f09377e7.jpg', 'adImages/S-00000006-photo-1537535214953-ebd2f09377e7.jpg', 'S-00000006'),
('S-00000007-photo-1574236079409-f76313628df9.jpg', 'adImages/S-00000007-photo-1574236079409-f76313628df9.jpg', 'S-00000007'),
('S-00000008-10c1f64a5a57965e9fc53531d76e1e74.jpg', 'adImages/S-00000008-10c1f64a5a57965e9fc53531d76e1e74.jpg', 'S-00000008'),
('H-00000007-3434330.jpg', 'adImages/H-00000007-3434330.jpg', 'H-00000007');

-- --------------------------------------------------------

--
-- Table structure for table `house_ad`
--

CREATE TABLE `house_ad` (
  `ad_id` varchar(10) NOT NULL,
  `rooms` int(11) NOT NULL,
  `furnished_status` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `house_ad`
--

INSERT INTO `house_ad` (`ad_id`, `rooms`, `furnished_status`) VALUES
('H-00000001', 4, 'Not Furnished'),
('H-00000002', 3, 'Furnished'),
('H-00000003', 1, 'Furnished'),
('H-00000004', 5, 'Furnished'),
('H-00000005', 5, 'Furnished'),
('H-00000006', 5, 'Furnished'),
('H-00000007', 4, 'Not Furnished');

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `report` (
  `id` int(11) NOT NULL,
  `ad_id` varchar(64) NOT NULL,
  `username` varchar(32) NOT NULL,
  `detail` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `report`
--

INSERT INTO `report` (`id`, `ad_id`, `username`, `detail`) VALUES
(9, 'H-00000002', 'fazal005', 'sdcdsc'),
(10, 'R-00000001', 'fazal005', 'Telling lies'),
(11, 'S-00000001', 'fazal005', ''),
(12, 'H-00000001', 'fazal005', 'rrgrffdgdfg');

-- --------------------------------------------------------

--
-- Table structure for table `room_ad`
--

CREATE TABLE `room_ad` (
  `ad_id` varchar(10) NOT NULL,
  `beds` int(11) NOT NULL,
  `furnished_status` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `room_ad`
--

INSERT INTO `room_ad` (`ad_id`, `beds`, `furnished_status`) VALUES
('R-00000001', 2, 'Furnished'),
('R-00000002', 4, 'Furnished'),
('R-00000003', 2, 'Furnished'),
('R-00000004', 2, 'Furnished'),
('R-00000005', 3, 'Not Furnished'),
('R-00000006', 3, 'Furnished');

-- --------------------------------------------------------

--
-- Table structure for table `shop_ad`
--

CREATE TABLE `shop_ad` (
  `ad_id` varchar(10) NOT NULL,
  `dimension` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `shop_ad`
--

INSERT INTO `shop_ad` (`ad_id`, `dimension`) VALUES
('S-00000001', '10*18'),
('S-00000002', '10*30'),
('S-00000003', '10*20'),
('S-00000004', '10*20'),
('S-00000005', '10*20'),
('S-00000006', '10*20'),
('S-00000007', '60*50'),
('S-00000008', '10*15');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `username` varchar(20) NOT NULL,
  `f_name` varchar(20) NOT NULL,
  `l_name` varchar(20) NOT NULL,
  `email` varchar(30) NOT NULL,
  `phone_no` varchar(13) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`username`, `f_name`, `l_name`, `email`, `phone_no`, `password`) VALUES
('fazal005', 'fazal', 'mohamed', 'fazal@gmail.com', '078521', 'fazal1234'),
('mush', 'moh', 'mush', 'mush@gmail.com', '0123456789', 'mush1234'),
('sadeek', 'sadeek', 'ahamed', 'sadeek@yahoo.com', '1234668890', 'sadeek12'),
('sasi', 'sasi', 'kumar', 'sasi@gmail.com', '9874563210', 'sasi1234');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `advertisement`
--
ALTER TABLE `advertisement`
  ADD PRIMARY KEY (`ad_id`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `ad_img`
--
ALTER TABLE `ad_img`
  ADD KEY `ad_id` (`ad_id`);

--
-- Indexes for table `house_ad`
--
ALTER TABLE `house_ad`
  ADD PRIMARY KEY (`ad_id`);

--
-- Indexes for table `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room_ad`
--
ALTER TABLE `room_ad`
  ADD PRIMARY KEY (`ad_id`);

--
-- Indexes for table `shop_ad`
--
ALTER TABLE `shop_ad`
  ADD PRIMARY KEY (`ad_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone_no` (`phone_no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `report`
--
ALTER TABLE `report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `advertisement`
--
ALTER TABLE `advertisement`
  ADD CONSTRAINT `advertisement_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ad_img`
--
ALTER TABLE `ad_img`
  ADD CONSTRAINT `ad_img_ibfk_1` FOREIGN KEY (`ad_id`) REFERENCES `advertisement` (`ad_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `house_ad`
--
ALTER TABLE `house_ad`
  ADD CONSTRAINT `house_ad_ibfk_1` FOREIGN KEY (`ad_id`) REFERENCES `advertisement` (`ad_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `room_ad`
--
ALTER TABLE `room_ad`
  ADD CONSTRAINT `room_ad_ibfk_1` FOREIGN KEY (`ad_id`) REFERENCES `advertisement` (`ad_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `shop_ad`
--
ALTER TABLE `shop_ad`
  ADD CONSTRAINT `shop_ad_ibfk_1` FOREIGN KEY (`ad_id`) REFERENCES `advertisement` (`ad_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
