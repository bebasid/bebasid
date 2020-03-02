![Netflix Error Playback](https://www.ghacks.net/wp-content/uploads/2016/02/netflix-error-unblocker.jpg)

Setelah menginstall BEBASID, kamu akan bisa membuka Netflix, tetapi saat masuk playback mode akan ada tulisan:

    ======================

    Oops, something when wrong....

    Internet Connection Problem

    An Internet or home network connection problem is preventing playback. Please check your Internet connection and try again.

    If the problem persists, please visit the Netflix Help Center.

    ======================

Kurang lebih seperti itu, karena akses kecepatan Netflix dilimit oleh Internet Positif jadi harus memakai GoodbyeDPI juga.

# Windows

Sebelumnya, install dahulu BEBASID - [USAGE.md](USAGE.md#windows)

Selanjutnya, kamu bisa download GoodbyeDPI disini:  
[Download](http://adena.me/goodbyedpi-0.1.5.zip) / [Mirrors](https://pastebin.com/raw/YCjrgF2G)

**Cara pakai:**  
Pertama, klik service_install.cmd untuk mulai menginstall aplikasinya.  
Kemudian tinggal klik run.cmd untuk memulai aplikasi.  
Silahkan coba untuk memutar film di Netflix.  
Jika sudah selesai, silahkan service_remove.cmd untuk memberhentikan aplikasi.

# Linux

Sebelumnya, install dahulu BEBASID - [USAGE.md](USAGE.md#linux)

Selanjutnya, kamu bisa menggunakan [Green Tunnel](https://github.com/SadeghHayeri/GreenTunnel) yang sudah dilengkapi dengan GUI, instalasinya mudah, tinggal install seperti package biasa, lalu jalankan dan tekan tombol menjadi on.

Alternatifnya, kamu bisa menggunakan [zapret](https://github.com/bol-van/zapret) dengan cara download, kemudian jalankan, install_easy.sh dan jawab pertanyaan yang tersedia.

# MacOS

Sebelumnya, install dahulu BEBASID - [USAGE.md](USAGE.md#bsd--macos)

Selanjutnya, kamu bisa menggunakan [Green Tunnel](https://github.com/SadeghHayeri/GreenTunnel) juga, instalasinya kurang lebih sama dengan Linux.

# Android

Sebelumnya, install dahulu BEBASID - [USAGE.md](USAGE.md#android)

Untuk android silahkan gunakan aplikasi [Dawn](https://play.google.com/store/apps/details?id=com.wktkf.dawn). Tinggal aktifkan saja.

# VPN (Alternatif)

Kalau cara di atas masih tidak bisa digunakan, kamu bisa menggunakan cara ini.

### Bahan:
- BEBASID
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
8. Selesai, silahkan mencoba 

### Rekomendasi Server:
- TCP VPN ID1
- TCP VPN ID2

Note: Hanya aktif selama 5 hari saja. (Jika mati, bisa buat ulang).