#!/bin/bash

set -e

trap "exit 1" TERM
TOP_PID=$$

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

function alert() {
    echo "Error occurred"
    kill -s TERM $TOP_PID
}

function log() {
    local message=$1
    local status=$2
    if [ "$status" == "error" ]; then
        echo "ERROR - $message"
    elif [ "$status" == "info" ]; then
        echo "INFO - $message"
    else
        echo "SUCCESS - $message"
    fi
}

function generateAppIcon() {
    echo "Generating App Icons..."
    local generator="$DIR/scripts/ios-icon-generator.sh"
    local appIcon="$DIR/Icons/app_icon.png"
    local appIconAssets="$DIR/Sources/Assets.xcassets/AppIcon.appiconset/"
    local output

    output=$(/bin/sh "$generator" "$appIcon" "$appIconAssets")
    echo "$output"

    if [[ $output == *"Generate Done"* ]]; then
        log "App Icon created successfully" "success"
    else
        log "App Icon generation failed" "error"
        alert
    fi
}

function generateSplash() {
    echo "Generating Splash Screen..."
    local generator="$DIR/scripts/ios-splash-generator.sh"
    local splashIcon="$DIR/Icons/splash.png"
    local splashIconAssets="$DIR/Sources/Assets.xcassets/splash.imageset/"
    local output

    output=$(/bin/sh "$generator" "$splashIcon" "$splashIconAssets")
    echo "$output"

    if [[ $output == *"Generate Done"* ]]; then
        log "Splash Screen created successfully" "success"
    else
        log "Splash Screen generation failed" "error"
        alert
    fi
}

function createProject() {
    echo "Generating Xcode project with XcodeGen..."
    local output=$(xcodegen 2>&1)
    echo "$output"

    if [[ $output == *"Created project"* ]]; then
        log "Xcode project created successfully" "success"
    else
        log "Xcode project creation failed" "error"
        alert
    fi
}

function openProject() {
    echo "Opening Xcode project..."
    xed . || { log "Failed to open Xcode project" "error"; alert; }
    log "Project opened in Xcode" "success"
}

function cleanEnvironment() {
    echo "Cleaning up environment..."
    rm -rf *.xcodeproj
    rm -rf *.xcworkspace
    rm -rf .build
    rm -rf .swiftpm
    log "Environment cleaned up" "success"
}

# Main script execution
cd "$DIR"
cleanEnvironment
generateAppIcon
generateSplash
createProject
openProject
