CREATE DATABASE IF NOT EXISTS `group25`
USE `group25`;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `screen_name` varchar(15) NOT NULL,
  `name` varchar(50) NOT NULL,
  `location` varchar(30) DEFAULT NULL,
  `sub_category` varchar(8) DEFAULT NULL,
  `following` int(11) NOT NULL,
  `followers` int(11) NOT NULL,
  `category` varchar(22) DEFAULT NULL,
  PRIMARY KEY (`screen_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `tweets`;
CREATE TABLE `tweets` (
  `id` varchar(25) NOT NULL,
  `tweet_text` varchar(280) DEFAULT NULL,
  `retweeted_count` int(11) DEFAULT NULL,
  `retweeted` int(11) DEFAULT NULL,
  `posting_user` varchar(45) DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_idx` (`posting_user`),
  CONSTRAINT `user` FOREIGN KEY (`posting_user`) REFERENCES `users` (`screen_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `url`;
CREATE TABLE `url` (
  `primary` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(25) NOT NULL,
  `link` varchar(500) NOT NULL,
  PRIMARY KEY (`primary`),
  KEY `uid_idx` (`uid`),
  CONSTRAINT `uid` FOREIGN KEY (`uid`) REFERENCES `tweets` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40275 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `hashtag`;
CREATE TABLE `hashtag` (
  `pk` int(11) NOT NULL AUTO_INCREMENT,
  `hid` varchar(25) NOT NULL,
  `hashtag` varchar(280) NOT NULL,
  PRIMARY KEY (`pk`),
  KEY `hid_idx` (`hid`),
  CONSTRAINT `hid` FOREIGN KEY (`hid`) REFERENCES `tweets` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52242 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `webappusers`;
CREATE TABLE `webappusers` (
  `username` varchar(15) NOT NULL,
  `password` varchar(40) NOT NULL,
  `role` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TRIGGER IF EXISTS `group25`.`users_BEFORE_DELETE`;

DELIMITER $$
USE `group25`$$
CREATE DEFINER=`tstanger`@`%` TRIGGER `users_BEFORE_DELETE` BEFORE DELETE ON `users` FOR EACH ROW BEGIN
	DELETE FROM group25.tweets WHERE (`posting_user` = old.screen_name); 
END$$
DELIMITER ;

DROP TRIGGER IF EXISTS `group25`.`tweets_BEFORE_DELETE`;

DELIMITER $$
USE `group25`$$
CREATE DEFINER=`tstanger`@`%` TRIGGER `tweets_BEFORE_DELETE` BEFORE DELETE ON `tweets` FOR EACH ROW BEGIN
    DELETE FROM group25.hashtag WHERE (hid = old.id);
	DELETE FROM group25.url WHERE (uid = old.id); 
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS `createWebAppUser`;

DELIMITER $$
CREATE DEFINER=`tstanger`@`%` PROCEDURE `createWebAppUser`(IN uname VARCHAR(15), IN pass VARCHAR(40), IN roles VARCHAR(13))
BEGIN
	INSERT INTO `group25`.`webappusers` (`username`, `password`, `role`) VALUES (uname, pass, roles);
END$$
DELIMITER ;

DROP procedure IF EXISTS `deleteUser`;

DELIMITER $$
USE `group25`$$
CREATE DEFINER=`tstanger`@`%` PROCEDURE `deleteUser`(IN screenName VARCHAR(15))
BEGIN
	DELETE FROM group25.users WHERE (`screen_name` = screenName); 
END$$

DELIMITER ;

DROP procedure IF EXISTS `insertUser`;

DELIMITER $$
USE `group25`$$
CREATE DEFINER=`tstanger`@`%` PROCEDURE `insertUser`(IN screenName VARCHAR(15), IN userName VARCHAR(50), IN location VARCHAR(30), IN subCategory VARCHAR(8), in follow INT, in followers INT, in category VARCHAR(22))
BEGIN
	INSERT INTO group25.users(`screen_name`, `name`, `location`, `sub_category`, `following`, `followers`, `category`)
    VALUES (screenName, userName, location, subCategory, follow, followers, category); 
END$$

DELIMITER ;

DROP procedure IF EXISTS `Q1opt`;

DELIMITER $$
USE `group25`$$
CREATE DEFINER=`tstanger`@`%` PROCEDURE `Q1opt`(IN k INT, IN givenMonth INT, IN givenYear INT)
BEGIN
	SELECT t.retweeted_count, t.tweet_text, t.posting_user, u.category, u.sub_category
	FROM group25.tweets t
	LEFT JOIN group25.users u ON t.posting_user = u.screen_name 
	WHERE givenMonth = MONTH(t.created_at) AND givenYear = YEAR(t.created_at)
	ORDER BY t.retweeted_count DESC
	LIMIT k;
END$$

DELIMITER ;

DROP procedure IF EXISTS `Q2opt`;

DELIMITER $$
USE `group25`$$
CREATE DEFINER=`tstanger`@`%` PROCEDURE `Q2opt`(IN k INT, IN givenHashtag VARCHAR(280), IN givenMonth INT, IN givenYear INT)
BEGIN
	SELECT u.screen_name, u.category, t.tweet_text, t.retweeted_count
	FROM group25.tweets t
    INNER JOIN group25.hashtag h ON t.id = h.hid 
    INNER JOIN group25.users u ON t.posting_user = u.screen_name
	WHERE givenMonth = MONTH(t.created_at) AND givenYear = YEAR(t.created_at) AND h.hashtag = givenHashtag
	ORDER BY t.retweeted_count DESC
	LIMIT k;
END$$

DELIMITER ;

DROP procedure IF EXISTS `Q3opt`;

DELIMITER $$
USE `group25`$$
CREATE DEFINER=`tstanger`@`%` PROCEDURE `Q3opt`(IN k INT, IN givenYear INT)
BEGIN
	SELECT COUNT(DISTINCT u.location) AS `Number of States`, GROUP_CONCAT(DISTINCT u.location) AS `List of States`, h.hashtag AS Hashtag
	FROM group25.hashtag h
    INNER JOIN group25.tweets t ON h.hid = t.id
    INNER JOIN group25.users u ON t.posting_user = u.screen_name
	WHERE YEAR(t.created_at) = givenYear AND NOT(u.location = 'na') 
	GROUP BY Hashtag
	ORDER BY `Number of States` DESC
	LIMIT k;
END$$

DELIMITER ;

DROP procedure IF EXISTS `Q6opt`;

DELIMITER $$
USE `group25`$$
CREATE DEFINER=`tstanger`@`%` PROCEDURE `Q6opt`(IN k INT, IN givenHashtags VARCHAR(500))
BEGIN
	SELECT u.screen_name AS `Screen Name`, u.location AS State
	FROM group25.users u
	INNER JOIN group25.tweets t ON u.screen_name = t.posting_user
	INNER JOIN group25.hashtag h ON t.id = h.hid
	WHERE FIND_IN_SET(h.hashtag, givenHashtags)
	GROUP BY u.screen_name
	HAVING COUNT(DISTINCT h.hashtag) = (LENGTH(givenHashtags) - LENGTH(REPLACE(givenHashtags, ',', '')) + 1)
	ORDER BY u.followers DESC
	LIMIT k; 
END$$

DELIMITER ;

DROP procedure IF EXISTS `Q10opt`;

DELIMITER $$
USE `group25`$$
CREATE DEFINER=`tstanger`@`%` PROCEDURE `Q10opt`(IN givenStateList VARCHAR(500), IN givenMonth INT, IN givenYear INT)
BEGIN
	SELECT DISTINCT h.hashtag AS Hashtag, GROUP_CONCAT(DISTINCT u.location) AS States
	FROM group25.tweets t
	INNER JOIN group25.users u ON t.posting_user = u.screen_name
	INNER JOIN group25.hashtag h ON t.id = h.hid 
	WHERE FIND_IN_SET(u.location, givenStateList) AND givenMonth = MONTH(t.created_at) AND givenYear = YEAR(t.created_at) AND NOT(u.location = 'na')
	GROUP BY Hashtag;
END$$

DELIMITER ;

DROP procedure IF EXISTS `Q15opt`;

DELIMITER $$
USE `group25`$$
CREATE DEFINER=`tstanger`@`%` PROCEDURE `Q15opt`(IN givenSubcategory VARCHAR(8), IN givenMonth INT, IN givenYear INT)
BEGIN
	SELECT u.screen_name, u.location, GROUP_CONCAT(url.link) AS all_links_for_given_month_and_year 
	FROM group25.url url
    INNER JOIN group25.tweets t ON url.uid = t.id
    INNER JOIN group25.users u ON t.posting_user = u.screen_name
	WHERE MONTH(t.created_at) = givenMonth AND YEAR(t.created_at) = givenYear AND givenSubcategory = u.sub_category
	GROUP BY screen_name
	ORDER BY t.created_at DESC;
END$$

DELIMITER ;

DROP procedure IF EXISTS `Q23opt`;

DELIMITER $$
USE `group25`$$
CREATE DEFINER=`tstanger`@`%` PROCEDURE `Q23opt`(IN givenSubCategory VARCHAR(8), IN givenMonthList VARCHAR(40), IN givenYear INT, IN k INT)
BEGIN
	SELECT DISTINCT h.hashtag AS Hashtag, COUNT(h.hashtag) AS `Times It Appeared`
	FROM group25.hashtag h 
    INNER JOIN group25.tweets t ON h.hid = t.id
    INNER JOIN group25.users u ON t.posting_user = u.screen_name
	WHERE u.sub_category = givenSubCategory AND givenYear = YEAR(t.created_at) AND FIND_IN_SET(MONTH(t.created_at), givenMonthList)
	GROUP BY h.hashtag
	ORDER BY `Times It Appeared` DESC
	LIMIT k;
END$$

DELIMITER ;

DROP procedure IF EXISTS `Q27opt`;

DELIMITER $$
USE `group25`$$
CREATE DEFINER=`tstanger`@`%` PROCEDURE `Q27opt`(IN k INT, IN givenYear INT, IN givenMonthOne INT, IN givenMonthTwo INT)
BEGIN
	SELECT DISTINCT u.screen_name
	FROM group25.tweets t
    INNER JOIN group25.users u ON t.posting_user = u.screen_name
	WHERE (givenYear = YEAR(t.created_at) AND (givenMonthOne = MONTH(t.created_at) OR givenMonthTwo = MONTH(t.created_at)))
	ORDER BY t.retweeted_count DESC
	LIMIT k; 
END$$

DELIMITER ;

