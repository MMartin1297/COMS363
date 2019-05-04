USE `group25`;
DROP procedure IF EXISTS `Q1`;

DELIMITER $$
USE `group25`$$
CREATE DEFINER=`tstanger`@`%` PROCEDURE `Q1`(IN k INT, IN givenMonth INT, IN givenYear INT)
BEGIN
	SELECT t.retweeted_count, t.tweet_text, t.posting_user, u.category, u.sub_category
	FROM group25.tweets t, group25.users u
	WHERE givenMonth = MONTH(t.created_at) AND givenYear = YEAR(t.created_at) AND t.posting_user = u.screen_name
	ORDER BY t.retweeted_count DESC
	LIMIT k;
END$$

DELIMITER ;