#!/bin/bash

# Ask for a new file name
read -p "Enter a name for the new file: " filename

# Convert filename to lowercase
lowername=$(echo "$filename" | tr '[:upper:]' '[:lower:]')

# Capitalize the first letter of the filename for the .desktop Name field
capitalized_name=$(echo "$lowername" | sed 's/\b\(.\)/\U\1/g')

# Print the file name
echo "You entered: $filename"

# Get the directory from where the script was run
script_dir=$(pwd)

# Check if the base folder exists
if [ ! -d "$script_dir/base" ]; then
    echo "Error: base folder not found!"
    exit 1
fi

# Check if base_dot_sh.sh exists in the base folder
if [ -f "$script_dir/base/base_dot_sh.sh" ]; then
    # Copy the base .sh file and rename it
    exec_file="./code/${lowername}.sh"
    cp "$script_dir/base/base_dot_sh.sh" "$exec_file"
    chmod +x "$exec_file"
else
    echo "Error: base_dot_sh.sh not found in the base folder!"
    exit 1
fi

# Check if base_dot_desktop exists in the base folder
if [ -f "$script_dir/base/base_dot_desktop" ]; then
    # Load content from base_dot_desktop
    desktop_info=$(cat "$script_dir/base/base_dot_desktop")
else
    desktop_info="No information provided for .desktop"
fi

# Crear archivo .desktop utilizando el nombre capitalizado para el Name
desktop_file="./${lowername}.desktop"

# Build paths
exec_path="$script_dir/code/${lowername}.sh"
icon_path="$script_dir/icons/icon.svg"

# Reemplazar $filename, $EXEC_PATH y $ICON_PATH en el contenido base
echo -e "$desktop_info" \
    | sed "s|\$filename|${capitalized_name}|" \
    | sed "s|\$EXEC_PATH|${exec_path}|" \
    | sed "s|\$ICON_PATH|${icon_path}|" \
    > "$desktop_file"

# Dar permisos de ejecución al archivo .desktop
chmod +x "$desktop_file"

# Wait for Enter to finish
read -p "Press Enter to exit..."

