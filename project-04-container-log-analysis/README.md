# Project 04 - Container Log Analysis & Incident Reporting Tool

## Overview

The Container Log Analysis & Incident Reporting Tool is a Bash-based operational utility designed to assist Cloud and DevOps engineers with Docker container troubleshooting.

The tool automatically collects container information, analyzes logs, detects potential issues, and generates an incident report with severity classifications and recommendations.

---

## Features

* Detect running Docker containers
* Collect container metadata
* Retrieve container logs
* Count errors and warnings
* Classify incident severity
* Generate operational recommendations
* Capture resource utilization
* Produce timestamped incident reports

---

## Technologies Used

* Linux
* Bash
* Docker
* Git
* GitHub CLI
* Jira

---

## Project Structure

```text
project-04-container-log-analysis/
│
├── .gitignore
├── DESIGN.md
├── README.md
├── container-log-analyzer.sh
├── logs/
└── reports/
```

---

## Severity Classification

### HIGH

One or more errors detected.

Recommendation:

* Immediate investigation required
* Review application logs
* Validate container health

### MEDIUM

Warnings detected but no errors.

Recommendation:

* Investigate warnings
* Monitor container behavior

### LOW

No errors or warnings detected.

Recommendation:

* No action required
* Continue routine monitoring

---

## Example Report Output

```text
Container Incident Report

Container Name : nodejs-container
Image          : nodejs-demo:v1
Status         : running

Resource Usage : 0.00% | 33.79MiB / 15.27GiB

Error Count    : 0
Warning Count  : 0

Severity       : LOW

Recommendation :
No action required. Continue monitoring.
```

---

## Skills Demonstrated

* Docker Administration
* Log Analysis
* Incident Response
* Bash Scripting
* Git Feature Branch Workflow
* Pull Request Workflow
* GitHub CLI Operations
* Jira Ticket Management

---

## Workflow Followed

Jira Ticket → GitHub Issue → Feature Branch → Development → Testing → Pull Request → Merge → Issue Closure

---

## Author

Syed Aftab
Cloud / DevOps Engineering Portfolio Project
