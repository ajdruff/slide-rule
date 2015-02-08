
-- note that the outfile cannot be a variable or a syntax error will result
select * from `wp_options` where `option_name` LIKE 'gblu%'
into outfile 'options.csv'
FIELDS TERMINATED BY '|' 
-- OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';



delete  from `wp_options_copy` where  `option_name` in ('gblu%');
LOAD DATA INFILE 'C:\\wamp\\www\\clients\\glandscapedesign.com\\website\\temp\\options.csv'  INTO TABLE wp_options_copy
FIELDS TERMINATED BY '|' 
LINES TERMINATED BY '\r\n';






