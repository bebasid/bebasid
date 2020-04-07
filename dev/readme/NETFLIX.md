![Netflix Error Playback](https://preview.redd.it/2b36et324w611.png?width=2722&format=png&auto=webp&s=f51780f3264251c65dba03cf13267e02cedf298c)

Setelah menginstall BEBASID, kamu akan bisa membuka Netflix, tetapi saat masuk playback mode akan ada tulisan:

    ======================

    Oops, something when wrong....

    Internet Connection Problem

    An Internet or home network connection problem is preventing playback. Please check your Internet connection and try again.

    If the problem persists, please visit the Netflix Help Center.

    ======================

Berikut beberapa aplikasi yang bisa digunakan untuk membypass throttling DPI untuk Netflix.
    
## Windows

- [GoodbyeDPI](https://github.com/bebasid/bebasid/releases/download/0.0.1/bebasid-gdpi.zip)
- [GreenTunnel](https://github.com/SadeghHayeri/GreenTunnel)
- [PowerTunnel](https://github.com/krlvm/PowerTunnel/releases)

Rekomendasi: GoodbyeDPI

## Linux

- [GreenTunnel](https://github.com/bebasid/bebasid/releases/download/0.0.1/bebasid-gt.zip)
- [PowerTunnel](https://github.com/krlvm/PowerTunnel/releases)
- [zapret](https://github.com/bol-van/zapret)

Rekomendasi: GreenTunnel

## MacOS

- [GreenTunnel](https://github.com/SadeghHayeri/GreenTunnel)
- [PowerTunnel](https://github.com/krlvm/PowerTunnel/releases)

Rekomendasi: GreenTunnel

## Android

- [Dawn](https://play.google.com/store/apps/details?id=com.wktkf.dawn)
- [PowerTunnel](https://github.com/krlvm/PowerTunnel-Android/releases)
- [DPITunnel](https://github.com/zhenyolka/DPITunnel/releases)

Rekomendasi: PowerTunnel

&nbsp;

&nbsp;

# TUTORIAL

## VPN

### Bahan:
- [BEBASID](https://bebasid.github.io/)
- [OpenVPN GUI](https://openvpn.net/community-downloads)
- Config Server [Indonesia TCPVPN](https://www.tcpvpn.com/vpn-server-indonesia)

### Langkah:
1. Buat SSH Indonesia di TCPVPN
2. Isi Username dan Password

```
Account has been successfully created !

Username :
Password :
IP :
```

3. Lihat di bawah halaman sampai ada pilihan download config .ovpn
4. Ekstrak file di folder anda
5. Buka OpenVPN GUI lalu import file hasil ekstrak tadi (yang ada 443)
6. Isi Username dan Password sesuai dengan langkah kedua (sesuai dengan SSH anda)
7. Sambungkan koneksi dan pilih 443
8. Selesai, selamat menonton

### Rekomendasi Server:
- TCP VPN ID1
- TCP VPN ID2

Note: Hanya aktif selama 5 hari saja. (Jika mati, bisa buat ulang).

## GoodbyeDPI

### Bahan
- [BEBASID](https://bebasid.github.io/)
- [GoodbyeDPI](https://github.com/bebasid/bebasid/releases/download/0.0.1/bebasid-gdpi.zip)

### Langkah:
1. Jalankan service_install_dnsredir.cmd untuk mulai menginstall
2. Buka run_dnsredir.cmd atau pilihan dns yang lainnya untuk kecepatan yang berbeda (pilih salah satu)
3. Selesai, selamat menonton

Note: Jangan tutup selama masih streaming, untuk versi aplikasi dari store masih belum bisa, hanya melalui browser saja

## Green Tunnel (untuk Linux)

### Bahan
- [BEBASID](https://bebasid.github.io/)
- Chrome (opsional)

### Langkah:
1. Pastikan aplikasi BEBASID telah terpasang
```
bebasid --help
```

2. Install Green Tunnel lewat aplikasi (Debian dan Arch (serta turunannya))
```
bebasid netflix install
```

3. Jalankan perintah
```
Jalankan (dengan Chrome)
bebasid netflix start

Jalankan (tanpa Chrome)
bebasid netflix start --nb

Berhentikan
bebasid netflix stop
```

## Green Tunnel (untuk Mac)

### Status
Terujikan di MacOS Catalina

### Bahan
- [BEBASID](https://bebasid.github.io/)
- Aplikasi BEBASID + GT
- Chrome (wajib)

### Langkah:
1. Pasang aplikasi BEBASID + GT untuk Mac
```
sudo curl -o /usr/local/bin/bebasid-gt https://raw.githubusercontent.com/bebasid/bebasid/master/dev/scripts/green-tunnel/gt-mac.sh
```

2. Install Green Tunnel lewat Aplikasi
```
bebasid-gt install
```
NB: Perintah ini akan memasang Homebrew, NodeJS + NPM, Tmux, dan Green Tunnel dalam sistem Mac

3. Jalankan perintah
```
Jalankan (dengan Chrome)
bebasid-gt start

Berhentikan
bebasid-gt stop
```
