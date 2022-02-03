#!/bin/bash

EXIT=0;
BUILD=$1;
ERRORS="";

if [ "$BUILD" == "production" ]; then
    OUTPUT=$(grep -r "//String get bannerAdUnitId => BannerAd.testAdUnitId");
    
    if [[ -n "$OUTPUT" ]]; then
        ERRORS="$ERRORS\nError: Test ads must be enabled in debug builds.";
        EXIT=1;
    fi
    
    OUTPUT=$(grep -r "static const timerDuration = 1;");
    
    if [[ -n "$OUTPUT" ]]; then
        ERRORS="$ERRORS\nError: Training timer time is in debug mode.";
        EXIT=1;
    fi
elif [ "$BUILD" == "development" ]; then
    OUTPUT=$(grep -r "//String get bannerAdUnitId => this._bannerAdUnitId;");
    
    if [[ -n "$OUTPUT" ]]; then
        ERRORS="$ERRORS\nError: Ads not enabled.";
        EXIT=1;
    fi
    
    OUTPUT=$(grep -r "static const timerDuration = 15;");
    
    if [[ -n "$OUTPUT" ]]; then
        ERRORS="$ERRORS\nError: Incorrect default training time.";
        EXIT=1;
    fi
else
    echo "Error: Build type is required."
fi

printf "$ERRORS";

printf "\n\nExit code $EXIT.";

exit $EXIT;