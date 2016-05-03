-- e.g.: example-dev.com
SET @DOMAIN_DEV='example-dev.com';
-- e.g.: example.com
SET @DOMAIN_LIVE='example.com';
-- e.g.: stage.example.com
SET @DOMAIN_STAGE='stage.example.com';
-- Absolute Path to doc root for dev server.  No ending slash e.g.:'C:/wamp/www/public_html' 
SET @ROOT_PATH_DEV='C:/wamp/www/public_html';
-- Absolute Path to doc root for live server.  No ending slash e.g.:'/home/username/public_html'
SET @ROOT_PATH_LIVE='/home/username/public_html';

-- Absolute Path to doc root for stage server.  No ending slash e.g.:'/home/username/stage/public_html' 
SET @ROOT_PATH_STAGE='/home/username/stage/public_html';