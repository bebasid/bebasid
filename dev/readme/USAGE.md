# Cara Penggunaan Lainnya
## Windows (Manual)

Salin file hosts bebasid ke
```
C:\Windows\System32\drivers\etc
```
Jika halaman masih belum bisa terbuka, silahkan lakukan flush dns di cmd.

```
ipconfig /release
ipconfig /renew
ipconfig /flushdns
```

## Android

### Root

**Manual**

Salin file hosts dan paste di folder /etc kemudian restart HP.

**AdAway**

Alternatif (jika ingin install melewati aplikasi atau menambahkan list hosts lain)

Install aplikasi [AdAway](https://f-droid.org/en/packages/org.adaway)

```
https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts
```

Buka aplikasinya, pilih Add, kemudian salin kode diatas lalu tambahkan.

Centang opsi "Allow Redirections" di Settings.

**Magisk** (Disarankan)

Buka Magisk lalu pilih menu "Module".

Selanjutnya klik tanda "+" lalu cari module bebasid-magisk.zip.

Klik tombol "Reboot" untuk memulai menerapkan module tersebut.

### Non-Root

Install aplikasi [Hosts Go](https://play.google.com/store/apps/details?id=dns.hosts.server.change), buka aplikasinya, klik "Hosts Settings", lalu pilih hosts. Kemudian jalankan.

## Linux

Buka terminal, lalu ketik atau salin kode di bawah ini, lalu enter.

```
# Install
sudo wget https://raw.githubusercontent.com/bebasid/bebasid/master/releases/bebasid.sh -O /usr/local/bin/bebasid

# Kemudian berikan permission ke folder bash
sudo chmod +x /usr/local/bin/bebasid

# Bantuan
bebasid --help
```

Alternatif (jika hanya ingin memasang file hosts):
```
sudo wget https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts -O /etc/hosts
```

## BSD / macOS

Buka terminal, lalu ketik atau salin kode di bawah ini, lalu enter.

```
# Install
sudo curl https://raw.githubusercontent.com/bebasid/bebasid/master/releases/bebasid.sh -o /usr/local/bin/bebasid

# Kemudian berikan permission ke folder bash
sudo chmod +x /usr/local/bin/bebasid

# Bantuan
bebasid --help
```

Alternatif (jika hanya ingin memasang file hosts):
```
sudo curl https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts -o /etc/hosts
```
