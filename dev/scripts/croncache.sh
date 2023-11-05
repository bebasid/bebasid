#!/bin/bash
path=$(pwd)
hostsdefault_path="$path/public_html/hostsdefault"

wget https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts -O "$hostsdefault_path"

cmp "$hostsdefault_path" "$path/public_html/hostscheck"
status=$?

if [[ $status = 0 ]]; then
    echo "Tidak ada pembaruan"
else
    cp "$hostsdefault_path" "$path/public_html/hostscheck"
    cp "$hostsdefault_path" "$path/public_html/hosts"
    
    sekarang=$(date)
    versi=`date +%M%H%m%d%Y`
    total=$(wc -l < "$path/public_html/hosts")
    
    sed -i "4i \ " "$path/public_html/hosts"
    sed -i "5i # Versi: $versi" "$path/public_html/hosts"
    sed -i "6i # Tanggal diperbarui: $sekarang" "$path/public_html/hosts"
    sed -i "7i # Total domain: ~$total" "$path/public_html/hosts"
    sed -i "8i # Mengambil data terbaru dari: https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts" "$path/public_html/hosts"
    sed -i "9i # Data diambil dan divalidasi secara real-time" "$path/public_html/hosts"
fi
