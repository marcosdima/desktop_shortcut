#!/bin/bash

# Create 'code' folder if it doesn't exist
mkdir -p ./code

# Create 'icons' folder if it doesn't exist
mkdir -p ./icons

# Define a URL for a random image (from a secure source)
image_url="https://worldvectorlogo.com/download/ubuntu-4.svg"

# Download a random image to the 'icons' folder
echo "Downloading a random image to the 'icons' folder..."
curl -L $image_url -o ./icons/icon.svg

# Confirm that the image has been downloaded
if [ -f "./icons/icon.svg" ]; then
    echo "Downloaded successfully"
else
    echo "Failed to download the image."
    exit 1
fi

# End the script
echo "Setup complete."

