#!/bin/bash

# Script that can check the uptime of an application and determine if it is functioning correctly or not. 
# The script assess the application's status by checking HTTP status codes and detects if the application is 'up', meaning it is functioning correctly, 
# or 'down', indicating that it is unavailable or not responding.

# Configuration
APP_URL="http://example.com"
CHECK_INTERVAL=60  # Checks in every minute
LOG_FILE="/var/log/app_status.log" # xhange the path of log file to the application's log file path

# Function to check HTTP status code
check_http_status() {
    local response=$(curl -s -o /dev/null -w "%{http_code}" "$APP_URL")
    echo "$response"
}

# Function to get current timestamp
get_timestamp() {
    date '+%Y-%m-%d %H:%M:%S'
}

# Function to log status
log_status() {
    local status=$1
    local timestamp=$(get_timestamp)
    echo "$timestamp - $status" >> "$LOG_FILE"
}

# Main loop
last_check_time=$(date +%s)
while true; do
    current_time=$(date +%s)
    elapsed_time=$((current_time - last_check_time))

    # Check application status
    local status_code=$(check_http_status)
    
    if [[ $status_code == 200* ]]; then
        log_status "UP"
        echo "$(get_timestamp) - Application is UP ($elapsed_time seconds)"
    else
        log_status "DOWN"
        echo "$(get_timestamp) - Application is DOWN ($elapsed_time seconds)"
    fi

    # Log elapsed time since last successful check
    if [[ $status_code == 200* ]]; then
        echo "$(get_timestamp) - Elapsed time since last successful check: $elapsed_time seconds" >> "$LOG_FILE"
    fi

    last_check_time=$current_time
    sleep $CHECK_INTERVAL
done
