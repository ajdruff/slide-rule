#Readme

##Slide Rule 
( A **S**taging,**L**ive, and **D**evelopment **E**nvironment administration tool for Web Developers)

##Contributors

Andrew Druffner <andrew@nomstock.com>

##Installation

To install Slide Rule, see the detailed [installation guide](https://github.com/ajdruff/slide-rule/blob/master/docs/install.md).

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

For a complete installation walkthrough, see the [installation guide](https://github.com/ajdruff/slide-rule/blob/master/docs/install.md).


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


