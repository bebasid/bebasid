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

- [bebasit](https://github.com/bebasid/bebasit/releases/download/v1.0/bebasit-win.zip) - [[Tutorial]](https://bebasid.github.io/bebasit/#install-win)
- [GoodbyeDPI](https://github.com/bebasid/bebasid/releases/download/0.0.1/bebasid-gdpi.zip) - [[Tutorial]](https://github.com/bebasid/bebasid/blob/master/dev/readme/NETFLIX.md#goodbyedpi)
- [GreenTunnel](https://github.com/SadeghHayeri/GreenTunnel)
- [PowerTunnel](https://github.com/krlvm/PowerTunnel/releases) - [[Tutorial]](https://github.com/bebasid/bebasid/blob/master/dev/readme/NETFLIX.md#powertunnel)

Rekomendasi: bebasit (GoodbyeDPI Method)

## Linux

- [bebasit](https://bebasid.github.io/bebasit/) - [[Tutorial]](https://bebasid.github.io/bebasit/#install-lin)
- [GreenTunnel](https://github.com/SadeghHayeri/GreenTunnel/releases) - [[Tutorial]](https://github.com/bebasid/bebasid/blob/master/dev/readme/NETFLIX.md#green-tunnel)
- [PowerTunnel](https://github.com/krlvm/PowerTunnel/releases) - [[Tutorial]](https://github.com/bebasid/bebasid/blob/master/dev/readme/NETFLIX.md#powertunnel)
- [zapret](https://github.com/bol-van/zapret)

Rekomendasi: bebasit (GreenTunnel Method)

## MacOS

- [bebasit](https://bebasid.github.io/bebasit/) - [[Tutorial]](https://bebasid.github.io/bebasit/#install-mac)
- [GreenTunnel](https://github.com/SadeghHayeri/GreenTunnel/releases) - [[Tutorial]](https://github.com/bebasid/bebasid/blob/master/dev/readme/NETFLIX.md#green-tunnel)
- [PowerTunnel](https://github.com/krlvm/PowerTunnel/releases) - [[Tutorial]](https://github.com/bebasid/bebasid/blob/master/dev/readme/NETFLIX.md#powertunnel)

Rekomendasi: bebasit (GreenTunnel Method)

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

## bebasit (Windows, Linux, dan Mac)

Petunjuk instalasi dan pemakaian bebasit dapat dilihat [di sini](https://bebasid.github.io/bebasit/)

## GoodbyeDPI

### Bahan
- [bebasid](https://bebasid.github.io/)
- [GoodbyeDPI](https://github.com/bebasid/bebasit/releases/download/v0.0.1/bebasit-gdpi.zip)

### Langkah:
1. Jalankan service_install_dnsredir.cmd untuk mulai menginstall
2. Buka run_dnsredir.cmd atau pilihan dns yang lainnya untuk kecepatan yang berbeda (pilih salah satu)
3. Selesai, selamat menonton

Note: Jangan tutup selama masih streaming, untuk versi aplikasi dari store masih belum bisa, hanya melalui browser saja

## Green Tunnel

### Bahan
- NodeJS
- Green Tunnel

### Langkah (GUI)
1. Buka aplikasi Green Tunnel
2. Nyalakan Green Tunnel

### Langkah (CLI)
1. Buka terminal
2. Buka Green Tunnel
```
$ gt
```

Referensi
```
$ gt --help
Usage: green-tunnel [options]
Usage: gt [options]

Options:
  --help, -h      Show help                                            [boolean]
  --version, -V   Show version number                                  [boolean]
  --ip            ip address to bind proxy server[string] [default: "127.0.0.1"]
  --port          port address to bind proxy server     [number] [default: 8000]
  --dns-type               [string] [choices: "https", "tls"] [default: "https"]
  --dns-server        [string] [default: "https://cloudflare-dns.com/dns-query"]
  --silent, -s    run in silent mode                  [boolean] [default: false]
  --verbose, -v   debug mode                              [string] [default: ""]
  --system-proxy  automatic set system-proxy           [boolean] [default: true]

Examples:
  gt
  gt --ip 127.0.0.1 --port 8000
  gt --dns-server https://doh.securedns.eu/dns-query
  gt --verbose 'green-tunnel:proxy*'
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
2. Unduh PowerTunnel terbaru. [[Link]](https://github.com/krlvm/PowerTunnel/releases/latest)

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
