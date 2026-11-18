# Sandbox Runner

Skrip wrapper berbasis Bash untuk menjalankan program yang tidak dipercaya
dengan batas waktu, memori, dan jumlah proses, sebagai user khusus berhak minim.

Proyek mata kuliah Sistem Operasi

## Latar Belakang

Menjalankan skrip dari sumber yang tidak jelas menggunakan akun sendiri
berisiko. Program bisa membuat sistem hang (loop tanpa henti, fork bomb)
atau menyentuh berkas pribadi pengguna. Sandbox Runner membatasi apa yang
bisa dilakukan program tersebut.

## Fitur

- [ ] Batas waktu eksekusi (must have)
- [ ] Batas memori dan jumlah proses
- [ ] Eksekusi sebagai `sandboxuser` di folder kerja terpisah
- [ ] Log setiap eksekusi
- [ ] Pembersihan folder kerja setelah selesai

## Kebutuhan

- Linux (diuji di [nama distro, misal Ubuntu 24.04]) di dalam mesin virtual
- Bash
- Akses `sudo`

## Cara Menjalankan

Belum tersedia, akan dilengkapi setelah fitur must have selesai.

## Batasan

Sandbox Runner adalah pembatas sumber daya dan hak akses, bukan isolasi
penuh. Program yang dijalankan masih dapat membaca berkas yang terbuka
untuk semua user (misalnya `/etc/passwd`) dan mengakses jaringan.

## Peringatan

Skrip ini membutuhkan `sudo`, menambah user ke sistem, dan pengujiannya
sengaja menjalankan program perusak. Jalankan hanya di mesin virtual.
