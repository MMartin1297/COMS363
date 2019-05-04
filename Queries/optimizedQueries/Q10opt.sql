USE `group25`;
DROP procedure IF EXISTS `Q10opt`;

DELIMITER $$
USE `group25`$$
CREATE PROCEDURE `Q10opt` (IN givenStateList VARCHAR(500), IN givenMonth INT, IN givenYear INT)
BEGIN
	SELECT DISTINCT h.hashtag AS Hashtag, GROUP_CONCAT(DISTINCT u.location) AS States
	FROM group25.tweets t
	INNER JOIN group25.users u ON t.posting_user = u.screen_name
	INNER JOIN group25.hashtag h ON t.id = h.hid
	WHERE FIND_IN_SET(u.location, givenStateList) AND givenMonth = MONTH(t.created_at) AND givenYear = YEAR(t.created_at) AND NOT(u.location = 'na')
	GROUP BY Hashtag;
END$$

DELIMITER ;