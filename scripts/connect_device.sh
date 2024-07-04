#!/bin/bash

# Function to print usage
usage() {
    echo "Usage: $0"
    exit 1
}

# Ensure adb server is running
adb start-server

# Get the device ID of the single connected device
DEVICE_ID=$(adb devices | grep -w "device" | cut -f1)
echo "Detected device with ID: $DEVICE_ID"

# Check if a single device is connected
if [ -z "$DEVICE_ID" ]; then
    echo "No device connected."
    exit 1
fi

# Retrieve the IP address of the connected device
# Define the default port for ADB
PORT=5555

DEVICE_IP=$(adb -s "$DEVICE_ID" shell ip route | awk '{print $9}' | tail -n 1)
echo "Detected device IP address: $DEVICE_IP"

# Enable ADB over Wi-Fi on the device
echo "Enabling ADB over Wi-Fi on the device..."
adb -s "$DEVICE_ID" tcpip $PORT

# Connect to the device over Wi-Fi
echo "Connecting to '$DEVICE_ID' through address: $DEVICE_IP:$PORT"
adb connect "$DEVICE_IP:$PORT"

# Verify the connection
if adb devices | grep -q "$DEVICE_IP:$PORT"; then
    echo "Successfully connected on $DEVICE_IP:$PORT"
else
    echo "Failed to connect to $DEVICE_IP:$PORT"
    exit 1
fi

# Optionally, to list connected devices
adb devices
