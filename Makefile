.PHONY: up down restart logs psql status clean help

up:
	docker compose up -d
	@sleep 5
	@make status

down:
	docker compose down

restart:
	docker compose restart

logs:
	docker compose logs -f $(filter-out $@,$(MAKECMDGOALS))

psql:
	docker exec -it observability-postgres psql -U admin -d appdb

status:
	@echo "=== Services Status ==="
	@docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | grep -E "observability|devops" || true
	@echo ""
	@echo "=== PostgreSQL Health ==="
	@docker exec observability-postgres pg_isready -U admin 2>/dev/null || echo "PostgreSQL not running"
	@echo ""
	@echo "=== Access URLs ==="
	@echo "Grafana:     http://localhost:3000 (admin/admin)"
	@echo "Prometheus:  http://localhost:9090"
	@echo "PostgreSQL:  localhost:5432 (admin/secret)"

clean:
	docker compose down -v

help:
	@echo "Available commands:"
	@echo "  make up       - Start all services"
	@echo "  make down     - Stop all services"
	@echo "  make restart  - Restart all services"
	@echo "  make logs     - View logs (use: make logs postgres)"
	@echo "  make psql     - Connect to PostgreSQL"
	@echo "  make status   - Show health status"
	@echo "  make clean    - Remove everything (including volumes)"

%:
	@:
