#!/usr/bin/env bash

## 1st question
## [2nd default answer]
## return user answer
askQuestion()
{
    echo -en "${YELLOW}$1${NORMAL}"
    read -ei "${2}" res
    echo "${res}";
}

## 1st user answer
## [2nd default answer]
## return 1/0
checkAnswerYN()
{
    if [ -z $1 ] && [ -a -n $2 ]; then
        $1 = $2
    fi
    if [ $1 = 'Y' -o $1 = 'y' ]; then
        return 1
    fi
    return 0
}