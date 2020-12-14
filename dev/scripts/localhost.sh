#!/bin/bash
echo ""
echo "Selamat datang $HOSTNAME"
echo ""
echo "Pilih tambahan yang akan diaplikasikan ke file hosts kamu"
echo "  1) MacOS localhost"
echo "  2) Linux localhost"
echo "  3) Android localhost"
echo "  4) Keluar"

read n
case $n in
  1) echo "Kamu memilih MacOS localhost"
    linenumber="$(grep -n "OPTIONAL]" /etc/hosts | head -n 1 | cut -d: -f1)"
    sudo sed -i "${linenumber}a\127.0.0.1 localhost\n255.255.255.255 broadcasthost\n::1 localhost\nfe80::1%lo0 localhost\n" /etc/hosts
    echo "Rules localhost MacOS telah ditambahkan ke hosts"
  ;;
  2) echo "Kamu memilih Linux localhost"
    linenumber="$(grep -n "OPTIONAL]" /etc/hosts | head -n 1 | cut -d: -f1)"
    sudo sed -i "${linenumber}a\127.0.0.1 localhost $HOSTNAME\n::1 localhost ip6-localhost ip6-loopback\nfe00::0         ip6-localnet\nff00::0 ip6-mcastprefix\nff02::1 ip6-allnodes\nff02::2 ip6-allrouters\n" /etc/hosts
    echo "Rules localhost Linux telah ditambahkan ke hosts"
  ;;
  3) echo "Kamu memilih Android localhost"
    linenumber="$(grep -n "OPTIONAL]" /etc/hosts | head -n 1 | cut -d: -f1)"
    sudo sed -i "${linenumber}a\127.0.0.1 localhost\n::1 ip6-localhost\n" /etc/hosts
    echo "Rules localhost Android telah ditambahkan ke hosts"
  ;;
  4) break
  ;;
  *) echo "Pilihan tidak tersedia"
  ;;
esac
