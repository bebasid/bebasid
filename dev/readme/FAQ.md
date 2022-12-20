# Frequently Asked Questions

Dibawah ini adalah pertanyaan dan jawaban yang seringkali diajukan saat mengalami masalah penggunaan bebasid

## Pertanyaan Umum
### Bagaimana cara kerja bebasid?
- bebasid bekerja dengan cara memetakan hostname ke alamat IP dalam file hosts sehingga untuk akses ke hostname yang diblokir tidak ke DNS, melainkan langsung diresolve oleh file hosts

### Adakah batasan maksimum dalam file hosts
- Hasil riset kami pada tahun 2019 menunjukkan bahwa file hosts dengan konten lebih dari sekitar 1 juta domain yand diblokir oleh Internet Positif (18 MB file dengan format txt) akan menunjukkan error "DNS Not Resolved" terhadap domain lain yang tidak tercantum dalam file hosts alias internet hanya dapat mengakses domain yang tercatat dalam file hosts

### Apakah bebasid merupakan VPN?
- Bukan

### Apakah bebasid berimbas terhadap kecepatan koneksi internet?
- Tidak, berbeda dengan VPN, bebasid tidak menyebabkan kecepatan koneksi internet bertambah ataupun berkurang.

### Apakah aplikasi bypass DPI seperti GoodbyeDPI dan Green Tunnel merupakan VPN?
- Bukan, aplikasi bypass DPI bekerja dengan cara memanipulasi HTTP Request Header sehingga tidak mengubah alamat IP Address


## Penyelesaian Masalah untuk Windows
### Error saat menginstall menggunakan aplikasi bebasid
- Laporkan masalah ini ke Discord bebasid
- Gunakan pemasangan file hosts secara manual

### Aplikasi jalan sekejap/sebentar setelah dibuka tetapi langsung keluar/exit
- Hapus file hosts dan hosts-bebasid.bak di folder C:\Windows\System32\drivers\etc kemudian buka kembali aplikasi.

### File hosts tidak terpasang, padahal sudah menggunakan aplikasi bebasid
- Seringkali aplikasi Antivirus seperti Kaspersky mengembalikan file hosts menjadi default
- Ada masalah saat melakukan pemasangan oleh aplikasi bebasid

### Sudah terpasang hosts bebasid, tetapi akses masih terblokir oleh Internet Positif
- Lakukan flushdns
- Hapus cache dan cookie
- Restart komputer

## Penyelesaian Masalah untuk Linux
### Muncul "Tidak dapat terkoneksi dengan Internet" padahal terkoneksi dengan internet
- Aplikasi bebasid gagal melakukan ping ke 8.8.8.8 dikarenakan suatu sebab (misalnya menggunakan jaringan Tri Indonesia), solusinya mengulang hingga berhasil

## Penyelesaian Masalah untuk MacOS (OSX)
### Mengapa bebasid tidak bekerja di peramban Safari?
- Peramban Safari hanya menggunakan hosts jika tercantum IPv4 dan IPv6, sedangkan bebasid hanya mencantumkan IPv4
