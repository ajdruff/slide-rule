
-- ##############################################################################################
-- ##############################################################################################
-- ###################################################
-- #########  Convert To Dev
-- ###########################################
-- #########  Use this file to convert a live WordPress database to a Dev one
-- ##############################################################################################
-- ##############################################################################################

-- Note you cannot use variables with the USE statement or anything else that expects an identifier



-- ###########################################
-- ######### CONFIG
-- ###########################################
use `clients_glandscapedesign_wp`;
SET @DATABASE_NAME='clients_glandscapedesign_wp';
SET @DOMAIN_LIVE='glandscapedesign.com';
SET @DOMAIN_DEV='glandscapedesign-dev.com';
SET @ROOT_PATH_LIVE='/home/gscape/public_html/glandscapedesign.com'; -- '/home/thewhitewhale/public_html/glandscapedesign.com';
SET @ROOT_PATH_DEV='E:/users/dev_cygwin/cygwin/home/adruff/wamp-www/clients/glandscapedesign.com/website/public_html';

-- optional : to test , surround with START TRANSACTION and ROLLBACK
-- START TRANSACTION;

-- ROLLBACK;




-- ###########################################
-- ######### Domain
-- ###########################################


UPDATE wp_options set option_value = replace(option_value, @DOMAIN_LIVE, @DOMAIN_DEV);
UPDATE wp_postmeta set meta_value = replace(meta_value,  @DOMAIN_LIVE, @DOMAIN_DEV);

-- Guids should not be changed or may cause feedreaders to re-display content.
-- uncomment only if this is used for dev/live or live/dev.
-- see http://codex.wordpress.org/Changing_The_Site_URL#Important_GUID_Note
-- UPDATE wp_posts set guid = replace(guid,  @DOMAIN_LIVE, @DOMAIN_DEV);
UPDATE wp_posts set post_content = replace(post_content,  @DOMAIN_LIVE, @DOMAIN_DEV);

-- use nomstock_wp_dev;UPDATE wp_posts set post_name = replace(post_name, @SEARCHFOR, @REPLACEWITH);


-- ###########################################
-- ######### Root Path
-- ###########################################
UPDATE wp_options set option_value = replace(option_value, @ROOT_PATH_LIVE, @ROOT_PATH_DEV);
-- ###########################################
-- ######### Content Links
-- ###########################################

-- select * from wp_options where option_value like "%/home/thewhitewhale/public_html/glandscapedesign.com%"
-- to see all paths


