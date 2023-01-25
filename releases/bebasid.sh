#!/bin/bash

bebasid_banner(){
  echo " _          _               _     _ "
  echo "| |__   ___| |__   __ _ ___(_) __| |"
  echo "| '_ \ / _ \ '_ \ / _' / __| |/ _' |"
  echo "| |_) |  __/ |_) | (_| \__ \ | (_| |"
  echo "|_.__/ \___|_.__/ \__,_|___/_|\__,_|"
  echo
  echo "=====  PEDULI INTERNET NETRAL  ====="
  echo
}
about(){
  echo "Name of File  : bebasid.sh"
  echo "Version       : v1.0 [Elena - Ann] Linux/Darwin Version"
  echo "Built         : 2020.9 [Evarina]"
  echo "Tested on     :"
  echo "    - Debian    : Debian, Ubuntu, Linux Mint"
  echo "    - RHEL      : CentOS, Fedora"
  echo "    - Arch      : Arch Linux, Manjaro"
  echo "    - Darwin    : MacOS Catalina"
  echo
  echo "Built with love by haibara"
}
rules(){
  echo "Version Codename: vx.y [Girl Name - Special Name]"
  echo "[Female Western Name - Special Name]"
  echo "  Female Western Name FL  (x):"
  echo "    0 : A,B,C,D (has been used)"
  echo "    1 : E"
  echo "    2 : F"
  echo "    3 : G"
  echo "    4 : H"
  echo "    etc : etc"
  echo
  echo "  Special Name (HMBTN/SV) (y):"
  echo "    0 : Ann"
  echo "    1 : Elli"
  echo "    2 : Karen"
  echo "    3 : Mary"
  echo "    4 : Popuri"
  echo "    5 : Abigail"
  echo "    6 : Emily"
  echo "    7 : Haley"
  echo "    8 : Leah"
  echo "    9 : Aja"
  echo
  echo "NB: Use minor update instead major update"
  echo
  echo "Build Codename: Year.Month [Name/Trending Topic]"
  echo
  echo "If month is 6 or 12, use Trending Topic"
  echo "  Example:  Mas Agus dan Mas Pras"
  echo
  echo "If month is even, use Boys Name (Z-A)"
  echo "  Example:  Zlatan"
  echo
  echo "If month is odd, use Girls Name (A-Z)"
  echo "  Example:  Annia"
}

# =========== DON'T CHANGE THE ORDER OF THIS FUNCTION =========== #

bantuan(){
  bebasid_banner
  echo "Cara penggunaan:"
  echo "bebasid [command] [option/[website]] [tambahan]"
  echo
  echo "List command:"
  echo "menu        : Menampilkan opsi menu bebasid"
  echo "hosts"
  echo "  install   : Mengganti hosts bawaan dengan hosts bebasid"
  echo "    --r18   : Mengganti hosts bawaan dengan hosts bebasid (R-18)"
  echo "  change    : Mengubah tipe host SFW menjadi NSFW"
  echo "  update    : Memperbarui hosts bebasid"
  echo "  remove    : Menghapus hosts bebasid"
  echo "app"
  echo "  renew     : Memperbarui aplikasi bebasid"
  echo "  uninstall : Menghapus aplikasi bebasid"
  echo "tunnel"
  echo "  start"
  echo "    gt      : Memulai tunnel dengan Green Tunnel"
  echo "    pt      : Memulai tunnel dengan PowerTunnel"
  echo "      --nb  : Memulai aplikasi bypass DPI tanpa membuka browser (ops)"
  echo "  stop      : Memberhentikan aplikasi bypass DPI"
  echo "  install"
  echo "    gt      : Memasang Green Tunnel"
  echo "    pt      : Memasang PowerTunnel"
  echo "  uninstall"
  echo "    gt      : Mencopot Green Tunnel"
  echo "    pt      : Mencopot PowerTunnel"
  echo "block"
  echo "  [website] : Memblokir akses ke [website] (ops)" 
  echo "unblock"
  echo "  [website] : Membuka akses ke [website] (ops)"
  echo "localhost"
  echo "  [website] : Membuat localhost (untuk proyek) (ops)"
  echo "    [ip]    : Memberikan IP Address Manual (ops)"
  echo "--help      : Menampilkan bantuan"
  echo "--version   : Menampilkan versi aplikasi bebasid"
  echo
  echo "Apabila setelah pemasangan bebasid terjadi error DNS Not Resolved,"
  echo "Mohon untuk segera menggunakan fitur fix yang ada di menu"
  echo
  echo "Copyright (c) 2019-"$(date +%Y)" BEBASID (under MIT License)"
  echo "by Komunitas Internet Netral Indonesia"
}
errorin(){
  echo "$1"
  exit 1
}
loadin(){
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
curl_wget(){
  if [[ -x $(command -v curl) ]]; then
  ambil="sudo curl $1 $2"
  elif [[ -x $(command -v wget) ]]; then
  ambil="sudo wget $3 $1"
  else
  echo "Harap install cURL atau wget"
  exit 1
  fi
}
check_duplicate_unblock(){
  echo "Memeriksa apakah domain $domain telah tercatat dalam file hosts"
  begin="$(grep -n "$domain" /etc/hosts | head -n 1 | cut -d: -f1)"
  if [[ $begin>0 ]]; then
  echo "Domain $domain telah tercatat dalam file hosts"
  echo
  echo "=== GAGAL MELAKUKAN PROSES UNBLOCK ===="
  exit 1
  fi
}
cek_koneksi_dengan_internet(){
  loadin 0.01 "Mengecek koneksi dengan internet"
  ipo="8.8.8.8"
  nee=1
  if ping -c ${nee} ${ipo} > /dev/null; then
  echo "Komputer terhubung dengan internet"
  echo
  echo
  else
  echo "Komputer tidak terhubung dengan internet"
  echo "Silahkan cek koneksi komputer dengan internet terlebih dahulu"
  exit 1
  fi
}
memulai_ulang_network(){
  loadin 0.01 "Memulai ulang Network Manager"
  getUname=$(uname -s)
  case $getUname in
  Linux* )
    if [[ -e /etc/debian_version ]]; then
    source /etc/os-release
    OS=$ID # debian or ubuntu
    elif [[ -e /etc/fedora-release ]]; then
    OS=fedora
    elif [[ -e /etc/centos-release ]]; then
    OS=centos
    elif [[ -e /etc/rockylinux-release ]]; then
    OS=rockylinux
    elif [[ -e /etc/arch-release ]]; then
    OS=arch
    else
    echo
    echo "Tidak dapat memulai ulang Network Manager"
    echo "Anda bisa memulai ulang Network Manager secara manual"
    fi
    case $OS in
    # DEBIAN DERIVATIVE
    "debian")
      sudo /etc/init.d/network-manager restart
      ;;
    "ubuntu")
      sudo service NetworkManager restart
      ;;
    # RHEL DERIVATIVE
    "centos")
      sudo systemctl restart NetworkManager.service
      ;;
    "fedora")
      sudo systemctl restart NetworkManager.service
      ;;
    "rockylinux")
      sudo systemctl restart NetworkManager.service
      ;;
    # ARCH DERIVATIVE
    "arch")
      sudo systemctl restart NetworkManager.service
      ;;
    esac
    ;;
  Darwin* )
    sudo killall -HUP mDNSResponder
    ;;
  esac
}

