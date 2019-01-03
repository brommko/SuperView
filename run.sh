#!/bin/bash

set -e

trap "exit 1" TERM
TOP_PID=$$

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

function alert() {
   echo "😭 - There was an error"
   kill -s TERM $TOP_PID
}

function commandExists {
  #this should be a very portable way of checking if something is on the path
  #usage: "if commandExists foo; then echo it exists; fi"
  type "$1" &> /dev/null
}

function checkForXcode() {
    if [ -d $(commandExists xcode-select) ]; then
        echo "👍 - Xcode installed"
    else
        echo "🔥 - You need to install Xcode first: https://developer.apple.com/xcode/"
        alert
    fi
}

function checkForSwiftenv() {
    if : $(commandExists swiftenv); then
        echo "👍 - Swift Version Manager installed"
    else
        installSwiftenv
    fi
}

function setSwiftVersion() {
    if : $(swiftenv local 4.2); then
        echo "👍 - Swift version set to 4.2"
    else
        echo "🔥 - Swift Version Manager can't set swift version to 4.2"
        alert
    fi
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


function installSwiftenv() {
    echo "🤞 - Swift Version Manager install in progress"

    if : $(git clone https://github.com/kylef/swiftenv.git ~/.swiftenv); then
      echo 'export SWIFTENV_ROOT="$HOME/.swiftenv"' >> ~/.bash_profile
      echo 'export PATH="$SWIFTENV_ROOT/bin:$PATH"' >> ~/.bash_profile
      echo 'eval "$(swiftenv init -)"' >> ~/.bash_profile
      echo "👍 - Swift Version Manager installed"
    else
      echo "🔥 - Swift Version Manager installed failed"
      alert
    fi
}

function installSwiftVersion() {
    if : $(swiftenv install 4.2); then
      echo "👍 - Swift 4.2 installed"
    else
      echo "🔥 - Swift 4.2 install failed"
      alert
    fi
}

function installXcodeGen() {
    if : $(git clone https://github.com/yonaskolb/XcodeGen.git); then
      cd XcodeGen
      make
      cd ../
      rm -rf XcodeGen/
      echo "👍 - XcodeGen installed"
      createProject
    else
      echo "🔥 - XcodeGen install failed"
      alert
    fi
}

function checkForXcodegen() {
    if : $(commandExists xcodegen); then
        echo "👍 - Xcodegen installed"
    else
        installXcodeGen
    fi
}

function createProject() {
    echo "✋ - Generating project"
    cd "$DIR";
    createXcode=$(xcodegen)

    if [[ $createXcode == *"Loaded project"* ]]; then
      echo "👍 - Xcode project created"
    else
      echo "🔥 - Xcode project generating failed"
      alert
    fi
}

function openProject() {
    projectPath=$(find "$DIR" -maxdepth 1 -name "*.xcodeproj");

    if [ -d "${projectPath}" ] ; then
      echo "👏 - Project is there!"
    else
      echo "🔥 - Can't find Xcode project"
      alert
    fi

    openXcode=$(open -a Xcode "$projectPath")
    if $openXcode; then
      echo "👏 - Let's open the project now"
      kill -9 $PPID
    else
      echo "🔥 - Can't open Xcode project"
      alert
    fi
}

rm -rf *.xcodeproj/

checkForXcode
checkForSwiftenv
installSwiftVersion
setSwiftVersion
generateAppIcon
generateSplash
checkForXcodegen
createProject
openProject
