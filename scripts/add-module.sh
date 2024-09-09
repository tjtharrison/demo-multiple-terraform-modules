#!/bin/bash

# Check if the script is called with a module name
if [ -z "$1" ]; then
  echo "Error: No module name provided."
  echo "Usage: ./add-module.sh <module-name>"
  exit 1
fi

MODULE_NAME=$1
MODULE_DIR="modules/$MODULE_NAME"
ASSETS_DIR="$(dirname "$0")/scaffolding"

# Check if the module directory already exists
if [ -d "$MODULE_DIR" ]; then
  echo "Error: Module '$MODULE_NAME' already exists in the 'modules' folder."
  exit 1
fi

# Create the module directory
mkdir -p "$MODULE_DIR"

# Check if the assets directory exists
if [ ! -d "$ASSETS_DIR" ]; then
  echo "Error: Assets directory '$ASSETS_DIR' not found."
  exit 1
fi
# Copy contents of the assets folder into the new module directory
cp -r "$ASSETS_DIR/" "$MODULE_DIR/"

# Create package.json file in the module directory
PACKAGE_JSON="$MODULE_DIR/package.json"
cat <<EOL > "$PACKAGE_JSON"
{
  "name": "$MODULE_NAME",
  "version": "0.0.1",
  "private": true
}
EOL

# Provide feedback
echo "Module '$MODULE_NAME' has been created in the 'modules' folder with assets copied."