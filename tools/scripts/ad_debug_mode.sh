#!/bin/bash

OUTPUT=$(grep -r "//String get bannerAdUnitId => BannerAd.testAdUnitId");

if  [[ ! -z "$OUTPUT" ]]; then
  echo "Error: Test banner must be enabled in Debug workflow.";
  exit 1;
fi

echo "No error";

exit 0;