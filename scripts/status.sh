#!/bin/bash
echo "=== Docker Containers Status ==="
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | grep observability

echo -e "\n=== PostgreSQL Health ==="
docker exec observability-postgres pg_isready -U admin

echo -e "\n=== Prometheus Targets ==="
curl -s http://localhost:9090/api/v1/targets | jq '.data.activeTargets[] | {job: .labels.job, health: .health}' 2>/dev/null || echo "Prometheus not ready or jq not installed"
