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

## v0.4 (2026-11-26)

- Memvalidasi input batas waktu agar berupa bilangan bulat lebih dari 0
- Input tidak valid (huruf, 0, angka negatif, angka berawalan 0) ditolak sebelum program dijalankan

## v0.5 (2026-11-26)

- Menolak eksekusi jika tidak ada program yang diberikan
- Menambahkan SIGKILL cadangan 1 detik setelah SIGTERM (`timeout -k 1s`)
- Menampilkan pesan hasil berbeda untuk tiap kode keluar (0, 124, 137, 126/127)
- Menambahkan skrip uji: memori, fork bomb, dan akses berkas sensitif
