#Getting Started With Slide Rule

#Assumptions/Cautions
If backup site is in git repository, be sure to make a copy of the entire repo, and 'clone' the repo so you have a complete backup. 

This procedure assumes you do NOT have a git repo on the remote site, since we'll be creating our own, so if there is one, create a complete backup before proceeding, then delete it.


#Tips

* If you are getting lost in what you are trying to do, focus on this : 
* Setup the local WAMP site first, then push to the live and staging sites. The dev site should always come first



#Overview (Broad Outline)

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

#Backup Live Site

make or obtain a complete backup of the live site if currently in production

including database and all files




##Create the Dev WAMP Folder

1. create a folder c:/wamp/www/clients/mynewsite.com and open it up in windows explorer
2. clone git@github.com:simpliwp/slide-rule.git  into it. when clone is finished you should have `mynewsite.com/slide-rule`
3. clone git@github.com:simpliwp/bplate-wp.git . when clone is finished you should have `mynewsite.com\bplate-wp`
4. delete the .git directory in both directories 
5. rename the bplate-wp directory 'home'

If starting from a template ( a template is just a folder you setup using the proceeding steps but without deleting the .git directories.):
 1.copy the template and rename it mynewsite.com
 2. pull from master to update both git repos
 3. delete .git directories once you are done updating

If you plan on making changes to slide-rule, don't delet its .git directory and instead checkout a new branch 'branch-blue.com'


create a netbeans project with existing sources and add the folders form the folde ryou just created.


#Configure 


Configuration files are contained in the 'templates' folder. 
You must make a copy of all configuration files and place them in the 'admin' folder.


1. Copy all files that begin with 'config' to the admin folder

e.g.:

    cp templates/config-* admin/
    
This is done so that any configuration changes are not pushed to the local repo since we ignore config files in the admin folder.

Alternately we considered using git-skip-worktree, but this proved cumbersome and can be overwritten if a git branch is reset (such as with a stash)




At a minimum, edit admin/config-bash.conf,config-mysql-live/dev/stage.conf for your installation.


Always add windows paths like this : c:/path/to/something/on/windows.
never like this : c:\path\to\... or c:\\path\\to\\...

#setup local WAMP Server


server name: example-dev.com
document root: C:\wamp\www\clients\gexample.com\home\public_html


#setup repos

after configuration, and removal of the .git directory in home, run the following:


    #setup remote repo
    admin/setup-repo-remote.sh








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

