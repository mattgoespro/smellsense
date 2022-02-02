#!/bin/bash

ERRORS="";
EXIT=0;

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

printf "$ERRORS";

exit $EXIT;