#!/bin/bash

./firefox.sh

set -e

echo "Starting openconnect"
sudo openconnect --useragent "AnyConnect-compatible Openconnect VPN Agent" "$VPN_SERVER" -b

# Wait a bit to let you authenticate
echo "Waiting for VPN connection..."
sleep 2

# Launch Firefox
echo "Launching Firefox (using VPN tunnel)..."
echo "x-terminal-emulator" 
x-terminal-emulator

# After Firefox closes, kill VPN and exit
echo "Shutting down VPN..."
sudo killall -SIGINT openconnect

echo "Done. Container exiting."
