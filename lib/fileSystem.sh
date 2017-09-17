#!/usr/bin/env bash


## 1st param is path
## retunr 1/0
checkDir()
{
    return $([ ! -d $1 ])
}

prepareDir()
{
    checkDir $1
    if [ $? -eq 0 ]; then
        handleError "${1} not exist"
        checkAnswerYN $(askQuestion "Create dir by this path?(y/N)?")
        [ $? -eq 1 ] && createDir $1
    fi
}

## 1st path for new directory
## 2nd access
## 3st owner
createDir()
{
    sudo mkdir -p $1
    sudo chmod -R $2 $1
    sudo chown -R $3:$3 $1
}