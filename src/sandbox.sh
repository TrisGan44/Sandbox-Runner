#!/bin/bash
timeout 3 "$@"
KODE=$?

if [ $KODE -eq 124 ]; then
    echo "DIHENTIKAN: lewat batas waktu"
else
    echo "Selesai, kode $KODE"
fi