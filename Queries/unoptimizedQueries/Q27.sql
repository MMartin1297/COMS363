USE `group25`;
DROP procedure IF EXISTS `Q27`;

DELIMITER $$
USE `group25`$$
CREATE DEFINER=`tstanger`@`%` PROCEDURE `Q27`(IN k INT, IN givenYear INT, IN givenMonthOne INT, IN givenMonthTwo INT)
BEGIN
	SELECT DISTINCT u.screen_name
	FROM group25.users u, group25.tweets t
	WHERE ((givenYear = YEAR(t.created_at) AND givenMonthOne = MONTH(t.created_at)) OR (givenYear = YEAR(t.created_at) AND givenMonthTwo = MONTH(t.created_at))) AND u.screen_name = t.posting_user 
	ORDER BY t.retweeted_count DESC
	LIMIT k;
END$$

DELIMITER ;