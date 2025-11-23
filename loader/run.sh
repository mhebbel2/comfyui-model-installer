#!/bin/bash

input_file="configs.yaml"

# Check if yq is installed
if ! command -v yq &> /dev/null; then
    echo "yq could not be found. Installing yq."
	curl -L https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -o /usr/local/bin/yq && chmod +x /usr/local/bin/yq
fi

# Get all top-level keys
keys=($(yq eval 'keys | .[]' "$input_file"))
echo "Available configs:"
for i in "${!keys[@]}"; do
    echo "$((i+1)). ${keys[i]}"
done

# Prompt user to select a top-level key by number
echo ""
read -p "Please enter the number to install that config: " selected_number

# Validate input and convert to key name
if ! [[ "$selected_number" =~ ^[0-9]+$ ]] || [ "$selected_number" -lt 1 ] || [ "$selected_number" -gt ${#keys[@]} ]; then
    echo "Invalid selection. Please run the script again and enter a valid number."
    exit 1
fi

selected_key="${keys[$((selected_number-1))]}"

WORKSPACE=/workspace/ComfyUI/models

# Process only the selected key, but don't show the selected key in output
# Loop over the tabular output and put the two columns into variables and echo them
yq eval '
  to_entries |
  map(select(.key == "'"$selected_key"'")) |
  map(
    .value | to_entries |
    map(
      .key as $category |
      .value |
      map([$category, .] | join(",")) |
      .[]
    ) |
    .[]
  ) |
  .[]' "$input_file" | while IFS=',' read -r destdir url; do
    # Extract filename from URL
    filename=$(basename "$url" | cut -d'?' -f1)
    echo "Downloading $url to $WORKSPACE/$destdir/$filename"
    curl -L -o "$WORKSPACE/$destdir/$filename" "$url"
    
    # Check if download was successful
    if [ $? -eq 0 ]; then
        echo "Successfully downloaded $filename"
    else
        echo "Failed to download $filename"
    fi
  done
