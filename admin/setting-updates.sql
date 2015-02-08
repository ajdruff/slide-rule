use `clients_glandscapedesign_wp`;
SET @OLD_EMAIL_ADDRESS='design@g-blu.com';
SET @NEW_EMAIL_ADDRESS='adruff@gmail.com';


-- optional : to test , surround with START TRANSACTION and ROLLBACK

-- ###########################################
-- #########  Update Password
-- ###########################################

select * from wp_users 

START TRANSACTION;

UPDATE wp_users SET user_email = MD5(@WPPASSWORD) WHERE user_login =@WPUSER LIMIT 1;

ROLLBACK;
