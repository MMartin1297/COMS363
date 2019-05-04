USE `group25`;
DROP procedure IF EXISTS `Q6opt`;

DELIMITER $$
USE `group25`$$
CREATE PROCEDURE `Q6opt` (IN k INT, IN givenHashtags VARCHAR(500))
BEGIN
	SELECT u.screen_name AS `Screen Name`, u.location AS State
	FROM group25.users u
	INNER JOIN group25.tweets t ON u.screen_name = t.posting_user
	INNER JOIN group25.hashtag h ON t.id = h.hid
	WHERE FIND_IN_SET(h.hashtag, givenHashtags)
	GROUP BY u.screen_name
	HAVING COUNT(DISTINCT h.hashtag) = (LENGTH(givenHashtags) - LENGTH(REPLACE(givenHashtags, ',', '')) + 1)
	ORDER BY u.followers DESC
	LIMIT k;
END$$

DELIMITER ;