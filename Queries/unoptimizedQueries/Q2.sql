USE `group25`;
DROP procedure IF EXISTS `Q2`;

DELIMITER $$
USE `group25`$$
CREATE DEFINER=`tstanger`@`%` PROCEDURE `Q2`(IN k INT, IN givenHashtag VARCHAR(280), IN givenMonth INT, IN givenYear INT)
BEGIN
	SELECT u.screen_name, u.category, t.tweet_text, t.retweeted_count
	FROM group25.tweets t, group25.users u, group25.hashtag h
	WHERE givenMonth = MONTH(t.created_at) AND givenYear = YEAR(t.created_at) AND t.posting_user = u.screen_name AND h.hashtag = givenHashtag AND h.hid = t.id
	ORDER BY t.retweeted_count DESC
	LIMIT k;
END$$

DELIMITER ;