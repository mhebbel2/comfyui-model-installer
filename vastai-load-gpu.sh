#!/bin/bash

ID=$(vastai show instances -q | head -1)

# Copy the selected script to the remote instance
scp ./loader/* "$(vastai scp-url $ID)" 2>/dev/null || {
    echo "Error: Failed to copy script to remote instance."
    exit 1
}

# Run the selected script on the remote instance
ssh $(vastai ssh-url $ID) -- "./run.sh"
