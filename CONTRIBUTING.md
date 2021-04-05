# Berkontribusi ke bebasid
Kontribusi yang dapat dilakukan dapat berupa:
* Melaporkan bug / issue,
* Melakakukan request feature baru,
* Membantu pengembangan / perbaikan,
* dan sebagainya.
 
### Kontribusi mengikuti lisensi yang berlaku
Setiap kontribusi yang dilakukan akan mengikuti lisensi yang berlaku, yaitu [MIT License](https://github.com/bebasid/bebasid/blob/master/LICENSE).

### Laporan bug & request feature
Jika menemukan bug atau ingin melakukan request feature baru, dapat dilakukan dengan [membuka issue baru](https://github.com/bebasid/bebasid/issues/new/choose).

### Membantu pengembangan / perbaikan
1. Lakukan fork pada repository ini.
2. Buat branch baru pada repository tersebut.
3. Lakukan pengembangan / perbaikan.
4. Lakukan pengujian pada perubahan / perbaikan.
5. Ajukan pull request.

### Menambah URL yang belum ada / tidak bekerja
1. Siapkan url yang tidak bisa diakses.
2. Siapkan jaringan yang dapat digunakan untuk mengakses url tersebut (Gunakan VPN / DNS Resolver).
3. Lakukan lookup / resolving.
3a. Dengan VPN, jalankan `nslookup url.com` di terminal/command line, hasil IP akan ditampilkan di layar.
3b. Dengan DNS Resolver, jalankan `dnscrypt-proxy -resolve url.com`  di terminal/command line, hasil IP akan ditampilkan di layar. *(Contoh perintah resolving dengan dnscrypt)*
4. Tambahkan ke hosts dengan format `ipaddress url.com`.

### Ringkasan komit untuk berkas hosts

Untuk memudahkan pengguna dalam melakukan pencarian di riwayat komit, mohon gunakan salah satu format ringkasan komit sebagai berikut:

```
A: example.com
M: example.com
D: example.com
```
* `A` berarti "Add"
* `M` berarti "Modify"
* `D` berarti "Delete"
* Protokol HTTP/HTTPS tidak perlu ditambahkan ke ringkasan komit.
* Jika Anda ingin mengaitkan sebuah issue ke ringkasan komit, Anda bisa menggunakan format seperti ini:<br>`A: example.com (#50)`

#### Referensi
* Untuk VPN dapat menggunakan OpenVPN dan profile dari [tcpvpn.com](https://tcpvpn.com), gunakan profile Indonesia untuk memastikan IP Address yang didapat adalah IP Address untuk akses dari Indonesia.
* Untuk DNS Resolver dapat menggunakan [DNSCrypt](https://www.dnscrypt.org/). 

