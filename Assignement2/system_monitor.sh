#!/bin/bash

# --- Thresholds ---
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80
PROC_THRESHOLD=300

# --- CPU usage ---
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}' | cut -d. -f1)
if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
    echo "ALERT: High CPU usage: ${CPU_USAGE}%"
fi

# --- Memory usage ---
MEM_USAGE=$(free | awk '/Mem/ {print int($3/$2 * 100)}')
if [ "$MEM_USAGE" -gt "$MEM_THRESHOLD" ]; then
    echo "ALERT: High Memory usage: ${MEM_USAGE}%"
fi

# --- Disk usage (root partition) ---
DISK_USAGE=$(df / | awk 'NR==2 {print substr($5, 1, length($5)-1)}')
if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    echo "ALERT: High Disk usage: ${DISK_USAGE}%"
fi

# --- Running processes ---
PROC_COUNT=$(ps -e --no-headers | wc -l)
if [ "$PROC_COUNT" -gt "$PROC_THRESHOLD" ]; then
    echo "ALERT: High number of processes: ${PROC_COUNT}"
fi

# --- Final status ---
if [ "$CPU_USAGE" -le "$CPU_THRESHOLD" ] && \
   [ "$MEM_USAGE" -le "$MEM_THRESHOLD" ] && \
   [ "$DISK_USAGE" -le "$DISK_THRESHOLD" ] && \
   [ "$PROC_COUNT" -le "$PROC_THRESHOLD" ]; then
    echo "System is healthy ✅"
fi
