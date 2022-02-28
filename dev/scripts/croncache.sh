curl -o /home/bebasidc/public_html/hosts https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts
sekarang=$(date)
total=$(wc -l < /home/bebasidc/public_html/hosts)
sed -i "5i \ " /home/bebasidc/public_html/hosts
sed -i "6i # Tanggal: $sekarang" /home/bebasidc/public_html/hosts
sed -i "7i # Total domain: $total" /home/bebasidc/public_html/hosts
sed -i "8i # Mengambil data terbaru dari: https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts" /home/bebasidc/public_html/hosts
sed -i "9i # Data diambil otomatis tiap 1 hari sekali" /home/bebasidc/public_html/hosts
