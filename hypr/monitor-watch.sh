#!/bin/bash

LAST_STATE=""

while true; do
    # Get current connected monitors (only enabled ones)
    CURRENT_STATE=$(hyprctl monitors | grep "Monitor" | awk '{print $2}' | sort | xargs)

    if [[ "$CURRENT_STATE" != "$LAST_STATE" ]]; then
        echo "[Monitor Change Detected] Updating layout..."
        ~/.config/hypr/monitor-setup.sh
        LAST_STATE="$CURRENT_STATE"
    fi

    sleep 2
done

