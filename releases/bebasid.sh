#!/bin/bash
# Instalasi bash bebasid untuk Linux

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
  echo "Version       : 2020.4 [Adelia] Linux Version"
  echo "Tested on     :"
  echo "    - Debian    : Debian, Ubuntu, Linux Mint"
  echo "    - RHEL      : CentOS, Fedora"
  echo "    - Arch      : Arch Linux, Manjaro"
  echo
  echo "Built with love by icaksh for bebasid"
  echo "Thanks for gvoze32 (The Author of bebasid)"
  echo
  echo "Especially thanks to:"
  echo "    - Linux Netflix Tester : gvoze32, LeLe"
  echo "    - MacOS Netflix Tester : Fulk, Dan008"
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
    echo "  update    : Memperbarui hosts bebasid"
    echo "  remove    : Menghapus hosts bebasid"
    echo "app"
    echo "  renew     : Memperbarui aplikasi bebasid"
    echo "  uninstall : Menghapus aplikasi bebasid"
    echo "netflix"
    echo "  start     : Memulai aplikasi bypass DPI untuk akses Netflix"
    echo "    --nb    : Memulai aplikasi bypass DPI tanpa membuka browser (ops)"
    echo "  stop      : Memberhentikan aplikasi bypass DPI"
    echo "  install   : Memasang aplikasi bypass DPI"
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
    echo "Copyright (c) 2020 BEBASID (under MIT License)"
    echo "by Komunitas Internet Netral Indonesia"
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
  cakepin 0.01 "Mengecek koneksi dengan internet"
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
  cakepin 0.01 "Memulai ulang Network Manager"
  if [[ -e /etc/debian_version ]]; then
    source /etc/os-release
    OS=$ID # debian or ubuntu
  elif [[ -e /etc/fedora-release ]]; then
    OS=fedora
  elif [[ -e /etc/centos-release ]]; then
    OS=centos
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
      sudo service network-manager restart
      ;;
    # RHEL DERIVATIVE
    "centos")
      sudo systemctl restart NetworkManager.service
      ;;
    "fedora")
      sudo systemctl restart NetworkManager.service
      ;;
    # ARCH DERIVATIVE
    "arch")
      sudo systemctl restart NetworkManager.service
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
  curl_wget http://two-ply-mixtures.000webhostapp.com/?geturl=app "--silent" "-qO- --quiet"
  dir=/usr/local/bin/bebasid
  curl_wget $($ambil) "-o $dir --progress-bar" "-O $dir -q --show-progress --progress=bar:force"
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
  cakepin 0.01 "Menghapus aplikasi BEBASID"
  if sudo rm -rf /usr/local/bin/bebasid; then
    echo
    echo "===== APLIKASI BEBASID TELAH DIHAPUS ====="
  else
    echo
    echo "===== APLIKASI BEBASID GAGAL DIHAPUS ====="
  fi
}
ambil_hosts_bebasid(){
  echo "Memulai pengambilan file hosts BEBASID"
  echo
  dir=/etc/hosts
  curl_wget https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts "-o $dir --progress-bar" "-O $dir -q --show-progress --progress=bar:force"
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
  cakepin 0.01 "Memeriksa kondisi"
  if [ -e /etc/hosts.bak-bebasid ]; then
    echo "Komputer ini telah terpasang BEBASID, silahkan uninstall BEBASID terlebih dahulu"
    echo
    echo "==== GAGAL MEMASANG HOSTS BEBASID ===="
    exit 1
  else
    echo "Pastikan komputer telah terpasang cURL atau wget"
    cakepin 0.01 "Memulai instalasi"
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
    ambil_hosts_bebasid
  fi
}
perbarui_hosts_bebasid(){
  cek_koneksi_dengan_internet
  echo "===== MEMPERBARUI HOSTS BEBASID ======"
  echo
  cakepin 0.01 "Memeriksa kondisi"
  if [ -e /etc/hosts.bak-bebasid ]; then
    sudo rm /etc/hosts
    ambil_hosts_bebasid
    exit 1
  else
    echo "Backup hosts asli tidak ditemukan, opsi pemasangan BEBASID akan dilakukan"
    echo
    pasang_hosts_bebasid
  fi
}
hapus_hosts_bebasid(){
  echo "=== MEMULAI PENCOPOTAN HOSTS BEBASID ==="
  echo
  cakepin 0.01 "Memeriksa hosts cadangan"
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
    cakepin 0.01 "Pencopotan dengan konfigurasi hosts bawaan Linux"
    kembalikan_hosts
    memulai_ulang_network
    echo
    echo "== HOSTS BEBASID TELAH SUKSES DICOPOT =="
  fi
}

