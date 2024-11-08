#!/bin/bash

CPU=$(top -bn1 | grep 'Cpu(s)' | \
           sed 's/.*, *\([0-9.]*\)%* id.*/\1/' | \
           awk '{print 100 - $1"%"}')

MEM=$(top -bn1 | grep "MiB Mem" | sed 's/.*: *\([0-9.]*\) total.*, *\([0-9.]*\) free.*, *\([0-9.]*\) used.*/\1 \2 \3/' | awk '{print "Total Memory: " $1"MiB\nMemory used: " $3"MiB ("$3 / $1 "%)\nMemory free: " $2"MiB ("$2 / $1 "%)"}')

DISK=$(df | grep -E "C:.*" | awk '{print "Total Storage: "$2 "\nTotal Used: "$3" ("$3/$2"%)\nTotal Free: "$4" (" $4/$2"%)"}')

CPUSINNERS=$(ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6)
MEMSINNERS=$(ps -eo pid,comm,%mem --sort=-%mem | head -n 6)

echo "CPU Utilization $CPU"
echo -e "\n$MEM"
echo -e "\n$DISK"
echo -e "\nTop 5 CPU users:\n$CPUSINNERS"
echo -e "\nTop 5 MEMORY users:\n$MEMSINNERS"
