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

Untuk permintaan, koreksi, atau penghapusan domain, masukkan satu domain atau URL HTTP/HTTPS. Input `example.com`, `https://example.com/`, dan `https://sub.example.com/` diproses sebagai `example.com`, termasuk saat memeriksa duplikat. Path, query, dan fragmen URL tidak digunakan.

Domain induk ditentukan dengan Public Suffix List dari `tldextract`: `sub.example.co.id` menjadi `example.co.id`, sedangkan `sub.nama.github.io` menjadi `nama.github.io`. Pada koreksi dan penghapusan, subdomain juga menargetkan domain induk tersebut. Input yang tidak valid menghentikan workflow sebelum isu ditutup atau daftar domain diubah.

### Membantu pengembangan / perbaikan
1. Lakukan _fork_ pada repositori ini.
2. Buat cabang (_branch_) baru pada repositori tersebut.
3. Lakukan pengembangan / perbaikan.
4. Lakukan pengujian pada perubahan / perbaikan.
5. Ajukan _pull request_.

Pengujian normalisasi domain isu:

```sh
python3 -m pip install -r dev/scripts/requirements-issue-domain.txt
python3 -m unittest discover -s dev/scripts -p 'test_issue_domain.py' -v
```

Versi `tldextract` dikunci di berkas requirements tersebut. Parser memakai snapshot Public Suffix List bawaan paket tanpa mengunduh daftar saat memproses isu; perbarui dependensi ini jika aturan suffix berubah.

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
