# Sandbox Runner (v0.5)

Skrip *wrapper* berbasis Bash untuk menjalankan program yang tidak dipercaya dengan batas sumber daya, agar program yang bermasalah tidak membuat sistem *hang*.

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

Menjalankan skrip dari sumber yang tidak jelas menggunakan akun utama berisiko tinggi. Program berbahaya atau *buggy* dapat membuat sistem *hang* (*infinite loop*, *fork bomb*, konsumsi RAM berlebih) atau menyentuh berkas pribadi pengguna. **Sandbox Runner** membatasi konsumsi sumber daya dan hak akses program tersebut pada tingkat Sistem Operasi.

---

## Fitur

**Sudah berjalan**

- [x] **Batas waktu eksekusi (`timeout`)**: batas dalam detik ditanyakan ke pengguna; program yang melewati batas dihentikan otomatis.
- [x] **Validasi batas waktu**: input harus bilangan bulat lebih dari 0.
- [x] **Batas memori virtual (`ulimit -v`)**: batas dalam MB ditanyakan ke pengguna, dikonversi ke KB, dan divalidasi harus bilangan bulat lebih dari 0.

**Direncanakan** (lihat jadwal di `docs/PROPOSAL.md`)

- [ ] Batas jumlah proses (`ulimit -u`)
- [ ] Eksekusi sebagai `sandboxuser` di folder kerja sementara
- [ ] Log setiap eksekusi
- [ ] Pembersihan folder kerja otomatis

---

## Kebutuhan Sistem

* **Sistem Operasi:** Linux di dalam Mesin Virtual (VM).
- **Shell:** Bash (`/bin/bash`).
- **Opsional:** Python 3, untuk skenario uji memori.

---

## Cara Menjalankan

1. **Kloning repositori dan beri izin eksekusi:**

   ```bash
   git clone https://github.com/TrisGan44/Sandbox-Runner.git
   cd Sandbox-Runner
   chmod 700 src/sandbox.sh
   ```

2. **Jalankan program di dalam sandbox:**

   ```bash
   ./src/sandbox.sh sleep 100
   ```

   Contoh interaksi di terminal:

   ```text
   Batas waktu (detik): 2
   Batas memori (MB): 64
   DIHENTIKAN: lewat batas waktu
   ```

3. **Jalankan skrip uji:**

   ```bash
   ./src/sandbox.sh bash tests/test_normal.sh
   ./src/sandbox.sh bash tests/test_infinite_loop.sh
   ```

> Jangan menjalankan skrip ini dengan `sudo`. Tanpa fitur `sandboxuser`, `sudo` membuat program di dalamnya berjalan sebagai root.

---

## Struktur Repositori

```text
├── src/sandbox.sh       skrip utama
├── tests/               skrip uji
├── docs/PROPOSAL.md     proposal proyek
├── Changelog.md         riwayat versi
└── readme.md
```

---

## Batasan Sistem

Sandbox Runner adalah pembatas sumber daya (*resource limiter*) pada tingkat proses, **bukan isolasi penuh** layaknya Virtual Machine atau Docker. Program yang dijalankan masih dapat membaca berkas yang terbuka untuk semua user (misalnya `/etc/passwd`) dan mengakses jaringan.

---

## ⚠️ Peringatan Keamanan

Skrip di folder `tests/` sengaja dirancang untuk menguji beban ekstrem. **Jalankan hanya di dalam Mesin Virtual (VM)**, dan buat *snapshot* sebelum pengujian.
