#!/bin/bash

# Define thresholds
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

# Get system metrics
CPU_USAGE=$(top -b -n 1 | awk '/%Cpu/{print $2}' | cut -d. -f1)
MEMORY_USAGE=$(free | awk '/Mem/{printf("%.2f"), $3/$2*100}')
DISK_USAGE=$(df -h / | awk '/\//{print $(NF-1)}' | cut -d% -f1)
PROCESSES=$(ps aux --sort=-%cpu | awk 'NR<=6{print $0}')

# Check CPU usage
if [ $CPU_USAGE -gt $CPU_THRESHOLD ]; then
    echo "High CPU usage detected: $CPU_USAGE%" >> system_alert.log
fi

# Check memory usage
if [ $MEMORY_USAGE -gt $MEMORY_THRESHOLD ]; then
    echo "High memory usage detected: $MEMORY_USAGE%" >> system_alert.log
fi

# Check disk space
if [ $DISK_USAGE -gt $DISK_THRESHOLD ]; then
    echo "High disk usage detected: $DISK_USAGE%" >> system_alert.log
fi

# Check running processes
if [ "$PROCESSES" ]; then
    echo "Top processes by CPU usage:" >> system_alert.log
    echo "$PROCESSES" >> system_alert.log
fi

# Print results to the console
cat system_alert.log

# Optionally, you can also send an email or perform other actions here
# Example: mail -s "System Alert" your_email@example.com < system_alert.log
