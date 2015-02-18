#Getting Started With Slide Rule

#Initial Prep

make a complete backup of the live site if currently in production. 
place it in maintenance mode
check for a git install, if there is one, clone it local and back it entirely up since we will be replacing it.

make a copy of the example.com folder
place it in wamp/www/clients
configure slide-rule
pull on both bplate_wp and slide-rule to update their files
delete the bplate-wp .git since we are going to replace it with a local repo of the site
configure 
setup the databases
setup the remote repo.
setup the local repo
if this is an existing site, replace wp-content with the wp-content from the existing site



#configuration

Always add windows paths like this : c:/path/to/something/on/windows.
never like this : c:\path\to\... or c:\\path\\to\\...



#Install Dev Database

**option 1 - start from scratch**
1. Run the WordPress install script just as you would for any typical installation. 
2. run the clean database script to get rid of posts,etc.

    ./scrub-wp-database-dev.sh


**option 2 - Restore from a dev backup**

place a dev backup obtained using mysqldump into temp/wp_dev.sql

Now restore the backup: 

    #restore
    admin/restore-database-dev.sh

**option 3 - Import from a Live Database Backup**


*Method 1 - Backup Live Database and restore to dev*


obtain a live database backup using mysqldump and copy it to temp/wp_dev.sql
    
    OR

run the backup-database-live.sh script:

    cd /path/to/slide-rule/
    #backup live database 
    admin/backup-database-live
    #make copy
    cp temp/wp_live.sql temp/wp_dev.sql

Now import the Live database to dev

    #restore
    admin/restore-database-dev.sh

Replace all instances of the live domain and live server's root path with the dev equivilents

    #convert
    admin/fix-domain-on-dev-database-from-live-domain.sh



When you import a live database, if the theme isn't available, you may get a blank or corrupted page. To fix this , log in as admin and change the theme or make sure the theme of the live site is available in wp-content/themes folder.

Passwords: To login to admin, if you don't have the admin password, create your own admin account using the create-new-admin-user.sql script within Netbeans/slide-rule. 





*Method 2 - Push Live Database to Dev*

    
    #push from live to dev
    admin/push-database-live-to-dev.sh
  
You may have to run `create-new-admin-user.sql` within netbeans to create a new admin user.

    #login and reset the theme if necessary




#Install Live Database



**option 1 - start from scratch**

Normally, you would only do this if you didn't yet have a dev database ready to be published. 

1. Run the WordPress install script just as you would for any typical installation. 
2. Install a maintenance plugin until you are ready to publish.

**option 2 - Restore from a live backup**

place a live backup obtained using mysqldump into temp/wp_live.sql

Now restore the backup: 

    #restore
    admin/restore-database-live.sh

**option 3 - Import from a Dev Database Backup**


*Method 1 - Backup Dev Database and restore to Live*


obtain a Dev database backup using mysqldump and copy it to temp/wp_live.sql
    
    OR

run the backup-database-live.sh script:

    cd /path/to/slide-rule/
    #backup dev database 
    admin/backup-database-dev
    #make copy
    cp temp/wp_dev.sql temp/wp_live.sql

Now import the Dev database to Live

    #restore
    admin/restore-database-live.sh

Replace all instances of the live domain and live server's root path with the dev equivilents

    #convert
    admin/fix-domain-on-live-database-from-dev-domain.sh



When you import a live database, if the theme isn't available, you may get a blank or corrupted page. To fix this , log in as admin and change the theme or make sure the theme of the live site is available in wp-content/themes folder.

Passwords: To login to admin, if you don't have the admin password, create your own admin account using the create-new-admin-user.sql script within Netbeans/slide-rule. 





*Method 2 - Push Dev Database to Live*

    
    #push from Dev to Live
    admin/push-database-dev-to-live.sh
  
You may have to run `create-new-admin-user.sql` within netbeans to create a new admin user.

    #login and reset the theme if necessary



#Install WordPress Files

