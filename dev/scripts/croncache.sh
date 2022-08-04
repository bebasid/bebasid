#!/bin/bash
wget https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts -O /home/bebasid/public_html/hostsdefault

cmp /home/bebasid/public_html/hostsdefault /home/bebasid/public_html/hostscheck
status=$?

if [[ $status = 0 ]]; then
    echo "Tidak ada pembaruan"
else
    cp /home/bebasid/public_html/hostsdefault /home/bebasid/public_html/hostscheck
    cp /home/bebasid/public_html/hostsdefault /home/bebasid/public_html/hosts
    
    sekarang=$(date)
    versi=`date +%M%H%m%d%Y`
    total=$(wc -l < /home/bebasid/public_html/hosts)
    
    sed -i "4i \ " /home/bebasid/public_html/hosts
    sed -i "5i # Versi: $versi" /home/bebasid/public_html/hosts
    sed -i "6i # Tanggal diperbarui: $sekarang" /home/bebasid/public_html/hosts
    sed -i "7i # Total domain: ~$total" /home/bebasid/public_html/hosts
    sed -i "8i # Mengambil data terbaru dari: https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts" /home/bebasid/public_html/hosts
    sed -i "9i # Data diambil otomatis 4x sehari tiap 6 jam sekali" /home/bebasid/public_html/hosts
fi
