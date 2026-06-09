#!/bin/bash
docker exec -it observability-postgres psql -U admin -d appdb "$@"