# =============================================================== #

perbarui_aplikasi_bebasid(){
  cek_koneksi_dengan_internet
  echo "======= MEMPERBARUI APLIKASI BEBASID ======"
  echo
  echo "Memulai pengambilan script bash BEBASID"
  echo
  dir=/usr/local/bin/bebasid
  curl_wget https://raw.githubusercontent.com/bebasid/bebasid/master/releases/bebasid.sh "-o $dir --progress-bar" "-O $dir -q --show-progress --progress=bar:force"
  if $ambil ; then
  echo
  echo "Berhasil mengunduh script aplikasi BEBASID"
  echo "Mengecek aplikasi"
  sudo bebasid --about
  echo
  echo "== BERHASIL MEMPERBARUI APLIKASI BEBASID =="
  else
  echo
  echo "Tidak dapat mengunduh script aplikasi BEBASID"
  echo
  echo "==== GAGAL MEMPERBARUI APLIKASI BEBASID ==="
  fi
}
hapus_aplikasi_bebasid(){
  read -p "Apakah anda yakin ingin menghapus BEBASID? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
  echo "== MEMULAI PENGHAPUSAN APLIKASI BEBASID =="
  echo
  loadin 0.01 "Menghapus aplikasi BEBASID"
  if sudo rm -rf /usr/local/bin/bebasid; then
  echo
  echo "===== APLIKASI BEBASID TELAH DIHAPUS ====="
  else
  echo
  echo "===== APLIKASI BEBASID GAGAL DIHAPUS ====="
  fi
}
ambil_hosts_bebasid(){
  case $1 in
  "SFW" )
    yuerel=https://raw.githubusercontent.com/bebasid/bebasid/master/dev/resources/hosts.sfw
    ;;
  "NSFW" )
    yuerel=https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts
    ;;
  esac
  echo "Memulai pengambilan file hosts BEBASID"
  echo
  dir=/etc/hosts
  curl_wget $yuerel "-o $dir --progress-bar" "-O $dir -q --show-progress --progress=bar:force"
  if $ambil; then
  sudo bash -c 'cat /etc/hosts-own >> /etc/hosts'
  echo
  echo "Berhasil mengambil file hosts BEBASID"
  memulai_ulang_network
  echo
  echo "====== BERHASIL MEMASANG BEBASID ====="
  else
  sudo mv /etc/hosts.bak-bebasid /etc/hosts
  echo "Gagal mengambil file hosts BEBASID"
  echo
  echo "======= GAGAL MEMASANG BEBASID ======="
  fi
}
pasang_hosts_bebasid(){
  cek_koneksi_dengan_internet
  echo "== MEMULAI PEMASANGAN HOSTS BEBASID =="
  echo
  loadin 0.01 "Memeriksa kondisi"
  if [ -e /etc/hosts.bak-bebasid ]; then
  echo "Komputer ini telah terpasang BEBASID, silahkan uninstall BEBASID terlebih dahulu"
  echo
  echo "==== GAGAL MEMASANG HOSTS BEBASID ===="
  exit 1
  else
  echo "Pastikan komputer telah terpasang cURL atau wget"
  loadin 0.01 "Memulai instalasi"
  reset
  bebasid_banner
  curl_wget https://raw.githubusercontent.com/bebasid/bebasid/master/dev/readme/RULES.md "" "-qO-"
  $ambil
  echo
  echo "Dengan melanjutkan berarti secara langsung dan tidak langsung, anda menyetujui apa yang tertulis diatas "
  read -p "Apakah anda yakin ingin melanjutkan pemasangan BEBASID? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
  reset
  # Codingan "Yang Penting Jalan" 
  echo "Mengecek koneksi dengan internet"
  echo "Komputer terhubung dengan internet"
  echo "== MEMULAI PEMASANGAN HOSTS BEBASID =="
  echo
  echo "Memeriksa kondisi"
  echo "Pastikan komputer telah terpasang cURL atau wget"
  echo "Memulai Instalasi"
  # End 
  sudo mv /etc/hosts /etc/hosts.bak-bebasid
  backup="$(cat /etc/hosts.bak-bebasid)"
  sudo bash -c "cat > /etc/hosts-own" <<EOF

# Konfigurasi Asli

$backup

# Konfigurasi Tambahan Pribadi
EOF
  echo
  if [ -z "$1" ]; then
    PS3='Pilih salah satu tipe hosts: '
    echo
    typeChoice=("Safe for Work" "Not Safe for Work")
    select typeChoiceOpt in "${typeChoice[@]}"
    do
    case $typeChoiceOpt in
      "Safe for Work" )
      ambil_hosts_bebasid "SFW"
      break
      ;;
      "Not Safe for Work" )
      ambil_hosts_bebasid "NSFW"
      break
      ;;
    esac
    done
  else
    ambil_hosts_bebasid $1
  fi
  fi
}
perbarui_hosts_bebasid(){
  cek_koneksi_dengan_internet
  echo "===== MEMPERBARUI HOSTS BEBASID ======"
  echo
  loadin 0.01 "Memeriksa kondisi"
  if [ -e /etc/hosts.bak-bebasid ]; then
  echo "Mengecek tipe hosts BEBASID yang dipakai"
  linePertama=$(sed "1q;d" /etc/hosts)
  if ! [[ $linePertama == *"Safe"* ]]; then
    echo "Type: NSFW"
    type="NSFW"
  else
    echo "Type: SFW"
    type="SFW"
  fi
  sudo rm /etc/hosts
  ambil_hosts_bebasid $type
  exit 1
  else
  errorin "hosts bebasid belum terpasang, silakan pasang hosts bebasid terlebih dahulu"
  fi
}
ubah_type_hosts_bebasid(){
    cek_koneksi_dengan_internet
    echo "====== UBAH TYPE HOSTS BEBASID  ======"
    echo
    loadin 0.01 "Memeriksa kondisi"
  if [ -e /etc/hosts.bak-bebasid ]; then
  echo "Mengecek tipe hosts BEBASID yang dipakai"
  linePertama=$(sed "1q;d" /etc/hosts)
  if ! [[ $linePertama == *"Safe"* ]]; then
    echo "Type Hosts Awal: NSFW"
            echo "Type Hosts Akan diubah ke SFW"
    type="SFW"
  else
    echo "Type Hosts Awal: SFW"
            echo "Type Hosts Akan diubah ke NSFW"
    type="NSFW"
  fi
        read -p "Apakah anda yakin ingin melanjutkan? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
  sudo rm /etc/hosts
  ambil_hosts_bebasid $type
  exit 1
  else
  errorin "hosts bebasid belum terpasang, silakan pasang hosts bebasid terlebih dahulu"
  fi
}
hapus_hosts_bebasid(){
  echo "=== MEMULAI PENCOPOTAN HOSTS BEBASID ==="
  echo
  loadin 0.01 "Memeriksa hosts cadangan"
  echo
  if [ -e /etc/hosts.bak-bebasid ]; then
  echo "Hosts cadangan ditemukan, memulai pencopotan BEBASID"
  sudo rm /etc/hosts
  sudo rm /etc/hosts-own
  sudo mv /etc/hosts.bak-bebasid /etc/hosts
  memulai_ulang_network
  echo
  echo "== HOSTS BEBASID TELAH SUKSES DICOPOT =="
  else
  echo "Hosts cadangan tidak ditemukan"
  read -p "Apakah anda yakin ingin menggunakan konfigurasi hosts bawaan Linux? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
  loadin 0.01 "Pencopotan dengan konfigurasi hosts bawaan Linux"
  kembalikan_hosts
  memulai_ulang_network
  echo
  echo "== HOSTS BEBASID TELAH SUKSES DICOPOT =="
  fi
}

