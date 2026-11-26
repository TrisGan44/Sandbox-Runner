#!/bin/bash

if [[ $# -lt 1 ]]; then
    echo "Penggunaan: $0 <program> [argumen...]"
    exit 1
fi

read -p "Batas waktu (detik): " BATAS
read -p "Batas memori (MB): " MEMORI

# Validasi input batas waktu
if ! [[ "$BATAS" =~ ^[0-9]+$ ]] || [ "$BATAS" -le 0 ]; then
    echo "Batas waktu harus berupa angka detik lebih dari 0"
    exit 1
fi

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

# Eksekusi child process dengan timeout & eskalasi sinyal SIGKILL (-k 1s)
timeout -k 1s "$BATAS" "$@"
KODE=$?

case $KODE in
    0)   echo "Selesai normal (kode 0)" ;;
    124) echo "DIHENTIKAN: lewat batas waktu (SIGTERM)" ;;
    137) echo "DIHENTIKAN PAKSA: sinyal SIGKILL (timeout/batas memori)" ;;
    126|127) echo "ERROR: program tidak ditemukan atau tidak bisa dieksekusi (kode $KODE)" ;;
    *)   echo "Selesai / dihentikan, kode $KODE" ;;
esac