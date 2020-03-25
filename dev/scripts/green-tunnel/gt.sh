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
}

open_gt(){
	screen -d -m gt --ip 127.0.0.1 --port 1945 --dns-server https://185.235.81.1/dns-query
	killall chrome
	screen -d -m google-chrome-stable --proxy-server=127.0.0.1:1945	
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
