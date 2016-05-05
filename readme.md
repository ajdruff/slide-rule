#Slide Rule Readme


##What is Slide Rule?

Slide Rule is a set of bash scripts that can be used to manage a development, staging, and live environment for a website. 

Once set-up, Git is used to check in development changes, and push to the live site.

It also provides scripts to automate website backups and migrations between domains.

##Why is it called Slide Rule? 

A slide rule is a tool to help you solve problems quickly. Its also a play on words in suggesting that the software can rule The first three consonants in the name  represent each different web environments.

S - Staging
L - Live
i
D - Development
e

R
U
L
E


##How Hard is it to set it up? 

Because there can be as many as 3 different web servers involved, an some manual steps in creating and configuring the database associated with each, it can be tedious and requires at least 30 minutes to an hour.

##Why Use Slide Rule? 


The biggest advantage to slide rule is the ability 



#Netbeans


Do I need to use Netbeans to use Slide Rule. No, but Netbeans provides a convenient place to run your bash scripts (instead of from the command line) as well as the SQL scripts that Slide Rule provides.

#Overview:



1. Create remote site on your Web Host
2. Create Remote WordPress Database on your Web Host

********** add all the overview steps here ***********


#Detailed Steps

##Remote Web Hosting Setup

###Create a new site

Below is an example using Web Hosting company Site5.com

1. Login to Multiadmin https://backstage.site5.com/
2. Click 'MultiAdmin'
3. Click 'Create Site'
4. Enter domain, contact email, username, and password. Place a checkmark for CGi and Shell access.

###Create the WordPress database

**Example Using Site 5**

1. Login to the SiteAdmin panel for your new site
2.  Click Databases/Manage Database and Users
3.  **Live Database:**
    1.  Enter 'wp' for the new database
    2.  Click 'Create Database and Add User'
    3.  Click 'Create User'
    4.  Enter username and password
    5.  Click 'Just Create User'
    6.  Click 'Assign New User' near the new database
    7.  Select Your New User and Click 'Assign'
4. **Staging Database:**
    1.  Enter wp_stage for the New Database
    2.  Click 'Just Create Database'
    3.  Click 'Assign New User'
    4.  Select the same user used for the live database  
5. **Development Database**


Add the db username, password and database name to the admin/config-mysql-stage/dev/live.conf files.  Note that usually, the same user and password is used for each of the client, mysql,mysqldump and mysqldiff sections.

You must also add the database information to the your site's WordPress  configuration files. For WordPress, see the `Configure WordPress` section.

**Create Database Scripts**

To create the database, you can execute the  `create-database` scripts either from the command line or directly from within Netbeans (see the Netbeans Project section for Run Environment configuration)

>Note that the create-database scripts may not work if you are using shared hosting due to permissions issues.



##Staging Subdomain

The staging site should reside on the same host as your live site but as a separate subdomain. This ensures that you can fully test the site under a similar environment as your live site. 

Create a subdomain. Below is an example of how you do this for cPanel on a shared hosting site ( Site5 was used for this example)






##Local Directory Setup

