#!/bin/bash

# =========================================
# Container Log Analysis & Incident Reporting Tool
# =========================================

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

REPORT_FILE="reports/incident_report_$TIMESTAMP.txt"

# Create Report Header
echo "=========================================" > "$REPORT_FILE"
echo "Container Incident Report" >> "$REPORT_FILE"
echo "Generated: $(date)" >> "$REPORT_FILE"
echo "=========================================" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Container Summary
echo "Container Summary" >> "$REPORT_FILE"
echo "-----------------" >> "$REPORT_FILE"

RUNNING_CONTAINERS=$(docker ps -q | wc -l)

echo "Running Containers: $RUNNING_CONTAINERS" >> "$REPORT_FILE"

TOTAL_CONTAINERS=$(docker ps -a -q | wc -l)

echo "Total Containers   : $TOTAL_CONTAINERS" >> "$REPORT_FILE"

echo "" >> "$REPORT_FILE"

echo "Report saved to: $REPORT_FILE"

CONTAINERS=$(docker ps --format "{{.Names}}")

for container in $CONTAINERS
do
    IMAGE=$(docker inspect --format='{{.Config.Image}}' "$container")
    STATUS=$(docker inspect --format='{{.State.Status}}' "$container")
    UPTIME=$(docker inspect --format='{{.State.StartedAt}}' "$container")
    STATS=$(docker stats --no-stream --format "{{.CPUPerc}} | {{.MemUsage}}" "$container")


    echo "Container Name : $container" >> "$REPORT_FILE"
    echo "Image          : $IMAGE" >> "$REPORT_FILE"
    echo "Status         : $STATUS" >> "$REPORT_FILE"
    echo "Uptime         : $UPTIME" >> "$REPORT_FILE"

    echo "" >> "$REPORT_FILE"
    echo "Recent Logs" >> "$REPORT_FILE"
    echo "-----------" >> "$REPORT_FILE"
    echo "Resource Usage : $STATS" >> "$REPORT_FILE"

    docker logs --tail 10 "$container" >> "$REPORT_FILE" 2>&1

    ERROR_COUNT=$(docker logs "$container" 2>&1 | grep -i "error" | wc -l)

    WARNING_COUNT=$(docker logs "$container" 2>&1 | grep -i "warning" | wc -l)

    echo "" >> "$REPORT_FILE"
    echo "Error Count   : $ERROR_COUNT" >> "$REPORT_FILE"
    echo "Warning Count : $WARNING_COUNT" >> "$REPORT_FILE"

    if [ "$ERROR_COUNT" -gt 0 ]
    then
        SEVERITY="HIGH"
        RECOMMENDATION="Immediate investigation required."

    elif [ "$WARNING_COUNT" -gt 0 ]
    then
        SEVERITY="MEDIUM"
        RECOMMENDATION="Investigate warnings and monitor container."

    else
        SEVERITY="LOW"
        RECOMMENDATION="No action required. Continue monitoring."

    fi

    echo "Severity      : $SEVERITY" >> "$REPORT_FILE"
    echo "Recommendation: $RECOMMENDATION" >> "$REPORT_FILE"

    echo "" >> "$REPORT_FILE"
    echo "=========================================" >> "$REPORT_FILE"

done