# =============================================================== #

cek_perintah_tunnel(){	
  case $1 in	
    "Green Tunnel" )	
      if ! [[ -x $(command -v gt) ]]; then	
        errorin "Green Tunnel tidak ditemukan, silakan pasang Green Tunnel terlebih dahulu"	
      fi	
      ;;	
    "PowerTunnel" )	
      if ! [[ -x $(command -v java) ]]; then	
        errorin "Java tidak terpasang, silakan pasang terlebih dahulu"	
      else	
        if ! [[ -e ~/.bebasit/PowerTunnel.jar ]]; then	
          errorin "PowerTunnel tidak ditemukan, silakan pasang PowerTunnel terlebih dahulu"	
        else	
          hash=$(shasum ~/.bebasit/PowerTunnel.jar | cut -d' ' -f1)	
          while ! [[ $hash == "39956402277e04026de4990821161adb32bc8cff" ]]; do	
            echo "Sedang Mengupdate PowerTunnel"	
            if curl -L -o ~/.bebasit/PowerTunnel.jar https://github.com/krlvm/PowerTunnel/releases/download/v1.11/PowerTunnel.jar; then	
                echo "Sukses memasang PowerTunnel"	
                hash=$(shasum ~/.bebasit/PowerTunnel.jar | cut -d' ' -f1)	
              else	
                echo "Tidak dapat mengambil file PowerTunnel"	
                exit 1	
            fi	
            hash=$(shasum ~/.bebasit/PowerTunnel.jar | cut -d' ' -f1)	
          done	
        fi	
      fi	
      ;;	
  esac	
  if ! [[ -x $(command -v tmux) ]]; then	
    errorin "Tmux tidak terpasang, silakan pasang Tmux terlebih dahulu"	
  fi	
}	
pilih_browser() {
  echo "=========================="
  echo "      PILIH BROWSER       "
  echo "=========================="
  echo "1. Google Chrome"
  echo "2. Firefox"
  echo "3. Brave Browser"
  echo -n "Pilih 1-3: "

}
mulai_bebasid_tunnel(){	
  getUname=$(uname -s)	
  case $getUname in	
    Linux* )	
      random=$(shuf -i 6000-8000 -n 1)	
      ;;	
    Darwin* )	
      random=$(jot -r 1 6000 8000)	
      ;;	
  esac	
  cek_perintah_tunnel $1	
  tmux has-session -t bebasid-tunnel 2>/dev/null	
  if [ $? != 0 ]; then	
    tmux new-session -d -s bebasid-tunnel -x 252 -y 29	
  else	
    tmux kill-session -t bebasid-tunnel	
    tmux new-session -d -s bebasid-tunnel -x 252 -y 29	
  fi	
  tmux split-window -v	
  bisa="no"	
  i=1	
  while [[ "$bisa" == "no" ]]; do	
    if [[ $i -eq 10 ]]; then	
      echo "$1 tidak dapat membuka blokiran terhadap Netflix"	
      echo "Silakan menggunakan metode lainnya"	
      tmux kill-session -t bebasid-tunnel	
      exit 1	
    fi	
    if [[ "$1" == "Green Tunnel" ]]; then	
      dns=$(curl "https://bebasid.herokuapp.com/?get=dns&dns=gt&n=$i" --silent)	
      loadin 0.01 "[$i] Mendapatkan DNS $dns"	
      echo "Tunnel: Green Tunnel"	
      tmux send-keys -t 1 "gt --ip 127.0.0.1 --port $random --dns-server $dns --system-proxy false --silent true -v 'green-tunnel:*'" Enter	
    elif [[ "$1" == "PowerTunnel" ]]; then	
      dns=$(curl "https://bebasid.herokuapp.com/?get=dns&dns=pt&n=$i" --silent)	
      loadin 0.01 "[$i] Mendapatkan DNS $dns"	
      echo "Tunnel: PowerTunnel"	
      db="https://raw.githubusercontent.com/bebasid/bebasit/master/dependencies/goodbyedpi/blacklist.txt"	
      tmux send-keys -t 1 "java -jar ~/.bebasit/PowerTunnel.jar -start -console -government-blacklist-from $db -chunk-size 21 -use-dns-server $dns -ip 127.0.0.1 -port $random -debug -disable-auto-proxy-setup -disable-updater" Enter	
    fi	
    loadin 0.01 "Mengetes Koneksi $1 ke Netflix"	
    sleep 10	
    if curl -x "http://127.0.0.1:$random" https://www.netflix.com --max-time 10; then	
      echo "Berhasil melakukan koneksi dengan Netflix"	
      bisa="ya"	
    else	
      echo "Gagal melakukan koneksi dengan Netflix"	
      echo "Mengulang kembali koneksi dengan DNS yang berbeda"	
      tmux send-keys -t 1 C-c	
      ((i++))	
    fi	
  done	
  tmux split-window -h	
  case $getUname in	
    Linux* )	
      if [[ "$browser" == "no" ]]; then	
        tmux send-keys -t 2 "bebasid tunnel bebasid-tunnel-nb" Enter	
      else	
        pilih_browser
        read number
        case $number in
        1)
          if [[ -x $(command -v google-chrome-stable) ]]; then	
            browser="google-chrome-stable"	
            killall chrome	
          elif [[ -x $(command -v google-chrome) ]]; then	
            browser="google-chrome"	
            killall chrome	
          else
            tmux send-keys -t 1 C-c
            errorin "Browser tidak ditemukan"
          fi
          ;;
        2)
          browser="firefox"
          killall firefox
          ;;
        3)
          if [[ -x $(command -v brave-browser-stable) ]]; then	
            browser="brave-browser-stable"	
            killall brave	
          elif [[ -x $(command -v brave-browser) ]]; then	
            browser="brave-browser"	
            killall brave	
          else
            tmux send-keys -t 1 C-c
            errorin "Browser tidak ditemukan"
          fi
          ;;
        *)
          tmux send-keys -t 1 C-c
          errorin "Browser tidak dipilih"
        esac
      loadin 0.01 "Tunggu sebentar, sedang membuka $browser"	
        if [[ "$browser" == "firefox" ]]; then
          firefox -CreateProfile bebasit
          firefoxDir=$(ls $HOME/.mozilla/firefox/ | grep bebasit)
          rm -rf $HOME/.mozilla/firefox/$firefoxDir/prefs.js
          touch $HOME/.mozilla/firefox/$firefoxDir/prefs.js
          echo -e 'user_pref("network.proxy.http", "127.0.0.1");\nuser_pref("network.proxy.http_port", '$random');\nuser_pref("network.proxy.type", 1);' > $HOME/.mozilla/firefox/$firefoxDir/prefs.js
          tmux send-keys -t 2 "$browser netflix.com -P bebasit" Enter
        else
          tmux send-keys -t 2 "$browser netflix.com --proxy-server=127.0.0.1:$random" Enter
        fi
      fi	
      ;;	
    Darwin* )	
      if [[ "$browser" == "no" ]]; then	
        tmux send-keys -t 2 "bebasid tunnel bebasid-tunnel-nb" Enter	
      else	
        browser="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"	
        killall 'Google Chrome'	
        loadin 0.01 "Tunggu sebentar, sedang membuka $browser"	
        tmux send-keys -t 2 "$browser netflix.com --proxy-server=127.0.0.1:$random" Enter	
      fi	
      ;;	
  esac	
  tmux send-keys -t 0 "bebasid tunnel bebasid-tunnel $random $1" Enter	
  tmux select-pane -t 0	
  tmux a	
}	
berhentikan_bebasid_tunnel(){	
  tmux kill-session -t bebasid-tunnel	
}	
pasang_aplikasi_bypass_dpi(){	
  dir="bebasit-installer.sh"	
  curl_wget https://raw.githubusercontent.com/bebasid/bebasit/master/sh/bebasit-installer.sh "-o $dir --silent" "-O $dir -q --quiet"	
  $ambil	
  bash ./bebasit-installer.sh $1	
  rm -rf bebasit-installer.sh $1	
}	
hapus_aplikasi_bypass_dpi(){	
  dir="bebasit-uninstaller.sh"	
  curl_wget https://raw.githubusercontent.com/bebasid/bebasit/master/sh/bebasit-uninstaller.sh "-o $dir --silent" "-O $dir -q --quiet"	
  bash ./bebasit-uninstaller.sh $1	
  rm -rf bebasit-uninstaller.sh $1	
}	

