set @USER_ID=1000;
SET @USER_LOGIN='YOUR_WP_USERNAME';
SET @USER_PASS='YOUR_WP_PASSWORD';
SET @USER_NICENAME='YOUR_WP_FULL_NAME';
SET @USER_EMAIL='YOUR_EMAIL_ADDRESS';
SET @USER_URL='';

SET @USER_DISPLAY_NAME='Site Admin';
SET @USER_REGISTERED='2015-01-28 20:18:23.000';


--  #####################################################################
-- do not edit below this line unless you know what you are doing!
 -- '2015-28-01 00:00:00';
SET @USER_ACTIVATION_KEY='';-- use empty string
set @USER_LEVEL=10; -- http://codex.wordpress.org/User_Levels#User_Levels_9_and_10
set @USER_ROLE='administrator'; -- administrator,editor,author,contributor,subscriber http://codex.wordpress.org/Roles_and_Capabilities



-- admin settings:
-- set @USER_LEVEL=10; -- http://codex.wordpress.org/User_Levels#User_Levels_9_and_10
-- set @USER_ROLE='administrator'; -- administrator,editor,author,contributor,subscriber http://codex.wordpress.org/Roles_and_Capabilities

INSERT INTO `wp_users` 
(
`ID`, 
`user_login`, 
`user_pass`, 
`user_nicename`, 
`user_email`, 
`user_url`, 
`user_registered`, 
`user_activation_key`, 
`user_status`, 
`display_name`)
 VALUES 
(
@USER_ID, -- id
@USER_LOGIN, -- user_login 
 MD5(@USER_PASS), -- user_pass 
@USER_NICENAME, -- user_nicename 
@USER_EMAIL, -- user_email 
@USER_URL, -- user_url 
@USER_REGISTERED, -- user_registered , date time or null
'', -- user_activation_key 
0, -- user_status   -- user_status is deprecated https://wordpress.org/support/topic/what-is-the-status-of-user_status
@USER_DISPLAY_NAME-- display_name 
);


INSERT INTO 
`wp_usermeta` 
(
`umeta_id`,
 `user_id`, 
`meta_key`, 
`meta_value`
) VALUES 
(
NULL, -- umeta_id
@USER_ID,  -- user_id
'wp_capabilities',  -- meta_key
CONCAT('a:1:{s:13:"',@USER_ROLE,'";s:1:"1";}') -- meta_value
);



INSERT INTO 
`wp_usermeta` 
(`umeta_id`, 
`user_id`, 
`meta_key`, 
`meta_value`
) 
VALUES 
(
NULL, -- umeta_id
@USER_ID, -- user_id
'wp_user_level', -- meta_key
@USER_LEVEL -- meta_value 
);