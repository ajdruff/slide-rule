
-- ##############################################################################################
-- ##############################################################################################
-- ###################################################
-- #########  Convert To Live
-- ###########################################
-- #########  Use this file to convert a live WordPress database to a Dev one
-- ##############################################################################################
-- ##############################################################################################

-- Note you cannot use variables with the USE statement or anything else that expects an identifier



-- ###########################################
-- ######### CONFIG
-- ###########################################
use `gscape_wp`;
SET @DOMAIN_LIVE='glandscapedesign.com';
SET @DOMAIN_DEV='glandscapedesign-dev.com';
SET @ROOT_PATH_LIVE='/home/gscape/public_html/glandscapedesign.com';
SET @ROOT_PATH_DEV='E:/users/dev_cygwin/cygwin/home/adruff/wamp-www/clients/glandscapedesign.com/website/public_html';


-- optional : to test , surround with START TRANSACTION and ROLLBACK
-- START TRANSACTION;

-- ROLLBACK;


-- ###########################################
-- ######### Domain
-- ###########################################


UPDATE wp_options set option_value = replace(option_value, @DOMAIN_DEV, @DOMAIN_LIVE);
UPDATE wp_postmeta set meta_value = replace(meta_value,  @DOMAIN_DEV, @DOMAIN_LIVE);

-- Guids should not be changed or may cause feedreaders to re-display content.
-- uncomment only if this is used for dev/live or live/dev.
-- see http://codex.wordpress.org/Changing_The_Site_URL#Important_GUID_Note
-- UPDATE wp_posts set guid = replace(guid, @DOMAIN_DEV, @DOMAIN_LIVE);
UPDATE wp_posts set post_content = replace(post_content,  @DOMAIN_DEV, @DOMAIN_LIVE);

-- use nomstock_wp_dev;UPDATE wp_posts set post_name = replace(post_name, @SEARCHFOR, @REPLACEWITH);


-- ###########################################
-- ######### Root Path
-- ###########################################

UPDATE wp_options set option_value = replace(option_value, @ROOT_PATH_DEV, @ROOT_PATH_LIVE);

-- ###########################################
-- ######### Content Links
-- ###########################################

