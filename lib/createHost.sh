#!/usr/bin/env bash

PATH+=":~/.bin"
## 1st param is host name
## 2nd is folder name, where are located index.php
## 3rd is directory owner
## 4th is access rights
. createHost.cfg
## color for out in console
. color.sh
  
hostName=$1
## set params 
if [ ! -z $2 ]; then
    public=$2      
fi
if [ ! -z $3 ]; then
    owner=$3      
fi
if [ ! -z $4 ]; then
    access=$4      
fi

checkResponse()
{
## 1st param is answer from user
## 2nd param is default 
    if [ -z $1 ] && [ -a -n $2 ]; then
        $1 = $2
    fi
    if [ $1 = 'Y' -o $1 = 'y' ]; then
        return 1
    fi
    return 0
}

echo -en "${BLUE}Approve public folder: ${NORMAL}"
read -ei "${public}" public

## set host name, and directory for site's files
while [ -z $siteDir ]; do
    
    if [ -z $hostName ]; then
        echo -en "${BLUE}Enter host name: ${NORMAL}"
        read hostName  
        continue
    fi    
    
    tmpSiteDir=$home'/'$hostName
    
    if [ -f $tmpSiteDir ]; then
        echo -e "${LRED}${tmpSiteDir}${RED} - is a file, fix it!${NORMAL}"
        continue
    elif [ -d $tmpSiteDir ]; then
        echo -en "${BOLD}${tmpSiteDir}${NORMAL} - allready exist.\n${BLUE}Use existing directory?${NORMAL}(Y/n): "
        read response
        checkResponse $response 'Y'
        if [ $? -ne 1 ]; then
            hostName=''
            continue
        fi
    fi
    
    ## check directory for new site
    if [ -n $tmpSiteDir ]; then
        echo -e "${BLUE}Directory for index: ${BOLD}${tmpSiteDir}/${public}"
        echo -en "${BLUE}Owner: ${owner}, access rights: ${access} Confirm?${NORMAL}(Y/n): "
        read response    
        checkResponse $response 'Y'
        if [ $? -ne 1 ]; then
            hostName=''
            continue
        fi
        
        if [ ! -d $tmpSiteDir'/'$public ]; then
            sudo mkdir -p $tmpSiteDir'/'$public
            sudo chmod -R $access $tmpSiteDir
            sudo chown -R $owner:$owner $tmpSiteDir
            if [ -d $tmpSiteDir'/'$public ]; then
                echo -e "${GREEN}Directory: ${BOLD}${tmpSiteDir}/${public}${GREEN} was created${NORMAL}"
                echo -e "${GREEN}Owner: ${owner}, access rights: ${access}${NORMAL}"
            else
                echo -e "${RED} Can't create: ${BOLD}${tmpSiteDir}/${public}\n${RED}Check permission${NORMAL}"
                exit
            fi
        fi
        siteDir=$tmpSiteDir
    fi
done

## path to template for apache config generating 
in=$pathToConfig'/'$cfgPattern
if [ ! -f $in ]; then
    echo -e "${RED}File with pattern for apache config create is not exist! \n Dir - ${in} \n Fix it, and try again${NORMAL}"
fi
## path to apache site config (in apache/sites-available)
out=$pathToConfig'/'$hostName'.conf'
canUseOut=1;
if [ -f $out ]; then
    echo -en "${BLUE}File config for this host(${hostName}) is allredy exist. Y - Rewrite it, n - use existing config ${NORMAL}"
    read response
    checkResponse $response 'Y';
    if [ $? -ne 1 ]; then
        canUseOut=0
    fi
fi
## generating site's config for apache
if [ $canUseOut -eq 1 ]; then
    sed "s|:name:|$hostName|g; s|:mail:|$mail|g; s|:home:|$home|g; s|:public:|$public|g; s|:logPath:|$logPath|g" $in | sudo tee -a $out > /dev/null
    echo -e "${GREEN}Apache config file ${BOLD}${out}${GREEN} was created.${NORMAL}"
fi

createFile()
{
    file=$1
    owner=$2
    access=$3
    defText=$4
    if [ ! -f $file ]; then
        echo -en "${BLUE}Create ${file}?${NORMAL}(y/N): "
        read response
        checkResponse $response 'N'
        if [ $? -eq 1 ]; then
            echo $defText | sudo tee $file > /dev/null
            sudo chmod $access $file
            sudo chown $owner:$owner $file
            if [ -f $file ]; then
                echo -e "${GREEN}${file} is created!${NORMAL}"
            else
                echo -e "${RED}${file} wasn't created!${NORMAL}"
            fi
        fi
    fi
}

## creating index.php
createFile $siteDir'/'$public'/index.php' $owner $access '<?php phpinfo(); ?>'

## creating .htaccess
createFile $siteDir'/'$public'/.htaccess' $owner $access

cd $pathToConfig
sudo a2ensite $hostName'.conf'
sudo systemctl start apache2
sudo systemctl reload apache2
if [ -z "$(apache2ctl -D DUMP_VHOSTS | grep ${hostName})" ]; then
    echo -e "${RED}Apache didn't enabled this site.${NORMAL}"
else
    echo -e "${GREEN}Apache enabled this site.${NORMAL}"
fi
    
if [ -z "$(cat /etc/hosts | grep ${hostName})" ]; then
    echo "127.0.0.1 ${hostName}" | sudo tee -a /etc/hosts > /dev/null
    echo -e "${GREEN}update hosts${NORMAL}"
fi

echo -e "${GREEN}Apache reload\nDone${NORMAL}"