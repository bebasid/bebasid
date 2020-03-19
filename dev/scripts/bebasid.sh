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
  echo "==  SUPPORT INDONESIAN NET NEUTRALITY  =="
  echo ""
}
about(){
  echo "Name of File  : BEBASID"
  echo "Version       : v2.0 (March 2020)"
  echo "Tested on     :"
  echo "    - Debian: Debian, Ubuntu, Linux Mint"
  echo "    - RHEL  : CentOS, Fedora"
  echo "    - Arch  : Arch Linux, Manjaro"
  echo ""
  echo "Built with love by Icaksh for BEBASID"
  echo "Fixed by gvoze32 (The author of BEBASID)"
}

# =========== DON'T CHANGE THE ORDER OF THIS FUNCTION =========== #

renew_bebasid(){
  echo "======= MEMPERBARUI APLIKASI BEBASID ======"
  if sudo curl -o /usr/local/bin/bebasid https://raw.githubusercontent.com/bebasid/bebasid/master/dev/scripts/bebasid.sh; then
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

remove_bebasid(){
  read -p "Apakah anda yakin ingin menghapus BEBASID? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
  echo "== MEMULAI PENGHAPUSAN APLIKASI BEBASID =="
  echo ""
  echo "Menghapus aplikasi BEBASID"
  if sudo rm -rf /usr/local/bin/bebasid; then
    echo ""
    echo "===== APLIKASI BEBASID TELAH DIHAPUS ====="
  else
    echo ""
    echo "===== APLIKASI BEBASID GAGAL DIHAPUS ====="
  fi
}

unblock_hosts(){
sudo bash -c 'cat >> /etc/hosts-own'<<EOF

# [${domain^^}]
$ip $domain
EOF

sudo bash -c 'cat >> /etc/hosts'<<EOF

# [${domain^^}]
$ip $domain
EOF
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

restore_hosts(){
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

restart_network(){
  echo "Memulai ulang Network Manager"
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

check_curl(){
  if sudo curl -o /etc/hosts https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts; then
    sudo bash -c 'cat /etc/hosts-own >> /etc/hosts'
    echo ""
    echo "Berhasil mengambil file hosts BEBASID"
    restart_network
    echo ""
    echo "====== BERHASIL MEMASANG BEBASID ====="
  else
    sudo mv /etc/hosts.bak-bebasid /etc/hosts
    echo "Gagal mengambil file hosts BEBASID"
    echo ""
    echo "======= GAGAL MEMASANG BEBASID ======="
  fi
}

install_bebasid(){
  echo "== MEMULAI PEMASANGAN HOSTS BEBASID =="
  echo ""
  echo "Memeriksa kondisi"
  if [ -e /etc/hosts.bak-bebasid ]; then
    echo "Anda telah memasang BEBASID, silahkan uninstall BEBASID anda terlebih dahulu"
    echo ""
    echo "==== GAGAL MEMASANG HOSTS BEBASID ===="
    exit 1
  else
    echo "Pastikan anda telah terkoneksi dengan internet dan telah terpasang cURL"
    read -p "Apakah anda yakin ingin memasang BEBASID? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
    sudo mv /etc/hosts /etc/hosts.bak-bebasid
    sudo touch /etc/hosts-own
    echo ""
    check_curl
  fi
}

update_bebasid(){
  echo "===== MEMPERBARUI HOSTS BEBASID ======"
  echo ""
  echo "Memeriksa kondisi"
  if [ -e /etc/hosts.bak-bebasid ]; then
    sudo rm /etc/hosts
    check_curl
    exit 1
  else
    echo "Backup hosts asli tidak ditemukan, opsi pemasangan BEBASID akan dilakukan"
    echo ""
    install_bebasid
  fi
}

uninstall_bebasid(){
  echo "=== MEMULAI PENCOPOTAN HOSTS BEBASID ==="
  echo ""
  echo "Memeriksa Hosts Cadangan"
  echo ""
  if [ -e /etc/hosts.bak-bebasid ]; then
    echo "Hosts cadangan ditemukan, memulai pencopotan BEBASID"
    sudo rm /etc/hosts
    sudo rm /etc/hosts-own
    sudo mv /etc/hosts.bak-bebasid /etc/hosts
    restart_network
    echo ""
    echo "== HOSTS BEBASID TELAH SUKSES DICOPOT =="
  else
    echo "Hosts cadangan tidak ditemukan"
    echo "Pencopotan dengan host konfigurasi bawaan Linux"
    restore_hosts
    restart_network
    echo ""
    echo "== HOSTS BEBASID TELAH SUKSES DICOPOT =="
  fi
}

# ====== OKAY, YOU CAN ADD YOUR CUSTOM FUNCTION BELOW HERE ====== #

grep_ip(){
  ip=$(curl http://two-ply-mixtures.000webhostapp.com/?domain=$domain)
  if ! [[ "$ip" =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$ ]]; then
  echo "$domain tidak dapat diunblock dikarenakan tidak ditemukan IP Address yang valid"
  exit 1
  fi
}

fix_hosts(){
  echo "== MEMULAI PERBAIKAN FILE HOSTS =="
  echo ""
  sudo rm "/etc/hosts"
  restore_hosts
  restart_network
  echo ""
  echo "== BERHASIL MELAKUKAN PERBAIKAN =="
  echo "Catatan: untuk menggunakan BEBASID kembali, dapat menggunakan fungsi update"
}


# INPUTING COMMAND
case $1 in
  "menu")
    bebasid_banner
    PS3='Pilih salah satu opsi: '
    echo ""
    options=("Install" "Update" "Uninstall" "Fix DNS Not Resolved Error" "Renew BEBASID Application" "Remove BEBASID Application" "Exit")
    select opt in "${options[@]}"
    do
      case $opt in
        "Install")
          install_bebasid
          break
          ;;
        "Update")
          update_bebasid
          break
          ;;
        "Uninstall")
          uninstall_bebasid
          break
          ;;
        "Fix DNS Not Resolved Error")
          fix_hosts
          break
          ;;
        "Renew BEBASID Application")
          renew_bebasid
          break
          ;;
        "Remove BEBASID Application")
          remove_bebasid
          break
          ;;
        "Exit")
          break
          ;;
        *)
          echo "Tidak ada opsi $REPLY"
          ;;
      esac
    done
    ;;
  "--help")
    bebasid_banner
    echo "Cara penggunaan:"
    echo "bebasid [command][website(untuk command block, unblock)]"
    echo ""
    echo "List command:"
    echo "menu      : Menampilkan opsi menu"
    echo "--help    : Menampilkan bantuan"
    echo "block     : Memblokir akses website"
    echo "unblock   : Membuka akses website yang terkena blokir Internet Positif"
    echo "install   : Memasang hosts"
    echo "update    : Memperbarui hosts"
    echo "uninstall : Menghapus hosts"
    echo "fix       : Memperbaiki error DNS Not Resolved"
    echo "renew     : Memperbarui aplikasi"
    echo "remove    : Menghapus aplikasi"
    echo ""
    echo "Apabila setelah pemasangan BEBASID terjadi error DNS Not Resolved,"
    echo "Mohon untuk segera menggunakan opsi fix, hal ini"
    echo "belum kami ketahui penyebabnya, yang pasti error terjadi karena"
    echo "ada kesalahan pada file hosts"
    ;;
  "unblock")
    if [ -z $2 ]; then
      echo "[website] tidak ditentukan"
      read -p "Masukkan website yang ingin diunblock: " domain
      read -p "Apakah sudah benar? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
      grep_ip
      unblock_hosts
    else
      domain=$2
      grep_ip
      unblock_hosts
    fi
    ;;
  "block")
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
  "install")
    install_bebasid
    ;;
  "update")
    update_bebasid
    ;;
  "uninstall")
    uninstall_bebasid
    ;;
  "fix")
    fix_hosts
    ;;
  "renew")
    renew_bebasid
    ;;
  "remove")
    remove_bebasid
    ;;
  "--about")
    bebasid_banner
    about
    ;;
  *)
    echo "Perintah tidak dikenali, ketik bebasid --help untuk bantuan"
    ;;
esac
