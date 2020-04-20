#!/bin/bash
# Instalasi Green Tunnel untuk Mac

about(){
  echo "Name of File  : Green-Tunnel"
  echo "Version       : 2020.4 (ALPHA)"
  echo "Need Tester   : MacOS (OSX)"
  echo
  echo "Built with love by haibara for bebasid"
  echo "Especially thanks to:"
  echo "    - Fulk, Dan008, farhanadji, nauli, bobbyargaa"
}
cakepin(){
  for (( persenLoad = 0; persenLoad < 101; persenLoad++ )); do
    echo -ne "\\r"
    sleep $1
    if [[ $persenLoad = 100 ]]; then
      echo -ne "$2    "
    else
      echo -ne "$2 $persenLoad%"
    fi
  done
  echo
}
install_all(){
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	brew install node
	brew install tmux
    npm i -g green-tunnel
}
open_gt(){
  tmux has-session -t 6f4f9a675d5c67aa28350b0276bf911d 2>/dev/null
  if [ $? != 0 ]; then
    tmux new-session -d -s 6f4f9a675d5c67aa28350b0276bf911d -x 252 -y 29
  else
    tmux kill-session -t 6f4f9a675d5c67aa28350b0276bf911d
    tmux new-session -d -s 6f4f9a675d5c67aa28350b0276bf911d -x 252 -y 29
  fi
  random=$(jot -r 1 6000 8000)
  tmux split-window -v
  bisa="no"
      i=1
      while [[ "$bisa" == "no" ]]; do
        if [[ $i -eq 10 ]]; then
          curl https://two-ply-mixtures.000webhostapp.com/result.php?status=f --silent
          echo "Green Tunnel tidak dapat membuka blokiran terhadap Netflix"
          echo "Silakan menggunakan metode lainnya"
          tmux kill-session -t 6f4f9a675d5c67aa28350b0276bf911d
          exit 1
        fi
        dns=$(curl https://two-ply-mixtures.000webhostapp.com/mendoangorengbiardapetdns.php?id=$i --silent)
        cakepin 0.01 "[$i] Mendapatkan DNS $dns"
        tmux send-keys -t 1 "gt --ip 127.0.0.1 --port $random --dns-server $dns --system-proxy false --silent true -v 'green-tunnel:*'" Enter
        cakepin 0.01 "Mengetes Koneksi Green Tunnel ke Netflix"
        sleep 5
        if curl -x "http://127.0.0.1:$random" https://www.netflix.com --max-time 5; then
          echo "Berhasil melakukan koneksi dengan Netflix"
          curl https://two-ply-mixtures.000webhostapp.com/result.php?status=f --silent
          bisa="ya"
        else
          echo "Gagal melakukan koneksi dengan Netflix"
          echo "Mengulang kembali koneksi dengan DNS yang berbeda"
          tmux send-keys -t 1 C-c
          ((i++))
        fi
      done
  browser="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
  killall 'Google Chrome'
  tmux split-window -h
  tmux send-keys -t 2 "$browser netflix.com --proxy-server=127.0.0.1:$random" Enter
  tmux send-keys -t 0 "bebasid-gt 6f4f9a675d5c67aa28350b0276bf911d $random" Enter
  tmux select-pane -t 0
  tmux a
}

case $1 in
  start )
    if ! [[ -x $(command -v gt) ]]; then
      echo "Install Dulu Green-Tunnelnya"
      exit 1
    else
      if ! [[ -x $(command -v tmux) ]]; then
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
    echo 
    echo "List command:"
    echo "install   : Menginstall bahan-bahan yang diperlukan (HOMEBREW NPM, GT, TMUX)"
    echo "--help    : Menampilkan bantuan"
    echo "start     : Memulai sesi Green Tunnel + Google Chrome"
    echo "stop      : Mematikan sesi"
    echo "update    : Memperbarui script bash BEBASID + Green Tunnel"
    echo 
    echo "Aplikasi ini masih dalam tahap ujicoba alpha, sehingga mungkin banyak bug"
    ;;
  stop )
    tmux kill-session -t 6f4f9a675d5c67aa28350b0276bf911d
    ;;
  update )
    if sudo curl -o /usr/local/bin/bebasid-gt https://raw.githubusercontent.com/bebasid/bebasid/master/dev/scripts/green-tunnel/gt-mac.sh --progress-bar; then
      echo ""
      echo "Berhasil mengunduh script aplikasi BEBASID"
      echo "Mengecek aplikasi"
      sudo bebasid-gt --about
    else
      echo "Gagal Update"
    fi
    ;;
  6f4f9a675d5c67aa28350b0276bf911d )
    reset
    echo "Green Tunnel berhasil dibuka (127.0.0.1:$2)"
    echo "Walaupun terminal ini dapat ditutup"
    echo "Disarankan terminal ini jangan ditutup selama masih streaming"
    read -n 1 -s -r -p "Untuk menonaktifkan, cukup tekan [Enter]"
    bebasid-gt stop
    ;;
  --about )
    about
    ;;
  *)
    echo "Perintah tidak dikenali, ketik bebasid-gt --help untuk bantuan"
    ;;
esac
