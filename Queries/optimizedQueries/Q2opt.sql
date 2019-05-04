USE `group25`;
DROP procedure IF EXISTS `Q2opt`;

DELIMITER $$
USE `group25`$$
CREATE PROCEDURE `Q2opt` (IN k INT, IN givenHashtag VARCHAR(280), IN givenMonth INT, IN givenYear INT)
BEGIN
	SELECT u.screen_name, u.category, t.tweet_text, t.retweeted_count
	FROM group25.tweets t
    INNER JOIN group25.hashtag h ON t.id = h.hid
    INNER JOIN group25.users u ON t.posting_user = u.screen_name
	WHERE givenMonth = MONTH(t.created_at) AND givenYear = YEAR(t.created_at) AND h.hashtag = givenHashtag
	ORDER BY t.retweeted_count DESC
	LIMIT k;
END$$

DELIMITER ;