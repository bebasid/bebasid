# Cara Penggunaan Lainnya
## Windows (Manual)

1. Salinkan [Hosts dari BEBASID](https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts), lalu tempelkan ke:
```
C:\Windows\System32\drivers\etc
```
*Untuk membukakan isi file hosts tersebut, silahkan pake bawaan Windows ([Notepad](https://apps.microsoft.com/store/detail/windows-notepad/9MSMLRH6LZF3)) atau program pihak ketiga ([Notepad++](https://notepad-plus-plus.org/downloads/)) jika mau melihat didalam [hosts file-nya](https://en.wikipedia.org/wiki/Hosts_(file)).*

2. Jika halaman masih belum bisa terbuka, silahkan melakukan **Flush DNS** di **Command Prompt**.

```
ipconfig /release
ipconfig /renew
ipconfig /flushdns
```

## Android

### <ins>Root</ins>
*Pastikan jika perangkatmu sudah di root. Jika belum, silahkan menuju ke langkah [Non-Root](#non-root) untuk memakainya.*

**Magisk (Disarankan):**

1. Bukakan Aplikasi **Magisk**, lalu pilih menu **"Module"**.
2. Selanjutnya klik tanda **"+"** lalu cari module `bebasid-magisk.zip`.
3. Lalu, pencet tombol **"Reboot"** untuk memulaikan menerap module `bebasid-magisk.zip` tersebut.

AdAway:

1. Install aplikasi [AdAway](https://f-droid.org/en/packages/org.adaway).

```
https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts
```

2. Bukakan aplikasinya, pilih **"Add"**, kemudian salinkan [Hosts dari BEBASID](https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts), lalu tambahkan setelah menempelkan link hosts bebasid.

3. Centangkan opsi **"Allow Redirections"** di **Pengaturan**/**Settings**.

Manual:

Alternatif *(Jika ingin install melewati file manager atau menambahkan list hosts lain)*

Salinkan [Hosts dari BEBASID](https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts) dan tempelkan di folder `/etc/` bagian `hosts`, kemudian restart HP.

### <ins>Non-Root</ins>

1. Install aplikasi [Hosts Go](https://play.google.com/store/apps/details?id=dns.hosts.server.change) yang ada di Play Store. 
2. Setelah install, bukakan aplikasi Hosts Go. 
3. Klik **"Hosts Settings"**, lalu pilih **hosts**. Kemudian jalankan didalam aplikasi Hosts Go.

## Linux

Buka **Terminal** di Linux, ikuti langkah-langkahnya dan salinkan kode di bawah ini, lalu pencet tombol enter di keyboard-mu.

```
# Install:
sudo wget https://raw.githubusercontent.com/bebasid/bebasid/master/releases/bebasid.sh -O /usr/local/bin/bebasid

# Kemudian berikan perizinan ke folder bash:
sudo chmod +x /usr/local/bin/bebasid

# Bantuan:
bebasid --help
```

Alternatif (*Jika hanya ingin memasang file hosts)*:
```
sudo wget https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts -O /etc/hosts
```

## BSD / macOS

Buka **Terminal** di BSD/macOS, ikuti langkah-langkahnya dan salinkan kode di bawah ini, lalu pencet tombol enter di keyboard-mu.

```
# Install:
sudo curl https://raw.githubusercontent.com/bebasid/bebasid/master/releases/bebasid.sh -o /usr/local/bin/bebasid

# Kemudian berikan perizinan ke folder bash:
sudo chmod +x /usr/local/bin/bebasid

# Bantuan:
bebasid --help
```

Alternatif *(Jika hanya ingin memasang file hosts)*:
```
sudo curl https://raw.githubusercontent.com/bebasid/bebasid/master/releases/hosts -o /etc/hosts
```

## Lintas anjungan

[SwitchHosts](https://github.com/oldj/SwitchHosts) - Aplikasi untuk manajemen & pengalihan host.
