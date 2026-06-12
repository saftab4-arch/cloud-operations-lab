# Container Incident Report

## Incident Summary

Web application became unavailable.

## Investigation

1. Checked running containers
   - docker ps

2. Checked all containers
   - docker ps -a

3. Reviewed container logs
   - docker logs web-app

4. Reviewed Docker events
   - docker events --since 30m

## Findings

Container received SIGTERM and performed a graceful shutdown.

No application errors observed.

## Recovery

docker start web-app

## Validation

docker ps

Verified application availability via:

http://localhost:8080

## Result

Service successfully restored.
