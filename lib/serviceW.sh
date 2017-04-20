#!/usr/bin/env bash

PATH+=":~/.bin"
. color.sh

action=$1
if [ -z $action ]; then
    echo "Error: not passed action"; exit 1
fi

service=$2
if [ -z $service ] && [ $action != 'help' ]; then
    echo "Error: not passed service name"; exit 1
fi

trap '' 2

help()
{
    echo -e "${CYAN} Command:"
    echo -e "    ${YELLOW}start SERVICE_NAME ${GRAY}${DBOLD}(start service)"
    echo -e "    ${YELLOW}stop SERVICE_NAME ${GRAY}${DBOLD}(stop service)"
    echo -e "    ${YELLOW}restart SERVICE_NAME ${GRAY}${DBOLD}(restart service)"
    echo -e "    ${YELLOW}status SERVICE_NAME ${GRAY}${DBOLD}(service info)"
    echo -e "    ${YELLOW}isActive SERVICE_NAME ${GRAY}${DBOLD}(check is active service)"
    echo -e "    ${YELLOW}isEnabled SERVICE_NAME ${GRAY}${DBOLD}(check is service add to autostart OS)"
    echo -e "    ${YELLOW}enable SERVICE_NAME ${GRAY}${DBOLD}(add service to autostart OS)"
    echo -e "    ${YELLOW}disable SERVICE_NAME ${GRAY}${DBOLD}(drop service from autostart OS)"
}

case $action in
    start)
        service $service start
    ;;

    stop)
        service $service stop
    ;;

    restart)
        service $service restart
    ;;

    status)
        service $service status
    ;;

    isActive)
        echo "$(systemctl is-active $service)"
    ;;

    isEnabled)
        status="$(systemctl is-enabled $service)"
        if [ "$status" = 'disabled' ]; then
            echo $status
        else
            echo 'enabled'
        fi
    ;;

    enable)
        if [ -z $(systemctl list-unit-files | grep $service) ]; then
            update-rc.d $service enable
        else
            systemctl enable $service
        fi
    ;;

    disable)
        if [ -z $(systemctl list-unit-files | grep $service) ]; then
            update-rc.d $service disable
        else
            systemctl disable $service
        fi
    ;;

    help|-h)
        help
    ;;

    *)
        echo "Error: passed action (${action}) is wrong"
        exit 255
    ;;
esac
