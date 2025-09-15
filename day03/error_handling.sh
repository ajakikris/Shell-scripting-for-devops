#!/bin/bash
set -e  # Exit immediately on any error

LOGFILE="./script.log"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOGFILE"
}

# Trap function for unexpected errors
error_trap() {
    log_message "ERROR at line $1. Exiting."
    echo "An error occurred at line $1. Check $LOGFILE for details."
    exit 1
}
trap 'error_trap $LINENO' ERR

# Function to create a folder with retries
create_folder_with_retry() {
    local folder="$1"
    local retries=3
    local count=0

    until mkdir "$folder"; do
        ((count++))
        log_message "Attempt $count: Failed to create folder $folder"
        echo "Retrying in 2 seconds..."
        sleep 2

        if [ $count -ge $retries ]; then
            log_message "Failed to create folder $folder after $retries attempts."
            echo "Failed to create folder $folder after $retries attempts."
            exit 1
        fi
    done

    log_message "Successfully created folder: $folder"
    echo "Folder $folder created successfully."
}

# Script Execution
log_message "Script started."

create_folder_with_retry "./test_folder"

log_message "Script completed successfully."
echo "All done!"