# =============================================================== #	

header_bebasid_fitur(){
  echo "== MEMULAI PENGGUNAAN FITUR BEBASID =="
  echo
  loadin 0.01 "Memeriksa kondisi"
}
aktifkan_fitur(){
  grepstart="$(grep -n "# \[$1]" /etc/hosts | head -n 1 | cut -d: -f1)"
  begin=$(( $grepstart + 1 ))
  loadin 0.01 "Memulai penulisan ulang - baris ke-$begin"
  ekorkucing="$(sed -n "/# \[$1]/,/# \[/p" /etc/hosts | tail -n 1 | cut -d: -f1 | sed 's/[][]/\\&/g')"
  grepend="$(grep -n "$ekorkucing" /etc/hosts | tail -n 1 | cut -d: -f1)"
  end=$(( $grepend - 2 ))
  loadin 0.01 "Mengakhiri penulisan ulang - baris ke-$end"
  sudo sed -i "$begin,$end{s/# //}" /etc/hosts
  echo "Berhasil menulis ulang baris ke-$begin hingga baris ke-$end"
}
footer_bebasid_fitur(){
  echo
  echo "============== BERHASIL =============="
}
matikan_safesearch_google(){
  header_bebasid_fitur
  echo "Fitur yang dipilih: Matikan Fitur SafeSearch (Google dan Youtube)"
  echo
  loadin 0.01 "Mencari konfigurasi"
  aktifkan_fitur "Matikan fitur SafeSearch Google dan Youtube"
  footer_bebasid_fitur
}
matikan_uzone(){
  header_bebasid_fitur
  echo "Fitur yang dipilih: Matikan Fitur Internet Positif"
  echo
  loadin 0.01 "Mencari konfigurasi"
  aktifkan_fitur "BLOCK INTERNET POSITIF"
  footer_bebasid_fitur
}
tambahkan_localhost_osx(){
  header_bebasid_fitur
  echo "Fitur yang dipilih: Tambahkan Localhost OSX"
  echo
  loadin 0.01 "Mencari konfigurasi"
  aktifkan_fitur "MacOS localhost"
  footer_bebasid_fitur
}
tambahkan_localhost_linux(){
  header_bebasid_fitur
  echo "Fitur yang dipilih: Tambahkan Localhost Linux"
  loadin 0.01 "Mencari konfigurasi localhost Linux dalam file hosts"
  aktifkan_fitur "Linux localhost"
  footer_bebasid_fitur
}
tambahkan_localhost_android(){
  header_bebasid_fitur
  echo "Fitur yang dipilih: Tambahkan Localhost Android"
  loadin 0.01 "Mencari konfigurasi localhost Android dalam file hosts"
  aktifkan_fitur "Android localhost"
  footer_bebasid_fitur
}
kembalikan_hosts(){
sudo bash -c "cat > /etc/hosts" <<EOF
127.0.1.1 myhostname
127.0.0.1 localhost

# The following lines are desirable for IPv6 capable hosts
::1 ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::2 ip6-allrouters
ff02::1 ip6-allnodes
ff02::3 ip6-allhosts
EOF
echo "Berhasil memasang hosts bawaan Linux"
}

