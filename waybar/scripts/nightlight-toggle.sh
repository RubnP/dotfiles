#!/bin/bash

PIDFILE="$HOME/.cache/gammastep.pid"

if [[ -f "$PIDFILE" ]]; then
    # If it's running, kill it
    kill "$(cat "$PIDFILE")" && rm "$PIDFILE"
    echo "Night light disabled"
else
    # Start in background and save PID
    gammastep -O 3500 &
    echo $! > "$PIDFILE"
    echo "Night light enabled"
fi

