# A architectural breakdown explaining your directory choices and how code is separated.

Aplikasi K-Drama menggunakan struktur yang memisahkan **data, domain, dan presentation** agar setiap bagian memiliki tanggung jawab yang jelas dan mudah dikembangkan.

## Struktur Folder

```text
lib/
├── core/
│   ├── theme/
│   │   └── app_theme.dart
│   └── widgets/
│       └── app_empty_state.dart
├── features/
│   ├── core/
│   │   └── widgets/
│   │       └── app_empty_state.dart
│   ├── drama/
│   │   ├── data/
│   │   │   └── drama_repository.dart
│   │   ├── domain/
│   │   │   └── models/
│   │   │       └── drama.dart
│   │   └── presentation/
│   │       ├── screens/
│   │       │   ├── detail_screen.dart
│   │       │   ├── home_shell.dart
│   │       │   └── log_screen.dart
│   │       └── widgets/
│   │           ├── collection_summary.dart
│   │           ├── drama_card.dart
│   │           ├── drama_search.dart
│   │           └── status_filter.dart
│   └── harness/
│       └── device_harness.dart
└── main.dart
```

## Explaination
- core/ berisi komponen umum yang dapat digunakan oleh aplikasi, seperti theme dan widget empty state.
- features/drama/domain/ berisi model utama aplikasi, yaitu Drama.
- features/drama/data/ menangani penyimpanan dan pengambilan data melalui DramaRepository.
- features/drama/presentation/screens/ berisi halaman utama aplikasi seperti HomeShell, DetailScreen, dan LogScreen.
- features/drama/presentation/widgets/ berisi widget yang digunakan untuk menampilkan dan mengelola koleksi drama.
- features/harness/ berisi DeviceHarness untuk pengujian responsive pada berbagai ukuran dan kondisi perangkat.
- main.dart merupakan entry point aplikasi dan mengatur konfigurasi utama aplikasi.

## Alasan Struktur
Struktur ini memisahkan data, model, dan tampilan sehingga perubahan pada satu bagian tidak perlu mengubah seluruh aplikasi. Pembagian berbasis fitur juga membuat kode lebih mudah dipahami dan dikembangkan.