# =============================================================== #

pasang_paket_bebasid(){
  perbarui_aplikasi_bebasid
  pasang_hosts_bebasid
  matikan_safesearch_google
  matikan_uzone
}
pasang_ulang_paket_bebasid(){
  perbarui_aplikasi_bebasid
  hapus_hosts_bebasid
  pasang_hosts_bebasid
  matikan_safesearch_google
  matikan_uzone
}
hapus_paket_bebasid(){
  hapus_hosts_bebasid
  hapus_aplikasi_bebasid
}

# ====== OKAY, YOU CAN ADD YOUR CUSTOM FUNCTION BELOW HERE ====== #

grep_ip(){
  echo "Mengambil IP dari $domain"
  echo
  curl_wget https://bebasid.herokuapp.com/?get=unblock&domain=$domain "" "-qO-"
  ip=$($ambil)
  if ! [[ "$ip" =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$ ]]; then
  echo
  echo "$domain tidak dapat diunblock dikarenakan tidak ditemukan IP Address yang valid"
  echo
  echo "=== GAGAL MELAKUKAN PROSES UNBLOCK ===="
  exit 1
  else
  echo
  echo "Berhasil mendapatkan IP dari $domain"
  fi
}

fix_hosts(){
  echo "== MEMULAI PERBAIKAN FILE HOSTS =="
  echo
  sudo rm "/etc/hosts"
  kembalikan_hosts
  memulai_ulang_network
  echo
  echo "== BERHASIL MELAKUKAN PERBAIKAN =="
  echo "Catatan: untuk menggunakan BEBASID kembali, dapat menggunakan fungsi update"
}

unblock_hosts(){
loadin 0.01 "Menuliskan domain ke dalam file hosts"
sudo bash -c 'cat >> /etc/hosts-own'<<EOF

# [$domain]
$ip $domain
EOF

sudo bash -c 'cat >> /etc/hosts'<<EOF

# [$domain]
$ip $domain
EOF
echo
echo "== BERHASIL MELAKUKAN PROSES UNBLOCK =="
}

block_hosts(){
sudo bash -c 'cat >> /etc/hosts-own'<<EOF

# [$domain - blocked]
0.0.0.0 $domain
EOF

sudo bash -c 'cat >> /etc/hosts'<<EOF

# [$domain - blocked]
0.0.0.0 $domain
EOF
}

localhost_hosts(){
sudo bash -c 'cat >> /etc/hosts-own'<<EOF

# [$domain - localhost]
$ip $domain
EOF

sudo bash -c 'cat >> /etc/hosts'<<EOF

# [$domain - localhost]
$ip $domain
EOF

sudo bash -c 'cat >> /etc/hosts.bak-bebasid'<<EOF

# [${domain^^} - localhost]
$ip $domain
EOF
}

