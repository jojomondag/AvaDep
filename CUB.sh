#!/bin/bash

PROJECT_NAME="$1"
OUTPUT_DIR="./bin/Release/net8.0"
FINAL_OUTPUT_DIR="./bin/Release/Universal"

# Function to build for a specific architecture
build_for_arch() {
    local arch=$1
    echo "Building for $arch..."
    dotnet publish -r osx-$arch -c Release
}

# Build only for arm64 architecture
build_for_arch "arm64"

# Create the final output directory
mkdir -p "$FINAL_OUTPUT_DIR"

# Copy the arm64 build to the final output directory, including all files in the publish folder
echo "Copying arm64 build to the final output directory..."
cp -R "$OUTPUT_DIR/osx-arm64/publish/"* "$FINAL_OUTPUT_DIR/"

echo "Build for osx-arm64 completed successfully"