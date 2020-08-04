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
	echo "Name of File  : bebasid.sh [BETA for Darwin]"
	echo "Version       : 2020.8 [Deandra] Linux/Darwin Version"
	echo "Tested on     :"
	echo "    - Debian    : Debian, Ubuntu, Linux Mint"
	echo "    - RHEL      : CentOS, Fedora"
	echo "    - Arch      : Arch Linux, Manjaro"
	echo "    - Darwin    : MacOS Catalina"
	echo
	echo "Built with love by haibara"
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
		menuUtama=("Hosts" "Fitur" "Aplikasi" "Paket" "Bantuan" "Keluar")
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
		echo "BEBASID - 2020.8 [Deandra]"
		echo "Linux/Darwin Beta Version"
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
