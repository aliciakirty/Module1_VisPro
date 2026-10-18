# Week 05 Reflection

## 1. Which structural decision from Week 1 helped you most by Week 5?

Pemisahan kode menjadi `data`, `domain`, dan `presentation` sangat membantu. Setiap bagian memiliki tugas masing-masing, sehingga lebih mudah untuk memperbaiki UI dan masalah responsive tanpa mengubah semua kode.

## 2. Which one cost you time, and what would you do differently?

Membagi kode ke beberapa folder dan file membutuhkan waktu karena saya harus menentukan fungsi dari setiap bagian. Pengujian responsive juga membutuhkan waktu karena beberapa masalah seperti overflow hanya muncul pada ukuran layar tertentu.

Jika mengulang dari awal, saya akan menentukan struktur folder sejak awal dan melakukan pengujian responsive lebih cepat.

## 3. Where is your app's state right now, and what will be hard about moving it in Module 2?

Saat ini data drama dikelola oleh `DramaRepository` dan disimpan menggunakan `SharedPreferences`. Model `Drama` berada di `domain`, sedangkan repository berada di `data`.

Di Module 2, tantangannya adalah membuat pengelolaan data menjadi lebih terpisah, seperti memisahkan data source, repository, dan domain. Dan juga harus memastikan perubahan pada penyimpanan data tidak memengaruhi tampilan aplikasi.