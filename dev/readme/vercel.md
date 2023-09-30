<div align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/5/5e/Vercel_logo_black.svg" width="320px">
  <h2>TUTORIAL MEMAKAI DNS KHUSUS MEMBUKA VERCEL.APP DARI BEBASID</h2>
</div>

### Tutorial untuk Provider
- [Telkomsel, XL](#telkomsel-dan-xl)
- [Indihome, CBN, Biznet, Indosat HIFI](#indihome-cbn-biznet-dan-hi-fi)
- [Indosat IM3, Smartfren, ICONNET, 3 (Three)](#indosat-im3-smartfren-iconnet-dan-3-three)
- [Lainnya](#lainnya)

<br>

## Telkomsel dan XL
1.  Ubah Settingan APN Provider.
2.  Cari tulisan **IPv4**, lalu ganti jadi **IPv4/IPv6**
3.  Simpan APN nya dan refresh koneksi seluler anda
4.  Setelah itu, masukan `vercel.dns.bebasid.com` di pengaturan **DNS Pribadi / Private DNS** di perangkat Anda 
5.  Jika anda ingin memakai DNS nya langsung di browser, anda bisa pergi ke **DNS Aman / Secure DNS**, pilih Custom dan isi `https://vercel.dns.bebasid.com/dns-query`
6.  Jika cara diatas tidak berfungsi, [maka silahkan download PowerTunnel untuk membypass DPI dari provider anda](https://github.com/krlvm/PowerTunnel-Android/releases)
<br>

## Indihome, CBN, Biznet, dan HI-FI
1.  Login ke router anda dan aktifkan IPv6 dan restart router anda
       -  Jika anda bingung dengan cara pengaktifkan IPv6 di router anda, [silahkan gabung Discord BebasID untuk diskusi](https://discord.gg/q7AAX3W)
2.  Pasang DNS kami di browser anda dengan cara:
       - **Firefox:**
          - Ketik `about:preferences` di bar URL dan klik enter
          - Klik icon **Privacy & Security** dan cari tulisan DNS-over-HTTPS
          - Klik Max Protection, pada Choose Provider pilih custom dan masukan `https://vercel.dns.bebasid.com/dns-query`
       - **Google Chrome:**
          - Ketik `chrome://settings/security` di bar URL dan klik enter
          - Cari settingan Secure DNS dan pada bagian **With**, pilih **Custom**
          - Masukan `https://vercel.dns.bebasid.com/dns-query`
3.  Jika anda ingin memasang DNS nya di smartphone anda, silahkan cari settingan **DNS Pribadi / Private DNS** dan masukan `vercel.dns.bebasid.com`
4.  Untuk pengguna CBN dan Indosat HI-FI, jika cara diatas masih tidak berfungsi silahkan coba bypass DPI di provider anda masing-masing dengan tool dibawah ini
       - GoodbyeDPI
       - PowerTunnel
       - GreenTunnel
<br>

## Indosat IM3, Smartfren, ICONNET, dan 3 (Three)
1.  [Download PowerTunnel untuk membypass DPI dari provider anda](https://github.com/krlvm/PowerTunnel-Android/releases)
2.  Untuk pengaturan DNS di PowerTunnel, silahkan klik icon 3 baris pada kiri kanan atas, centang bagian DNS dan klik icon gear
3.  DNS Profile pilih Custom, pada bagian DNS or DoH Resolver, silahkan isi `https://vercel.dns.bebasid.com/dns-query`
4.  Centang Enable DNSSec
5.  Kembali dan centang LibertyTunnel dan klik icon gear
6.  Centang bagian
      - Mix host case completely
      - Mix Host header case
      - Send additional 21KB payload
      - Dan uncheck semua selain diatas
7.  Centang Packet Chunking dan ganti Chunk size menjadi **5**
8.  Kembali dan nyalakan PowerTunnel
<br>

## Lainnya
1.  Untuk DoH, silahkan ikuti cara dibawah:
       - **Firefox:**
          - Ketik `about:preferences` di bar URL dan klik enter
          - Klik icon **Privacy & Security** dan cari tulisan DNS-over-HTTPS
          - Klik Max Protection, pada Choose Provider pilih custom dan masukan `https://vercel.dns.bebasid.com/dns-query`
       - **Google Chrome:**
          - Ketik `chrome://settings/security` di bar URL dan klik enter
          - Cari settingan Secure DNS dan pada bagian **With**, pilih **Custom**
          - Masukan `https://vercel.dns.bebasid.com/dns-query`
2.  Untuk DoT, silahkan ikuti cara dibawah:
      - Pergi ke pengaturan handphone anda masing-masing
      - Cari settingan DNS Pribadi / Private DNS
      - Masukan `vercel.dns.bebasid.com` dan klik OK/Save
<br><br><br>

### Jika anda masih mempunyai pertanyaan, silahkan gabung Discord kami
  <a href="https://discord.gg/EKrxZyu" rel="nofollow" style="text-align: center; margin:2% auto;">
            <img class="discord" src="https://camo.githubusercontent.com/82ad315ab53d897c96ac232fe1a5cee370e6bf4c9d17cf1f50e1f29759bcae82/68747470733a2f2f646973636f72646170702e636f6d2f6170692f6775696c64732f3633303431353930373032313338393832352f7769646765742e706e673f7374796c653d62616e6e657232" alt="Join Discord BEBASID" data-canonical-src="https://discordapp.com/api/guilds/630415907021389825/widget.png?style=banner2">
        </a>
