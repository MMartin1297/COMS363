USE `group25`;
DROP procedure IF EXISTS `Q15opt`;

DELIMITER $$
USE `group25`$$
CREATE PROCEDURE `Q15opt` (IN givenSubcategory VARCHAR(8), IN givenMonth INT, IN givenYear INT)
BEGIN
	SELECT u.screen_name, u.location, GROUP_CONCAT(url.link) AS all_links_for_given_month_and_year
	FROM group25.url url
    INNER JOIN group25.tweets t ON url.uid = t.id
    INNER JOIN group25.users u ON t.posting_user = u.screen_name
	WHERE MONTH(t.created_at) = givenMonth AND YEAR(t.created_at) = givenYear AND givenSubcategory = u.sub_category
	GROUP BY screen_name
	ORDER BY t.created_at DESC;
END$$

DELIMITER ;