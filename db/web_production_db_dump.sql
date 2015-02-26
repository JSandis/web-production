-- phpMyAdmin SQL Dump
-- version 4.2.12
-- http://www.phpmyadmin.net
--
-- Värd: localhost
-- Tid vid skapande: 26 feb 2015 kl 13:21
-- Serverversion: 5.6.21-log
-- PHP-version: 5.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Databas: `web_production`
--
CREATE DATABASE IF NOT EXISTS `web_production` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `web_production`;

-- --------------------------------------------------------

--
-- Tabellstruktur `images`
--

DROP TABLE IF EXISTS `images`;
CREATE TABLE IF NOT EXISTS `images` (
`id` int(11) NOT NULL,
  `path` varchar(255) NOT NULL,
  `thumbnail_path` varchar(255) NOT NULL,
  `description` text,
  `user_id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL,
  `uploaded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellstruktur `menus`
--

DROP TABLE IF EXISTS `menus`;
CREATE TABLE IF NOT EXISTS `menus` (
  `menu_name` varchar(255) NOT NULL,
  `machine_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `menus`
--

INSERT INTO `menus` (`menu_name`, `machine_name`) VALUES
('Main menu', 'menu-main-menu');

-- --------------------------------------------------------

--
-- Tabellstruktur `menu_links`
--

DROP TABLE IF EXISTS `menu_links`;
CREATE TABLE IF NOT EXISTS `menu_links` (
`id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `menu_machine_name` varchar(255) NOT NULL,
  `menu_link_id` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `menu_links`
--

INSERT INTO `menu_links` (`id`, `title`, `path`, `menu_machine_name`, `menu_link_id`, `weight`) VALUES
(4, 'Home', 'home-page', 'menu-main-menu', NULL, 0),
(5, 'Awesome page', 'awesome-page', 'menu-main-menu', 4, 0),
(6, 'Wonderful page', 'wonderful-page', 'menu-main-menu', 5, 0),
(7, 'Happy page', 'happy-page', 'menu-main-menu', 6, 0),
(10, 'Bad page', 'bad-page', 'menu-main-menu', 4, 0),
(11, 'Horrible page', 'horrible-page', 'menu-main-menu', 10, 0);

-- --------------------------------------------------------

--
-- Tabellstruktur `pages`
--

DROP TABLE IF EXISTS `pages`;
CREATE TABLE IF NOT EXISTS `pages` (
`id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `pages`
--

INSERT INTO `pages` (`id`, `title`, `body`, `user_id`, `created`) VALUES
(2, 'Test page', '<p>Some home page content that will attract some users!</p>', 1, '2015-02-16 10:08:06'),
(4, 'Awesome page', '<p>This is an Awesome page!</p>', 1, '2015-02-19 23:39:36'),
(5, 'Wonderful page', '<p>This is a wonderful page!</p>', 1, '2015-02-20 01:05:59'),
(6, 'Happy page', '<p>This is a happy page!</p>', 1, '2015-02-20 11:05:28'),
(13, 'Bad page', '<p>This is a bad page!</p>', 1, '2015-02-21 13:06:18'),
(18, 'Horrible page', '<p>This is a horrible page!</>', 1, '2015-02-22 22:27:36');

-- --------------------------------------------------------

--
-- Tabellstruktur `url_alias`
--

DROP TABLE IF EXISTS `url_alias`;
CREATE TABLE IF NOT EXISTS `url_alias` (
`id` int(11) NOT NULL,
  `path` varchar(255) NOT NULL,
  `page_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `url_alias`
--

INSERT INTO `url_alias` (`id`, `path`, `page_id`) VALUES
(2, 'home-page', 2),
(4, 'awesome-page', 4),
(5, 'wonderful-page', 5),
(6, 'happy-page', 6),
(13, 'bad-page', 13),
(18, 'horrible-page', 18);

-- --------------------------------------------------------

--
-- Tabellstruktur `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
`id` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `pass` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `users`
--

INSERT INTO `users` (`id`, `user_name`, `pass`, `created_at`) VALUES
(1, 'johanna@mycompany.se', '7110eda4d09e062aa5e4a390b0a572ac0d2c0220', '2015-02-14 23:00:49');

-- --------------------------------------------------------

--
-- Tabellstruktur `user_data`
--

DROP TABLE IF EXISTS `user_data`;
CREATE TABLE IF NOT EXISTS `user_data` (
  `user_id` varchar(45) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumpning av Data i tabell `user_data`
--

INSERT INTO `user_data` (`user_id`, `first_name`, `last_name`, `middle_name`, `address`, `phone`, `description`) VALUES
('1', 'Johanna', 'Sandberg', NULL, 'Konstiga gatan 1, 12345 Kristianstad', '012-3456789', 'My Company AB');

-- --------------------------------------------------------

--
-- Tabellstruktur `videos`
--

DROP TABLE IF EXISTS `videos`;
CREATE TABLE IF NOT EXISTS `videos` (
`id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `alt` varchar(255) DEFAULT NULL,
  `description` text,
  `user_id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL,
  `uploaded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index för dumpade tabeller
--

--
-- Index för tabell `images`
--
ALTER TABLE `images`
 ADD PRIMARY KEY (`id`), ADD KEY `images_user_idx` (`user_id`), ADD KEY `images_page_idx` (`page_id`);

--
-- Index för tabell `menus`
--
ALTER TABLE `menus`
 ADD PRIMARY KEY (`machine_name`);

--
-- Index för tabell `menu_links`
--
ALTER TABLE `menu_links`
 ADD PRIMARY KEY (`id`), ADD KEY `menu_links_menu_idx` (`menu_machine_name`), ADD KEY `menu_links_menu_link_idx` (`menu_link_id`);

--
-- Index för tabell `pages`
--
ALTER TABLE `pages`
 ADD PRIMARY KEY (`id`), ADD KEY `pages_user_idx` (`user_id`);

--
-- Index för tabell `url_alias`
--
ALTER TABLE `url_alias`
 ADD PRIMARY KEY (`id`), ADD KEY `url_alias_page_idx` (`page_id`);

--
-- Index för tabell `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `email_UNIQUE` (`user_name`);

--
-- Index för tabell `user_data`
--
ALTER TABLE `user_data`
 ADD PRIMARY KEY (`user_id`), ADD KEY `datas_user_idx` (`user_id`);

--
-- Index för tabell `videos`
--
ALTER TABLE `videos`
 ADD PRIMARY KEY (`id`), ADD KEY `videos_user_idx` (`user_id`), ADD KEY `videos_page_idx` (`page_id`);

--
-- AUTO_INCREMENT för dumpade tabeller
--

--
-- AUTO_INCREMENT för tabell `images`
--
ALTER TABLE `images`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT för tabell `menu_links`
--
ALTER TABLE `menu_links`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT för tabell `pages`
--
ALTER TABLE `pages`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT för tabell `url_alias`
--
ALTER TABLE `url_alias`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT för tabell `users`
--
ALTER TABLE `users`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT för tabell `videos`
--
ALTER TABLE `videos`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Restriktioner för dumpade tabeller
--

--
-- Restriktioner för tabell `images`
--
ALTER TABLE `images`
ADD CONSTRAINT `images_page` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `images_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restriktioner för tabell `menu_links`
--
ALTER TABLE `menu_links`
ADD CONSTRAINT `menu_links_menu` FOREIGN KEY (`menu_machine_name`) REFERENCES `menus` (`machine_name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `menu_links_menu_link` FOREIGN KEY (`menu_link_id`) REFERENCES `menu_links` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restriktioner för tabell `pages`
--
ALTER TABLE `pages`
ADD CONSTRAINT `pages_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restriktioner för tabell `url_alias`
--
ALTER TABLE `url_alias`
ADD CONSTRAINT `url_alias_page` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Restriktioner för tabell `videos`
--
ALTER TABLE `videos`
ADD CONSTRAINT `videos_page` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
ADD CONSTRAINT `videos_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
