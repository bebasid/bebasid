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
      sudo apt -y install nodejs tmux
      sudo npm i -g green-tunnel
        ;;
      # DINASTI ARCH, HOHOHO
      "arch")
      sudo pacman -Syy
      sudo pacman -S npm tmux
      sudo npm i -g green-tunnel
      ;;
  esac
}

open_gt(){
  random=$(shuf -i 6000-8000 -n 1)
  killall chrome
  cek_distro
  case $OS in
    "debian" )
      stable=""
      ;;
    "arch" )
      stable="-stable"
      ;;
  esac
  # TMUX IS NOT TERMUX.. OKAY
  tmux new-session -d -s 6f4f9a675d5c67aa28350b0276bf911d -x 252 -y 29
  tmux split-window -v
  tmux split-window -h
  tmux send-keys -t 1 "gt --ip 127.0.0.1 --port $random --dns-server https://doh.dnslify.com/dns-query --system-proxy false --silent true -v 'green-tunnel:*'" Enter
  text="Tunggu sebentar, sedang membuka Google Chrome"
  rand=0.1
  load
  tmux send-keys -t 2 "google-chrome$stable netflix.com --proxy-server=127.0.0.1:$random" Enter
  tmux send-keys -t 0 "bebasid-gt 6f4f9a675d5c67aa28350b0276bf911d $random" Enter
  tmux select-pane -t 0
  tmux a
}

case $1 in
  start )
    if ! command -v gt > /dev/null; then
      echo "Install Dulu Green-Tunnelnya"
      exit 1
    else
      if ! command -v tmux > /dev/null ; then
        echo "Install Dulu Tmuxnya"
        exit 1
      else
      open_gt
      fi
    fi
    ;;
  install )
    install_all
    ;;
  --help )
    echo "BEBASID + Green Tunnel"
    echo "Cara penggunaan:"
    echo "bebasid-gt [command]"
    echo ""
    echo "List command:"
    echo "install   : Menginstall bahan-bahan yang diperlukan (NPM, GT, TMUX)"
    echo "--help    : Menampilkan bantuan"
    echo "start     : Memulai sesi Green Tunnel + Google Chrome"
    echo "stop      : Mematikan sesi"
    echo "update    : Memperbarui script bash BEBASID + Green Tunnel"
    echo ""
    echo "Aplikasi ini masih dalam tahap ujicoba alpha, sehingga mungkin banyak bug"
    ;;
  stop )
    tmux kill-session -t 6f4f9a675d5c67aa28350b0276bf911d
    ;;
  update )
    if sudo curl -o /usr/local/bin/bebasid-gt https://raw.githubusercontent.com/bebasid/bebasid/master/dev/scripts/green-tunnel/gt.sh --progress-bar; then
      echo ""
      echo "Berhasil mengunduh script aplikasi BEBASID"
      echo "Mengecek aplikasi"
      sudo bebasid --about
    else
      echo "Gagal Update"
    fi
    ;;
  6f4f9a675d5c67aa28350b0276bf911d )
    reset
    echo "Green Tunnel berhasil dibuka (127.0.0.1:$2)"
    echo "Terminal ini jangan ditutup selama masih streaming"
    echo "Untuk menonaktifkan, silahkan ketik perintah bebasid-gt stop"
    ;;
  *)
    echo "Perintah tidak dikenali, ketik bebasid-gt --help untuk bantuan"
    ;;
esac