# =============================================================== #
# =============================================================== #
# =============================================================== #

case $1 in
  menu )
  bebasid_banner
  echo
  echo "+---------------------------------------+"
  echo "|              MENU  UTAMA              |"
  echo "+---------------------------------------+"
  echo""
  PS3='Pilih salah satu opsi: '
  echo
  menuUtama=("Hosts" "Fitur" "Tunnel" "Aplikasi" "Paket" "Bantuan" "Keluar")
  select menuUtamaOpt in "${menuUtama[@]}"
  do
    case $menuUtamaOpt in
    Hosts )
      echo
      echo "+---------------------------------------+"
      echo "|           MENU UTAMA - HOSTS          |"
      echo "+---------------------------------------+"
      echo
      PS3='Pilih salah satu opsi: '
      echo
      menuHosts=("Pasang Hosts BEBASID" "Perbarui Hosts BEBASID" "Hapus Hosts BEBASID" "Keluar")
      select menuHostsOpt in "${menuHosts[@]}"
      do
      case $menuHostsOpt in
        "Pasang Hosts BEBASID" )
        pasang_hosts_bebasid
        break
        ;;
        "Pasang Hosts BEBASID (R-18)" )
        pasang_hosts_bebasid "NSFW"
        break
        ;;
        "Change Type Hosts BEBASID" )
        ambil_hosts_bebasid "NSFW"
        break
        ;;
        "Perbarui Hosts BEBASID" )
        echo
        perbarui_hosts_bebasid
        break
        ;;
        "Hapus Hosts BEBASID" )
        echo
        hapus_hosts_bebasid
        break
        ;;
        #"Menu Sebelumnya" )
        #  break
        #  ;;
        "Keluar" )
        break
        ;;
      esac
      done
      break
      ;;
    Fitur )
      echo
      echo "+---------------------------------------+"
      echo "|           MENU UTAMA - FITUR          |"
      echo "+---------------------------------------+"
      echo
      PS3='Pilih salah satu opsi: '
      menuFitur=("Matikan Fitur SafeSearch (Google dan Youtube)" "Matikan Fitur Internet Positif" "Tambahkan Localhost OSX" "Tambahkan Localhost Linux" "Tambahkan Localhost Android" "Perbaiki Error DNS Not Resolved (Linux)" "Keluar")
      select menuFiturOpt in "${menuFitur[@]}"
      do
      case $menuFiturOpt in
        "Matikan Fitur SafeSearch (Google dan Youtube)" )
        echo
        matikan_safesearch_google
        break
        ;;
        "Matikan Fitur Internet Positif")
        echo
        matikan_uzone
        break
        ;;
        "Tambahkan Localhost OSX" )
        echo
        tambahkan_localhost_osx
        break
        ;;
        "Tambahkan Localhost Linux" )
        echo
        tambahkan_localhost_linux
        break
        ;;
        "Tambahkan Localhost Android" )
        echo
        tambahkan_localhost_android
        break
        ;;
        "Perbaiki Error DNS Not Resolved (Linux)" )
        echo
        kembalikan_hosts
        ;;
        #"Menu Sebelumnya" )
        #  break
        #  ;;
        "Keluar" )
        break
        ;;
      esac
      done
      break
      ;;
      Tunnel )	
          echo	
          echo "+---------------------------------------+"	
          echo "|          MENU UTAMA - TUNNEL          |"	
          echo "+---------------------------------------+"	
          echo	
          PS3='Pilih salah satu opsi: '	
          echo	
          menuTunnel=("Mulai Tunnel DPI" "Berhentikan Tunnel DPI" "Pasang Aplikasi Tunnel DPI" "Keluar")	
          select menuTunnelOpt in "${menuTunnel[@]}"	
          do	
            case $menuTunnelOpt in	
              "Mulai Tunnel DPI" )	
                echo	
                mulai_bebasid_tunnel	
                break	
                ;;	
              "Berhentikan Tunnel DPI" )	
                echo	
                berhentikan_bebasid_tunnel	
                break	
                ;;	
              "Pasang Aplikasi Tunnel DPI" )	
                echo	
                PS3='Pilih aplikasi yang ingin dipasang:'	
                echo	
                menuTunnelApp=("Green Tunnel" "PowerTunnel")	
                select menuTunnelAppOpt in "${menuTunnelApp[@]}"	
                do	
                  case $menuTunnelAppOpt in	
                    "Green Tunnel" )	
                      echo	
                      pasang_aplikasi_bypass_dpi "green-tunnel"	
                      break	
                      ;;	
                    "PowerTunnel" )	
                      echo	
                      pasang_aplikasi_bypass_dpi "powertunnel"	
                      break	
                      ;;	
                  esac	
                done	
                break	
                ;;	
              #"Menu Sebelumnya" )	
              #  break	
              #  ;;	
              "Keluar" )	
                break	
                ;;	
            esac	
          done	
          break	
          ;;
    Aplikasi )
      echo
      echo "+---------------------------------------+"
      echo "|         MENU UTAMA - APLIKASI         |"
      echo "+---------------------------------------+"
      echo
      PS3='Pilih salah satu opsi: '
      echo
      menuAplikasi=("Perbarui Aplikasi BEBASID" "Hapus Aplikasi BEBASID" "Keluar")
      select menuAplikasiOpt in "${menuAplikasi[@]}"
      do
      case $menuAplikasiOpt in
        "Perbarui Aplikasi BEBASID" )
        echo
        perbarui_aplikasi_bebasid
        break
        ;;
        "Hapus Aplikasi BEBASID" )
        echo
        hapus_aplikasi_bebasid
        break
        ;;
        #"Menu Sebelumnya" )
        #  break
        #  ;;
        "Keluar" )
        break
        ;;
      esac
      done
      break
      ;;
    Paket )
      echo
      echo "+---------------------------------------+"
      echo "|           MENU UTAMA - PAKET          |"
      echo "+---------------------------------------+"
      echo
      PS3='Pilih salah satu opsi: '
      echo
      menuPaket=("Pasang Paket BEBASID" "Pasang Ulang Paket BEBASID" "Hapus Paket BEBASID" "Keluar")
      select menuPaketOpt in "${menuPaket[@]}"
      do
      case $menuPaketOpt in
        "Pasang Paket BEBASID" )
        echo
        echo "BEBASID akan menginstal hosts dan mengaktifkan fitur yang tersedia"
        echo "Hal ini membutuhkan waktu yang tidak sebentar sehingga pastikan komputer anda memiliki cukup daya"
        read -p "Apakah anda yakin ingin melanjutkan? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
        echo
        pasang_paket_bebasid
        break
        ;;
        "Pasang Ulang Paket BEBASID" )
        echo
        echo "BEBASID akan menginstal ulang hosts dan mengaktifkan fitur yang tersedia"
        echo "Hal ini membutuhkan waktu yang tidak sebentar sehingga pastikan komputer anda memiliki cukup daya"
        read -p "Apakah anda yakin ingin melanjutkan? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
        echo
        pasang_ulang_paket_bebasid
        break
        ;;
        "Hapus Paket BEBASID" )
        echo
        echo "BEBASID akan menghapus hosts dan menonaktifkan fitur yang tersedia"
        echo "Hal ini membutuhkan waktu yang tidak sebentar sehingga pastikan komputer anda memiliki cukup daya"
        echo "Serta hal ini tidak dapat diurungkan"
        read -p "Apakah anda yakin ingin melanjutkan? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
        echo
        hapus_paket_bebasid
        break
        ;;
        #"Menu Sebelumnya" )
        #  break
        #  ;;
        "Keluar" )
        break
        ;;
      esac
      done
      break
      ;;
    Bantuan )
      echo
      bantuan
      break
      ;;
    Keluar )
      break
      ;;
    esac
  done
  ;;
  "--help")
  bantuan
  ;;
  hosts )
  case $2 in
    install )
    case $3 in
    "--r18" )
      pasang_hosts_bebasid "NSFW"
      ;;
    * )
      pasang_hosts_bebasid "SFW"
      ;;
    esac
    ;;
    change )
    ubah_type_hosts_bebasid
    ;;
    update )
    perbarui_hosts_bebasid
    ;;
    remove )
    hapus_hosts_bebasid
    ;;
    * )
    echo "Perintah tidak dikenali, ketik bebasid --help untuk bantuan"
  esac
  ;;
  app )
  case $2 in
    renew )
    perbarui_aplikasi_bebasid
    ;;
    uninstall )
    hapus_hosts_bebasid
    ;;
    * )
    echo "Perintah tidak dikenali, ketik bebasid --help untuk bantuan"
  esac
  ;;
  tunnel )	
    case $2 in	
      start )	
        if [[ "$4" == "--nb" ]]; then	
          browser="no"	
        else	
          browser="yes"	
        fi	
        case $3 in	
          gt )	
            mulai_bebasid_tunnel "Green Tunnel"	
            ;;	
          pt )	
            mulai_bebasid_tunnel "PowerTunnel"	
            ;;	
          * )	
          echo "Perintah tidak dikenali, ketik bebasid --help untuk bantuan"	
          ;;	
        esac	
        ;;	
      stop )	
        berhentikan_bebasid_tunnel	
        ;;	
      install )	
      case $3 in	
        gt )	
          pasang_aplikasi_bypass_dpi "green-tunnel"	
          ;;	
        pt )	
          pasang_aplikasi_bypass_dpi "powertunnel"	
          ;;	
        * )	
          echo "Perintah tidak dikenali, ketik bebasid --help untuk bantuan"	
          ;;	
       esac 	
      ;;	
      uninstall )	
      case $3 in	
        gt )	
          hapus_aplikasi_bypass_dpi "green-tunnel"	
          ;;	
        pt )	
          hapus_aplikasi_bypass_dpi "powertunnel"	
          ;;	
        * )	
          echo "Perintah tidak dikenali, ketik bebasid --help untuk bantuan"	
          ;;	
       esac 	
      ;;	
      bebasid-tunnel )	
        reset	
        echo "$4 berhasil dibuka (127.0.0.1:$3)"	
        echo "Walaupun terminal ini dapat ditutup"	
        echo "Disarankan terminal ini jangan ditutup selama masih streaming"	
        read -n 1 -s -r -p "Untuk menonaktifkan, cukup tekan [Enter]"	
        bebasid tunnel stop	
        ;;	
      bebasid-tunnel-nb )	
        reset	
        echo "Opsi tanpa browser telah dipilih"	
        echo "Silahkan mengatur sendiri proxy secara manual"	
        echo "Terutama untuk Firefox"	
        read -n 1 -s -r -p ""	
        ;;	
      * )	
        echo "Perintah tidak dikenali, ketik bebasid --help untuk bantuan"	
    esac	
    ;;
  block )
  if [ -z $2 ]; then
    echo "[website] tidak ditentukan"
    read -p "Masukkan website yang ingin diblock: " domain
    read -p "Apakah sudah benar? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
    grep_ip
    unblock_hosts
  else
  domain=$2
  block_hosts
  fi
  ;;
  unblock )
  if [ -z $2 ]; then
    echo "[website] tidak ditentukan"
    read -p "Masukkan website yang ingin diunblock: " domain
    read -p "Apakah sudah benar? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
    check_connection
    echo "===== MEMULAI PROSES UNBLOCK HOSTS ===="
    echo
    cek_koneksi_dengan_internet
    grep_ip
    unblock_hosts
  else
    domain=$2
    cek_koneksi_dengan_internet
    echo "===== MEMULAI PROSES UNBLOCK HOSTS ===="
    echo
    check_duplicate_unblock
    grep_ip
    unblock_hosts
  fi
  ;;
  localhost )
  if [ -z $2 ]; then
    echo "[website] tidak ditentukan"
    read -p "Masukkan website yang ingin diunblock: " domain
    read -p "Apakah sudah benar? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
    if [[ -z $3 ]]; then
    ip="127.0.0.1"
    else
    ip=$3
    fi
    localhost_hosts
  else
    domain=$2
    if [[ -z $3 ]]; then
    ip="127.0.0.1"
    else
    ip=$3
    fi
    localhost_hosts
  fi
  ;;
  "--help" )
  bantuan
  ;;
  "--about" )
  bebasid_banner
  about
  ;;
  "--version" )
  echo "BEBASID v1.0 [Elena - Ann]"
  echo "Linux/Darwin Version"
  ;;
  "--hidden" )
  echo '                                ╒▓█▓▓███▓W▄╓'
  echo '                                 ▓▓▀  ▀▓▒▓▓▒█▓▄╖           ,▄▄'
  echo '                        ╓╗p▓▓▓▓▓▓▓█▄▓▓▓▓▄▄▄▀▀▓▓▓▓▓██▓▓▓▓▓██▀'
  echo '                   ,▄▓█▓▓▓██▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓█▓▄▄    ▀▀▀'
  echo '               ,g▓▓▓▓▓██▓▓▓▓▓▓▓▌▓▓▓▓▓▓▓▓▓▓▓██▓▓█▓▄╖'
  echo '              ,&▓▓▓▒▓██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▌▓▓▓▓██▓▓▄▄      ╓'
  echo '            ▄▒▓▓▓▓▓█▓▓▓▓▓▓█▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒█▓▓▓▀█▀▓▌▓▄.,Æ▒▌'
  echo '            █▄▓▒▒█▓▌▓▓▓▓▓▓█▓▓▓▓▓▌▀▓▓▓▓▓▓▓▓▓▓▓▓▌▒▒▀▓▒▒▒▓,  ▀▄▒▒▒▀W'
  echo '          ╣▓▓▓▓▓▓▌▓▓▓▓▓▓▓▒▀▓▒▒▌░▀░▒▀▀▀▀╜▒▒▀▀▒@▓▄▒▒  █▓▓▓▓▓   ▌▒▓█'
  echo '         ▐▒▓▓▓▓▓▌]▓▓▓▓▓▓█▒▄▓▒▓   ▒▀▒▄▒▒▒▒▒▒▓▓▓▓▓▓▓▓█▓▓▓▓▓▄     █▄'
  echo '         █▓▓▓▓▓█▒▒▓▓▓▓▀▒▐▒▓▓▌▌     ≡▒░▀▀▒▄▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▄    ▀U'
  echo '         ▌▓▓█▓▓█▒▒▒▒▒▒▒▒▒█▓▓▓█       ,╓ ▒▒▒▀▀▀▀▀█▓▓▓▓▓▓▓▓▓▓▓▀▄'
  echo '         █▓▓▌▓▓█▒▒@▓▓▓▄▒▒▒█▓▓▓█              ╓▒∞▀▀▓▓▓▓▓▓▓██▒▄▓▓▄'
  echo '         ▌▓▓▒▀▓█▒╫▓▓▓▓▓▓▓▒▓▌▀▀▓█▄ ,,▄╖      ▓   ,▒█▓▓▓▓▓▓▓▓▒█▓▓▓▓'
  echo '         ║▓▓▒▒▄▒▌▒▓▓▓▓▓▓▓▓▓▓▄╖m▀  ¬┌▓U      ▀*▒    ▀▓▓█▓▓▓▓▀▓██▓█▓▄'
  echo '         └▌▓▌▓▓▓Ñ█▒▓▓▓▓▓▓▓▓▓▓▄   ,⌐┴*         m     █▓▓█▓▓▓▓└▓█╙▓▓▓'
  echo '          ║H▓▌▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓██,    ░░             █▓▓▓██▓▓▓██ ▐▓▓⌐'
  echo '           █▓█▓▓▓▓▓Ñ█▓▀▓▓▓▓▓▓▓▓▓▓█▓▄,       ╓¬    ,█ ▀▓▓███▓▓▓▄  ▓█'
  echo '           └▓▓└▀▓▓▓▓▓▓██▓▓▓▓▓▓▓▓▓▓▓▓▀█▓░,       ▄▓▓▓▓  ▀▓▓▌ └▓▓ ┌█'
  echo '            └▓▌ └█▓▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▒▒▀█░,▄▄▓▓▓└ ▀▓▓▓⌐  █▌   █▌ '
  echo '              ▀    ▀▓▓▓▓▓█▓▓▓██▓▓▓▒▒▒▓▓▓▓██▓█ ▀▀▓▄   ╙▀⌐  U    Γ'
  echo '               ╙      ▀▓▓▓█▀▓▓╙▓▓▓▒██▓▓▓▓▓█▓███p»▄          ╓╖'
  echo '                        ▀▌▒▄╙▓H▐█████████▓█▀    ▓▒ v     g+█▒░█'
  echo '                          ▀▓ └ ▐█▓▓▓██████▀ U    ▌░ └▄    %▓▄▄▀'
  echo '                         ,⌐▄     ▀█▌Q⌐  ,█ ,▌    ▓▒   U'
  echo '                          ≡░▀  ]  ▀█HWª██▌ ▒█    ██   ▐'
  echo '                          └▄▒▒▓⌐   ▀█  ╙█████▌   ██ ▄▄▄H'
  echo '                             *Γ      U   ╓████▄▄▓█ ▐██▀'
  echo '                                       ,,,█▀  ▀▀▀ⁿ'
  echo
  echo '                          KIMI NO UNMEI NO HITO WA BOKU JANAI :")'
  echo '                      TSURAI KEDO INAMENAI, TEMO HANAREGATAI NO SA :")'
  ;;
  * )
  echo "Perintah tidak dikenali, ketik bebasid --help untuk bantuan"
  ;;
esac
