# Project 02 - Container Health Monitoring & Auto-Recovery

## Overview

This project simulates a Cloud Operations monitoring workflow.

The script monitors a Docker container and automatically attempts recovery if the container is found stopped.

Incident activity is logged for operational visibility and troubleshooting.

## Technologies Used

- Linux
- Bash
- Docker
- Git
- GitHub
- Jira
- Slack

## Project Structure

project-02-container-health-monitoring-auto-recovery/
│
├── monitor.sh
├── incident_log.txt
└── README.md

## Monitoring Script

<PASTE SCRIPT>

## Workflow

1. Check container health
2. Detect stopped container
3. Log incident
4. Attempt recovery
5. Verify restart
6. Record recovery status

## Test Scenario

Container:
web-app

Initial State:
Stopped

Recovery Command:
docker start web-app

Result:
Recovery successful

## Sample Incident Log

Fri Jun 12 21:20:39 EDT 2026 - Container stopped.
Fri Jun 12 21:20:39 EDT 2026 - Recovery successful.

## Jira Workflow

Ticket Created:
DL2-1

Status Flow:

To Do
→ In Progress
→ Done

Investigation and recovery evidence documented within Jira.

## Skills Demonstrated

- Docker Operations
- Incident Response
- Service Recovery
- Bash Scripting
- Monitoring Automation
- Git Workflow
- Jira Ticket Management

## Future Improvements

- Email notifications
- Slack alerts
- Multi-container monitoring
- Scheduled execution via cron
- Health endpoint validation
