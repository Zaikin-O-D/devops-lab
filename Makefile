.PHONY: up down restart logs psql status clean help

up:
	docker-compose up -d
	@echo "✅ Services started. Wait 10 seconds for health checks..."
	sleep 10
	@make status

down:
	docker-compose down

restart:
	docker-compose restart

logs:
	docker-compose logs -f $(filter-out $@,$(MAKECMDGOALS))

psql:
	docker exec -it observability-postgres psql -U admin -d appdb

status:
	@./scripts/status.sh

clean:
	docker-compose down -v
	@echo "🗑️  All containers and volumes removed"

help:
	@echo "Available commands:"
	@echo "  make up       - Start all services"
	@echo "  make down     - Stop all services"
	@echo "  make restart  - Restart all services"
	@echo "  make logs     - View logs (use: make logs postgres)"
	@echo "  make psql     - Connect to PostgreSQL"
	@echo "  make status   - Show health status"
	@echo "  make clean    - Remove everything (including data volumes)"

%:
	@:
