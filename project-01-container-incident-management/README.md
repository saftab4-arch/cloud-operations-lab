# Project 01 – Container Incident Management System

## Overview

This project simulates a real-world Cloud Operations / Site Reliability Engineering (SRE) incident response workflow using Docker, Linux, GitHub, GitHub CLI, and Jira.

The objective was not simply to run a container, but to follow the complete operational lifecycle of a production incident:

* Deploy an application
* Detect an outage
* Create incident tracking records
* Investigate the failure
* Analyze logs and events
* Identify root cause
* Restore service
* Validate recovery
* Document findings
* Close the incident

This project demonstrates practical skills used by Cloud Engineers, DevOps Engineers, Platform Engineers, and SREs.

---

# Technologies Used

| Tool             | Purpose                                   |
| ---------------- | ----------------------------------------- |
| Linux / Git Bash | Command-line operations                   |
| Docker           | Containerized application deployment      |
| NGINX            | Sample web application                    |
| Git              | Version control                           |
| GitHub           | Source code repository                    |
| GitHub CLI (gh)  | Issue management from terminal            |
| Jira             | Incident tracking and workflow management |
| Markdown         | Incident documentation                    |

---

# Architecture

```text
                    +------------------+
                    |     Browser      |
                    | localhost:8080   |
                    +---------+--------+
                              |
                              |
                              v
                    +------------------+
                    | Docker Port Map  |
                    |   8080 -> 80     |
                    +---------+--------+
                              |
                              |
                              v
                    +------------------+
                    |  NGINX Container |
                    |     web-app      |
                    +---------+--------+
                              |
                              |
                              v
                    +------------------+
                    | Docker Engine    |
                    +------------------+
```

---

# Incident Workflow

```text
Application Healthy
        |
        v
GitHub Issue Created
        |
        v
Jira Incident Created
        |
        v
Container Stopped
        |
        v
Application Outage
        |
        v
Investigation
        |
        +--> docker ps
        |
        +--> docker ps -a
        |
        +--> docker logs
        |
        +--> docker events
        |
        v
Root Cause Identified
        |
        v
Service Recovery
        |
        v
Validation
        |
        v
Documentation
        |
        v
Issue Closure
```

---

# Repository Structure

```text
cloud-operations-lab/
|
└── project-01-container-incident-management/
    |
    ├── README.md
    ├── incident_notes.md
    └── .gitignore
```

---

# Phase 1 – Create Project Repository

Initialize local Git repository:

```bash
git init
```

### What it does

Creates a hidden `.git` directory containing:

* Commit history
* Branch information
* Repository metadata

---

Create project directory:

```bash
mkdir project-01-container-incident-management
cd project-01-container-incident-management
```

Create project files:

```bash
touch README.md
touch incident_notes.md
```

---

# Phase 2 – Connect GitHub Repository

Create GitHub repository:

```bash
gh repo create cloud-operations-lab --public
```

### Explanation

| Flag        | Meaning           |
| ----------- | ----------------- |
| gh          | GitHub CLI        |
| repo create | Create repository |
| --public    | Public repository |

---

Add remote:

```bash
git remote add origin git@github.com:<username>/cloud-operations-lab.git
```

Verify:

```bash
git remote -v
```

Expected output:

```text
origin git@github.com:user/repo.git (fetch)
origin git@github.com:user/repo.git (push)
```

---

# Phase 3 – Deploy Web Application

Pull nginx image:

```bash
docker pull nginx
```

### What happened?

Docker Hub provided:

```text
nginx image
```

instead of manually installing nginx.

---

View local images:

```bash
docker images
```

Shows:

```text
Image Name
Image ID
Size
```

---

Create container:

```bash
docker run -d --name web-app -p 8080:80 nginx
```

### Flag Breakdown

| Flag           | Meaning                     |
| -------------- | --------------------------- |
| run            | Create container            |
| -d             | Detached mode               |
| --name web-app | Container name              |
| -p             | Port mapping                |
| 8080:80        | Host port -> Container port |
| nginx          | Image used                  |

---

Visual:

```text
Browser
   |
localhost:8080
   |
   v
Host Port 8080
   |
Docker Mapping
   |
Container Port 80
```

---

Verify running container:

```bash
docker ps
```

---

Validate application:

```text
http://localhost:8080
```

Expected:

```text
Welcome to nginx!
```

---

# Phase 4 – Incident Creation

## GitHub Issue

Create outage ticket:

```bash
gh issue create
```

Issue:

```text
Web Application Outage
```

Verify:

```bash
gh issue list
```

---

## Jira Incident

Created Jira ticket:

```text
DEV-8
```

Status:

```text
TO DO
```

---

# Phase 5 – Simulate Outage

Stop application:

```bash
docker stop web-app
```

### What happened?

Docker sent:

```text
SIGTERM (Signal 15)
```

to nginx.

Nginx performed graceful shutdown.

---

Verify outage:

```bash
docker ps
```

Result:

```text
web-app missing
```

Application became unavailable.

---

# Phase 6 – Investigation

## Step 1

Check running containers:

```bash
docker ps
```

Purpose:

```text
Shows running containers only
```

---

## Step 2

Check all containers:

```bash
docker ps -a
```

Purpose:

```text
Shows:
Running
Stopped
Exited
Failed
Containers
```

Observed:

```text
Exited (137)
```

---

## Understanding Exit Code 137

Exit code:

```text
137
```

indicates container process terminated.

Exit code alone is not enough to determine root cause.

Additional investigation required.

---

## Step 3

Review logs:

```bash
docker logs web-app
```

Useful equivalent:

```text
journalctl
/var/log/syslog
```

for containers.

---

View recent logs:

```bash
docker logs --tail 20 web-app
```

Purpose:

```text
Last 20 lines only
```

---

Key findings:

```text
signal 15 received
gracefully shutting down
worker exiting
```

Evidence of clean shutdown.

---

## Step 4

Review Docker Events

```bash
docker events --since 30m
```

Purpose:

Docker audit trail.

Shows:

```text
container start
container stop
container die
container kill
```

Observed:

```text
signal=15
```

---

# Root Cause Analysis

Evidence gathered:

```text
docker ps -a
docker logs
docker events
```

Findings:

* Container existed
* Container was not running
* SIGTERM received
* Graceful shutdown observed
* No application errors
* No crashes detected

Root Cause:

```text
Container intentionally stopped.
```

---

# Phase 7 – Recovery

Start existing container:

```bash
docker start web-app
```

### Why start instead of run?

Incorrect:

```bash
docker run nginx
```

Creates NEW container.

Correct:

```bash
docker start web-app
```

Starts existing container.

---

Verify recovery:

```bash
docker ps
```

Expected:

```text
web-app
myubuntu
```

running.

---

Validate service:

```text
http://localhost:8080
```

Expected:

```text
Welcome to nginx!
```

---

# Phase 8 – Jira Updates

Move ticket:

```text
TO DO
    ↓
IN PROGRESS
```

Investigation notes added.

Recovery notes added.

Final status:

```text
DONE
```

---

# Phase 9 – GitHub Issue Resolution

Add resolution comment:

```bash
gh issue comment 1 --body "Incident resolved..."
```

Included:

* Investigation findings
* Root cause
* Recovery actions
* Validation results

Close issue:

```bash
gh issue close 1
```

Verify:

```bash
gh issue list
```

No open issues.

---

# Phase 10 – Documentation

Created:

```text
incident_notes.md
```

Documented:

* Incident summary
* Investigation
* Findings
* Recovery
* Validation
* Final outcome

---

# Git Workflow

Stage files:

```bash
git add .
```

Commit:

```bash
git commit -m "Document container outage investigation and recovery"
```

Push:

```bash
git push
```

---

# Skills Demonstrated

## Linux

* Navigation
* File creation
* CLI troubleshooting
* Log analysis

## Docker

* Images
* Containers
* Networking
* Logs
* Events
* Lifecycle management

## GitHub

* Repository management
* Issue tracking
* Documentation

## GitHub CLI

* Create issues
* View issues
* Comment on issues
* Close issues

## Jira

* Incident tracking
* Status transitions
* Investigation documentation
* Resolution workflow

## Cloud Operations

* Incident response
* Root cause analysis
* Service validation
* Recovery procedures
* Documentation

---

# Key Lessons Learned

1. Always investigate before restarting services.
2. Docker logs reveal application behavior.
3. Docker events provide an audit trail.
4. Exit codes alone do not tell the full story.
5. Service recovery must be validated.
6. Incident documentation is part of engineering work.
7. GitHub and Jira complement operational workflows.
8. Containers can be restarted without recreation.
9. Root cause analysis is more important than quick fixes.
10. Professional operations work requires documentation and traceability.

---

# Project Outcome

Successfully completed a full end-to-end Cloud Operations incident response workflow using:

```text
Linux
Docker
Git
GitHub
GitHub CLI
Jira
Incident Management
Documentation
```

Status:

✅ Application Restored

✅ GitHub Issue Closed

✅ Jira Ticket Closed

✅ Incident Documented

✅ Repository Updated

✅ Project Completed
