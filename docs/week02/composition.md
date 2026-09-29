Week 02 — Widget Composition

`DramaCard` diekstraksi untuk readability. Widget ini mengatur tampilan ringkasan drama, progress, dan area yang bisa ditekan, lalu melaporkan event saat card ditekan. 
`DramaSearch` diekstraksi untuk readability. Widget ini mengatur search field dan interaksi input, lalu mengirim search query ke `HomeShell`. 
`StatusFilter` juga dibuat untuk readability untuk mengatur dropdown status dan mengirim status yang dipilih. 
`CollectionSummary` dibuat untuk readability karena mengatur tampilan ringkasan koleksi dan tidak perlu mengirim data ke widget lain. 
`AppEmptyState` dibuat untuk reuse karena digunakan untuk menampilkan kondisi data kosong atau pencarian yang tidak menemukan hasil, dan tidak mengirim data ke widget lain.

Search query dan status yang dipilih disimpan di `HomeShell` karena keduanya digunakan untuk memfilter daftar drama. `DramaSearch` dan `StatusFilter` hanya mengatur tampilan dan mengirim perubahan melalui callback. Dengan begitu, state tetap dikelola oleh parent dan widget yang diekstraksi tetap sederhana.