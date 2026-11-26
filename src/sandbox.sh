#!/bin/bash
read -p "Batas waktu (detik): " BATAS
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

timeout "$BATAS" "$@"
KODE=$?

if [ $KODE -eq 124 ]; then
    echo "DIHENTIKAN: lewat batas waktu"
else
    echo "Selesai, kode $KODE"
fi
