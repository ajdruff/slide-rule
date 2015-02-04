
-- ##############################################################################################
-- ##############################################################################################
-- #########  WordPress Queries for Deployment and Maintenance
-- #########  Each query is designed to be run on a single line, with the 'use database' line
-- #########  the first command it executes to ensure safety when working with multiple databases
-- #########  tip: Do a search and replace on the entire file when working with a single database 
-- ##############################################################################################
-- ##############################################################################################

-- Note you cannot use variables with the USE statement or anything else that expects an identifier


-- ###########################################
-- #########  Update Password
-- ###########################################
--  start config
SET @WPPASSWORD='vvWGs3fR7M';
SET @WPUSER='ns_admin';
use hosthubb_wp;UPDATE wp_users SET user_pass = MD5(@WPPASSWORD) WHERE user_login =@WPUSER LIMIT 1;




--###########################################
--#########  Update tables with a Search and Replace
-- ###########################################
-- start config

SET @SEARCHFOR='dinghyreviews.com';
SET @REPLACEWITH='dinghyreviews-dev.com';
-- end config
use dingrevs_wp;UPDATE wp_options set option_value = replace(option_value, @SEARCHFOR, @REPLACEWITH);
UPDATE wp_postmeta set meta_value = replace(meta_value, @SEARCHFOR, @REPLACEWITH);
-- use nomstock_wp_dev;UPDATE wp_posts set guid = replace(guid, @SEARCHFOR, @REPLACEWITH);
-- #use nomstock_wp_dev;UPDATE wp_posts set post_content = replace(post_content, @SEARCHFOR, @REPLACEWITH);
-- use nomstock_wp_dev;UPDATE wp_posts set post_name = replace(post_name, @SEARCHFOR, @REPLACEWITH);

-- ###########################################

SET @SEARCHFOR='dinghyreviews.com';
SET @REPLACEWITH='dinghyreviews-dev.com';
-- end config
use dingrevs_wp;UPDATE wp_postmeta set meta_value = replace(meta_value, @SEARCHFOR, @REPLACEWITH);


-- ###########################################
-- #########  Select Query with Like
-- ###########################################
-- start config

-- end config
use nomstock_wp_dev;select *  from wp_options where option_name LIKE '%manager%';
-- use nomstock_wp_dev;select *  from wp_options where option_name LIKE '%rule%';


-- ###########################################

-- ###########################################
-- #########  View all Posts by Certain Author and After Date
-- #########  View  all posts, pages, and custom post types for a specific author
-- ###########################################
-- start config

SET @WPUSERID='1'
-- end config ----
use nomstock_wp_dev;Select * FROM wp_posts a LEFT JOIN wp_term_relationships b ON (a.ID = b.object_id)LEFT JOIN wp_postmeta c ON (a.ID = c.post_id) WHERE a.post_author = @WPUSERID and  WHERE post_date < "2013-01-01";
-- ###########################################


-- ###########################################
-- #########  View all Media Attachements ( useful for checking to make sure you have everything in your library_
-- ###########################################
-- start config

SET @WPUSERID='1'
-- end config
Use @WPDATABASE Select * FROM wp_posts a LEFT JOIN wp_term_relationships b ON (a.ID = b.object_id) LEFT JOIN wp_postmeta c ON (a.ID = c.post_id) WHERE post_type = 'attachment'

-- ###########################################


-- ##############################################################################################
-- #########  DELETE QUERIES
-- ##############################################################################################


-- ###########################################
-- #########  Delete all comments
-- ###########################################
-- start config

-- end config
use nomstock_wp_dev;TRUNCATE TABLE wp_comments;
-- ###########################################


-- ###########################################
-- #########  Delete all Posts before a certain date ( useful to cleanup initial install)
-- #########   (includes view query for safety) 
-- ###########################################
-- start config

SET @EARLIESTDATE='2013-01-01'
-- end config
use nomstock_wp_dev;Select * FROM wp_posts a LEFT JOIN wp_term_relationships b ON (a.ID = b.object_id) LEFT JOIN wp_postmeta c ON (a.ID = c.post_id) WHERE post_date < @EARLIESTDATE;
use nomstock_wp_dev;Delete a,b,c FROM wp_posts a LEFT JOIN wp_term_relationships b ON (a.ID = b.object_id) LEFT JOIN wp_postmeta c ON (a.ID = c.post_id) WHERE post_date < @EARLIESTDATE;
-- ###########################################





-- ###########################################
-- #########  Delete all Posts 
-- #########  delete all posts, pages, and custom post types for a specific author
-- #########   (includes view query for safety) 
-- ###########################################
-- start config

SET @WPUSERID='1'
-- end config
use nomstock_wp_dev;Select * FROM wp_posts a LEFT JOIN wp_term_relationships b ON (a.ID = b.object_id)LEFT JOIN wp_postmeta c ON (a.ID = c.post_id) WHERE a.post_author = @WPUSERID;
use nomstock_wp_dev;Delete a,b,c FROM wp_posts a LEFT JOIN wp_term_relationships b ON (a.ID = b.object_id)LEFT JOIN wp_postmeta c ON (a.ID = c.post_id) WHERE a.post_author = @WPUSERID;
-- ###########################################





