#!/bin/bash

echo "Cleaning and rebuilding project...";
flutter clean
flutter pub get
flutter pub run flutter_launcher_icons:main -f tools/flutter-dev/flutter_launcher_icons.yaml
