USE `group25`;
DROP procedure IF EXISTS `insertUser`;

DELIMITER $$
USE `group25`$$
CREATE PROCEDURE `insertUser` (IN screenName VARCHAR(15), IN userName VARCHAR(50), IN location VARCHAR(30), IN subCategory VARCHAR(8), in follow INT, in followers INT, in category VARCHAR(22))
BEGIN
	INSERT INTO group25.users(`screen_name`, `name`, `location`, `sub_category`, `following`, `followers`, `category`)
    VALUES (screenName, userName, location, subCategory, follow, followers, category);
END$$

DELIMITER ;