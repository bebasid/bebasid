#!/bin/bash

# Instalasi Aplikasi BEBASID untuk Linux
# Tested on RHEL (CentOS, Fedora), Debian (Ubuntu, Linux Mint, etc) and Arch Linux (Manjaro)

bebasid_banner(){
  echo " ____  _____ ____    _    ____ ___ ____  "
  echo "| __ )| ____| __ )  / \  / ___|_ _|  _ \ "
  echo "|  _ \|  _| |  _ \ / _ \ \___ \| || | | |"
  echo "| |_) | |___| |_) / ___ \ ___) | || |_| |"
  echo "|____/|_____|____/_/   \_\____/___|____/ "
  echo ""
  echo "=======  PEDULI INTERNET NETRAL  ========"
  echo ""
}
about(){
  echo "Name of File  : BEBASID"
  echo "Version       : 2020.4 [BETA]"
  echo "Tested on     :"
  echo "    - Debian    : Debian, Ubuntu, Linux Mint"
  echo "    - RHEL      : CentOS, Fedora"
  echo "    - Arch      : Arch Linux, Manjaro"
  echo ""
  echo "Built with love by Icaksh for BEBASID"
  echo "Thanks for gvoze32 (The Author of BEBASID)"
}

# =========== DON'T CHANGE THE ORDER OF THIS FUNCTION =========== #

bantuan(){
    bebasid_banner
    echo "Cara penggunaan:"
    echo "bebasid [command] [option/[website]] [tambahan]"
    echo ""
    echo "List command:"
    echo "menu        : Menampilkan opsi menu BEBASID"
    echo "hosts"
    echo "  install   : Mengganti hosts bawaan dengan hosts BEBASID"
    echo "  update    : Memperbarui hosts BEBASID"
    echo "  remove    : Menghapus hosts BEBASID"
    echo "app"
    echo "  renew     : Memperbarui aplikasi BEBASID"
    echo "  uninstall : Menghapus aplikasi BEBASID"
    echo "netflix"
    echo "  start     : Memulai aplikasi bypass DPI untuk akses Netflix"
    #echo "    --nb    : Memulai aplikasi bypass DPI tanpa membuka browser (ops)"
    echo "  stop      : Memberhentikan aplikasi bypass DPI"
    echo "block"
    echo "  [website] : Memblokir akses ke [website] (ops)" 
    echo "unblock"
    echo "  [website] : Membuka akses ke [website] (ops)"
    echo "localhost"
    echo "  [website] : Membuat localhost (untuk proyek) (ops)"
    echo "    [ip]    : Memberikan IP Address Manual (ops)"
    echo "--help      : Menampilkan bantuan"
    echo ""
    echo "Apabila setelah pemasangan BEBASID terjadi error DNS Not Resolved,"
    echo "Mohon untuk segera menggunakan fitur fix yang ada di menu, hal ini"
    echo "belum kami ketahui penyebabnya, yang pasti error terjadi karena"
    echo "ada kesalahan pada file hosts"
}

