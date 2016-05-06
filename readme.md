#Readme

##Slide Rule 
( A **S**taging,**L**ive, and **D**evelopment **E**nvironment administration tool for Web Developers)

##Contributors

Andrew Druffner <andrew@nomstock.com>

##Installation

<<<<<<< HEAD
##Local Directory Setup

In the directory that  will hold your local dev files(mine is `C:\wamp\www`) , do the following:

1. Create a folder with the name of your website, e.g. `C:\wamp\www\ajdruff.com`
2. Create a subdirectory `home`  , e.g.: `C:\wamp\www\ajdruff.com\home`
3. Now Clone this project or download and place the contents in a directory called 'slide-rule', so you have the following directory structure or something similar (the folder names may change or you may have a different number of fdirectories)

4. Create a new directory `site-templates` and place the contents of what you want to serve as the basis of your new site. This can be anything from a single index.html file to an entire example WordPress site. 

For this example, we'll clone my bplate-wp project.                

```

wamp
+---www
    +---example.com
        +---home
        +---slide-rule
        +---site-templates

```
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
=======
To install Slide Rule, see the detailed [installation guide](https://github.com/ajdruff/slide-rule/blob/master/docs/getting-started.md).
>>>>>>> ajdruff.com

##What is Slide Rule?


Slide Rule is a set of bash  and SQL scripts that can be used to manage source control, publishing, backups, and migrations for a development, staging, and live environment for a website. 

It uses Git to manage file changes between your dev and production environments, and provides a bash script that can push your dev changes to a staging enviroment for testing or demo.


**With Slide Rule installed:**

* You'll have greater control of tracking source changes on your live and dev servers
* You work locally on a Git development branch. When ready to go live, you simply push to the master branch. 
* Changes made on your production server that conflict with your latest development push are prevented from being overwritten. Slide Rule does this by automatically archiving production server files to their own branch when a master push conflicts with them.
* Server admin is easier, enabling you to:
    - backup each environment's database
    - backup the live server
    - convert WordPress database to a new domain
    - update WordPress passwords and users
    - When integrated with a development IDE such as Netbeans, you rarely have to resort to a command line when deploying.



##Setup and Requirements

Slide Rule installation involves cloning the project, configuring the scripts, and executing a setup script that sets up Git repos on the dev and production server.

For a complete installation walkthrough, see the [installation guide](https://github.com/ajdruff/slide-rule/blob/master/docs/getting-started.md).


**Slide Rule requires:**

* a linux environment that supports bash on your dev machine (cygwin or native)
* Git on both your development machine (your desktop machine) and web host (production server)


##Why Use Slide Rule? 


The biggest advantage to Slide Rule is in enforcing Git source control on both the development and production servers. It helps you setup Git so that you can work on your dev files locally, and push them to your production server when you want to go live.

An added advantage is that it provides a convenient place to add all the scripts you use to manage your servers. 


#Does it work only with WordPress?

Slide Rule basically just copies files to and from web environments, and provides scripts to create and backup databases. Although some scripts are intended to work with a WordPress database (the scrub scripts for example), Slide Rule can work with just about any site that supports bash and ssh.


#Netbeans (or similar IDE) Recommended

Although Netbeans is not a requirement to run Slide Rule, it is recommended.

By adding  Slide Rule to the same Netbeans project that contains your development files, you have a  more efficient work environment when you are ready to deploy your changes to staging or production.

You'll be able to execute the scripts with a few clicks without resorting to the command line.


##Slide Rule Usage: Making and Publishing Development Changes

Create a development branch to make your changes

    git checkout -b example.com

Commit Your Changes

    git commit -a -m 'updated theme'

Merge to dev

    git fetch
    git checkout dev
    git merge example.com
    git checkout master
    git merge dev


Go Live (Push files to production server): 

    git push master


