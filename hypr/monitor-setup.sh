#!/bin/bash

CONNECTED=$(hyprctl monitors | grep "Monitor" | awk '{print $2}' | xargs)

set_monitor() {
    local name=$1
    local res=$2
    local refresh=$3
    local pos=$4

    if echo "$CONNECTED" | grep -q "$name"; then
        echo "Enabling $name at $pos with $res@$refresh"
        hyprctl keyword monitor "$name,$res@$refresh,$pos,1" || echo "Failed to apply config for $name"
    fi
}

# Disable all monitors (hyprctl keyword disables with special syntax)
for mon in HDMI-A-1 HDMI-A-2 DVI-D-1; do
    if echo "$CONNECTED" | grep -q "$mon"; then
        hyprctl keyword monitor "$mon,disable"
    fi
done

# Layout positioning
X=0

if echo "$CONNECTED" | grep -q "DVI-D-1"; then
    set_monitor DVI-D-1 1280x1024 60 "${X}x0"
    X=$((X + 1280))
fi

if echo "$CONNECTED" | grep -q "HDMI-A-2"; then
    set_monitor HDMI-A-2 1920x1080 60 "${X}x0"
    X=$((X + 1920))
fi

if echo "$CONNECTED" | grep -q "HDMI-A-1"; then
    set_monitor HDMI-A-1 1920x1080 60 "${X}x0"
    X=$((X + 1920))
fi

