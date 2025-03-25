<div align="center">

#### Bahasa / Language
| <img src="https://em-content.zobj.net/thumbs/120/twitter/351/flag-indonesia_1f1ee-1f1e9.png" width="16"/> **Indonesia** | <img src="https://github.com/twitter/twemoji/blob/master/assets/svg/1f1fa-1f1f8.svg" width="16"/> [English](README.en.md) |
|-|-|

<p align="center">
    <img src="dev/resources/logo-black.svg#gh-light-mode-only" alt="BebasID Logo White" width="445">
    <img src="dev/resources/logo.svg#gh-dark-mode-only" alt="BebasID Logo Black" width="445"><br>
    <i>Membantumu berselancar dengan bebas dan tak ada habisnya!</i>
</p>

<a href="#">
<!--    
<img src="https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fbebasid%2Fbebasid&count_bg=%23222222&title_bg=%23222222&icon=myspace.svg&icon_color=%23FFFFFF&title=PENONTON+%5BHARI+INI+%2F+TOTAL%5D&edge_flat=true"/>
</a>

<br>
//-->

<a href="LICENSE">
    <img alt="Static Badge" src="https://img.shields.io/badge/MIT-white?style=for-the-badge&logo=andela&logoColor=white&label=Lisensi&labelColor=222">
</a>

<img alt="Static Badge" src="https://img.shields.io/badge/2019-white?style=for-the-badge&logo=fireship&logoColor=white&label=Diluncurkan&labelColor=222">

<br>

<a href="https://discord.gg/bebasid-630415907021389825">
    <img alt="Discord" src="https://img.shields.io/discord/630415907021389825?style=for-the-badge&logo=discord&logoColor=white&label=Discord&labelColor=222&color=white">
</a>

<a href="https://t.me/bebasidbykini">
    <img alt="Static Badge" src="https://img.shields.io/badge/join-white?style=for-the-badge&logo=telegram&logoColor=white&label=Telegram&labelColor=222">
</a>

<a href="https://chat.whatsapp.com/Jmn5Uv4UYj0GdQooI1Jwbi">
    <img alt="Static Badge" src="https://img.shields.io/badge/join-white?style=for-the-badge&logo=whatsapp&logoColor=white&label=WhatsApp&labelColor=222">
</a>

<br>

<a href="https://trakteer.id/bebasidbykini">
    <img alt="Static Badge" src="https://img.shields.io/badge/donasi-white?style=for-the-badge&logo=buymeacoffee&logoColor=white&label=Trakteer&labelColor=222">
</a>

<a href="https://saweria.co/bebasid">
    <img alt="Static Badge" src="https://img.shields.io/badge/donasi-white?style=for-the-badge&logo=iconjar&logoColor=white&label=Saweria&labelColor=222">
</a>
</p>

## Sponsor

*Penyedia VPS yang berorientasi pada kebebasan dan netral untuk kebutuhannya.*

