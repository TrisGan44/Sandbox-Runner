# Sandbox Runner (v1.0)
Skrip *wrapper* berbasis Bash untuk menjalankan program yang tidak dipercaya dengan batas waktu, memori, dan jumlah proses, sebagai *user* khusus berhak minim (`sandboxuser`).

**Proyek Kelompok Mata Kuliah Sistem Operasi (TIK103)**  
Program Studi D4 Rekayasa Keamanan Siber – Politeknik Negeri Jakarta

---

## 👥 Anggota Kelompok & Pembagian Fokus Kerja

| Nama Mahasiswa | Fokus Peran | Tanggung Jawab Utama |
| :--- | :--- | :--- |
| **Tristan Birendra Rozi** | Ketua Kelompok & Arsitek Sistem | Inisialisasi repositori Git, manajemen jadwal, penyusunan `README.md`, & integrasi sistem |
| **Cello Gemayel Aswan** | Pengembang Inti (*Resource & Isolation*) | Implementasi pembatasan sumber daya (`ulimit`: CPU, RAM, NPROC) & isolasi direktori sementara |
| **Muhammad Farrelivo Kafka Herdian** | Pengembang Inti (*Process & Execution*) | Implementasi eksekusi *child process* (`subshell` & `timeout`), penanganan sinyal, & skrip uji (`tests/`) |
| **Rosa Salsabillah Putri Wardoyo** | Dokumentator | Penyusunan dokumen proposal (`docs/PROPOSAL.md`), `Changelog.md`, & laporan/presentasi akhir |

---

## Latar Belakang
Menjalankan skrip dari sumber yang tidak jelas menggunakan akun utama berisiko tinggi. Program berbahaya atau *buggy* dapat membuat sistem *hang* (*infinite loop*, *fork bomb*, konsumsi RAM berlebih) atau merusak berkas pribadi pengguna. **Sandbox Runner** hadir untuk membatasi konsumsi sumber daya dan hak akses program tersebut pada tingkat Sistem Operasi.

---

## Fitur Utama (v1.0 - Selesai)
- [x] **Batas waktu eksekusi (`timeout`)** — Menghentikan proses otomatis jika melewati batas detik yang ditentukan.
- [x] **Batas memori dan jumlah proses (`ulimit`)** — Membatasi memori virtual maksimal 64 MB (`ulimit -v 65536`) dan maksimal 15 proses (`ulimit -u 15`).
- [x] **Eksekusi sebagai `sandboxuser` di folder kerja sementara** — Membuat *user* sistem tanpa akses *login* dan ruang kerja terisolasi di `/tmp/sandbox_XXXXXX`.
- [x] **Log setiap eksekusi** — Mencatat waktu mulai, perintah, batas waktu, dan status hasil ke dalam berkas `sandbox.log`.
- [x] **Pembersihan folder kerja otomatis** — Menggunakan mekanisme `trap` untuk menghapus seluruh berkas sisa eksekusi setelah selesai.

---

## Kebutuhan Sistem
* **Sistem Operasi:** Linux (diuji di Ubuntu 22.04 / 24.04 LTS) di dalam Mesin Virtual (VM).
* **Interpreter & Shell:** Bash (`/bin/bash`) dan Python 3 (untuk menjalankan skrip uji memori).
* **Hak Akses:** Akses `sudo` (diperlukan untuk membuat `sandboxuser` dan mengatur kepemilikan folder sementara).

---

## Cara Menjalankan

1. **Kloning repositori dan beri izin eksekusi:**
   ```bash
   git clone https://github.com
   cd Sandbox-Runner
   chmod 700 src/sandbox.sh
   ```

2. **Jalankan perintah atau skrip uji di dalam sandbox:**
   ```bash
   sudo ./src/sandbox.sh sleep 100
   ```
   *Contoh interaksi di terminal:*
   ```text
   Batas waktu (detik) [default 3]: 2
   DIHENTIKAN: lewat batas waktu (2s)
   ```

3. **Periksa riwayat eksekusi pada file log:**
   ```bash
   cat sandbox.log
   ```

---

## Batasan Sistem
Sandbox Runner adalah pembatas sumber daya (*resource limiter*) dan pengatur hak akses pada tingkat proses, **bukan isolasi penuh** layaknya Virtual Machine atau Docker. Program yang dijalankan masih dapat membaca berkas sistem yang memiliki izin baca publik (seperti `/etc/passwd`) dan mengakses jaringan selama tidak dibatasi oleh *namespace* jaringan.

---

## ⚠️ Peringatan Keamanan
Skrip ini membutuhkan `sudo`, menambahkan *user* sistem (`sandboxuser`), dan skrip di folder `tests/` sengaja dirancang untuk menguji beban ekstrem. **Jalankan hanya di dalam Mesin Virtual (VM).**
