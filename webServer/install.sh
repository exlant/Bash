#!/usr/bin/env bash

pathFrom=~/NeedleResourse/scripts/bash/webServer
pathTo=~/.bin
pathFromLib=~/NeedleResourse/scripts/bash/lib

if [ ! -d $pathTo ]; then
    mkdir -p -m 655 $pathTo
1    chown ${USER}:${USER} $pathTo
fi

main="/usr/bin/eWebServer"
sudo cp -f "${pathFrom}/eWebServer.sh" $main
sudo chmod a=rx,u+w $main
sudo chown root:root $main

color="${pathTo}/color.sh"
cp "${pathFromLib}/color.sh" $color
chmod a=rx,u+w $color

fileDesktop="/usr/share/applications/eWebServer.desktop"
sudo cp -f "${pathFrom}/eWebServer.desktop" $fileDesktop
sudo chmod 744 $fileDesktop
sudo chown root:root $fileDesktop

fileIcon="/usr/share/icons/hicolor/256x256/apps/eWebServer.png"
sudo cp "${pathFrom}/eWebServer.png" $fileIcon
sudo chmod 644 $fileIcon

cp -f "${pathFrom}/help.sh" "${pathTo}/e-web-server-help.sh"
chmod a=rx,u+w "${pathTo}/e-web-server-help.sh"

cp -f "${pathFromLib}/serviceW.sh" "${pathTo}/servicew"
chmod a=rx,u+w "${pathTo}/servicew"

cp -f "${pathFromLib}/createHost.sh" "${pathTo}/createHost"
chmod a=rx,u+w "${pathTo}/createHost"

cp -f "${pathFromLib}/createHost.cfg" "${pathTo}/createHost.cfg"
chmod a=rx,u+w "${pathTo}/createHost.cfg"

createHostTmpl="/etc/apache2/sites-available/tmpl.conf"
sudo cp -f "${pathFromLib}/createHost.tmpl" $createHostTmpl
sudo chmod a=rx $createHostTmpl
sudo chown root:root $createHostTmpl