cakepin(){
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

curl_wget(){
  if [[ -x $(command -v curl) ]]; then
    ambil="sudo curl $url $copt"
  elif [[ -x $(command -v wget) ]]; then
    ambil="sudo wget $wopt $url"
  else
    echo "Harap install cURL atau wget"
    exit 1
  fi
}

check_duplicate_unblock(){
  echo "Memeriksa apakah domain $domain telah tercatat dalam file hosts"
  begin="$(grep -n "${domain^^}" /etc/hosts | head -n 1 | cut -d: -f1)"
  if [[ $begin>0 ]]; then
    echo "Domain $domain telah tercatat dalam file hosts"
    echo ""
    echo "=== GAGAL MELAKUKAN PROSES UNBLOCK ===="
    exit 1
  fi
}


# =========== NETWORK =========== #

cek_koneksi_dengan_internet(){
  text="Mengecek koneksi dengan internet"
  rand=0.01
  cakepin
  ipo="8.8.8.8"
  nee=1
  if ping -c ${nee} ${ipo} > /dev/null; then
    echo "Komputer terhubung dengan internet"
    echo ""
    echo ""
  else
    echo "Komputer tidak terhubung dengan internet"
    echo "Silahkan cek koneksi komputer dengan internet terlebih dahulu"
    exit 1
  fi
}

memulai_ulang_network(){
  text="Memulai ulang Network Manager"  
  rand=0.01
  cakepin
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
    echo ""
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

# =========== NETWORK END =========== #

# =========== APLIKASI =========== #

perbarui_aplikasi_bebasid(){
  cek_koneksi_dengan_internet
  echo "======= MEMPERBARUI APLIKASI BEBASID ======"
  echo ""
  echo "Memulai pengambilan script bash BEBASID"
  echo ""
  url=http://two-ply-mixtures.000webhostapp.com/?geturl=app
  copt="--silent"
  wopt="-qO- --quiet"
  curl_wget
  url=$($ambil)
  dir=/usr/local/bin/bebasid
  copt="-o $dir --progress-bar"
  wopt="-O $dir -q --show-progress --progress=bar:force"
  curl_wget
  if $ambil ; then
    echo ""
    echo "Berhasil mengunduh script aplikasi BEBASID"
    echo "Mengecek aplikasi"
    sudo bebasid --about
    echo ""
    echo "== BERHASIL MEMPERBARUI APLIKASI BEBASID =="
  else
    echo ""
    echo "Tidak dapat mengunduh script aplikasi BEBASID"
    echo ""
    echo "==== GAGAL MEMPERBARUI APLIKASI BEBASID ==="
  fi
}

hapus_aplikasi_bebasid(){
  read -p "Apakah anda yakin ingin menghapus BEBASID? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
  echo "== MEMULAI PENGHAPUSAN APLIKASI BEBASID =="
  echo ""
  text="Menghapus aplikasi BEBASID"
  rand=0.01
  cakepin
  if sudo rm -rf /usr/local/bin/bebasid; then
    echo ""
    echo "===== APLIKASI BEBASID TELAH DIHAPUS ====="
  else
    echo ""
    echo "===== APLIKASI BEBASID GAGAL DIHAPUS ====="
  fi
}

# =========== END =========== #

# =========== HOSTS =========== #

ambil_hosts_bebasid(){
  echo "Memulai pengambilan file hosts BEBASID"
  echo ""
  url=https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts
  dir=/etc/hosts
  copt="-o $dir --progress-bar"
  wopt="-O $dir -q --show-progress --progress=bar:force"
  curl_wget
  if $ambil; then
    sudo bash -c 'cat /etc/hosts-own >> /etc/hosts'
    echo ""
    echo "Berhasil mengambil file hosts BEBASID"
    memulai_ulang_network
    echo ""
    echo "====== BERHASIL MEMASANG BEBASID ====="
  else
    sudo mv /etc/hosts.bak-bebasid /etc/hosts
    echo "Gagal mengambil file hosts BEBASID"
    echo ""
    echo "======= GAGAL MEMASANG BEBASID ======="
  fi
}

pasang_hosts_bebasid(){
  cek_koneksi_dengan_internet
  echo "== MEMULAI PEMASANGAN HOSTS BEBASID =="
  echo ""
  text="Memeriksa kondisi"
  rand=0.01
  cakepin
  if [ -e /etc/hosts.bak-bebasid ]; then
    echo "Komputer ini telah terpasang BEBASID, silahkan uninstall BEBASID terlebih dahulu"
    echo ""
    echo "==== GAGAL MEMASANG HOSTS BEBASID ===="
    exit 1
  else
    echo "Pastikan komputer telah terpasang cURL atau wget"
    text="Memulai instalasi"
    rand=0.01
    cakepin
    reset
    bebasid_banner
    url=https://raw.githubusercontent.com/bebasid/bebasid/master/dev/readme/RULES.md
    copt=""
    wopt="-qO-"
    curl_wget
    $ambil
    echo ""
    echo "Dengan melanjutkan berarti secara langsung dan tidak langsung, anda menyetujui apa yang tertulis diatas "
    read -p "Apakah anda yakin ingin melanjutkan pemasangan BEBASID? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
    reset
    # Codingan "Yang Penting Jalan" 
    echo "Mengecek koneksi dengan internet"
    echo "Komputer terhubung dengan internet"
    echo "== MEMULAI PEMASANGAN HOSTS BEBASID =="
    echo ""
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
    echo ""
    ambil_hosts_bebasid
  fi
}

perbarui_hosts_bebasid(){
  cek_koneksi_dengan_internet
  echo "===== MEMPERBARUI HOSTS BEBASID ======"
  echo ""
  text="Memeriksa kondisi"
  rand=0.01
  cakepin
  if [ -e /etc/hosts.bak-bebasid ]; then
    sudo rm /etc/hosts
    ambil_hosts_bebasid
    exit 1
  else
    echo "Backup hosts asli tidak ditemukan, opsi pemasangan BEBASID akan dilakukan"
    echo ""
    pasang_hosts_bebasid
  fi
}

hapus_hosts_bebasid(){
  echo "=== MEMULAI PENCOPOTAN HOSTS BEBASID ==="
  echo ""
  text="Memeriksa Hosts Cadangan"
  rand=0.01
  cakepin
  echo ""
  if [ -e /etc/hosts.bak-bebasid ]; then
    echo "Hosts cadangan ditemukan, memulai pencopotan BEBASID"
    sudo rm /etc/hosts
    sudo rm /etc/hosts-own
    sudo mv /etc/hosts.bak-bebasid /etc/hosts
    memulai_ulang_network
    echo ""
    echo "== HOSTS BEBASID TELAH SUKSES DICOPOT =="
  else
    echo "Hosts cadangan tidak ditemukan"
    read -p "Apakah anda yakin ingin menggunakan konfigurasi hosts bawaan Linux? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
    text="Pencopotan dengan konfigurasi hosts bawaan Linux"
    rand=0.01
    cakepin
    kembalikan_hosts
    memulai_ulang_network
    echo ""
    echo "== HOSTS BEBASID TELAH SUKSES DICOPOT =="
  fi
}

# =========== END =========== #

# =========== NETFLIX =========== #
mulai_streaming_netflix(){
  if ! [[ -x $(command -v gt) ]]; then
    echo "Install Dulu Green-Tunnelnya"
    exit 1
  else
    if ! [[ -x $(command -v tmux) ]]; then
      echo "Install Dulu Tmuxnya"
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
      tmux send-keys -t 1 "gt --ip 127.0.0.1 --port $random --dns-server https://doh.dnslify.com/dns-query --system-proxy false --silent true -v 'green-tunnel:*'" Enter
      tmux split-window -h
      #if [[ "$3" == "--nb" ]]; then
      #  tmux send-keys -t 2 "bebasid netflix 8e3f1bbb73f0f6c952fcf873332eae9f" Enter
      #else
        if [[ -x $(command -v google-chrome-stable) ]]; then
          browser="google-chrome-stable"
          killall chrome
        elif [[ -x $(command -v google-chrome) ]]; then
          browser="google-chrome"
          killall chrome
        #elif command -v chromium > /dev/null; then
          #browser="chromium"
          #killall chromium
          #return
        fi
          text="Tunggu sebentar, sedang membuka $browser"
          rand=0.1
          cakepin
          tmux send-keys -t 2 "$browser netflix.com --proxy-server=127.0.0.1:$random" Enter
      #fi
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
  echo""
}
# =========== END =========== #

# =========== PITUR =========== #

header_bebasid_fitur(){
  echo "== MEMULAI PENGGUNAAN FITUR BEBASID =="
  echo ""
  text="Memeriksa kondisi"
  rand=0.01
  cakepin
}

aktifkan_fitur(){
  grepstart="$(grep -n "# \[$keyword]" /etc/hosts | head -n 1 | cut -d: -f1)"
  begin=$(( $grepstart + 1 ))
  text="Memulai penulisan ulang - baris ke-$begin"
  rand=0.01
  cakepin
  ekorkucing="$(sed -n "/# \[$keyword]/,/# \[/p" /etc/hosts | tail -n 1 | cut -d: -f1 | sed 's/[][]/\\&/g')"
  grepend="$(grep -n "$ekorkucing" /etc/hosts | tail -n 1 | cut -d: -f1)"
  end=$(( $grepend - 2 ))
  text="Mengakhiri penulisan ulang - baris ke-$end"
  rand=0.01
  cakepin
  sudo sed -i "$begin,$end{s/# //}" /etc/hosts
  echo "Berhasil menulis ulang baris ke-$begin hingga baris ke-$end"
}

footer_bebasid_fitur(){
  echo ""
  echo "============== BERHASIL =============="
}

matikan_safesearch_google(){
  header_bebasid_fitur
  echo "Fitur yang dipilih: Matikan Fitur SafeSearch (Google dan Youtube)"
  echo ""
  text="Mencari konfigurasi"
  rand=0.01
  cakepin
  keyword="Matikan fitur SafeSearch Google dan Youtube"
  aktifkan_fitur
  footer_bebasid_fitur
}

tambahkan_localhost_osx(){
  header_bebasid_fitur
  echo "Fitur yang dipilih: Tambahkan Localhost OSX"
  echo ""
  text="Mencari konfigurasi"
  rand=0.01
  cakepin
  keyword="MacOS localhost"
  aktifkan_fitur
  footer_bebasid_fitur
}

tambahkan_localhost_linux(){
  header_bebasid_fitur
  echo "Fitur yang dipilih: Tambahkan Localhost Linux"
  text="Mencari konfigurasi localhost Linux dalam file hosts"
  rand=0.01
  cakepin
  keyword="Linux localhost"
  aktifkan_fitur
  footer_bebasid_fitur
}

tambahkan_localhost_android(){
  header_bebasid_fitur
  echo "Fitur yang dipilih: Tambahkan Localhost Android"
  text="Mencari konfigurasi localhost Android dalam file hosts"
  rand=0.01
  cakepin
  keyword="Android localhost"
  aktifkan_fitur
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
  echo ""
  url=http://two-ply-mixtures.000webhostapp.com/?domain=$domain
  copt=""
  wopt="-qO-"
  curl_wget
  ip=$($ambil)
  if ! [[ "$ip" =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$ ]]; then
  echo ""
  echo "$domain tidak dapat diunblock dikarenakan tidak ditemukan IP Address yang valid"
  echo ""
  echo "=== GAGAL MELAKUKAN PROSES UNBLOCK ===="
  exit 1
  else
    echo ""
    echo "Berhasil mendapatkan IP dari $domain"
  fi
}

fix_hosts(){
  echo "== MEMULAI PERBAIKAN FILE HOSTS =="
  echo ""
  sudo rm "/etc/hosts"
  kembalikan_hosts
  memulai_ulang_network
  echo ""
  echo "== BERHASIL MELAKUKAN PERBAIKAN =="
  echo "Catatan: untuk menggunakan BEBASID kembali, dapat menggunakan fungsi update"
}

unblock_hosts(){
text="Menuliskan domain ke dalam file hosts"
rand=0.01
cakepin
sudo bash -c 'cat >> /etc/hosts-own'<<EOF

# [${domain^^}]
$ip $domain
EOF

sudo bash -c 'cat >> /etc/hosts'<<EOF

# [${domain^^}]
$ip $domain
EOF
echo ""
echo "== BERHASIL MELAKUKAN PROSES UNBLOCK =="
}

block_hosts(){
sudo bash -c 'cat >> /etc/hosts-own'<<EOF

# [${domain^^} - BLOCKED]
0.0.0.0 $domain
EOF

sudo bash -c 'cat >> /etc/hosts'<<EOF

# [${domain^^} - BLOCKED]
0.0.0.0 $domain
EOF
}

localhost_hosts(){
sudo bash -c 'cat >> /etc/hosts-own'<<EOF

# [${domain^^} - LOCALHOST]
$ip $domain
EOF

sudo bash -c 'cat >> /etc/hosts'<<EOF

# [${domain^^} - LOCALHOST]
$ip $domain
EOF

sudo bash -c 'cat >> /etc/hosts.bak-bebasid'<<EOF

# [${domain^^} - LOCALHOST]
$ip $domain
EOF
}




case $1 in
  menu )
    bebasid_banner
    echo ""
    echo "+---------------------------------------+"
    echo "|              MENU  UTAMA              |"
    echo "+---------------------------------------+"
    echo""
    PS3='Pilih salah satu opsi: '
    echo ""
    menu_utama=("Hosts" "Fitur" "Netflix" "Aplikasi" "Bantuan" "Keluar")
    select menu_utama_opt in "${menu_utama[@]}"
    do
      case $menu_utama_opt in
        Hosts )
          echo ""
          echo "+---------------------------------------+"
          echo "|           MENU UTAMA - HOSTS          |"
          echo "+---------------------------------------+"
          echo ""
          PS3='Pilih salah satu opsi: '
          echo ""
          menu_hosts=("Pasang Hosts BEBASID" "Perbarui Hosts BEBASID" "Hapus Hosts BEBASID" "Keluar")
          select menu_hosts_opt in "${menu_hosts[@]}"
          do
            case $menu_hosts_opt in
              "Pasang Hosts BEBASID" )
                pasang_hosts_bebasid
                break
                ;;
              "Perbarui Hosts BEBASID" )
                echo ""
                perbarui_hosts_bebasid
                break
                ;;
              "Hapus Hosts BEBASID" )
                echo ""
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
          echo ""
          echo "+---------------------------------------+"
          echo "|           MENU UTAMA - FITUR          |"
          echo "+---------------------------------------+"
          echo ""
          PS3='Pilih salah satu opsi: '
          menu_fitur=("Matikan Fitur SafeSearch (Google dan Youtube)" "Tambahkan Localhost OSX" "Tambahkan Localhost Linux" "Tambahkan Localhost Android" "Perbaiki Error DNS Not Resolved (Linux)" "Keluar")
          select menu_fitur_opt in "${menu_fitur[@]}"
          do
            case $menu_fitur_opt in
              "Matikan Fitur SafeSearch (Google dan Youtube)" )
                echo ""
                matikan_safesearch_google
                break
                ;;
              "Tambahkan Localhost OSX" )
                echo ""
                tambahkan_localhost_osx
                break
                ;;
              "Tambahkan Localhost Linux" )
                echo ""
                tambahkan_localhost_linux
                break
                ;;
              "Tambahkan Localhost Android" )
                echo ""
                tambahkan_localhost_android
                break
                ;;
              "Perbaiki Error DNS Not Resolved (Linux)" )
                echo ""
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
          echo ""
          echo "+---------------------------------------+"
          echo "|          MENU UTAMA - NEFLIX          |"
          echo "+---------------------------------------+"
          echo ""
          PS3='Pilih salah satu opsi: '
          echo ""
          menu_netflix=("Mulai Streaming Netflix" "Berhenti Streaming Netflix" "Keluar")
          select menu_netflix_opt in "${menu_netflix[@]}"
          do
            case $menu_netflix_opt in
              "Mulai Streaming Netflix" )
                echo ""
                mulai_streaming_netflix
                break
                ;;
              "Berhenti Streaming Netflix" )
                echo ""
                berhenti_streaming_neflix
                break
                ;;
              #"Pasang Aplikasi Bypass DPI" )
              #  echo ""
              #  pasang_aplikasi_bypass_dpi
              #  break
              #  ;;
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
          echo ""
          echo "+---------------------------------------+"
          echo "|         MENU UTAMA - APLIKASI         |"
          echo "+---------------------------------------+"
          echo ""
          PS3='Pilih salah satu opsi: '
          echo ""
          menu_aplikasi=("Perbarui Aplikasi BEBASID" "Hapus Aplikasi BEBASID" "Keluar")
          select menu_aplikasi_opt in "${menu_aplikasi[@]}"
          do
            case $menu_aplikasi_opt in
              "Perbarui Aplikasi BEBASID" )
                echo ""
                perbarui_aplikasi_bebasid
                break
                ;;
              "Hapus Aplikasi BEBASID" )
                echo ""
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
          echo ""
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
        mulai_streaming_netflix
        ;;
      stop )
        berhenti_streaming_neflix
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
      echo ""
      cek_koneksi_dengan_internet
      grep_ip
      unblock_hosts
    else
      domain=$2
      cek_koneksi_dengan_internet
      echo "===== MEMULAI PROSES UNBLOCK HOSTS ===="
      echo ""
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
  * )
  echo "Perintah tidak dikenali, ketik bebasid --help untuk bantuan"
  ;;
esac
