#!/bin/bash

# ----------- CONFIGURATION ----------- #
REPO_ROOT="/home/rcmd/homeserver/homeserver"
EXTRA_FOLDER="$REPO_ROOT/extra-cups-restart"
UDEV_RULES_FILE="99-restart-cups-docker.rules"
RESTART_SCRIPT="restart-cups-docker.sh"
DEST_UDEV_RULE="/etc/udev/rules.d/$UDEV_RULES_FILE"
TARGET_SCRIPT_PATH="/usr/local/bin/restart-cups-docker.sh"
DOCKER_COMPOSE_FILE="$REPO_ROOT/docker-compose.printer.yml"
# ------------------------------------- #

echo "Setting up printer reconnect restart script for CUPS container..."

# Step 1: Copy udev rule
echo "Copying udev rule to $DEST_UDEV_RULE..."
sudo cp "$EXTRA_FOLDER/$UDEV_RULES_FILE" "$DEST_UDEV_RULE"

# Step 2: Copy the restart script to /usr/local/bin
echo "Installing restart script to $TARGET_SCRIPT_PATH..."
sudo cp "$EXTRA_FOLDER/$RESTART_SCRIPT" "$TARGET_SCRIPT_PATH"

# Step 3: Make it executable
echo "Making restart script executable..."
sudo chmod +x "$TARGET_SCRIPT_PATH"

# Step 4: Reload udev rules
echo "Reloading udev rules..."
sudo udevadm control --reload
sudo udevadm trigger --subsystem-match=usb --action=change

echo "Setup complete! Printer reconnection will now trigger container restart."
