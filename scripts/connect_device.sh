#!/bin/bash

function usage() {
    echo "Usage: connect_device.sh [-d <wifi|vm>]"
}

function connect_wireless_device() {
    # Ensure adb server is running
    adb start-server

    # Get the device ID of the single connected device
    DEVICE_ID="$(adb devices | grep -w "device" | cut -f1)"
    echo "Detected device with ID: $DEVICE_ID"

    # Check if a single device is connected
    if [ -z "$DEVICE_ID" ]; then
        echo "No device connected."
        return 1
    fi

    ADB_PORT=5555

    # Retrieve the IP address of the connected device
    DEVICE_IP="$(adb -s "$DEVICE_ID" shell ip route | awk '{print $9}' | tail -n 1)"

    echo "Identified device '$DEVICE_ID' with IP address: $DEVICE_IP"

    echo "Enabling ADB over Wi-Fi on the device..."
    adb -s "$DEVICE_ID" tcpip $ADB_PORT

    # Connect to the device over Wi-Fi
    echo "Connecting through address: $DEVICE_IP:$ADB_PORT"
    adb connect "$DEVICE_IP:$ADB_PORT"

    # Verify the connection
    if adb devices | grep -q "$DEVICE_IP:$ADB_PORT"; then
        echo "Connection successful."
        return 0
    fi

    echo "Connection failed."
    return 1
}

while getopts "d:" opt; do
    case "${opt}" in
    d)
        if [ -z "$OPTARG" ]; then
            usage
            exit 1
        fi

        case "$OPTARG" in
        "wifi")
            echo "Connecting to device over Wi-Fi..."

            if ! connect_wireless_device; then
                echo -e "\n\nFailed to connect to device."
                exit 1
            fi
            ;;
        "vm")
            echo "Connecting to device over VM..."
            exit 0
            ;;

        *)
            echo "Invalid option: $OPTARG"
            usage
            exit 1
            ;;
        esac
        ;;
    \?)
        usage
        ;;
    esac
done

exit 0
