#!/bin/bash

echo "Cleaning and rebuilding project...";
flutter pub run flutter_native_splash:remove --path=tools/flutter-dev/flutter_native_splash.yaml
flutter clean
flutter pub get
flutter pub run flutter_native_splash:create --path=tools/flutter-dev/flutter_native_splash.yaml
flutter pub run flutter_launcher_icons:main -f tools/flutter-dev/flutter_launcher_icons.yaml


