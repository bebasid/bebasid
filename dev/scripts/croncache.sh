#!/bin/bash
path=$(pwd)

hostsdefault_path="$path/public_html/hostsdefault"
hostscheck_path="$path/public_html/hostscheck"
hosts_path="$path/public_html/hosts"

wget https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts -O "$hostsdefault_path"

cmp "$hostsdefault_path" "$hostscheck_path"
status=$?

if [[ $status = 0 ]]; then
    echo "Tidak ada pembaruan"
else
    cp "$hostsdefault_path" "$hostscheck_path"
    cp "$hostsdefault_path" "$hosts_path"
    
    sekarang=$(date)
    versi=`date +%M%H%m%d%Y`
    total=$(wc -l < "$hosts_path")
    
    sed -i "4i \ " "$hosts_path"
    sed -i "5i # Versi: $versi" "$hosts_path"
    sed -i "6i # Tanggal diperbarui: $sekarang" "$hosts_path"
    sed -i "7i # Total domain: ~$total" "$hosts_path"
    sed -i "8i # Mengambil data terbaru dari: https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts" "$hosts_path"
    sed -i "9i # Data diambil dan divalidasi secara real-time" "$hosts_path"
fi
