#!/bin/bash

DEVICE_IDS=$(lsblk -o NAME,TYPE | grep "mpath" | awk '{print $1}')

if [ -z "$DEVICE_IDS" ]; then
    echo "Не найдено устройств типа mpath."
    exit 1
fi

echo "Информация о устройствах:"
for DEVICE_ID in $DEVICE_IDS; do
    echo "Информация для устройства: $DEVICE_ID"
    multipath -ll -v 3 2>&1 | grep "$(lsblk | grep -B 1 "$DEVICE_ID" | head -n 1 | awk '{print $1}')" | grep -E 'serial|product|vendor'
    echo ""
done


