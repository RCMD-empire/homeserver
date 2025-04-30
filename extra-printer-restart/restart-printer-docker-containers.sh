#!/bin/bash

# Configuration
COMPOSE_FILES_PATH="/home/rcmd/homeserver/"

COMPOSE_FILE_CUPS="docker-compose.printer.yml"
CUPS_SERVICE_NAME="cups"

COMPOSE_FILE_SCAN="docker-compose.scanner.yml"
SCAN_SERVICE_NAME="scanservjs"

# Function to restart a specific service or all running services from a Compose file
restart_if_running() {
    local compose_file="$1"
    local target_service="$2"
    local full_path="${COMPOSE_FILES_PATH}${compose_file}"

    if [[ -n "$target_service" ]]; then
        # Check if the target service is running
        if docker compose -f "$full_path" ps --status=running --services | grep -qx "$target_service"; then
            echo "Restarting service '$target_service' in $compose_file..."
            docker compose -f "$full_path" restart "$target_service"
        else
            echo "Service '$target_service' is not running in $compose_file. Skipping..."
        fi
    else
        # Restart all running services in the compose file
        running_services=$(docker compose -f "$full_path" ps --status=running --services)

        if [[ -n "$running_services" ]]; then
            echo "Restarting all running services in $compose_file..."
            docker compose -f "$full_path" restart $running_services
        else
            echo "No running services in $compose_file. Skipping..."
        fi
    fi
}

# Examples of usage
restart_if_running "$COMPOSE_FILE_CUPS" "$CUPS_SERVICE_NAME"
restart_if_running "$COMPOSE_FILE_SCAN" "$SCAN_SERVICE_NAME"