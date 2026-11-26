# Proposal Proyek Sistem Operasi (TIK103)
**Judul:** Perancangan dan Implementasi Mini Sandbox Runner Berbasis Pembatasan Sumber Daya dan Hak Akses Linux

## 1. Identitas Kelompok
* **Program Studi:** D4 Rekayasa Keamanan Siber – Politeknik Negeri Jakarta
* **Anggota:** Tristan Birendra Rozi, Cello Gemayel Aswan, Muhammad Farrelivo Kafka Herdian, Rosa Salsabillah Putri Wardoyo.

## 2. Latar Belakang & Rumusan Masalah
Dalam pengembangan perangkat lunak, *online judge*, maupun analisis sampel skrip mencurigakan, mengeksekusi kode tak tepercaya secara langsung menggunakan akun pengguna utama sangat berbahaya. Masalah utama yang diatasi adalah mencegah *Denial of Service* lokal (CPU/RAM habis akibat *infinite loop* atau *fork bomb*) serta mencegah akses tidak sah ke direktori pengguna utama.

## 3. Tujuan & Kriteria Sukses
* **Tujuan:** Membangun skrip *wrapper* CLI berbasis Bash (`sandbox.sh`) yang mampu membatasi waktu eksekusi, memori, jumlah proses, serta mengisolasi hak akses eksekusi.
* **Kriteria Sukses:** Program target yang melebihi batas waktu atau batas sumber daya dapat dihentikan otomatis tanpa membuat VM *host* mengalami *hang*.

## 4. Pemetaan Konsep Sistem Operasi
1. **Manajemen Proses & Sinyal (`fork`, `exec`, `wait`, `SIGTERM`/`SIGKILL`):** Mengelola siklus hidup proses anak menggunakan mekanisme *subshell* dan utilitas `timeout`, serta membaca status keluar (*exit code* `124` untuk *timeout*).
2. **Kontrol Sumber Daya (`setrlimit` / `ulimit`):** Mengatur batas keras (*hard limit*) untuk waktu CPU (`-t`), memori virtual (`-v`), dan jumlah proses (`-u`).
3. **Sistem Berkas & Direktori Sementara (`mktemp`):** Menyediakan ruang kerja terisolasi yang dibersihkan secara otomatis setelah proses berakhir.
4. **Keamanan & Izin Akses (*Privilege Drop*):** Menjalankan proses target menggunakan akun khusus tanpa hak istimewa (`sandboxuser`).

## 5. Arsitektur & Alur Kerja Sistem
`Input Perintah & Parameter Batas` ➔ `Pembuatan Direktori Kerja Sementara` ➔ `Penerapan Limit Sumber Daya (ulimit) & Privilege Drop` ➔ `Eksekusi Proses dengan Timer (timeout)` ➔ `Pencatatan Log & Status Exit Code` ➔ `Pembersihan Direktori Kerja`.

## 6. Prioritas Fitur (MVP)
* **Must Have (Pertemuan 12):** Pembatasan waktu eksekusi interaktif (`timeout`) dan deteksi kode keluar.
* **Should Have (Pertemuan 13):** Pembatasan RAM dan jumlah proses (`ulimit`), serta direktori kerja terisolasi sementara.
* **Could Have (Pertemuan 14):** Eksekusi sebagai `sandboxuser` (`sudo -u`) dan pencatatan riwayat eksekusi ke berkas `.log`.

## 7. Rencana Pengujian (Skenario Uji)
* **Uji Fungsional Normal:** Menjalankan perintah ringan (`echo`, `ls`, atau skrip kalkulasi singkat) dan memastikan kode keluar `0`.
* **Uji *Infinite Loop*:** Menjalankan `sleep 100` atau perulangan tanpa henti dengan batas 2 detik, lalu memverifikasi pesan `DIHENTIKAN: lewat batas waktu`.
* **Uji *Memory Bomb* & *Fork Bomb* (Pertemuan 13–14):** Menguji ketahanan pembatasan RAM dan proses di dalam VM terisolasi.

## 8. Pembagian Peran & Jadwal (Minggu 12–15)
* **Minggu 12:** Inisialisasi repositori, penyusunan proposal, `README.md`, dan prototipe MVP `v0.2` (batas waktu).
* **Minggu 13:** Penambahan `ulimit` (memori & proses) dan pembuatan skrip uji di folder `tests/`.
* **Minggu 14:** Implementasi eksekusi sebagai `sandboxuser`, pencatatan log, dan pengujian menyeluruh di VM.
* **Minggu 15:** Finalisasi laporan akhir, `Changelog.md`, dan demo presentasi.

## 9. Risiko & Mitigasi
* **Risiko:** Pengujian *fork bomb* atau alokasi memori berlebih berpotensi membuat sistem operasi *hang*.
* **Mitigasi:** Seluruh pengembangan dan pengujian wajib dilakukan di dalam Mesin Virtual (VM) yang telah dibuatkan *snapshot* sebelum pengujian dimulai.
