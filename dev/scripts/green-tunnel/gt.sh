#!/bin/bash

# Instalasi Green Tunnel untuk Linux
# Tested on Manjaro Linux with Google Chrome Stable

about(){
  echo "Name of File  : Green-Tunnel"
  echo "Version       : 2020.3 (ALPHA)"
  echo "Tested on     :"
  echo "    - Arch      : Manjaro"
  echo ""
  echo "Built with love by Icaksh for BEBASID"
  echo "Specially thanks to LeLe & gvoze32"
}

open_gt(){
	random=$(shuf -i 6000-8000 -n 1)
	screen -d -m gt --ip 127.0.0.1 --port $random --dns-server https://doh.dnslify.com/dns-query
	killall chrome && killall screen
	screen -d -m google-chrome-stable netflix.com --proxy-server=127.0.0.1:$random
}

if ! [ -e /usr/bin/gt ]; then
    sudo pacman -Syy
    sudo pacman -S npm
    sudo npm i -g green-tunnel
else
    if ! [ -e /usr/bin/screen ] ; then
    	sudo pacman -S screen
    	open_gt
	else
		open_gt
	fi
fi
