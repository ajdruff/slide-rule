
-- ##############################################################################################
-- ##############################################################################################
-- ###################################################
-- #########  Convert Dev To Stage
-- ###########################################
-- #########  Use this file to convert a Dev WordPress database to a Stage one
-- ##############################################################################################
-- ##############################################################################################

-- Note you cannot use variables with the USE statement or anything else that expects an identifier


-- optional : to test , surround with START TRANSACTION and ROLLBACK
-- START TRANSACTION;

-- ROLLBACK;


-- ###########################################
-- ######### Domain
-- ###########################################


UPDATE wp_options set option_value = replace(option_value, @DOMAIN_SEARCH, @DOMAIN_REPLACE);
UPDATE wp_postmeta set meta_value = replace(meta_value,  @DOMAIN_SEARCH, @DOMAIN_REPLACE);

-- Guids should not be changed or may cause feedreaders to re-display content.
-- uncomment only if this is used for dev/stage or stage/dev.
-- see http://codex.wordpress.org/Changing_The_Site_URL#Important_GUID_Note
-- UPDATE wp_posts set guid = replace(guid, @DOMAIN_SEARCH, @DOMAIN_REPLACE);
UPDATE wp_posts set post_content = replace(post_content,  @DOMAIN_SEARCH, @DOMAIN_REPLACE);

-- use nomstock_wp_dev;UPDATE wp_posts set post_name = replace(post_name, @SEARCHFOR, @REPLACEWITH);


-- ###########################################
-- ######### Root Path
-- ###########################################

UPDATE wp_options set option_value = replace(option_value, @ROOT_PATH_SEARCH, @ROOT_PATH_REPLACE);

-- ###########################################
-- ######### Content Links
-- ###########################################

