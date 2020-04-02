#!/bin/bash
# Instalasi Node.JS, Node Packager Manager, Green Tunnel, Tmux

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
case $OS in
"debian")
sudo apt update && sudo apt install curl
curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo rm -rf nodesource_setup.sh
sudo apt update
sudo apt -y install nodejs tmux
sudo npm i -g green-tunnel
;;
"arch")
sudo pacman -Syy
sudo pacman -S npm tmux curl
sudo npm i -g green-tunnel
;;
esac
