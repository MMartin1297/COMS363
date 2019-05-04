USE `group25`;
DROP procedure IF EXISTS `Q3`;

DELIMITER $$
USE `group25`$$
CREATE DEFINER=`tstanger`@`%` PROCEDURE `Q3`(IN k INT, IN givenYear INT)
BEGIN
	SELECT COUNT(DISTINCT u.location) AS `Number of States`, GROUP_CONCAT(DISTINCT u.location) AS `List of States`, h.hashtag AS Hashtag
	FROM group25.users u, group25.tweets t, group25.hashtag h
	WHERE YEAR(t.created_at) = givenYear AND h.hid = t.id AND t.posting_user = u.screen_name AND NOT(u.location = 'na')
	GROUP BY Hashtag
	ORDER BY `Number of States` DESC
	LIMIT k;
END$$

DELIMITER ;