# =============================================================== #

mulai_streaming_netflix(){
  if ! [[ -x $(command -v gt) ]]; then
    echo "Green Tunnel belum terinstal, ketik bebasid --help untuk bantuan"
    exit 1
  else
    if ! [[ -x $(command -v tmux) ]]; then
      echo "Tmux belum terinstal, ketik bebasid --help untuk bantuan"
      exit 1
    else
      tmux has-session -t 6f4f9a675d5c67aa28350b0276bf911d 2>/dev/null
      if [ $? != 0 ]; then
        tmux new-session -d -s 6f4f9a675d5c67aa28350b0276bf911d -x 252 -y 29
      else
        tmux kill-session -t 6f4f9a675d5c67aa28350b0276bf911d
        tmux new-session -d -s 6f4f9a675d5c67aa28350b0276bf911d -x 252 -y 29
      fi
      random=$(shuf -i 6000-8000 -n 1)
      tmux split-window -v
      bisa="no"
      i=1
      while [[ "$bisa" == "no" ]]; do
        if [[ $i -eq 10 ]]; then
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
        if curl -x "http://127.0.0.1:$random" https://www.netflix.com --max-time 4; then
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
      if [[ "$browser" == "no" ]]; then
        tmux send-keys -t 2 "bebasid netflix 8e3f1bbb73f0f6c952fcf873332eae9f" Enter
      else
        if [[ -x $(command -v google-chrome-stable) ]]; then
          browser="google-chrome-stable"
          killall chrome
        elif [[ -x $(command -v google-chrome) ]]; then
          browser="google-chrome"
          killall chrome
        fi
          cakepin 0.01 "Tunggu sebentar, sedang membuka $browser"
          tmux send-keys -t 2 "$browser netflix.com --proxy-server=127.0.0.1:$random" Enter
      fi
      tmux send-keys -t 0 "bebasid netflix 6f4f9a675d5c67aa28350b0276bf911d $random" Enter
      tmux select-pane -t 0
      tmux a
    fi
  fi
}
berhenti_streaming_neflix(){
  tmux kill-session -t 6f4f9a675d5c67aa28350b0276bf911d
}
pasang_aplikasi_bypass_dpi(){
  dir="install-gt.sh"
  curl_wget https://raw.githubusercontent.com/bebasid/bebasid/master/dev/commands/install-gt.sh "-o $dir --silent" "-O $dir -q --quiet"
  $ambil
  sudo bash ./install-gt.sh
  rm -rf install-gt.sh
}

# =============================================================== #

