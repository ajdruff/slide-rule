-- ###########################################
-- #########  Update Password
-- ###########################################

SET @WPPASSWORD='USER_PASSWORD_HERE'; -- Intenitally left blank in committed file
SET @WPUSER='WP_USER_NAME_HERE'; -- Intenitally left blank in committed file

-- UPDATE wp_users SET user_pass = MD5(@WPPASSWORD) WHERE user_login =@WPUSER LIMIT 1;
