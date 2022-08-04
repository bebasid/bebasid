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
    total=$(wc -l < /home/bebasid/public_html/hosts)
    
    sed -i "5i \ " /home/bebasid/public_html/hosts
    sed -i "6i # Tanggal: $sekarang" /home/bebasid/public_html/hosts
    sed -i "7i # Total domain: ~$total" /home/bebasid/public_html/hosts
    sed -i "8i # Mengambil data terbaru dari: https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts" /home/bebasid/public_html/hosts
    sed -i "9i # Data diambil otomatis tiap 1 hari sekali" /home/bebasid/public_html/hosts
fi
