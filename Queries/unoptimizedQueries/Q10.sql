USE `group25`;
DROP procedure IF EXISTS `Q10`;

DELIMITER $$
USE `group25`$$
CREATE DEFINER=`tstanger`@`%` PROCEDURE `Q10`(IN givenStateList VARCHAR(500), IN givenMonth INT, IN givenYear INT)
BEGIN
SELECT DISTINCT h.hashtag AS Hashtag, GROUP_CONCAT(DISTINCT u.location) AS States
FROM group25.users u, group25.tweets t, group25.hashtag h
WHERE h.hid = t.id AND t.posting_user = u.screen_name AND FIND_IN_SET(u.location, givenStateList) AND givenMonth = MONTH(t.created_at) AND givenYear = YEAR(t.created_at) AND NOT(u.location = 'na')
GROUP BY Hashtag;
END$$

DELIMITER ;