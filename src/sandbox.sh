#!/bin/bash

# ===== 1. Batas waktu =====
read -p "Batas waktu (detik): " BATAS

# Cek BATAS harus angka bulat positif.
# Pola ^[1-9][0-9]*$ artinya:
#   ^       = awal teks
#   [1-9]   = karakter pertama angka 1 sampai 9 (jadi 0 dan 08 ditolak)
#   [0-9]*  = sisanya angka 0 sampai 9, boleh berapa pun panjangnya
#   $       = akhir teks
# Tanda ! di depan artinya "kalau TIDAK cocok".
if ! [[ "$BATAS" =~ ^[1-9][0-9]*$ ]]; then
    echo "Batas waktu harus angka bulat lebih dari 0 (detik)"
    exit 1    # berhenti di sini, kode 1 = gagal
fi

# ===== 2. Batas memori =====
read -p "Batas memori (MB): " MEMORI

# ulimit -v menerima ukuran dalam KB.
if ! [[ "$MEMORI" =~ ^[0-9]+$ ]] || [ "$MEMORI" -le 0 ]; then
    echo "Batas memori harus berupa angka MB lebih dari 0"
    exit 1
fi

MEMORI_KB=$((MEMORI * 1024))
ulimit -v "$MEMORI_KB" || {
    echo "Gagal menerapkan batas memori"
    exit 1
}

# ===== 3. Jalankan program =====
timeout "$BATAS" "$@"
KODE=$?

# ===== 4. Tampilkan hasil =====
if [ $KODE -eq 124 ]; then
    echo "DIHENTIKAN: lewat batas waktu"
else
    echo "Selesai, kode $KODE"
fi