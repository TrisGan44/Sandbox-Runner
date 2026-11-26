#!/bin/bash
echo "Mencoba membaca berkas sensitif..."
ls -la /root 2>&1
cat /etc/shadow 2>&1