#!/bin/bash

CONTAINER="web-app"

echo "Checking container health..."

if docker ps | grep -q "$CONTAINER"
then
    echo "Container is healthy and running."

else
    echo "$(date) - Container stopped." >> incident_log.txt

    echo "Attempting recovery..."

    if docker start $CONTAINER
    then
        echo "$(date) - Recovery successful." >> incident_log.txt
    else
        echo "$(date) - Recovery failed." >> incident_log.txt
    fi

fi
