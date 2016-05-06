
#Intro

The following is a detailed guide on installing 
[Slide Rule](https://github.com/ajdruff/slide-rule),


##Assumptions

* *You are starting with a brand new site and do not have  existing files on your production site
* You are running on a LAMP like environment 
* Your Live Site is on shared hosting (not required)
* Your Staging environment is a subdomain of your live site.
* You've already created a SSH key pair to use for connection to your live site and running scripts.

>*If you are trying to add Slide Rule to an existing site, you must first backup your production files and use them as your website template, placing them in the 'site-templates' folder before running your setup script.

##Installation Overview

Major Installation Steps Include:

* Live Server Setup
* Staging Server Setup (Optional)
* Dev Server Setup
* Local Directory Setup
* Slide Rule Configuration
* Slide Rule Setup Script
* Configure WordPress (if applicable)
* Go Live
* Setup WordPress (if applicable)
* Create a Netbeans Project (Optional)
* Troubleshooting
* Notes





##Live Server Setup


###Create a new web root for your domain

On your production server, shared hosting account or VPS,  create a new virtual host or standalone web site. 

Below is an example using Web Hosting company Site5.com

1. Login to Multiadmin https://backstage.site5.com/
2. Click 'MultiAdmin'
3. Click 'Create Site'
4. Enter domain, contact email, username, and password. Place a checkmark for CGi and Shell access.

###Create the WordPress database (If applicable)

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


Add the db username, password and database name to the admin/config-mysql-stage/dev/live.conf files.  Note that usually, the same user and password is used for each of the client, mysql,mysqldump and mysqldiff sections.

You must also add the database information to the your site's WordPress  configuration files. For WordPress, see the `Configure WordPress` section.

**Create Database Scripts**

To create the database, you can execute the  `create-database` scripts either from the command line or directly from within Netbeans (see the Netbeans Project section for Run Environment configuration)

>Note that the create-database scripts may not work if you are using shared hosting due to permissions issues.



###SSH Keys

Slide Rule uses SSH to communicate with your remote web servers securely, and so requires that your ssh public key be uploaded to the server's authorized key file.

For more information on creating a public/private key pair, see [GitHub's 'Generating an SSH key' guide](https://help.github.com/articles/generating-an-ssh-key/).
    
    
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



##Staging Server Setup

The staging site should reside on the same host as your live site but as a separate subdomain. This ensures that you can fully test the site under a similar environment as your live site. 

###Create the subdomain. 

Below is an example of how you do this for cPanel on a shared hosting site ( Site5 was used for this example)

1. Login to your cPanel (SiteAdmin for Site5) for your site
2. Click 'Domains'
3. Click 'Subdomains'
4. For 'Subdomain:' enter 'stage'
5. For Document Root, make sure it says 'public_html/stage' so the full path is `/home/username/public_html/stage`
6. Click 'Create'

 
###Update the local hosts file or DNS record

Edit your hosts file and/or dns server and add an entry for your staging url. 

Below is an example of what a host entry might look like:

    174.36.179.67 stage.example.com #staging

Its recommended that a remote DNS record isn't used to discourage googlebot spidering.



##Development Server Setup

###Create the Development Server Database

Create the MySQL database using the steps appropriate for your particular setup. If you are using WAMP or similar, you can use the `create-database-dev.sh` script in Slide Rule. Before using it, complete the 'Slide Rule Configuration' so that the script has access to the database user and password.


###Virtual Host

Configure your Web Server to point your development domain (e.g: example-dev.com) to your web root under the `home` directory. 

For example, if you used the bplate-wp site template with the `public_html` directory under the `home` directory, after running the setup scripts, your full path to the root would be 
`C:wamp\www\example.com\home\public_html`. 

You can choose your own url, but it should be different from your live server. For example.com , you might want to use `example-dev.com` for your development server


See your Dev server's documentation for specifics on how to do this. Its different for UwAmp, MAMP, WAMP, etc.
    

###Update the local hosts file or DNS record

Edit your hosts file and/or dns server and add an entry for your staging url. 

Below is an example of what a host entry might look like:

    127.0.0.1 example-dev.com #dev server

Its recommended that if your dev server is remote, a remote DNS record isn't used to discourage googlebot spidering.




##Local Directory Setup

In the directory that  will hold your local dev files(mine is `C:\wamp\www`) , do the following:

1. Create a directory with the name of your website, e.g. `C:\wamp\www\example.com`
2. Create a subdirectory `home` under the `example.com` directory , e.g.: `C:\wamp\www\example.com\home`


3. Create a subdirectory `site-templates` under the `example.com` directory  , e.g.: `C:\wamp\www\example.com\site-templates`
4.  Within the `site-templates` directory, place the files for your new site. This can be anything from a single index.html file to an entire example WordPress site. 

    In this example, I cloned a WordPress installation template project I created, `bplate-wp`. 

        cd c:\wamp\www\example.com\site-templates
        git clone https://github.com/ajdruff/bplate-wp.git

 

5. Git clone Slide Rule or download and place the contents in a directory called 'slide-rule'.


        cd c:\wamp\www\example.com
        git clone https://github.com/ajdruff/slide-rule.git


6. Your local development directory that contains your project files should now look something like this : 


``````````````

c
wamp
+---www
    +---example.com
        +---home
        +---slide-rule
        +---site-templates
            +---bplate-wp           


````````````````



##Slide Rule Configuration

Before running any Slide Rule script, you'll need to tell Slide Rule where your files are located and providing it with your database credentials. Do this by editing its configuration files.


1. From the `templates` directory, copy all files that begin with 'config-' to the admin directory

        cp templates/config-* admin/


2. Edit the `config`  files you copied into the admin directory and replace values for each variable with values that match your setup. Read the comments in each configuration file for more information.

    The files should include the following (this list may change depending on the version of Slide Rule you are using)

    - config-bash.conf
    - config-bash-advanced.conf
    - config-mysql-dev.conf
    - config-mysql-live.conf
    - config-mysql-stage.conf
    - config-sql.sql









##Slide Rule Setup Script

From a command line, execute setup.sh. 

    ./setup.sh


This will do the following:
* set correct permissions locally
* execute setup-repo-remote.sh which does the following:
    - creates a remote git repo on your live server
    - uploads the git post-receive script (post-receive.sh) to your live server that ensures that the master branch is checked out into your live web root whenever you do a push, and archives any changes that were made on the live server that were not checked in
* execute setup-repo-local.sh which:
* copies the site template files over to 'home'







##Configure WordPress (if applicable)


*`/home/_live/config` directory:*

* copy wp-config-db-sample.wp to wp-config-db.php and add your database values for the production(live) database

*`/home/_stage/config` directory:*

* copy wp-config-db-sample.wp to wp-config-db.php and add your database values for the staging database

*`/home/config` directory:*
copy wp-config-db-sample.wp to wp-config-db.php and add your database values for the dev database




##Go Live!


###Upload the Production Configuration Files

    ./push-config-live.sh

This will upload the production server's configuration files ( but won't check them in to the git repo ) 
to the live server. If you skip this step and try to run WordPress, you'll get database connection errors.

>Note that this step only needs to be done on the initial site setup and thereafter only when there are changes to the live site's configuration (ie, database password change)

###Git push to master

Once you've run the setup script, your local `home` directory should be checked out to a    `dev` branch. To go live, you need to fetch the branches from the remote live git repo, merge your dev branch into it, and then push the live branch back to the remote.

1. Commit your changes to your branch
2. Merge your branch to dev
3. Fetch to update master
2. Merge dev to master 
3. push master to origin

Pushing to Master will fire the post receive script which will merge them into the 'live' branch, checkout the live branch. If there were any changes on the server in the meantime, it will commit those changes to an archived branch which you can then fetch and checkout if you want to investigate.


##Setup WordPress (If applicable)

If everything went well, you can now visit http://example-dev.com and http://example.com and complete the WordPress setup.


##Create a Netbeans Project (Optional)

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







##Troubleshooting

**Database Connection Errors**

* check that you uploaded the live configuration files.
* check that there is no IP block for database connection (if you are experiencing connection errors while running a script). cPanel often blacklists all IPs for db administration unless you specifically white list yours.
* add a step where you setup WordPress or upload a database or something.
* database connection errors when trying to connect. You didn't configure your database connection files and/or did not run the `push-config-live.sh` script.

##Notes:

##git exclude
The .git repo exists on the remote server at the root of your server. It excludes every folder except those that are excepted. In the default setup , this is public_html or whatever folder you have configured.

so it looks like this : 

    ```
    
    #to include a directory, !/relative/path/to/directory/from/git/root/no/ending/slash
    !/public_html
    !/config
    
    ```




#Todo:#

create a video showing:
* installation
* site database migration
* site backup
* admin changes made on live, need to push to dev
* admin changes made on dev, mneed to push to live
* a non-database setup (DownCast)
        