| <a href="https://member.atharva.co.id"><img src="https://member.atharva.co.id/assets/img/logo.png" width="380"></a> |
|-|
| <p align="center">[atharva.co.id](https://member.atharva.co.id)</p> |

<!--
| <a href="https://qdei.co">![QDEI Cloud](https://qdei.co/_image?href=%2F_astro%2Fqdei-logo.Dh5viwbv.avif&f=webp)</a> |
| - |
| <p align="center">[qdei.co](https://qdei.co)</p> |

Dimulai dari **Rp. 50.000,00**.  
[Lihat paket langganan VPS selengkapnya](https://www.atharva.cloud/index.php?rp=/store/cloud-vm-lite)
//-->
</div>

##
> [!IMPORTANT]  
> Untuk Provider (ISP) yang memakai DPI, harap baca [ini](#pemberitahuan-tentang-dpi).<br><br>
> Kami tidak akan menfasilitasi hal illegal seperti Judi Online, Kami bertujuan untuk netralitas internet, bukan melawan hukum dan merugikan masyarakat. Sehingga <b>Kami tidak akan menghiraukan permintaan untuk menambah situs judol ke host kami.</b>

## Daftar Isi
- [Daftar Isi](#daftar-isi)
- [BebasID](#bebasid)
    - [Windows](#windows)
    - [Linux](#linux)
    - [Android](#android)
    - [macOS](#macos)
  - [Metode Lain](#metode-lain)
- [Berkontribusi, Pertanyaan, atau Permintaan](#berkontribusi-pertanyaan-atau-permintaan)
  - [Pemberitahuan tentang DPI](#pemberitahuan-tentang-dpi)
  - [Pertanyaan Umum](#pertanyaan-umum)
- [Syarat dan Ketentuan](#syarat-dan-ketentuan)

## BebasID
Dengan BebasID, anda dapat membuka halaman situs web yang diblokir dengan memanfaatkan [_hosts file_](<https://en.wikipedia.org/wiki/Hosts_(file)>).

### Windows
#### Antarmuka Pengguna Grafis (GUI) - Sedang Perbaikan
<!---
Anda dapat menggunakan [aplikasi BebasID](https://github.com/bebasid/bebasid/releases/tag/v1.1) untuk menginstal hosts BebasID.

![bebasid.exe dijalankan di Windows 10](https://i.imgur.com/Bcq0rgm.png)

Jika Anda membutuhkan kode sumber BebasID (GUI), silakan kunjungi repo [BebasID-src](https://github.com/bebasid/bebasid-src).
-->
*Informasi status perbaikan: [BebasID-src](https://github.com/bebasid/bebasid-src)*

#### PowerShell - Direkomendasikan
```
Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"irm https://raw.githubusercontent.com/bebasid/bebasid/master/releases/bebasid.ps1 | iex`"" -Verb RunAs -Wait
```

#### BebasHosts Portable
BebasHosts adalah penulisan ulang (*rewrite*) dari aplikasi BebasID untuk mengatur hosts file. Anda dapat menggunakan [aplikasi BebasHosts](https://github.com/bebasid/bebasid/raw/master/releases/BebasHosts%20Portable.zip) dengan 2 fungsi utama, yaitu:
1. `.Host-Update.bat` digunakan untuk memodifikasi hosts file Anda dengan file hosts dari BebasID.
2. `.Host-Reset.bat` digunakan untuk mengembalikan hosts file Anda ke kondisi default dari Windows.

### Linux
#### BebasID Shell
Pasang
```
sudo wget https://raw.githubusercontent.com/bebasid/bebasid/master/releases/bebasid.sh -O /usr/local/bin/bebasid && sudo chmod +x /usr/local/bin/bebasid
```
Bantuan
```
bebasid --help
```

#### Hanya Pasang
```
sudo wget https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts -O /etc/hosts
```

### Android
#### Bindhosts (Module Magisk)
Pasang module [bindhosts](https://github.com/backslashxx/bindhosts) ke Magisk, KernelSU atau APatch.
Tambahkan hosts ke bindhosts dan jalankan action menggunakan WebUI [seperti ini](https://imgur.com/a/FGUN2P9).
Jika anda menggunakan Magisk, gunakan [KSU WebUI](https://github.com/5ec1cff/KsuWebUIStandalone) untuk mengakses WebUI dari bindhosts.

### macOS
#### BebasID Shell
Pasang
```
sudo curl https://raw.githubusercontent.com/bebasid/bebasid/master/releases/bebasid.sh -o /usr/local/bin/bebasid && sudo chmod +x /usr/local/bin/bebasid
```

Bantuan
```
bebasid --help
```

#### Hanya Pasang
```
sudo curl https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts -o /etc/hosts
```

### Lintas anjungan
[SwitchHosts](https://github.com/oldj/SwitchHosts) - Aplikasi untuk manajemen & pengalihan host.

### Metode Lain
#### **BebasDNS / BebasID DNS:**
Jika hosts ini tidak cocok untuk Anda, dan Anda ingin menggunakan versi DNS atau DoH/DoT, silakan kunjungi repo [BebasDNS](https://github.com/bebasid/bebasdns).

#### **Pengguna Lainnya:**
Untuk panduan penggunaan lainnya, silakan kunjungi [PENGGUNAAN LAINNYA](https://github.com/bebasid/bebasid/blob/master/dev/readme/USAGE.md) jika Anda memahami pemakaian tersebut.

## Berkontribusi, Pertanyaan, atau Permintaan
Untuk membantu pengembangan BebasID, silakan kunjungi [KONTRIBUSI](https://github.com/bebasid/bebasid/blob/master/CONTRIBUTING.md).

Untuk melaporkan masalah atau mengajukan permintaan fitur, silakan [buka isu baru](https://github.com/bebasid/bebasid/issues/new/choose).

### Pemberitahuan tentang DPI
<details>
<summary>Pencet untuk buka pemberitahuan</summary>

Untuk Wi-Fi / Provider (ISP) yang memakai [Inspeksi Paket Dalam (DPI)](https://github.com/bebasid/bebasdns/blob/main/dev/readme/learnmore.md#apa-itu-dpi), harap gunakan [BebasIT / BebasID IT](https://github.com/bebasid/bebasit) untuk melewati DPI. Atau dengan menyalakan Protokol Internet versi 6 (IPv6), agar DNS-nya melakukan terpaksa jika ISP-nya sudah mendukung.

Bagi Provider ISP yang memblokir domain DoH/DoT, silakan kontak kami di [dukungan@bebasid.com](mailto:dukungan@bebasid.com) untuk mendapatkan alternatif domain lain untuk mengakses layanan DNS BebasID.

**Ciri-ciri ISP menggunakan DPI:**
| Protokol HTTP mengalihkan ke [lamanlabuh.aduankonten.id](http://lamanlabuh.aduankonten.id) | Sedangkan Protokol HTTPS mengerluarkan ke `ERR_CONNECTION_RESET`/`PR_CONNECT_RESET_ERROR` |
|:-|:-|
| <img src="https://github.com/bebasid/bebasid/blob/master/dev/resources/http-lamanlabuh-result.png" alt="HTTP Lamanlabuh Result"> | <img src="https://github.com/bebasid/bebasid/blob/master/dev/resources/https-connection-reset.png" alt="HTTPS Connection Reset Result"> |

[Lihat penjelasan tentang DPI selengkapnya](https://github.com/bebasid/bebasdns/blob/main/dev/readme/learnmore.md).

**Tutorial cara melewati/bypass DPI atau Lamanlabuh menggunakan Modem/Router atau di Sistem Operasi (OS):**

**Modem/Router:**
| <a href="https://github.com/bebasid/bebasit/blob/master/docs/openwrt-tutorial.md"><img src="https://archive.org/download/github.com-openwrt-openwrt_-_2021-04-13_21-34-02/cover.jpg" width="16"/> OpenWRT</a> | <a href="https://github.com/bebasid/bebasit/blob/master/docs/mikrotik-tutorial.md"><img src="https://i.imgur.com/DLGa8wW.png" width="16"/> MikroTik</a> |
|:-|:-|

**Sistem Operasi (OS):**
| <a href="https://github.com/bebasid/bebasit/blob/master/README.md#windows"><img src="https://github.com/bebasid/bebasid/blob/master/dev/resources/windows-11-icon-logo-png_seeklogo-406208.png?raw=true" width="16"/> Windows</a> | <a href="https://github.com/bebasid/bebasit/blob/master/README.md#macos"><img src="https://cdn-icons-png.flaticon.com/512/2/2235.png" width="16"/> MacOS</a> | <a href="https://github.com/bebasid/bebasit/blob/master/README.md#linux"><img src="https://cdn-icons-png.flaticon.com/512/226/226772.png" width="16"/> Linux</a> |
|:-|:-|:-|

</details>

### Pertanyaan Umum
Jika Anda mengalami masalah saat menggunakan BebasID, silakan tanyakan di [Discord](https://discord.gg/EKrxZyu) atau kirim email ke [`dukungan@bebasid.com`](mailto:dukungan@bebasid.com).

## Syarat dan Ketentuan
Dengan menggunakan aplikasi BebasID, Anda dianggap telah membaca, memahami, serta menyetujui semua peraturan yang telah kami buat. Jika Anda tidak menyetujui peraturan tersebut, maka Anda tidak diperkenankan menggunakan aplikasi BebasID. Untuk informasi lebih lanjut tentang aturan yang berlaku, Anda dapat mengunjungi halaman [ATURAN](https://github.com/bebasid/bebasid/blob/master/dev/readme/RULES.md).

---

<p align="center">Bagikan proyek ini</p>
<div id="sosial">
 <p align="center">
  <a href="https://twitter.com/intent/tweet?text=https%3A//github.com/bebasid/bebasid"><img src="https://img.shields.io/badge/X%20%2F%20Twitter-white?style=for-the-badge&logo=x&logoColor=black"/></a>
  <a href="https://www.facebook.com/sharer/sharer.php?u=https%3A//github.com/bebasid/bebasid"><img src="https://img.shields.io/badge/Facebook-white?style=for-the-badge&logo=facebook&logoColor=black"/></a>
 </p>
</div>
