# Week 4 — H2: Constraint Diagnosis

1. Overflow pada teks panjang di DramaCard
Screenshot: h2-title-overflow.png
Masalah: Teks judul drama yang sangat panjang, seperti teks berisi banyak karakter `a`, melewati batas lebar kartu dan menyebabkan overflow horizontal.
Penyebab: Teks tidak membungkus baris dengan benar sehingga lebarnya melebihi ruang yang tersedia.
Perbaikan: Mengatur pembungkusan teks menggunakan `softWrap: true`, membatasi jumlah baris dengan `maxLines`, dan menggunakan `TextOverflow.ellipsis`.

2. Overflow pada teks episode di tablet portrait
Screenshot: h2-episode-overflow.png
Masalah: Pada tampilan tablet portrait, teks bagian episode yang mencapai sekitar 200 karakter menampilkan garis overflow kuning-merah.
Penyebab: Ruang horizontal yang tersedia tidak mencukupi untuk menampilkan teks episode yang panjang di dalam layout kartu.
Perbaikan: Mengatur teks episode agar membungkus baris, membatasi jumlah baris, menggunakan `TextOverflow.ellipsis`, dan memastikan widget teks mendapatkan batas lebar yang sesuai.

3. StatusFilter terlalu kecil
Screenshot: h2-status-filter.png
Masalah: Widget `StatusFilter` menjadi terlalu kecil setelah tinggi kontainernya dibatasi menjadi 10 piksel.
Penyebab: Constraint tinggi yang diberikan kepada widget terlalu kecil untuk menampilkan `DropdownButtonFormField` beserta dekorasinya dengan baik.
Perbaikan: Menghapus batas tinggi yang terlalu kecil dan membiarkan widget menggunakan tinggi yang sesuai dengan konten, atau menetapkan tinggi minimum yang memadai.