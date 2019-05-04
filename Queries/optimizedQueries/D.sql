USE `group25`;
DROP procedure IF EXISTS `deleteUser`;

DELIMITER $$
USE `group25`$$
CREATE PROCEDURE `deleteUser` (IN screenName VARCHAR(15))
BEGIN
	DELETE FROM group25.users WHERE (`screen_name` = screenName);
END$$

DELIMITER ;