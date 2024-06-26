#!/bin/bash

flags="--apply"

while getopts "d:" opt; do
    case $opt in
    d)
        flags="--dry-run"
        ;;
    *)
        flags="--apply"
        ;;
    esac
done

dart fix $flags
