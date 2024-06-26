#!/bin/bash

flutter packages pub run build_runner build || {
    echo "error: failed to generate database files."
    exit 1
}

exit 0
