#!/usr/bin/env bash

action="full"

case $action in

    start|full)
        echo 'start'
    ;;

    stop|full)
        echo 'stop'
    ;;

esac


