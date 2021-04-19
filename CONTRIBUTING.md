# Berkontribusi ke bebasid
Kontribusi yang dapat dilakukan dapat berupa:
* Melaporkan kutu komputer (_bug_) / isu,
* Melakukan permintaan fitur baru,
* Membantu pengembangan / perbaikan,
* dan sebagainya.
 
### Kontribusi mengikuti lisensi yang berlaku
Setiap kontribusi yang dilakukan akan mengikuti lisensi yang berlaku, yaitu [Lisensi MIT](https://github.com/bebasid/bebasid/blob/master/LICENSE).

### Laporan kutu & permintaan fitur
Jika menemukan kutu atau ingin melakukan permintaan fitur baru, dapat dilakukan dengan [membuka isu baru](https://github.com/bebasid/bebasid/issues/new/choose).

### Membantu pengembangan / perbaikan
1. Lakukan _fork_ pada repositori ini.
2. Buat cabang (_branch_) baru pada repositori tersebut.
3. Lakukan pengembangan / perbaikan.
4. Lakukan pengujian pada perubahan / perbaikan.
5. Ajukan _pull request_.

### Menambah URL yang belum ada / tidak bekerja
1. Siapkan URL yang tidak bisa diakses.
2. Siapkan jaringan yang dapat digunakan untuk mengakses URL tersebut (Gunakan VPN / DNS Resolver).
3. Lakukan lookup / resolving.
3a. Dengan VPN, jalankan `nslookup url.com` di terminal/baris perintah (_command line_), hasil IP akan ditampilkan di layar.
3b. Dengan DNS Resolver, jalankan `dnscrypt-proxy -resolve url.com`  di terminal/baris perintah, hasil IP akan ditampilkan di layar. *(Contoh perintah resolving dengan dnscrypt)*
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
* Jika Anda ingin mengaitkan sebuah isu ke ringkasan komit, Anda bisa menggunakan format seperti ini:<br>`A: example.com (#50)`

#### Referensi
* Untuk VPN dapat menggunakan OpenVPN dan profil dari [tcpvpn.com](https://tcpvpn.com), gunakan profil Indonesia untuk memastikan alamat IP yang didapat adalah alamat IP untuk akses dari Indonesia.
* Untuk DNS Resolver dapat menggunakan [DNSCrypt](https://www.dnscrypt.org/). 
