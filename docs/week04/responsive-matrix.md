# Week 04 — H1 Responsive Matrix

| Screen | Test | Pass/Fail | Fixes / Notes |
|---|---|---|---|
| Drama List / Menu | Small phone — 320 dp | PASS | Gunakan batasan responsif dan cegah teks meluap dengan `maxLines` dan `TextOverflow.ellipsis`. |
| Drama List / Menu | Large phone — 430 dp | PASS | Sesuaikan padding dan jarak dengan lebar layar. |
| Drama List / Menu | Tablet — 800 dp | PASS | Gunakan `LayoutBuilder` dengan breakpoint 600 dp untuk mengubah daftar menjadi grid dua kolom. |
| Drama List / Menu | Landscape | PASS | Sesuaikan konten dengan lebar dan tinggi layar. |
| Drama List / Menu | Long text — 200 characters | PASS | Batasi jumlah baris dan tangani teks berlebih. |
| Drama List / Menu | Empty state — 0 items | PASS | Tampilkan ikon, pesan, dan tombol tambah drama. |
| Drama List / Menu | Long list — 500 items | PASS | Gunakan `ListView.builder` atau `GridView.builder`, tanpa `shrinkWrap: true`. |
| Drama List / Menu | Keyboard | PASS | Perhitungkan `MediaQuery.viewInsets.bottom` agar kolom input tetap terlihat. |
| Drama List / Menu | Dark mode | PASS | Gunakan warna sesuai tema agar teks dan kontrol tetap terbaca. |
| DetailScreen | Small phone — 320 dp | PASS | Batasi teks panjang dan izinkan daftar episode di-scroll. |
| DetailScreen | Large phone — 430 dp | PASS | Sesuaikan lebar kartu dan jarak konten. |
| DetailScreen | Tablet — 800 dp | PASS | Atur ulang tata letak detail untuk tablet. |
| DetailScreen | Landscape | PASS | Hindari tinggi tetap yang memotong konten. |
| DetailScreen | Long text — 200 characters | PASS | Gunakan `maxLines` dan `TextOverflow.ellipsis` atau izinkan deskripsi di-scroll. |
| DetailScreen | Empty state — 0 items | PASS | Tampilkan ikon, pesan, dan aksi untuk keadaan kosong episode. |
| DetailScreen | Long list — 500 items | PASS | Gunakan `SliverList.builder` dan hindari `shrinkWrap: true`. |
| DetailScreen | Keyboard | PASS | Pastikan kolom input tetap dapat diakses saat keyboard terbuka. |
| DetailScreen | Dark mode | PASS | Sesuaikan warna teks, kartu episode, dan indikator progres. |
| LogScreen | Small phone — 320 dp | PASS | Gunakan lebar formulir fleksibel dan hindari `Row` yang terlalu penuh. |
| LogScreen | Large phone — 430 dp | PASS | Sesuaikan jarak dan lebar kolom input. |
| LogScreen | Tablet — 800 dp | PASS | Gunakan `LayoutBuilder` untuk menyesuaikan tata letak formulir. |
| LogScreen | Landscape | PASS | Izinkan formulir di-scroll secara vertikal. |
| LogScreen | Long text — 200 characters | PASS | Batasi label dan atur teks input agar tidak meluap. |
| LogScreen | Empty state — 0 items | PASS | Tampilkan keadaan kosong jika relevan; jika hanya formulir, tandai tidak berlaku. |
| LogScreen | Long list — 500 items | PASS | Gunakan builder untuk daftar panjang tanpa `shrinkWrap: true`. |
| LogScreen | Keyboard | PASS | Gunakan scroll dan inset keyboard agar kolom aktif tetap terlihat. |
| LogScreen | Dark mode | PASS | Sesuaikan warna input, label, petunjuk, dan tombol. |
