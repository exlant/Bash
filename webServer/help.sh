#!/usr/bin/env bash

PATH+=":~/.bin"
. color.sh

echo -e "${LGREEN}command list:"
echo -e "${CYAN} --apache2"
echo -e "    ${YELLOW}a2start ${GRAY}${DBOLD}(start ${WEB_SER})"
echo -e "    ${YELLOW}a2stop ${GRAY}${DBOLD}(stop ${WEB_SER})"
echo -e "    ${YELLOW}a2restart ${GRAY}${DBOLD}(restart ${WEB_SER})"
echo -e "    ${YELLOW}a2status ${GRAY}${DBOLD}(${WEB_SER} info)"
echo -e "    ${YELLOW}createHost HOST_NAME ${GRAY}${DBOLD}( create host )\n"
echo -e "${CYAN} --apache2"
echo -e "    ${YELLOW}mysqlStart ${GRAY}${DBOLD}(start mysql)"
echo -e "    ${YELLOW}mysqlStop ${GRAY}${DBOLD}(stop mysql)"
echo -e "    ${YELLOW}mysqlRestart ${GRAY}${DBOLD}(restart mysql)"
echo -e "    ${YELLOW}mysqlStatus ${GRAY}${DBOLD}(mysql info)\n"
echo -e "${CYAN} --full"
echo -e "    ${YELLOW}fullStart ${GRAY}${DBOLD}(start ${WEB_SER}, mysql)"
echo -e "    ${YELLOW}fullRestart ${GRAY}${DBOLD}(restart ${WEB_SER}, mysql)"
echo -e "    ${YELLOW}fullStop ${GRAY}${DBOLD}(stop ${WEB_SER}, mysql)"
echo -e "    ${YELLOW}fullCheck ${GRAY}${DBOLD}(check ${WEB_SER}, mysql)\n"
