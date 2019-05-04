USE `group25`;
DROP procedure IF EXISTS `Q6`;

DELIMITER $$
USE `group25`$$
CREATE DEFINER=`tstanger`@`%` PROCEDURE `Q6`(IN k INT, IN givenHashtags VARCHAR(500))
BEGIN
	SELECT u.screen_name AS `Screen Name`, u.location AS State
	FROM group25.users u, group25.tweets t, group25.hashtag h
	WHERE h.hid = t.id AND t.posting_user = u.screen_name AND FIND_IN_SET(h.hashtag, givenHashtags)
	GROUP BY u.screen_name
	HAVING COUNT(DISTINCT h.hashtag) = (LENGTH(givenHashtags) - LENGTH(REPLACE(givenHashtags, ',', '')) + 1)
	ORDER BY u.followers DESC
	LIMIT k;
END$$

DELIMITER ;