header_bebasid_fitur(){
  echo "== MEMULAI PENGGUNAAN FITUR BEBASID =="
  echo
  cakepin 0.01 "Memeriksa kondisi"
}
aktifkan_fitur(){
  grepstart="$(grep -n "# \[$1]" /etc/hosts | head -n 1 | cut -d: -f1)"
  begin=$(( $grepstart + 1 ))
  cakepin 0.01 "Memulai penulisan ulang - baris ke-$begin"
  ekorkucing="$(sed -n "/# \[$1]/,/# \[/p" /etc/hosts | tail -n 1 | cut -d: -f1 | sed 's/[][]/\\&/g')"
  grepend="$(grep -n "$ekorkucing" /etc/hosts | tail -n 1 | cut -d: -f1)"
  end=$(( $grepend - 2 ))
  cakepin 0.01 "Mengakhiri penulisan ulang - baris ke-$end"
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
  cakepin 0.01 "Mencari konfigurasi"
  aktifkan_fitur "Matikan fitur SafeSearch Google dan Youtube"
  footer_bebasid_fitur
}
#matikan_uzone(){
#  header_bebasid_fitur
#  echo "Fitur yang dipilih: Matikan Fitur Internet Positif"
#  echo
#  cakepin 0.01 "Mencari konfigurasi"
#  aktifkan_fitur "BLOCK INTERNET POSITIF"
#  footer_bebasid_fitur
#}
tambahkan_localhost_osx(){
  header_bebasid_fitur
  echo "Fitur yang dipilih: Tambahkan Localhost OSX"
  echo
  cakepin 0.01 "Mencari konfigurasi"
  aktifkan_fitur "MacOS localhost"
  footer_bebasid_fitur
}
tambahkan_localhost_linux(){
  header_bebasid_fitur
  echo "Fitur yang dipilih: Tambahkan Localhost Linux"
  cakepin 0.01 "Mencari konfigurasi localhost Linux dalam file hosts"
  aktifkan_fitur "Linux localhost"
  footer_bebasid_fitur
}
tambahkan_localhost_android(){
  header_bebasid_fitur
  echo "Fitur yang dipilih: Tambahkan Localhost Android"
  cakepin 0.01 "Mencari konfigurasi localhost Android dalam file hosts"
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

# ====== OKAY, YOU CAN ADD YOUR CUSTOM FUNCTION BELOW HERE ====== #

grep_ip(){
  echo "Mengambil IP dari $domain"
  echo
  curl_wget http://two-ply-mixtures.000webhostapp.com/?domain=$domain "" "-qO-"
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
cakepin 0.01 "Menuliskan domain ke dalam file hosts"
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
    menuUtama=("Hosts" "Fitur" "Netflix" "Aplikasi" "Bantuan" "Keluar")
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
          menuFitur=("Matikan Fitur SafeSearch (Google dan Youtube)" "Tambahkan Localhost OSX" "Tambahkan Localhost Linux" "Tambahkan Localhost Android" "Perbaiki Error DNS Not Resolved (Linux)" "Keluar")
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
        Netflix )
          echo
          echo "+---------------------------------------+"
          echo "|          MENU UTAMA - NEFLIX          |"
          echo "+---------------------------------------+"
          echo
          PS3='Pilih salah satu opsi: '
          echo
          menuNetflix=("Mulai Streaming Netflix" "Berhenti Streaming Netflix" "Pasang Aplikasi Bypass DPI" "Keluar")
          select menuNetflixOpt in "${menuNetflix[@]}"
          do
            case $menuNetflixOpt in
              "Mulai Streaming Netflix" )
                echo
                mulai_streaming_netflix
                break
                ;;
              "Berhenti Streaming Netflix" )
                echo
                berhenti_streaming_neflix
                break
                ;;
              "Pasang Aplikasi Bypass DPI" )
                echo
                pasang_aplikasi_bypass_dpi
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
        pasang_hosts_bebasid
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
  netflix )
    case $2 in
      start )
        if [[ "$3" == "--nb" ]]; then
          browser="no"
        else
          browser="yes"
        fi
        mulai_streaming_netflix
        ;;
      stop )
        berhenti_streaming_neflix
        ;;
      install )
        pasang_aplikasi_bypass_dpi
        ;;
      6f4f9a675d5c67aa28350b0276bf911d )
        reset
        echo "Green Tunnel berhasil dibuka (127.0.0.1:$3)"
        echo "Walaupun terminal ini dapat ditutup"
        echo "Disarankan terminal ini jangan ditutup selama masih streaming"
        read -n 1 -s -r -p "Untuk menonaktifkan, cukup tekan [Enter]"
        bebasid netflix stop
        ;;
      8e3f1bbb73f0f6c952fcf873332eae9f )
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
    echo "BEBASID - 2020.4 [Adelia] Linux Version"
    ;;
  * )
  echo "Perintah tidak dikenali, ketik bebasid --help untuk bantuan"
  ;;
esac
