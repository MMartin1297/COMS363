USE `group25`;
DROP procedure IF EXISTS `Q27opt`;

DELIMITER $$
USE `group25`$$
CREATE PROCEDURE `Q27opt` (IN k INT, IN givenYear INT, IN givenMonthOne INT, IN givenMonthTwo INT)
BEGIN
	SELECT DISTINCT u.screen_name
	FROM group25.tweets t
    INNER JOIN group25.users u ON t.posting_user = u.screen_name
	WHERE (givenYear = YEAR(t.created_at) AND (givenMonthOne = MONTH(t.created_at) OR givenMonthTwo = MONTH(t.created_at)))
	ORDER BY t.retweeted_count DESC
	LIMIT k;
END$$

DELIMITER ;