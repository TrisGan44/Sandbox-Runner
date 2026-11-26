# Sandbox Runner
Skrip *wrapper* berbasis Bash untuk menjalankan program yang tidak dipercaya dengan batas waktu, memori, dan jumlah proses, sebagai *user* khusus berhak minim.

**Proyek Kelompok Mata Kuliah Sistem Operasi (TIK103)**  
Program Studi D4 Rekayasa Keamanan Siber – Politeknik Negeri Jakarta

---

## 👥 Anggota Kelompok & Pembagian Fokus Kerja

| Nama Mahasiswa | Fokus Peran | Tanggung Jawab Utama |
| :--- | :--- | :--- |
| **Tristan Birendra Rozi** | Ketua Kelompok & Arsitek Sistem | Inisialisasi repositori Git, manajemen jadwal, penyusunan `README.md`, & integrasi sistem |
| **Cello Gemayel Aswan** | Pengembang Inti (*Resource & Isolation*) | Implementasi pembatasan sumber daya (`ulimit`: CPU, RAM, NPROC) & isolasi direktori sementara |
| **Muhammad Farrelivo Kafka Herdian** | Pengembang Inti (*Process & Execution*) | Implementasi eksekusi *child process* (`subshell` & `timeout`), penanganan sinyal, & tangkapan output |
| **Rosa Salsabillah Putri Wardoyo** | Penguji (QA) & Dokumentator | Penyusunan skrip uji berbahaya (`tests/`), dokumen proposal (`docs/PROPOSAL.md`), & `Changelog.md` |

---

## Latar Belakang
Menjalankan skrip dari sumber yang tidak jelas menggunakan akun utama berisiko tinggi. Program berbahaya atau *buggy* dapat membuat sistem *hang* (*infinite loop*, *fork bomb*) atau membaca dan merusak berkas pribadi pengguna. **Sandbox Runner** hadir untuk membatasi konsumsi sumber daya dan hak akses program tersebut pada tingkat Sistem Operasi.

---

## Status Fitur (Roadmap MVP)
- [x] **Batas waktu eksekusi (`timeout`)** — *Selesai di v0.2 (Must Have)*
- [ ] **Batas memori dan jumlah proses (`ulimit`)** — *Dalam pengerjaan (v0.3)*
- [ ] **Eksekusi sebagai `sandboxuser` di folder kerja sementara** — *Direncanakan (v0.4)*
- [ ] **Log setiap eksekusi & pembersihan folder otomatis** — *Direncanakan (v0.4)*

---

## Kebutuhan Sistem
* **Sistem Operasi:** Linux (diuji di Ubuntu 22.04 LTS / Ubuntu 24.04 LTS) di dalam Mesin Virtual (VM).
* **Shell:** Bash (`/bin/bash`).
* **Hak Akses:** Akses `sudo` (untuk konfigurasi *user* terisolasi pada tahap lanjutan).

---

## Cara Menjalankan (Reproducibility)

1. **Kloning repositori dan beri izin eksekusi:**
   ```bash
   git clone https://github.com
   cd Sandbox-Runner
   chmod 700 src/sandbox.sh
   ```

2. **Jalankan skrip dengan target perintah (Contoh uji *timeout*):**
   ```bash
   ./src/sandbox.sh sleep 100
   ```
   *Contoh interaksi di terminal:*
   ```text
   Batas waktu (detik) [default 3]: 2
   DIHENTIKAN: lewat batas waktu
   ```

---

## Batasan Sistem
Sandbox Runner adalah pembatas sumber daya (*resource limiter*) dan pengatur hak akses pada tingkat proses, **bukan isolasi penuh** layaknya Virtual Machine atau Docker. Program yang dijalankan masih dapat membaca berkas sistem yang memiliki izin baca publik (seperti `/etc/passwd`) dan mengakses jaringan selama tidak dibatasi oleh *namespace* jaringan.

---

## ⚠️ Peringatan Keamanan
Proyek ini dibuat untuk tujuan pembelajaran mata kuliah Sistem Operasi. Pengujian menggunakan skrip berbahaya (seperti *infinite loop*, konsumsi RAM ekstrem, atau *fork bomb*) **wajib dijalankan hanya di dalam Mesin Virtual (VM)** yang terisolasi dari sistem utama (*host*).
