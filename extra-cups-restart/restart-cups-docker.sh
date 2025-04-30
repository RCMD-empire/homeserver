#!/bin/bash
COMPOSE_FILE_PATH="/home/rcmd/homeserver/homeserver/docker-compose.printer.yml"
# Check if the container is running
if docker ps --format '{{.Names}}' | grep -q '^cups-server$'; then
    echo "Restarting cups-server container..."
    docker compose -f "$COMPOSE_FILE_PATH" restart cups
else
    echo "cups-server not running — no action taken."
fi
