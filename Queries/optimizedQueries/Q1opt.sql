USE `group25`;
DROP procedure IF EXISTS `Q1opt`;

DELIMITER $$
USE `group25`$$
CREATE PROCEDURE `Q1opt` (IN k INT, IN givenMonth INT, IN givenYear INT)
BEGIN
	SELECT t.retweeted_count, t.tweet_text, t.posting_user, u.category, u.sub_category
	FROM group25.tweets t
	LEFT JOIN group25.users u ON t.posting_user = u.screen_name
	WHERE givenMonth = MONTH(t.created_at) AND givenYear = YEAR(t.created_at)
	ORDER BY t.retweeted_count DESC
	LIMIT k;
END$$

DELIMITER ;