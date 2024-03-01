#!/bin/bash

# Check if at least one argument is provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 <file_to_send> [<destination_directory>] [<destination_host>]"
    exit 1
fi

# Extracting arguments
file_to_send=$1
destination_directory=""
destination_host="192.168.119.135" # default destination host

# Check if destination directory and host are provided
if [ $# -ge 2 ]; then
    if [ "$2" = "h2" ]; then
        destination_host="192.168.119.134"
        if [ $# -ge 3 ]; then
            destination_directory="$3/"
        fi
    else
        destination_directory="$2/"
        if [ $# -ge 3 ]; then
            destination_host="$3"
        fi
    fi
fi

# SCP the file to the destination
scp "$file_to_send" stud@"$destination_host":~/"$destination_directory"

# Check if SCP was successful
if [ $? -eq 0 ]; then
    echo "File sent successfully to $destination_host!"
else
    echo "Error: Failed to send file."
fi
