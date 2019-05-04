USE `group25`;
DROP procedure IF EXISTS `Q15`;

DELIMITER $$
USE `group25`$$
CREATE DEFINER=`tstanger`@`%` PROCEDURE `Q15`(IN givenSubcategory VARCHAR(8), IN givenMonth INT, IN givenYear INT)
BEGIN
	SELECT u.screen_name, u.location, GROUP_CONCAT(url.link) AS all_links_for_given_month_and_year
	FROM group25.users u, group25.tweets t, group25.url
	WHERE u.screen_name = t.posting_user AND url.uid = t.id AND MONTH(t.created_at) = givenMonth AND YEAR(t.created_at) = givenYear AND givenSubcategory = u.sub_category
	GROUP BY screen_name
	ORDER BY t.created_at DESC;
END$$

DELIMITER ;