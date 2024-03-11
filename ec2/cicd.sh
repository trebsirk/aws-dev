#!/bin/bash

# Define variables
APP_NAME="my-scala-app"
VERSION_FILE="version.txt"
SBT_COMMAND="sbt"
S3_BUCKET="my-scala-app"
S3_KEY="artifacts/$APP_NAME-$(cat $VERSION_FILE).jar"

# Read version from file
VERSION=$(cat $VERSION_FILE)

# aws s3api head-object --bucket my-scala-app --key artifacts

# Check if artifact already exists in S3
echo "Checking if artifact already exists in S3..."
if aws s3api head-object --bucket "$S3_BUCKET" --key "$S3_KEY" &> /dev/null; then
    echo "Error: Artifact with version $VERSION already exists in S3."
    exit 1
fi

exit 0

# Clean previous build artifacts
echo "Cleaning previous build artifacts..."
$SBT_COMMAND clean

# Build the Scala application
echo "Building the Scala application..."
$SBT_COMMAND compile

# Run tests
echo "Running tests..."
$SBT_COMMAND test

# Package the application. This require the 'assembly' plugin for sbt. 
echo "Packaging the application..."
$SBT_COMMAND assembly

# Copy the packaged artifact to S3
echo "Copying the packaged artifact to S3..."
aws s3 cp "target/scala-*/$APP_NAME-$VERSION.jar" "s3://$S3_BUCKET/$S3_KEY"

# Version the artifact using Git
echo "Tagging release version $VERSION in Git..."
git tag -a v$VERSION -m "Release version $VERSION"
git push --tags

echo "Build, test, packaging, and upload to S3 completed successfully!"
