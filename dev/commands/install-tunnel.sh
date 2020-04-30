#!/bin/bash
# Built with love by haibara
loadin(){
  for (( pLoad = 0; pLoad < 101; pLoad++ )); do
    echo -ne "\\r"
    sleep $1
    if [[ $pLoad = 100 ]]; then
      echo -ne "$2    "
    else
      echo -ne "$2 $pLoad%"
    fi
  done
  echo
}
install_tunnel(){
  getUname=$(uname -s)
  case $getUname in
    Linux* )
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
          sudo apt update && sudo apt install curl tmux
          curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh
          case $1 in
            "Green Tunnel" )
              sudo bash nodesource_setup.sh
              sudo rm -rf nodesource_setup.sh
              sudo apt update
              sudo npm i -g green-tunnel
              ;;
            "PowerTunnel" )
              if sudo curl -o ~/.bebasid/PowerTunnel.jar https://github.com/krlvm/PowerTunnel/releases/download/v1.10/PowerTunnel.jar; then
                echo "Sukses memasang PowerTunnel"
              else
                echo "Tidak dapat mengambil file PowerTunnel"
                exit 1
              fi
              ;;
          esac
          ;;
        "arch")
          sudo pacman -Syy
          sudo pacman -S tmux curl
          case $1 in
            "Green Tunnel" )
              sudo pacman -S npm
              sudo npm i -g green-tunnel
              ;;
            "PowerTunnel" )
              sudo pacman -S jre-openjdk
              if sudo curl -o ~/.bebasid/PowerTunnel.jar https://github.com/krlvm/PowerTunnel/releases/download/v1.10/PowerTunnel.jar; then
                echo "Sukses memasang PowerTunnel"
              else
                echo "Tidak dapat mengambil file PowerTunnel"
                exit 1
              fi
              ;;
          esac
          ;;
        esac
      ;;
    Darwin* )
      echo "Script ini hanya work untuk MacOS High Sierra hingga yang terbaru"
      echo "App: Homebrew, tmux, cURL, Java (PowerTunnel) / NodeJS(Green Tunnel)"
      echo "Tunnel yang akan dipasang : $1"
      read -p "Apakah anda yakin ingin melanjutkan pemasangan (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
      if ! [[ -x $(command -v brew) ]]; then
        loadin 0.01 "Memulai pemasangan Homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
      elif ! [[ -x $(command -v tmux) ]]; then
        loadin 0.01 "Memulai pemasangan tmux"
        brew install tmux
      fi
      case $1 in
        "Green Tunnel" )
          if ! [[ -x $(command -v node) ]]; then
            loadin 0.01 "Memulai pemasangan NodeJS dan NPM"
            brew install node
          elif ! [[ -x $(command -v gt) ]]; then
            loadin 0.01 "Memulai pemasangan Green Tunnel"
            npm i -g green-tunnel
          fi
          echo "INSTALASI BERHASIL"
          ;;
        "PowerTunnel" )
          if ! [[ -x $(command -v java) ]]; then
            brew tap caskroom/cask
            brew tap caskroom/versions
            brew cask install java
          elif ! [[ -e ~/.bebasid/PowerTunnel.jar ]]; then
            if sudo curl -L -o ~/.bebasid/PowerTunnel.jar https://github.com/krlvm/PowerTunnel/releases/download/v1.10/PowerTunnel.jar; then
              echo "Sukses memasang PowerTunnel"
            else
              echo "Tidak dapat mengambil file PowerTunnel"
              exit 1
            fi
          fi
      esac
      ;;
  esac
}
case $1 in
  "green-tunnel" )
    install_tunnel "Green Tunnel"
    exit 1
    ;;
  "powertunnel" )
    install_tunnel "PowerTunnel"
    exit 1
    ;;
esac
