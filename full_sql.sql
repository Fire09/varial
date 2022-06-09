-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 28, 2022 at 05:38 AM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 7.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `varial`
--

-- --------------------------------------------------------

--
-- Table structure for table `boost_levels`
--

CREATE TABLE `boost_levels` (
  `id` int(11) DEFAULT NULL,
  `level` int(3) DEFAULT NULL,
  `xp` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `boost_queue`
--

CREATE TABLE `boost_queue` (
  `id` int(100) DEFAULT NULL,
  `pSrc` int(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `characters`
--

CREATE TABLE `characters` (
  `id` int(11) NOT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) NOT NULL DEFAULT 'John',
  `last_name` varchar(50) NOT NULL DEFAULT 'Doe',
  `date_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `dob` varchar(50) DEFAULT 'NULL',
  `cash` int(9) DEFAULT 500,
  `bank` int(9) NOT NULL DEFAULT 5000,
  `phone_number` varchar(15) DEFAULT NULL,
  `story` text NOT NULL,
  `new` int(1) NOT NULL DEFAULT 1,
  `deleted` int(11) NOT NULL DEFAULT 0,
  `gender` int(1) NOT NULL DEFAULT 0,
  `job` varchar(50) DEFAULT 'unemployed',
  `jail_time` int(11) NOT NULL DEFAULT 0,
  `dirty_money` int(11) NOT NULL DEFAULT 0,
  `gang_type` int(11) NOT NULL DEFAULT 0,
  `jail_time_mobster` int(11) UNSIGNED ZEROFILL NOT NULL DEFAULT 00000000000,
  `judge_type` int(11) NOT NULL DEFAULT 0,
  `iswjob` int(11) NOT NULL DEFAULT 0,
  `metaData` varchar(1520) DEFAULT '{}',
  `stress_level` int(11) DEFAULT 0,
  `bones` mediumtext DEFAULT '{}',
  `emotes` varchar(4160) DEFAULT '{}',
  `paycheck` int(11) DEFAULT 0,
  `stocks` mediumtext DEFAULT NULL,
  `rehab` int(12) DEFAULT 0,
  `meta` text DEFAULT 'move_m@casual@d',
  `dna` text DEFAULT '{}',
  `wallpaper` longtext DEFAULT NULL,
  `pp` longtext DEFAULT '',
  `policemdtinfo` longtext DEFAULT '',
  `tags` longtext DEFAULT '',
  `gallery` longtext DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `characters`
--

INSERT INTO `characters` (`id`, `owner`, `first_name`, `last_name`, `date_created`, `dob`, `cash`, `bank`, `phone_number`, `story`, `new`, `deleted`, `gender`, `job`, `jail_time`, `dirty_money`, `gang_type`, `jail_time_mobster`, `judge_type`, `iswjob`, `metaData`, `stress_level`, `bones`, `emotes`, `paycheck`, `stocks`, `rehab`, `meta`, `dna`, `wallpaper`, `pp`, `policemdtinfo`, `tags`, `gallery`) VALUES
(17, 'steam:110000134210df5', 'Test', 'test', '2022-05-28 03:35:06', '1999-08-12', 500, 5000, '2928771972', 'Default story - new char system', 1, 0, 0, 'unemployed', 0, 0, 0, 00000000000, 0, 0, '{\"thirst\":100,\"health\":200,\"hunger\":100,\"armour\":0}', 0, '{}', '{}', 0, NULL, 0, 'move_m@casual@d', '{}', NULL, '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `characters_cars`
--

CREATE TABLE `characters_cars` (
  `id` int(11) NOT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  `purchase_price` float DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `vehicle_state` longtext DEFAULT NULL,
  `fuel` int(11) DEFAULT 100,
  `name` varchar(50) DEFAULT NULL,
  `engine_damage` bigint(19) UNSIGNED DEFAULT 1000,
  `body_damage` bigint(20) DEFAULT 1000,
  `degredation` longtext DEFAULT '100,100,100,100,100,100,100,100',
  `current_garage` varchar(50) DEFAULT 'T',
  `financed` int(11) DEFAULT 0,
  `last_payment` int(11) DEFAULT 0,
  `coords` longtext DEFAULT NULL,
  `license_plate` varchar(255) NOT NULL DEFAULT '',
  `payments_left` int(3) DEFAULT 0,
  `server_number` int(11) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `repoed` int(11) NOT NULL DEFAULT 0,
  `garage_info` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `characters_clothes`
--

CREATE TABLE `characters_clothes` (
  `cid` int(11) DEFAULT NULL,
  `assExist` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `characters_houses`
--

CREATE TABLE `characters_houses` (
  `id` int(11) NOT NULL,
  `citizenid` varchar(50) DEFAULT '[]',
  `name` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `tier` int(11) DEFAULT NULL,
  `owned` varchar(50) DEFAULT NULL,
  `coords` text DEFAULT NULL,
  `hasgarage` varchar(50) DEFAULT 'false',
  `garage` varchar(200) DEFAULT '[]',
  `keyholders` text DEFAULT NULL,
  `decorations` longtext DEFAULT NULL,
  `stash` text DEFAULT NULL,
  `outfit` text DEFAULT NULL,
  `logout` text DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `characters_house_plants`
--

CREATE TABLE `characters_house_plants` (
  `id` int(11) NOT NULL,
  `houseid` varchar(50) DEFAULT '11111',
  `plants` varchar(65000) DEFAULT '[]'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `characters_weapons`
--

CREATE TABLE `characters_weapons` (
  `id` int(11) NOT NULL DEFAULT 0,
  `type` varchar(255) DEFAULT NULL,
  `ammo` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `character_current`
--

CREATE TABLE `character_current` (
  `cid` int(11) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `drawables` mediumtext DEFAULT NULL,
  `props` mediumtext DEFAULT NULL,
  `drawtextures` mediumtext DEFAULT NULL,
  `proptextures` mediumtext DEFAULT NULL,
  `assExists` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `character_current`
--

INSERT INTO `character_current` (`cid`, `model`, `drawables`, `props`, `drawtextures`, `proptextures`, `assExists`) VALUES
(17, '1885233650', '{\"1\":[\"masks\",0],\"2\":[\"hair\",0],\"3\":[\"torsos\",0],\"4\":[\"legs\",0],\"5\":[\"bags\",0],\"6\":[\"shoes\",1],\"7\":[\"neck\",0],\"8\":[\"undershirts\",0],\"9\":[\"vest\",0],\"10\":[\"decals\",0],\"11\":[\"jackets\",0],\"0\":[\"face\",0]}', '{\"1\":[\"glasses\",-1],\"2\":[\"earrings\",-1],\"3\":[\"mouth\",-1],\"4\":[\"lhand\",-1],\"5\":[\"rhand\",-1],\"6\":[\"watches\",-1],\"7\":[\"braclets\",-1],\"0\":[\"hats\",-1]}', '[[\"face\",0],[\"masks\",0],[\"hair\",0],[\"torsos\",0],[\"legs\",0],[\"bags\",0],[\"shoes\",2],[\"neck\",0],[\"undershirts\",1],[\"vest\",0],[\"decals\",0],[\"jackets\",0]]', '[[\"hats\",-1],[\"glasses\",-1],[\"earrings\",-1],[\"mouth\",-1],[\"lhand\",-1],[\"rhand\",-1],[\"watches\",-1],[\"braclets\",-1]]', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `character_face`
--

CREATE TABLE `character_face` (
  `cid` int(11) DEFAULT NULL,
  `hairColor` mediumtext DEFAULT NULL,
  `headBlend` mediumtext DEFAULT NULL,
  `headOverlay` mediumtext DEFAULT NULL,
  `headStructure` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `character_face`
--

INSERT INTO `character_face` (`cid`, `hairColor`, `headBlend`, `headOverlay`, `headStructure`) VALUES
(17, '[1,1]', '{\"skinFirst\":15,\"shapeThird\":0,\"shapeSecond\":0,\"skinThird\":0,\"thirdMix\":0.0,\"skinMix\":1.0,\"hasParent\":false,\"shapeMix\":0.0,\"shapeFirst\":0,\"skinSecond\":0}', '[{\"secondColour\":0,\"name\":\"Blemishes\",\"colourType\":0,\"firstColour\":0,\"overlayOpacity\":1.0,\"overlayValue\":255},{\"secondColour\":0,\"name\":\"FacialHair\",\"colourType\":1,\"firstColour\":0,\"overlayOpacity\":0.0,\"overlayValue\":255},{\"secondColour\":0,\"name\":\"Eyebrows\",\"colourType\":1,\"firstColour\":0,\"overlayOpacity\":1.0,\"overlayValue\":255},{\"secondColour\":0,\"name\":\"Ageing\",\"colourType\":0,\"firstColour\":0,\"overlayOpacity\":1.0,\"overlayValue\":255},{\"secondColour\":0,\"name\":\"Makeup\",\"colourType\":2,\"firstColour\":0,\"overlayOpacity\":1.0,\"overlayValue\":255},{\"secondColour\":0,\"name\":\"Blush\",\"colourType\":2,\"firstColour\":0,\"overlayOpacity\":1.0,\"overlayValue\":255},{\"secondColour\":0,\"name\":\"Complexion\",\"colourType\":0,\"firstColour\":0,\"overlayOpacity\":1.0,\"overlayValue\":255},{\"secondColour\":0,\"name\":\"SunDamage\",\"colourType\":0,\"firstColour\":0,\"overlayOpacity\":1.0,\"overlayValue\":255},{\"secondColour\":0,\"name\":\"Lipstick\",\"colourType\":2,\"firstColour\":0,\"overlayOpacity\":1.0,\"overlayValue\":255},{\"secondColour\":0,\"name\":\"MolesFreckles\",\"colourType\":0,\"firstColour\":0,\"overlayOpacity\":1.0,\"overlayValue\":255},{\"secondColour\":0,\"name\":\"ChestHair\",\"colourType\":1,\"firstColour\":0,\"overlayOpacity\":1.0,\"overlayValue\":255},{\"secondColour\":0,\"name\":\"BodyBlemishes\",\"colourType\":0,\"firstColour\":0,\"overlayOpacity\":1.0,\"overlayValue\":255},{\"secondColour\":0,\"name\":\"AddBodyBlemishes\",\"colourType\":0,\"firstColour\":0,\"overlayOpacity\":1.0,\"overlayValue\":255}]', '[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]');

-- --------------------------------------------------------

--
-- Table structure for table `character_hospital_patients`
--

CREATE TABLE `character_hospital_patients` (
  `id` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `illness` varchar(50) NOT NULL DEFAULT 'none',
  `level` int(11) NOT NULL DEFAULT 0,
  `time` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `character_housing`
--

CREATE TABLE `character_housing` (
  `id` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `housing_id` int(11) NOT NULL,
  `Street` text NOT NULL,
  `assigned` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `character_housing_keys`
--

CREATE TABLE `character_housing_keys` (
  `id` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `housing_id` int(11) NOT NULL,
  `giver` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `character_motel`
--

CREATE TABLE `character_motel` (
  `id` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `building_type` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `character_motel`
--

INSERT INTO `character_motel` (`id`, `cid`, `building_type`) VALUES
(13, 17, 1);

-- --------------------------------------------------------

--
-- Table structure for table `character_outfits`
--

CREATE TABLE `character_outfits` (
  `cid` int(11) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `name` text DEFAULT NULL,
  `slot` int(11) DEFAULT NULL,
  `drawables` text DEFAULT '{}',
  `props` text DEFAULT '{}',
  `drawtextures` text DEFAULT '{}',
  `proptextures` text DEFAULT '{}',
  `hairColor` text DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `character_passes`
--

CREATE TABLE `character_passes` (
  `id` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `rank` int(11) NOT NULL DEFAULT 1,
  `name` text NOT NULL,
  `giver` text NOT NULL,
  `pass_type` text NOT NULL,
  `business_name` text NOT NULL,
  `bank` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `character_passes`
--

INSERT INTO `character_passes` (`id`, `cid`, `rank`, `name`, `giver`, `pass_type`, `business_name`, `bank`) VALUES
(1, 17, 5, 'police', '1', 'police', 'police', 0);

-- --------------------------------------------------------

--
-- Table structure for table `character_presets`
--

CREATE TABLE `character_presets` (
  `id` int(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `price` int(255) DEFAULT NULL,
  `drawables` mediumtext DEFAULT NULL,
  `props` mediumtext DEFAULT NULL,
  `drawtextures` mediumtext DEFAULT NULL,
  `proptextures` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `character_tattoos`
--

CREATE TABLE `character_tattoos` (
  `id` int(11) NOT NULL,
  `cid` int(11) NOT NULL DEFAULT 0,
  `tattoos` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `character_tattoos`
--

INSERT INTO `character_tattoos` (`id`, `cid`, `tattoos`) VALUES
(13, 17, '{}');

-- --------------------------------------------------------

--
-- Table structure for table `dispatch_code`
--

CREATE TABLE `dispatch_code` (
  `id` int(11) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `display_code` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_important` varchar(255) DEFAULT NULL,
  `priority` varchar(255) DEFAULT NULL,
  `playsound` varchar(255) DEFAULT NULL,
  `soundname` varchar(255) DEFAULT NULL,
  `blip_color` varchar(255) DEFAULT NULL,
  `is_police` varchar(255) DEFAULT NULL,
  `is_ems` varchar(255) DEFAULT NULL,
  `is_news` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `dispatch_log`
--

CREATE TABLE `dispatch_log` (
  `dispatch_id` varchar(255) DEFAULT NULL,
  `cid` varchar(255) DEFAULT NULL,
  `first_street` varchar(255) DEFAULT NULL,
  `second_street` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `event_id` varchar(255) DEFAULT NULL,
  `origin_x` varchar(255) DEFAULT NULL,
  `origin_y` varchar(255) DEFAULT NULL,
  `origin_z` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `dispatch_vehicle`
--

CREATE TABLE `dispatch_vehicle` (
  `id` int(11) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `first_color` varchar(255) DEFAULT NULL,
  `second_color` varchar(255) DEFAULT NULL,
  `plate` varchar(255) DEFAULT NULL,
  `heading` varchar(255) DEFAULT NULL,
  `event_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `general_variables`
--

CREATE TABLE `general_variables` (
  `id` int(11) NOT NULL,
  `value` text DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `group_banking`
--

CREATE TABLE `group_banking` (
  `group_type` mediumtext DEFAULT NULL,
  `bank` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hospital_patients`
--

CREATE TABLE `hospital_patients` (
  `id` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `illness` text NOT NULL DEFAULT '',
  `time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `hospital_patients`
--

INSERT INTO `hospital_patients` (`id`, `cid`, `level`, `illness`, `time`) VALUES
(12, 17, 0, 'none', 0);

-- --------------------------------------------------------

--
-- Table structure for table `houses`
--

CREATE TABLE `houses` (
  `id` int(11) NOT NULL DEFAULT 0,
  `cid` int(11) NOT NULL DEFAULT 0,
  `model` text DEFAULT '',
  `data` text DEFAULT '{}',
  `furniture` text DEFAULT '{}',
  `mykeys` text NOT NULL DEFAULT '{}',
  `house_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `jobs_whitelist`
--

CREATE TABLE `jobs_whitelist` (
  `cid` int(11) DEFAULT NULL,
  `job` varchar(50) DEFAULT 'unemployed',
  `rank` int(11) DEFAULT 0,
  `callsign` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `mdt_bolos`
--

CREATE TABLE `mdt_bolos` (
  `id` int(11) NOT NULL,
  `title` longtext NOT NULL,
  `plate` longtext NOT NULL,
  `owner` longtext NOT NULL,
  `individual` longtext NOT NULL,
  `detail` longtext NOT NULL,
  `tags` longtext NOT NULL,
  `gallery` longtext NOT NULL,
  `officers` longtext NOT NULL,
  `time` longtext NOT NULL,
  `author` longtext DEFAULT NULL,
  `type` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `mdt_bulletins`
--

CREATE TABLE `mdt_bulletins` (
  `id` int(11) NOT NULL,
  `author` longtext DEFAULT NULL,
  `title` longtext DEFAULT NULL,
  `info` longtext DEFAULT NULL,
  `time` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `mdt_dashmessage`
--

CREATE TABLE `mdt_dashmessage` (
  `message` longtext DEFAULT NULL,
  `time` longtext DEFAULT NULL,
  `author` longtext DEFAULT NULL,
  `profilepic` longtext DEFAULT NULL,
  `job` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `mdt_incidents`
--

CREATE TABLE `mdt_incidents` (
  `id` int(11) NOT NULL,
  `title` longtext NOT NULL,
  `information` longtext NOT NULL,
  `tags` longtext NOT NULL,
  `officers` longtext NOT NULL,
  `civilians` longtext NOT NULL,
  `evidence` longtext NOT NULL,
  `associated` longtext NOT NULL,
  `time` longtext NOT NULL,
  `author` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `mdt_logs`
--

CREATE TABLE `mdt_logs` (
  `log` longtext DEFAULT NULL,
  `time` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `mdt_report`
--

CREATE TABLE `mdt_report` (
  `id` int(11) NOT NULL,
  `title` longtext DEFAULT NULL,
  `reporttype` longtext DEFAULT NULL,
  `author` longtext DEFAULT NULL,
  `detail` longtext DEFAULT NULL,
  `tags` longtext DEFAULT NULL,
  `gallery` longtext DEFAULT NULL,
  `officers` longtext DEFAULT NULL,
  `civilians` longtext DEFAULT NULL,
  `time` longtext DEFAULT NULL,
  `type` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `mdt_vehicleinfo`
--

CREATE TABLE `mdt_vehicleinfo` (
  `plate` varchar(50) NOT NULL DEFAULT '',
  `code5` longtext NOT NULL,
  `stolen` longtext NOT NULL,
  `info` longtext NOT NULL,
  `image` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `mdt_weapons`
--

CREATE TABLE `mdt_weapons` (
  `id` int(11) NOT NULL,
  `identifier` longtext DEFAULT NULL,
  `serialnumber` longtext DEFAULT NULL,
  `image` longtext DEFAULT 'https://cdn.discordapp.com/attachments/770324167894761522/912602343164502096/not-found.jpg',
  `owner` longtext DEFAULT NULL,
  `brand` longtext DEFAULT 'Unknown',
  `type` longtext DEFAULT 'Unknown',
  `information` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `mech_materials`
--

CREATE TABLE `mech_materials` (
  `garage` text DEFAULT 'Tow Garage',
  `Scrap` int(11) DEFAULT 0,
  `Plastic` int(11) DEFAULT 0,
  `Glass` int(11) DEFAULT 0,
  `Steel` int(11) DEFAULT 0,
  `Aluminium` int(11) DEFAULT 0,
  `Rubber` int(11) DEFAULT 0,
  `Copper` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `phone_invoices`
--

CREATE TABLE `phone_invoices` (
  `id` int(10) NOT NULL,
  `recievercid` varchar(50) DEFAULT NULL,
  `payment` int(11) NOT NULL DEFAULT 0,
  `bank` tinytext DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `sendercid` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `phone_yp`
--

CREATE TABLE `phone_yp` (
  `id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `job` varchar(500) DEFAULT NULL,
  `phonenumber` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `playerstattoos`
--

CREATE TABLE `playerstattoos` (
  `identifier` int(11) DEFAULT NULL,
  `tattoos` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `racing_tracks`
--

CREATE TABLE `racing_tracks` (
  `id` int(11) NOT NULL,
  `checkPoints` text DEFAULT NULL,
  `track_names` text DEFAULT NULL,
  `creator` text DEFAULT NULL,
  `distance` text DEFAULT NULL,
  `races` text DEFAULT NULL,
  `fastest_car` text DEFAULT NULL,
  `fastest_name` text DEFAULT NULL,
  `fastest_lap` int(11) DEFAULT NULL,
  `fastest_sprint` int(11) DEFAULT NULL,
  `fastest_sprint_name` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `data` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `stash`
--

CREATE TABLE `stash` (
  `owner_cid` int(11) DEFAULT NULL,
  `admin` int(11) DEFAULT NULL,
  `x` int(122) DEFAULT NULL,
  `y` int(122) DEFAULT NULL,
  `z` int(122) DEFAULT NULL,
  `g_x` int(122) DEFAULT NULL,
  `g_y` int(122) DEFAULT NULL,
  `g_z` int(122) DEFAULT NULL,
  `owner_pin` int(11) DEFAULT NULL,
  `guest_pin` int(11) DEFAULT NULL,
  `useGarage` int(11) DEFAULT NULL,
  `tier` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `storage_units`
--

CREATE TABLE `storage_units` (
  `id` longtext DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `given_access` varchar(50) DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_history`
--

CREATE TABLE `transaction_history` (
  `id` int(11) NOT NULL,
  `cid` text NOT NULL,
  `trans_id` int(11) NOT NULL,
  `account` text NOT NULL,
  `amount` int(11) NOT NULL,
  `trans_type` text NOT NULL,
  `receiver` text NOT NULL,
  `message` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tweets`
--

CREATE TABLE `tweets` (
  `handle` longtext NOT NULL,
  `message` varchar(500) NOT NULL,
  `time` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `hex_id` varchar(100) DEFAULT NULL,
  `steam_id` varchar(50) DEFAULT NULL,
  `community_id` varchar(100) DEFAULT NULL,
  `license` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL DEFAULT 'Uknown',
  `ip` varchar(50) NOT NULL DEFAULT 'Uknown',
  `rank` varchar(50) NOT NULL DEFAULT 'user',
  `date_created` timestamp NOT NULL DEFAULT current_timestamp(),
  `controls` text DEFAULT '{}',
  `settings` text DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `hex_id`, `steam_id`, `community_id`, `license`, `name`, `ip`, `rank`, `date_created`, `controls`, `settings`) VALUES
(10, 'steam:110000134210df5', 'STEAM_0:1:437290746', '76561198834847220', 'license:4c1be3ad9ed7a7e9277de4dce6295052b5505337', 'hyperfno', 'Uknown', 'dev', '2022-05-27 22:15:09', '{\"radiotoggle\":\",\",\"generalProp\":\"7\",\"vehicleBelt\":\"B\",\"heliCam\":\"E\",\"devnoclip\":\"F2\",\"loudSpeaker\":\"-\",\"switchRadioEmergency\":\"9\",\"helilockon\":\"SPACE\",\"vehicleSlights\":\"Q\",\"generalMenu\":\"F1\",\"helispotlight\":\"G\",\"generalChat\":\"T\",\"newsTools\":\"H\",\"vehicleSearch\":\"G\",\"handheld\":\"LEFTSHIFT+P\",\"vehicleCruise\":\"X\",\"vehicleDoors\":\"L\",\"showDispatchLog\":\"z\",\"radiovolumeup\":\"]\",\"newsNormal\":\"E\",\"housingSecondary\":\"G\",\"radiovolumedown\":\"[\",\"generalUse\":\"E\",\"vehicleSsound\":\"LEFTALT\",\"vehicleSnavigate\":\"R\",\"tokoptt\":\"CAPS\",\"generalUseSecondaryWorld\":\"F\",\"carStereo\":\"LEFTALT+P\",\"devmarker\":\"F6\",\"newsMovie\":\"M\",\"devcloak\":\"F3\",\"helirappel\":\"X\",\"helivision\":\"INPUTAIM\",\"devmenu\":\"F5\",\"movementCrouch\":\"X\",\"generalUseThird\":\"G\",\"actionBar\":\"TAB\",\"generalUseSecondary\":\"ENTER\",\"distanceChange\":\"G\",\"tokoToggle\":\"LEFTCTRL\",\"generalEscapeMenu\":\"ESC\",\"movementCrawl\":\"Z\",\"generalPhone\":\"P\",\"generalInventory\":\"K\",\"vehicleHotwire\":\"H\",\"generalTackle\":\"LEFTALT\",\"generalScoreboard\":\"U\",\"housingMain\":\"H\"}', '{\"hud\":[],\"tokovoip\":{\"localClickOff\":true,\"releaseDelay\":200,\"phoneVolume\":0.8,\"remoteClickOn\":true,\"radioVolume\":0.8,\"clickVolume\":0.8,\"remoteClickOff\":true,\"localClickOn\":true,\"stereoAudio\":true}}');

-- --------------------------------------------------------

--
-- Table structure for table `user_apartment`
--

CREATE TABLE `user_apartment` (
  `room` int(11) NOT NULL,
  `roomType` int(1) DEFAULT NULL,
  `cid` mediumtext NOT NULL,
  `mykeys` varchar(50) NOT NULL DEFAULT '[]',
  `ilness` mediumtext NOT NULL DEFAULT 'Alive',
  `isImprisoned` mediumtext NOT NULL DEFAULT '0',
  `isClothesSpawn` mediumtext NOT NULL DEFAULT 'true',
  `cash` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_bans`
--

CREATE TABLE `user_bans` (
  `steam_id` longtext NOT NULL DEFAULT '',
  `discord_id` longtext NOT NULL DEFAULT '',
  `steam_name` longtext NOT NULL DEFAULT '',
  `reason` longtext NOT NULL DEFAULT '',
  `details` longtext NOT NULL,
  `date_banned` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_boat`
--

CREATE TABLE `user_boat` (
  `id` int(11) NOT NULL,
  `identifier` varchar(255) DEFAULT '{}',
  `boat_name` varchar(255) DEFAULT '{}',
  `boat_model` varchar(255) DEFAULT '{}',
  `boat_price` varchar(255) DEFAULT '{}',
  `boat_plate` varchar(255) DEFAULT '{}',
  `boat_state` varchar(255) DEFAULT '{}',
  `boat_colorprimary` varchar(255) DEFAULT '{}',
  `boat_colorsecondary` varchar(255) DEFAULT '{}',
  `boat_pearlescentcolor` varchar(255) DEFAULT '{}',
  `boat_wheelcolor` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_contacts`
--

CREATE TABLE `user_contacts` (
  `identifier` varchar(40) NOT NULL,
  `name` longtext NOT NULL,
  `number` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_crypto`
--

CREATE TABLE `user_crypto` (
  `id` int(11) NOT NULL,
  `cryptoid` varchar(255) NOT NULL,
  `cryptoamount` varchar(255) DEFAULT NULL,
  `cryptocid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_inventory2`
--

CREATE TABLE `user_inventory2` (
  `item_id` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `id` int(11) NOT NULL,
  `name` varchar(500) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `information` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `slot` int(11) NOT NULL,
  `dropped` tinyint(4) NOT NULL DEFAULT 0,
  `creationDate` bigint(20) NOT NULL DEFAULT 0,
  `quality` int(11) DEFAULT 100
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_inventory2`
--

INSERT INTO `user_inventory2` (`item_id`, `id`, `name`, `information`, `slot`, `dropped`, `creationDate`, `quality`) VALUES
('mobilephone', 20520, 'motel-1-17', '{}', 1, 0, 1653707812301, 100),
('mobilephone', 20521, 'ply-17', '{}', 1, 0, 1653707812301, 100);

-- --------------------------------------------------------

--
-- Table structure for table `user_licenses`
--

CREATE TABLE `user_licenses` (
  `cid` longtext NOT NULL,
  `type` longtext NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_licenses`
--

INSERT INTO `user_licenses` (`cid`, `type`, `status`) VALUES
('17', 'Weapon', 0),
('17', 'Hunting', 0),
('17', 'Bar', 0),
('17', 'Pilot', 0),
('17', 'Business', 0),
('17', 'Drivers', 1),
('17', 'Fishing', 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_messages`
--

CREATE TABLE `user_messages` (
  `id` int(11) NOT NULL,
  `sender` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `date` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user_settings`
--

CREATE TABLE `user_settings` (
  `hex_id` varchar(255) NOT NULL DEFAULT '',
  `settings` varchar(255) DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_display`
--

CREATE TABLE `vehicle_display` (
  `id` int(11) NOT NULL,
  `model` varchar(60) COLLATE utf8mb4_turkish_ci NOT NULL,
  `name` varchar(60) COLLATE utf8mb4_turkish_ci NOT NULL,
  `commission` int(11) NOT NULL DEFAULT 10,
  `baseprice` int(11) NOT NULL DEFAULT 25,
  `price` int(11) DEFAULT 25000
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_mdt`
--

CREATE TABLE `vehicle_mdt` (
  `dbid` int(11) NOT NULL,
  `plate` varchar(255) DEFAULT NULL,
  `notes` varchar(50) DEFAULT NULL,
  `image` varchar(255) DEFAULT 'https://cdn.discordapp.com/attachments/832371566859124821/881624386317201498/Screenshot_1607.png',
  `code` int(11) DEFAULT 0,
  `stolen` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `weapons_serials`
--

CREATE TABLE `weapons_serials` (
  `id` int(11) NOT NULL,
  `cid` int(11) DEFAULT NULL,
  `serial` mediumtext DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `information` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `weed`
--

CREATE TABLE `weed` (
  `id` int(11) NOT NULL,
  `x` int(11) DEFAULT 0,
  `y` int(11) DEFAULT 0,
  `z` int(11) DEFAULT 0,
  `growth` int(11) DEFAULT 0,
  `type` varchar(50) DEFAULT NULL,
  `time` longtext DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `_character_crypto_wallet`
--

CREATE TABLE `_character_crypto_wallet` (
  `id` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `__banking_logs`
--

CREATE TABLE `__banking_logs` (
  `cid` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `reason` longtext NOT NULL,
  `withdraw` int(11) DEFAULT NULL,
  `business` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `___mdw_bulletin`
--

CREATE TABLE `___mdw_bulletin` (
  `id` bigint(20) NOT NULL DEFAULT 0,
  `title` longtext NOT NULL,
  `info` longtext NOT NULL,
  `time` varchar(50) NOT NULL DEFAULT '0',
  `src` mediumtext NOT NULL,
  `author` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `___mdw_incidents`
--

CREATE TABLE `___mdw_incidents` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `author` varchar(100) NOT NULL,
  `time` varchar(100) NOT NULL,
  `details` longtext NOT NULL,
  `tags` longtext NOT NULL,
  `officers` longtext NOT NULL,
  `civilians` longtext NOT NULL,
  `evidence` longtext NOT NULL,
  `associated` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `___mdw_logs`
--

CREATE TABLE `___mdw_logs` (
  `id` int(11) NOT NULL,
  `text` longtext NOT NULL,
  `time` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `___mdw_messages`
--

CREATE TABLE `___mdw_messages` (
  `id` int(11) NOT NULL,
  `job` varchar(255) NOT NULL DEFAULT 'police',
  `name` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `time` varchar(255) DEFAULT NULL,
  `profilepic` mediumtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `___mdw_profiles`
--

CREATE TABLE `___mdw_profiles` (
  `idP` int(11) NOT NULL,
  `cid` int(11) DEFAULT NULL,
  `image` longtext DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `tags` longtext NOT NULL DEFAULT '{}',
  `gallery` longtext NOT NULL DEFAULT '{}'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `____mdw_bolos`
--

CREATE TABLE `____mdw_bolos` (
  `dbid` int(11) NOT NULL,
  `title` mediumtext DEFAULT NULL,
  `author` mediumtext DEFAULT NULL,
  `time` mediumtext DEFAULT NULL,
  `plate` mediumtext DEFAULT NULL,
  `owner` mediumtext DEFAULT NULL,
  `individual` mediumtext NOT NULL,
  `detail` longtext DEFAULT NULL,
  `tags` longtext DEFAULT NULL,
  `gallery` longtext DEFAULT NULL CHECK (json_valid(`gallery`)),
  `officers` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `____mdw_bolos_ems`
--

CREATE TABLE `____mdw_bolos_ems` (
  `dbid` int(11) NOT NULL,
  `title` mediumtext DEFAULT NULL,
  `author` mediumtext DEFAULT NULL,
  `time` mediumtext DEFAULT NULL,
  `plate` mediumtext DEFAULT NULL,
  `owner` mediumtext DEFAULT NULL,
  `individual` mediumtext NOT NULL,
  `detail` longtext DEFAULT NULL,
  `tags` longtext DEFAULT NULL,
  `gallery` longtext DEFAULT NULL,
  `officers` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `____mdw_reports`
--

CREATE TABLE `____mdw_reports` (
  `dbid` int(11) NOT NULL,
  `title` mediumtext DEFAULT NULL,
  `type` mediumtext DEFAULT NULL,
  `author` mediumtext DEFAULT NULL,
  `time` mediumtext DEFAULT NULL,
  `detail` longtext DEFAULT NULL,
  `tags` longtext DEFAULT '[]',
  `gallery` longtext DEFAULT '[]',
  `officers` longtext DEFAULT '[]',
  `civsinvolved` longtext DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `____mdw_reports_ems`
--

CREATE TABLE `____mdw_reports_ems` (
  `dbid` int(11) NOT NULL,
  `title` mediumtext DEFAULT NULL,
  `type` mediumtext DEFAULT NULL,
  `author` mediumtext DEFAULT NULL,
  `time` mediumtext DEFAULT NULL,
  `detail` longtext DEFAULT NULL,
  `tags` longtext DEFAULT '[]',
  `gallery` longtext DEFAULT '[]',
  `officers` longtext DEFAULT '[]',
  `civsinvolved` longtext DEFAULT '[]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `characters`
--
ALTER TABLE `characters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `characters_cars`
--
ALTER TABLE `characters_cars`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `character_hospital_patients`
--
ALTER TABLE `character_hospital_patients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `character_housing`
--
ALTER TABLE `character_housing`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `character_housing_keys`
--
ALTER TABLE `character_housing_keys`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `character_motel`
--
ALTER TABLE `character_motel`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `character_passes`
--
ALTER TABLE `character_passes`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `character_presets`
--
ALTER TABLE `character_presets`
  ADD KEY `id` (`id`);

--
-- Indexes for table `character_tattoos`
--
ALTER TABLE `character_tattoos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `general_variables`
--
ALTER TABLE `general_variables`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hospital_patients`
--
ALTER TABLE `hospital_patients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdt_bolos`
--
ALTER TABLE `mdt_bolos`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `mdt_bulletins`
--
ALTER TABLE `mdt_bulletins`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `mdt_incidents`
--
ALTER TABLE `mdt_incidents`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `mdt_report`
--
ALTER TABLE `mdt_report`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `mdt_vehicleinfo`
--
ALTER TABLE `mdt_vehicleinfo`
  ADD PRIMARY KEY (`plate`) USING BTREE;

--
-- Indexes for table `mdt_weapons`
--
ALTER TABLE `mdt_weapons`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `phone_invoices`
--
ALTER TABLE `phone_invoices`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `citizenid` (`recievercid`) USING BTREE;

--
-- Indexes for table `phone_yp`
--
ALTER TABLE `phone_yp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `racing_tracks`
--
ALTER TABLE `racing_tracks`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaction_history`
--
ALTER TABLE `transaction_history`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_apartment`
--
ALTER TABLE `user_apartment`
  ADD PRIMARY KEY (`room`) USING BTREE;

--
-- Indexes for table `user_boat`
--
ALTER TABLE `user_boat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_inventory2`
--
ALTER TABLE `user_inventory2`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `user_messages`
--
ALTER TABLE `user_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_settings`
--
ALTER TABLE `user_settings`
  ADD PRIMARY KEY (`hex_id`);

--
-- Indexes for table `vehicle_display`
--
ALTER TABLE `vehicle_display`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `weapons_serials`
--
ALTER TABLE `weapons_serials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `weed`
--
ALTER TABLE `weed`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `___mdw_bulletin`
--
ALTER TABLE `___mdw_bulletin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `___mdw_incidents`
--
ALTER TABLE `___mdw_incidents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `___mdw_logs`
--
ALTER TABLE `___mdw_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `___mdw_messages`
--
ALTER TABLE `___mdw_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `___mdw_profiles`
--
ALTER TABLE `___mdw_profiles`
  ADD PRIMARY KEY (`idP`) USING BTREE;

--
-- Indexes for table `____mdw_bolos`
--
ALTER TABLE `____mdw_bolos`
  ADD PRIMARY KEY (`dbid`) USING BTREE;

--
-- Indexes for table `____mdw_bolos_ems`
--
ALTER TABLE `____mdw_bolos_ems`
  ADD PRIMARY KEY (`dbid`) USING BTREE;

--
-- Indexes for table `____mdw_reports`
--
ALTER TABLE `____mdw_reports`
  ADD PRIMARY KEY (`dbid`) USING BTREE;

--
-- Indexes for table `____mdw_reports_ems`
--
ALTER TABLE `____mdw_reports_ems`
  ADD PRIMARY KEY (`dbid`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `characters`
--
ALTER TABLE `characters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `characters_cars`
--
ALTER TABLE `characters_cars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `character_hospital_patients`
--
ALTER TABLE `character_hospital_patients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `character_housing`
--
ALTER TABLE `character_housing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `character_housing_keys`
--
ALTER TABLE `character_housing_keys`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `character_motel`
--
ALTER TABLE `character_motel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `character_passes`
--
ALTER TABLE `character_passes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `character_presets`
--
ALTER TABLE `character_presets`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `character_tattoos`
--
ALTER TABLE `character_tattoos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `general_variables`
--
ALTER TABLE `general_variables`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hospital_patients`
--
ALTER TABLE `hospital_patients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `mdt_bolos`
--
ALTER TABLE `mdt_bolos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `mdt_bulletins`
--
ALTER TABLE `mdt_bulletins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `mdt_incidents`
--
ALTER TABLE `mdt_incidents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `mdt_report`
--
ALTER TABLE `mdt_report`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `mdt_weapons`
--
ALTER TABLE `mdt_weapons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `phone_invoices`
--
ALTER TABLE `phone_invoices`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `phone_yp`
--
ALTER TABLE `phone_yp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=189;

--
-- AUTO_INCREMENT for table `racing_tracks`
--
ALTER TABLE `racing_tracks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction_history`
--
ALTER TABLE `transaction_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `user_apartment`
--
ALTER TABLE `user_apartment`
  MODIFY `room` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `user_boat`
--
ALTER TABLE `user_boat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_inventory2`
--
ALTER TABLE `user_inventory2`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20522;

--
-- AUTO_INCREMENT for table `user_messages`
--
ALTER TABLE `user_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `vehicle_display`
--
ALTER TABLE `vehicle_display`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `weapons_serials`
--
ALTER TABLE `weapons_serials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `weed`
--
ALTER TABLE `weed`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `___mdw_incidents`
--
ALTER TABLE `___mdw_incidents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `___mdw_logs`
--
ALTER TABLE `___mdw_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `___mdw_messages`
--
ALTER TABLE `___mdw_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `___mdw_profiles`
--
ALTER TABLE `___mdw_profiles`
  MODIFY `idP` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `____mdw_bolos`
--
ALTER TABLE `____mdw_bolos`
  MODIFY `dbid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `____mdw_bolos_ems`
--
ALTER TABLE `____mdw_bolos_ems`
  MODIFY `dbid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `____mdw_reports`
--
ALTER TABLE `____mdw_reports`
  MODIFY `dbid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `____mdw_reports_ems`
--
ALTER TABLE `____mdw_reports_ems`
  MODIFY `dbid` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
