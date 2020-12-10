#!/bin/bash

set -e

trap "exit 1" TERM
TOP_PID=$$

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

function alert() {
   echo "😭 - There was an error"
   kill -s TERM $TOP_PID
}

function generateAppIcon() {
    echo "✋ - Generating App Icons"
    generator=$DIR/scripts/ios-icon-generator.sh;
    appIcon=$DIR/Icons/app_icon.png;
    appIconAssets=$DIR/Sources/Assets.xcassets/AppIcon.appiconset/;
    handleGenerate=$(/bin/sh "$generator" "$appIcon" "$appIconAssets");

    if [[ $handleGenerate == *"Generate Done"* ]]; then
      echo "👍 - App Icon created"
    else
      echo "🔥 - App Icon generating failed"
      alert
    fi
}

function generateSplash() {
    echo "✋ - Generating App Icons"
    generator=$DIR/scripts/ios-splash-generator.sh;
    splashIcon=$DIR/Icons/splash.png;
    splashIconAssets=$DIR/Sources/Assets.xcassets/splash.imageset/;
    handleGenerate=$(/bin/sh "$generator" "$splashIcon" "$splashIconAssets");

    if [[ $handleGenerate == *"Generate Done"* ]]; then
      echo "👍 - Splash created"
    else
      echo "🔥 - Splash generating failed"
      alert
    fi
}

function createProject() {
    echo "✋ - Generating project"
    cd "$DIR";
    createXcode=$(xcodegen)

    if [[ $createXcode == *"Created project"* ]]; then
      echo "👍 - Xcode project created"
    else
      echo "🔥 - Xcode project generating failed"
      alert
    fi
}

function openProject() {
    openXcode=$(xed .);
    if $openXcode; then
      echo "👏 - Let's open the project now"
      kill -9 $PPID
    else
      echo "🔥 - Can't open Xcode project"
      alert
    fi
}

function podInstall() {
    installPods=$(pod install)
    if [[ $installPods == *"Pod installation complete!"* ]]; then
      echo "👏 - DONE"
      #otvori xcode
      $(xed .);
      kill -9 $PPID
    else
      echo "🔥 - Can't install pods"
      alert
    fi
}

cd "$DIR";
$(rm -rf *.xcodeproj);
$(rm -rf *.xcworkspace);
$(rm -rf Pods);
$(rm -rf Podfile.lock);

generateAppIcon
generateSplash
createProject
podInstall
openProject