# Changelog

## v0.1 (2026-11-19)

- Menjalankan program dengan batas waktu 3 detik menggunakan `timeout`
- Menampilkan hasil: dihentikan karena batas waktu, atau selesai dengan kode keluar

## v0.2 (2026-11-25)

- Batas waktu sekarang ditanyakan ke pengguna saat skrip dijalankan

## v0.3 (2026-11-26)

- Menambahkan input batas memori dalam MB saat skrip dijalankan
- Menerapkan batas memori virtual menggunakan `ulimit -v`, dengan konversi MB ke KB
- Memvalidasi input agar berupa bilangan bulat lebih dari 0
