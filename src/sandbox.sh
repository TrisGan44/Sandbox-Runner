#!/bin/bash

# ===== 0. Cek program =====
if [[ $# -lt 1 ]]; then
    echo "Penggunaan: $0 <program> [argumen...]"
    exit 1
fi

# ===== 1. Batas waktu =====
read -p "Batas waktu (detik): " BATAS

# Pola ^[1-9][0-9]*$: diawali angka 1-9, sisanya angka 0-9.
# Menolak huruf, 0, angka negatif, dan angka berawalan 0.
if ! [[ "$BATAS" =~ ^[1-9][0-9]*$ ]]; then
    echo "Batas waktu harus angka bulat lebih dari 0 (detik)"
    exit 1
fi

# ===== 2. Batas memori =====
read -p "Batas memori (MB): " MEMORI

# Minimal 16 MB: di bawah itu, program dasar seperti bash dan timeout tidak bisa jalan.
if ! [[ "$MEMORI" =~ ^[1-9][0-9]*$ ]] || [ "$MEMORI" -lt 16 ]; then
    echo "Batas memori harus angka bulat, minimal 16 MB"
    exit 1
fi

# ulimit -v menerima ukuran dalam KB.
MEMORI_KB=$((MEMORI * 1024))
ulimit -v "$MEMORI_KB" || {
    echo "Gagal menerapkan batas memori"
    exit 1
}

# ===== 3. Batas jumlah proses =====
# ulimit -u menghitung SEMUA thread milik user, bukan hanya dari sandbox.
# Jadi batas = thread yang sudah berjalan + 30 jatah tambahan.
# -L: hitung per thread, karena satu proses bisa punya banyak thread.
PROSES_SEKARANG=$(ps -L -u "$(id -un)" --no-headers | wc -l)
ulimit -u $((PROSES_SEKARANG + 30)) || {
    echo "Gagal menerapkan batas jumlah proses"
    exit 1
}

# ===== 4. Jalankan program =====
# -k 1s: jika program tidak berhenti setelah SIGTERM, kirim SIGKILL 1 detik kemudian
timeout -k 1s "$BATAS" "$@"
KODE=$?

# ===== 5. Tampilkan hasil =====
case $KODE in
    0)       echo "Selesai normal (kode 0)" ;;
    124)     echo "DIHENTIKAN: lewat batas waktu (SIGTERM)" ;;
    137)     echo "DIHENTIKAN PAKSA: tidak berhenti setelah SIGTERM (SIGKILL)" ;;
    126|127) echo "ERROR: program tidak ditemukan atau tidak bisa dijalankan (kode $KODE)" ;;
    *)       echo "Selesai dengan kode $KODE" ;;
esac