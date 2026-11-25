#!/bin/bash
read -p "Batas waktu (detik): " BATAS
timeout "$BATAS" "$@"
KODE=$?

if [ $KODE -eq 124 ]; then
    echo "DIHENTIKAN: lewat batas waktu"
else
    echo "Selesai, kode $KODE"
fi