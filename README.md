# Bash

The repository for my own bash scripts

The scripts were written for familiarization with the bash in education purpose.

Even so, they solve some problems.

Consist from:

1.  eWebServer - is wrapper for LAMP, who can start,stop,restart LAMP services(apache2, mysql) from icon's quicklist located in unity panel.

    Available functional  from icon's quicklist:
    1. do start, stop, restart or get status for one of services apache2, mysql
    2. full(start, stop, restart) action applied for all services(apache2, mysql)
    3. fullCheck - check services on is active and is enabled
    4. create host - run script for quickly host creating and adding

    More commands are available from the console mode.

    For install use install.sh,  who copy needfull files to needfull directories, namely to
    /usr/bin/eWebServer  - main file
    /usr/share/applications/eWebServer.desktop - config for unity link
    /usr/share/icons/hicolor/256x256/apps/eWebServer.png - image for icon
    Needful library files: help.sh, color.sh, createHost.sh, createHost.tmpl, serviceW.sh
    By default they copy from "../lib" directory to ~/.bin
    Template for apache host config copy to /etc/apache2/sites-available/tmpl.conf


2. servicew.sh - is wrapper for services, needfull for eWebServer, can apply some action on services


3. createHost - can create and add host to apache

   Functionality:
   - make dir for new site
   - generate and create host config for apache
   - create files index.php and .htaccess in public dir
   - add new host to /etc/hosts
   - add new host to apache2 (a2ensite)
   - restart apache2 in the end

   Config file: createHost.cfg
   Config template file: createHost.tmpl (need copy to /etc/apache2/sites-available/tmpl.conf)

4. color.sh - variables with colors code for console dialog


List with future abilities:
    - choose template for generation host config (createHost)
    - edit some config parameters from console dialog (createHost)
    - work with mysql backup from icon's quicklist