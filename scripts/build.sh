#!/bin/bash

echo "Cleaning and rebuilding project..."

flutter clean || {
    echo -e "\nerror: failed to clean project."
    exit 1>>/dev/null
}

flutter pub get || {
    echo -e "\nerror: failed to get dependencies."
    exit 1>>/dev/null
}

flutter pub run flutter_launcher_icons:main -f .config/flutter_launcher_icons.yaml || {
    echo -e "\nerror: failed to generate launcher icons."
    echo -e "\n\nBuild failed."
    exit 1>>/dev/null
}

./scripts/generate_db.sh || {
    echo -e "\n\nerror: build failed."
    exit 1>>/dev/null
}

echo -e "\n\nBuild successful."

exit 0 >>/dev/null
