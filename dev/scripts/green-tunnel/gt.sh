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

load(){
  for (( i = 0; i < 101; i++ )); do
    echo -ne "\\r"
    sleep $rand
    if [[ $i = 100 ]]; then
      echo -ne "$text    "
    else
      echo -ne "$text $i%"
    fi
  done
  echo ""
}

cek_distro(){
  if [[ -e /etc/debian_version ]]; then
      source /etc/os-release
      OS=debian
    elif [[ -e /etc/arch-release ]]; then
      OS=arch
    else
    echo ""
    echo "Belum mendukung distro selain Debian dan Arch (dan Turunannya)"
    echo "Install NPM dan Green-Tunnel secara manual"
    exit 1
    fi
}

install_all(){
  cek_distro
  case $OS in
      # ANAK CUCU DEBIAN
      "debian")
      curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh
      sudo bash nodesource_setup.sh
      sudo rm -rf nodesource_setup.sh
      sudo apt update
      sudo apt -y install nodejs screen
      sudo npm i -g green-tunnel
        ;;
      # ARCH DERIVATIVE
      "arch")
      sudo pacman -Syy
      sudo pacman -S npm screen
      sudo npm i -g green-tunnel
      ;;
  esac
}

open_gt(){
	random=$(shuf -i 6000-8000 -n 1)
	screen -d -m -S '6f4f9a675d5c67aa28350b0276bf911d' gt --ip 127.0.0.1 --port $random --dns-server https://doh.dnslify.com/dns-query --system-proxy false --silent true -v 'green-tunnel:*' proc
	killall chrome
	text="Tunggu sebentar, sedang membuka Google Chrome"
	rand=0.0001
	load
  cek_distro
  case $OS in
    "debian" )
      stable=""
      ;;
    "arch" )
      stable="-stable"
      ;;
  esac
	screen -d -m -S '554838a8451ac36cb977e719e9d6623c' google-chrome$stable netflix.com --proxy-server=127.0.0.1:$random
  echo "Green Tunnel = 127.0.0.1:$random"
}

case $1 in
  start )
    if ! [ -e /usr/bin/gt ]; then
      echo "Install Dulu Green-Tunnelnya"
    else
      if ! [ -e /usr/bin/screen ] ; then
        echo "Install Dulu Screennya"
      else
      open_gt
      fi
    fi
    ;;
  install )
    install_all
    ;;
  gete )
    screen -r '6f4f9a675d5c67aa28350b0276bf911d'
    ;;
  stop )
    screen -S 6f4f9a675d5c67aa28350b0276bf911d -X quit
    screen -S 554838a8451ac36cb977e719e9d6623c -X quit
    ;;
esac
