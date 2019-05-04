USE `group25`;
DROP procedure IF EXISTS `Q3opt`;

DELIMITER $$
USE `group25`$$
CREATE PROCEDURE `Q3opt` (IN k INT, IN givenYear INT)
BEGIN
	SELECT COUNT(DISTINCT u.location) AS `Number of States`, GROUP_CONCAT(DISTINCT u.location) AS `List of States`, h.hashtag AS Hashtag
	FROM group25.hashtag h
    INNER JOIN group25.tweets t ON h.hid = t.id
    INNER JOIN group25.users u ON t.posting_user = u.screen_name
	WHERE YEAR(t.created_at) = givenYear AND NOT(u.location = 'na')
	GROUP BY Hashtag
	ORDER BY `Number of States` DESC
	LIMIT k;
END$$