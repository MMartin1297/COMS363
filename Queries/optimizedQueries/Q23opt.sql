USE `group25`;
DROP procedure IF EXISTS `Q23opt`;

DELIMITER $$
USE `group25`$$
CREATE PROCEDURE `Q23opt` (IN givenSubCategory VARCHAR(8), IN givenMonthList VARCHAR(40), IN givenYear INT, IN k INT)
BEGIN
	SELECT DISTINCT h.hashtag AS Hashtag, COUNT(h.hashtag) AS `Times It Appeared`
	FROM group25.hashtag h
    INNER JOIN group25.tweets t ON h.hid = t.id
    INNER JOIN group25.users u ON t.posting_user = u.screen_name
	WHERE u.sub_category = givenSubCategory AND givenYear = YEAR(t.created_at) AND FIND_IN_SET(MONTH(t.created_at), givenMonthList)
	GROUP BY h.hashtag
	ORDER BY `Times It Appeared` DESC
	LIMIT k;
END$$

DELIMITER ;