In the directory that  will hold your local dev files(mine is `C:\wamp\www` , do the following:

1. Create a folder with the name of your website, e.g. `C:\wamp\www\ajdruff.com`
2. Create a subdirectory `home`  , e.g.: `C:\wamp\www\ajdruff.com\home`
3. Now Clone this project or download and place the contents in a directory called 'slide-rule', so you have the following directory structure or something similar (the folder names may change or you may have a different number of fdirectories)

4. Create a new directory `site-templates` and place the contents of what you want to serve as the basis of your new site. This can be anything from a single index.html file to an entire example WordPress site. 

For this example, we'll clone my bplate-wp project.                

wamp
+---www
    +---example.com
        +---home
        +---slide-rule
        +---site-templates
            +---bplate-wp           


#Local Git Repos

##Create the home repo

    cd "cygdrive/c/wamp/www/example.com/home"
    git init

##(Optional) Create a new branch for slide-rule

To ensure that we capture any new scripts we create or any modifications to existing scripts.

    cd "cygdrive/c/wamp/www/example.com/home"
    git checkout -b 'example.com'






##Netbeans Project

You can run slide-rule scripts directly from within Netbeans. Just include the slide-rule directory in your project files and configure the run environment to use bash. 

Example Setup:

1. Click 'New Project'
    * Select 'PHP' and 'PHP Application with Existing Sources'
    * Sources Folder: `C:\www\example.com`
    * Run As: Local Web Site
    * Project URL: http://example.com
2.  Configure the Run Environment
    * Click 'Run'
    * Click 'Set Project Configuration'
    * Click 'Customize'
    * Click 'New'
    * Configuration Name: Bash Script
    * Run as : Script (run in command line)
    * PHP Interpreter: C:\cygwin\bin\bash.exe   (change this to the path to your local bash shell)


##Slide Rule Configuration

1. From the `templates` directory, copy all files that begin with 'config-' to the admin directory

```
            cp templates/config-* admin/
```


2. Edit the `config`  files you copied into the admin directory and replace values for each variable with values that match your setup. Read the comments in each configuration file for more information.

The files may include (this may not be the exhaustive list)

    - config-bash.conf
    - config-bash-advanced.conf
    - config-mysql-dev.conf
    - config-mysql-live.conf
    - config-mysql-stage.conf
    - config-sql.sql





##Setup Keys

    
    
    #copy the local key to the authorized key file
    cat /local/path/to/id_rsa.pub | ssh user@example.com "mkdir -p ~/.ssh;  cat>~/.ssh/authorized_keys;"
    #set permissions
    ssh user@example.com
    chmod 600 ~/.ssh/authorized_keys; chmod 700 ~/.ssh


where /local/path/to/id_rsa.pub is the local path to your PUBLIC key file


**Example:**
   
    
    cat /home/adruff/.ssh/id_rsa.pub |ssh ajdruff@ajdruff.com "mkdir -p ~/.ssh;  cat>~/.ssh/authorized_keys;"
    ssh ajdruff@ajdruff.com
    chmod 600 ~/.ssh/authorized_keys; chmod 700 ~/.ssh





#Run the Setup Scripts

From a command line, execute setup.sh. 

    ./setup.sh


This will do the following:
* set correct permissions locally
* execute setup-repo-remote.sh which does the following:
    - creates a remote git repo on your live server
    - uploads the git post-receive script (post-receive.sh) to your live server that ensures that the master branch is checked out into your live web root whenever you do a push, and archives any changes that were made on the live server that were not checked in
* execute setup-repo-local.sh which:
* copies the site template files over to 'home'

#Configure WordPress (if applicable)


*`/home/_live/config` directory:*

* copy wp-config-db-sample.wp to wp-config-db.php and add your database values for the production(live) database

*`/home/_stage/config` directory:*

* copy wp-config-db-sample.wp to wp-config-db.php and add your database values for the staging database

*`/home/config` directory:*
copy wp-config-db-sample.wp to wp-config-db.php and add your database values for the dev database


##Local Dev Server Setup (WAMP)

###Host File

Edit your hosts file and/or dns server and add entries for your staging, production, and development domains. Modify per your particular setup and hosting IP. Below is an example:

    174.36.179.67 example.com #prod
    174.36.179.67 stage.example.com #staging
    127.0.0.1 example-dev.com #dev server
    



##Virtual Host

Configure your Web Server to point your development domain (e.g: example-dev.com) to your web root under the `home` directory. 

For example, if you used the bplate-wp site template with the `public_html` directory under the `home` directory, after running the setup scripts, your full path to the root would be 
`C:wamp\www\example.com\home\public_html`. 

You can choose your own url, but it should be different from your live server. For example.com , you might want to use `example-dev.com` for your development server


See your Dev server's documentation for specifics on how to do this. Its different for UwAmp, MAMP, WAMP, etc.


##Live Configuration Files

    ./push-config-live.sh

This will push configuration files ( but won't check them in to the git repo ) 
to the live server. Note that before you do this, WordPress will give database connection errors if you pushed to master before you ran this script.

#Go Live!

Once you've run the setup script, your local `home` directory should be checked out to a    `dev` branch. To go live, you need to fetch the branches from the remote live git repo, merge your dev branch into it, and then push the live branch back to the remote.

1. Commit your changes to your branch
2. Merge your branch to dev
3. Fetch to update master
2. Merge dev to master 
3. push master to origin

Pushing to Master will fire the post receive script which will merge them into the 'live' branch, checkout the live branch. If there were any changes on the server in the meantime, it will commit those changes to an archived branch which you can then fetch and checkout if you want to investigate.




**Troubleshooting:**



* ensure that the database connection works on the remote host. probably you didn't white list your IP.
* add a step where you setup WordPress or upload a database or something.
* database connection errors when trying to connect. You didn't configure your database connection files and/or did not run the `push-config-live.sh` script.

#Notes: (clean this up before publication!)

##git exclude
The .git repo exists on the remote server at the root of your server. It excludes every folder except those that are excepted. In the default setup , this is public_html or whatever folder you have configured.

so it looks like this : 
#to include a directory, !/relative/path/to/directory/from/git/root/no/ending/slash
!/public_html
!/config




