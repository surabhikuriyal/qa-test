#!/bin/bash

# Script that monitors the health of a Linux system. It should check CPU usage, memory usage, disk space, and running processes. 
# If any of these metrics exceed predefined thresholds (e.g., CPU usage > 80%), the script sends an alert to the console or a log file.

# Configuration
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=20
LOG_FILE="/var/log/system_health.log"
INTERVAL=60  #time interval can vary (here it checks in every 1 minute)

# Function to send alert
send_alert() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - CRITICAL: $1" >> "$LOG_FILE"
    echo "ALERT: $1" | mail -s "System Health Alert" admin@example.com
}

# Function to check CPU usage
check_cpu() {
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1)
    echo "$cpu_usage"
}

# Function to check memory usage
check_memory() {
    local meminfo=$(free -m | awk '/Mem:/ {print $3 "/" $2}')
    echo "$meminfo"
}

# Function to check disk space
check_disk() {
    local df_output=$(df -h / | awk 'NR==2 {print $5}')
    echo "${df_output%*}"
}

# Function to check running processes
check_processes() {
    local processes=$(ps aux | wc -l)
    echo "$processes"
}


while true; do
    cpu_usage=$(check_cpu)
    memory_usage=$(check_memory)
    disk_space=$(check_disk)
    running_processes=$(check_processes)

    echo "$(date '+%Y-%m-%d %H:%M:%S') - CPU Usage: $cpu_usage%, Memory: $memory_usage, Disk Space: $disk_space%, Running Processes: $running_processes" >> "$LOG_FILE"

    if (( $(echo "$cpu_usage > $CPU_THRESHOLD" | bc -l) )); then
        send_alert "CPU usage exceeds $CPU_THRESHOLD%"
    fi

    if [[ "$memory_usage" =~ ^[0-9]+$ ]] && (( $(echo "$memory_usage > $MEMORY_THRESHOLD" | bc -l) )); then
        send_alert "Memory usage exceeds $MEMORY_THRESHOLD%"
    fi

    if (( $(echo "$disk_space < $DISK_THRESHOLD" | bc -l) )); then
        send_alert "Disk space below $DISK_THRESHOLD%"
    fi

    if (( $(echo "$running_processes > 1000" | bc -l) )); then
        send_alert "Running processes exceed 1000"
    fi

    sleep $INTERVAL
done
