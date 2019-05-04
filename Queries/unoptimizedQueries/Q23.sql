USE `group25`;
DROP procedure IF EXISTS `Q23`;

DELIMITER $$
USE `group25`$$
CREATE DEFINER=`tstanger`@`%` PROCEDURE `Q23`(IN givenSubCategory VARCHAR(8), IN givenMonthList VARCHAR(40), IN givenYear INT, IN k INT)
BEGIN
	SELECT DISTINCT h.hashtag AS Hashtag, COUNT(h.hashtag) AS `Times It Appeared`
	FROM group25.users u, group25.tweets t, group25.hashtag h
	WHERE h.hid = t.id AND t.posting_user = u.screen_name AND u.sub_category = givenSubCategory AND givenYear = YEAR(t.created_at) AND FIND_IN_SET(MONTH(t.created_at), givenMonthList)
	GROUP BY h.hashtag
	ORDER BY `Times It Appeared` DESC
	LIMIT k;
END$$

DELIMITER ;