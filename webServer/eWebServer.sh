#!/usr/bin/env bash
PATH+=":~/.bin"
. color.sh

declare WEB_SER="apache2"
declare QUICK='f'
while getopts ":q" opt; do
    case $opt in
        q) QUICK='t' ;;
    esac
done
if [ -n $QUICK ]; then
    set -- ${@:$OPTIND}
fi

trap '' 2

_set()
{
    local name=$1
    local def=$2

    echo -en "${CYAN}Print the '${name}': ${NORMAL}"
    read -ei "$def" res
    eval $name="$res"
}

command()
{
    local action=$1
    if [ -z "$action" ]; then
        _set action
    fi

    case $action in
        a2start)
            servicew 'start' $WEB_SER
        ;;
        a2stop)
            servicew 'stop' $WEB_SER
        ;;
        a2restart)
            servicew 'restart' $WEB_SER
        ;;
        a2status)
            servicew 'status' $WEB_SER
        ;;

        createHost)
            hostName=$2
            if [ -z $hostName ]; then
                _set hostName
            fi
            createHost $hostName
        ;;

        mysqlStart)
            servicew 'start' 'mysql'
        ;;
        mysqlStop)
            servicew 'stop' 'mysql'
        ;;
        mysqlRestart)
            servicew 'restart' 'mysql'
        ;;
        mysqlStatus)
            servicew 'status' 'mysql'
        ;;

        fullStart)
            command 'a2start'
            command 'mysqlStart'
        ;;

        fullRestart)
            command 'a2restart'
            command 'mysqlRestart'
        ;;

        fullStop)
            command 'a2stop'
            command 'mysqlStop'

        ;;

        fullCheck)
            QUICK='t'
            echo -e "${LYELLOW}${WEB_SER} is: ${NORMAL}"
            command 'isActive' 'apache2'
            command 'isEnabled' 'apache2'
            echo -e "${LYELLOW}mysql is: ${NORMAL}"
            command 'isActive' 'mysql'
            command 'isEnabled' 'mysql'
            QUICK='f'
        ;;

        isActive)
            serviceName=$2
            if [ -z $serviceName ]; then
                _set serviceName
            fi
            echo "$(servicew 'isActive' $serviceName)"
        ;;

        isEnabled)
            serviceName=$2
            if [ -z $serviceName ]; then
                _set serviceName
            fi
            echo "$(servicew 'isEnabled' $serviceName)"
        ;;

        enable)
            serviceName=$2
            if [ -z $serviceName ]; then
                _set serviceName
            fi
            echo "$(servicew 'enable' $serviceName)"
            command 'isEnabled'
        ;;

        disable)
            serviceName=$2
            if [ -z $serviceName ]; then
                _set serviceName
            fi
            echo "$(servicew 'disable' $serviceName)"
            command 'isEnabled'
        ;;

        help|h)
            . e-web-server-help.sh
            servicew help
        ;;

        exit) exit ;;

        *) echo -e "${RED}Error: not found action: ${BOLD}${ACTION}${NORMAL}" ;;
    esac

    if [ $QUICK = 'f' ]; then
            command
    fi
}

if [ -z $1 ]; then
    QUICK='t'
    command 'help'
    QUICK='f'
fi

action=$1
    if [ -z $action ]; then
        _set action 'fullStart'
    fi
command "$action"