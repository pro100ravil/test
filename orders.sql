-- phpMyAdmin SQL Dump
-- version 4.0.10.10
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1:3306
-- Время создания: Окт 13 2015 г., 16:11
-- Версия сервера: 5.5.45
-- Версия PHP: 5.6.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `orders`
--

-- --------------------------------------------------------

--
-- Структура таблицы `table1`
--

CREATE TABLE IF NOT EXISTS `table1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `text` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `table1`
--

INSERT INTO `table1` (`id`, `name`, `text`) VALUES
(1, 'имя1', 'описание1'),
(2, 'имя2', 'описание2'),
(3, 'имя3', 'описание3'),
(4, 'test', 'test');

-- --------------------------------------------------------

--
-- Структура таблицы `table2`
--

CREATE TABLE IF NOT EXISTS `table2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `text` text,
  `other_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `other_id` (`other_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `table2`
--

INSERT INTO `table2` (`id`, `name`, `text`, `other_id`) VALUES
(3, 'table2_name1', 'table2_discription1', 1),
(4, 'table2_name2', 'table2_discription2', 1),
(5, 'table2_name3', 'table2_discription3', 1),
(6, 'table2_name4', 'table2_discription4', 2);

-- --------------------------------------------------------

--
-- Структура таблицы `table3`
--

CREATE TABLE IF NOT EXISTS `table3` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `text` text,
  `other_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `other_id` (`other_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `table3`
--

INSERT INTO `table3` (`id`, `name`, `text`, `other_id`) VALUES
(3, 'table3_name1', 'discription', 6),
(4, 'какое-то имя в третьей таблице', 'его описание', 6);

-- --------------------------------------------------------

--
-- Структура таблицы `table4`
--

CREATE TABLE IF NOT EXISTS `table4` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `text` text,
  `other_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `other_id` (`other_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `table5`
--

CREATE TABLE IF NOT EXISTS `table5` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `text` text,
  `other_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `other_id` (`other_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Структура таблицы `test_table`
--

CREATE TABLE IF NOT EXISTS `test_table` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alphabetic` varchar(5) NOT NULL,
  `numeric_` float NOT NULL,
  `date` date NOT NULL,
  `unsortable` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Дамп данных таблицы `test_table`
--

INSERT INTO `test_table` (`id`, `alphabetic`, `numeric_`, `date`, `unsortable`) VALUES
(1, 'abc', 20, '2008-11-24', 'this'),
(2, 'dba', 8, '2004-03-01', 'column'),
(7, 'ecd', 6, '1979-07-23', 'cannot'),
(8, 'cnt', 4.2, '1492-12-08', 'be'),
(9, '001', 0, '1601-08-13', 'sorted'),
(10, 'eof', 2, '1979-07-23', 'never');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `fio` varchar(30) NOT NULL,
  `uname` varchar(20) NOT NULL,
  `upass` varchar(50) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`user_id`, `fio`, `uname`, `upass`) VALUES
(1, 'Gizatov', 'Ravil', '1234567890'),
(2, 'secondname', 'user', 'e10adc3949ba59abbe56e057f20f883e');

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `table2`
--
ALTER TABLE `table2`
  ADD CONSTRAINT `table2_ibfk_1` FOREIGN KEY (`other_id`) REFERENCES `table1` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `table3`
--
ALTER TABLE `table3`
  ADD CONSTRAINT `table3_ibfk_1` FOREIGN KEY (`other_id`) REFERENCES `table2` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `table4`
--
ALTER TABLE `table4`
  ADD CONSTRAINT `table4_ibfk_1` FOREIGN KEY (`other_id`) REFERENCES `table3` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `table5`
--
ALTER TABLE `table5`
  ADD CONSTRAINT `table5_ibfk_1` FOREIGN KEY (`other_id`) REFERENCES `table4` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
