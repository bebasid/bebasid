![Netflix Error Playback](https://preview.redd.it/2b36et324w611.png?width=2722&format=png&auto=webp&s=f51780f3264251c65dba03cf13267e02cedf298c)

Setelah menginstall bebasid, kamu akan bisa membuka Netflix, tetapi saat masuk playback mode akan ada tulisan:

    ======================

    Oops, something when wrong....

    Internet Connection Problem

    An Internet or home network connection problem is preventing playback. Please check your Internet connection and try again.

    If the problem persists, please visit the Netflix Help Center.

    ======================

Berikut beberapa aplikasi yang bisa digunakan untuk membypass throttling DPI untuk Netflix.
    
## Windows

- [GoodbyeDPI](https://github.com/bebasid/bebasid/releases/download/0.0.1/bebasid-gdpi.zip) - [[Tutorial]](https://github.com/bebasid/bebasid/blob/master/dev/readme/NETFLIX.md#goodbyedpi)
- [GreenTunnel](https://github.com/SadeghHayeri/GreenTunnel)
- [PowerTunnel](https://github.com/krlvm/PowerTunnel/releases) - [[Tutorial]](https://github.com/bebasid/bebasid/blob/master/dev/readme/NETFLIX.md#powertunnel)

Rekomendasi: GoodbyeDPI

## Linux

- [GreenTunnel](https://github.com/bebasid/bebasid/releases/download/0.0.1/bebasid-gt.zip) - [[Tutorial]](https://github.com/bebasid/bebasid/blob/master/dev/readme/NETFLIX.md#green-tunnel-untuk-linux)
- [PowerTunnel](https://github.com/krlvm/PowerTunnel/releases) - [[Tutorial]](https://github.com/bebasid/bebasid/blob/master/dev/readme/NETFLIX.md#powertunnel)
- [zapret](https://github.com/bol-van/zapret)

Rekomendasi: GreenTunnel

## MacOS

- [GreenTunnel](https://github.com/SadeghHayeri/GreenTunnel) - [[Tutorial]](https://github.com/bebasid/bebasid/blob/master/dev/readme/NETFLIX.md#green-tunnel-untuk-mac)
- [PowerTunnel](https://github.com/krlvm/PowerTunnel/releases) - [[Tutorial]](https://github.com/bebasid/bebasid/blob/master/dev/readme/NETFLIX.md#powertunnel)

Rekomendasi: GreenTunnel

## Android

- [Dawn](https://play.google.com/store/apps/details?id=com.wktkf.dawn)
- [PowerTunnel](https://github.com/krlvm/PowerTunnel-Android/releases)
- [DPITunnel](https://github.com/zhenyolka/DPITunnel/releases)

Rekomendasi: PowerTunnel

## Android TV / STB

- [Wireguard](https://play.google.com/store/apps/details?id=com.wktkf.dawn) - [[Tutorial]](https://github.com/bebasid/bebasid/blob/master/dev/readme/NETFLIX.md#wireguard)
- VPN - [[Tutorial]](https://github.com/bebasid/bebasid/blob/master/dev/readme/NETFLIX.md#vpn)
- [PowerTunnel](https://github.com/krlvm/PowerTunnel-Android/releases)
- [Dawn](https://play.google.com/store/apps/details?id=com.wktkf.dawn)

Rekomendasi: PowerTunnel (Jika mendukung pemasangan dari luar Play Store)

## Alternatif
Jika diatas tidak mendukung, maka mau tidak mau kamu harus menggunakan VPN - [[Tutorial]](https://github.com/bebasid/bebasid/blob/master/dev/readme/NETFLIX.md#vpn)

&nbsp;

# TUTORIAL

## VPN

### Bahan:
- [bebasid](https://bebasid.github.io/)
- [OpenVPN GUI](https://openvpn.net/community-downloads)
- Config Server 1 [Indonesia TCPVPN](https://www.tcpvpn.com/vpn-server-indonesia)
- Alternatif Config Server 2 [VPNBook](https://www.vpnbook.com/)
- Alternatif Config Server 3 [VPN Jantit](https://www.vpnjantit.com/free-openvpn.html)
- Alternatif Config Server 4 [ListVPN](https://www.listvpn.net/free-vpn-pptp-l2tp-asia)
- Alternatif Config Server 5 [FreeVPN](https://freevpn.me/accounts/)
- Alternatif Config Server 6 [SSHagan](https://www.sshagan.net/?page=vpn-servers)

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

## Wireguard

### Bahan:
- [Wireguard](https://www.wireguard.com/install/)
- Config Server 1 [Wireguard Netflix/Torrent](https://www.fastssh.com/page/wireguard-servers/)
- Alternatif Config Server 2 [AzireVPN](https://www.azirevpn.com/cfg/wireguard)
- Alternatif Config Server 3 [Cryptostorm](https://cryptostorm.is/wireguard)
- Alternatif Config Server 4 [TunSafe](https://tunsafe.com/vpn)

### Langkah:
1. Buat config Wireguard Netflix/Torrent
2. Isi Username dan Password

```
[+] Username has been successfully created
[+] setting an expired date.....
[+] Account valid until ~
[+] Account is ready to use, please check the detail below:
```

3. Lihat di bawah halaman sampai ada pilihan copy dan download config
4. Download config dengan format .conf
5. Buka Wireguard lalu import file yang didownload tadi
6. Isi Username dan Password sesuai dengan langkah kedua
7. Sambungkan koneksi
8. Selesai, selamat menonton

## GoodbyeDPI

### Bahan
- [bebasid](https://bebasid.github.io/)
- [GoodbyeDPI](https://github.com/bebasid/bebasid/releases/download/0.0.1/bebasid-gdpi.zip)

### Langkah:
1. Jalankan service_install_dnsredir.cmd untuk mulai menginstall
2. Buka run_dnsredir.cmd atau pilihan dns yang lainnya untuk kecepatan yang berbeda (pilih salah satu)
3. Selesai, selamat menonton

Note: Jangan tutup selama masih streaming, untuk versi aplikasi dari store masih belum bisa, hanya melalui browser saja

## Green Tunnel (untuk Linux)

### Bahan
- [bebasid](https://bebasid.github.io/)
- Chrome (opsional)

### Langkah:
1. Pastikan aplikasi bebasid telah terpasang
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

### Persyaratan Sistem
- OSX 10.13 (High Sierra) atau lebih tinggi

### Bahan
- [bebasid](https://bebasid.github.io/)
- Aplikasi bebasid + GT
- Chrome (wajib)

### Note
Sebelum melakukan prosedur dibawah ini, anda bisa mengecek perkiraan apakah Netflix dapat dibypass oleh Green Tunnel atau tidak [disini](http://two-ply-mixtures.000webhostapp.com/cek_netflix.php)

### Langkah:
1. Pasang aplikasi bebasid + GT untuk Mac
```
sudo curl -o /usr/local/bin/bebasid-gt https://raw.githubusercontent.com/bebasid/bebasid/master/dev/scripts/green-tunnel/gt-mac.sh
```

2. Berikan akses (_permission_)
```
sudo chmod +x /usr/local/bin/bebasid-gt
```

3. Install Green Tunnel lewat Aplikasi
```
bebasid-gt install
```
NB: Perintah ini akan memasang Homebrew, NodeJS + NPM, Tmux, dan Green Tunnel dalam sistem Mac

4. Jalankan perintah
```
Jalankan (dengan Chrome)
bebasid-gt start

Berhentikan
bebasid-gt stop
```

## PowerTunnel

### Bahan
- [PowerTunnel](https://github.com/krlvm/PowerTunnel/releases/latest)
- Java Runtime Environment (JRE) 7+

Rekomendasi [JRE 8](https://www.oracle.com/java/technologies/javase-jre8-downloads.html)

### Langkah:
1. Install JRE dan pastikan JRE sudah terpasang.
```
$ java -version
```
2. Unduh PowerTunnel terbaru. [[Link]]((https://github.com/krlvm/PowerTunnel/releases/latest))

3. Buat _file_ bernama ```government-blacklist.txt``` di dalam 1 direktori ```PowerTunnel.jar```.
```
$ ls
government-blacklist.txt  PowerTunnel.jar
```

4. Isi _file_ ```government-blacklist.txt``` dengan teks di bawah. Kemudian, _save_.
```
netflix.com
nflxso.net
netflix.co.id
netflix.net
nflxext.com
nflximg.com
nflxvideo.net
```

5. Nyalakan PowerTunnel (_GUI Mode_)
```
java -jar PowerTunnel.jar
```

6. Nyalakan dan jalankan PowerTunnel (_Console Mode_)
```
java -jar PowerTunnel.jar -start -console
```

7. Nyalakan dan jalankan PowerTunnel (_Console Mode_) tanpa _Auto Proxy_ di Windows.
```
java -jar PowerTunnel.jar -start -console -disable-auto-proxy-setup
```

Referensi:
```
$ java -jar PowerTunnel.jar -help
Available params:
 -help - display help
 -start - starts server right after load
 -console - console mode, without UI
 -government-blacklist-from [URL] - automatically fill government blacklist from URL
 -use-dns-sec - enables DNSSec mode with the Google DNS servers
 -use-doh-resolver [URL] - enables DNS over HTTPS resolver
 -disallow-invalid-packets - HTTP packets without Host header will be thrown out (unrecommended)
 -full-chunking - enables chunking the whole packets
 -mix-host-case - enables 'Host' header case mix (unstable)
 -send-payload [length] - to bypass HTTP blocking, 21 is recommended
 -chunk-size [size] - sets size of one chunk
 -ip [IP Address] - sets IP Address
 -port [Port] - sets port
 -with-web-ui [appendix] - enables Web UI at http://powertunnelmonitor[appendix].info
 -disable-auto-proxy-setup - disables auto proxy setup on Windows
 -auto-proxy-setup-win-ie - auto proxy setup using IE instead of native API on Windows
 -full-output-mirroring - fully mirrors system output to the log
 -set-scale-factor [n] - sets DPI scale factor (for testing purposes)
 -disable-journal - disables journal
 -disable-tray - disables tray icon
 -disable-native-lf - disables native L&F (when UI enabled)
 -disable-ui-scaling - disables UI scaling (when UI enabled)
 -disable-updater - disables the update notifier
 -debug - enables debug
```
