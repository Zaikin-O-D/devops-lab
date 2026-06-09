-- Создание тестовых таблиц
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Вставка тестовых данных
INSERT INTO users (username, email) VALUES
    ('alice', 'alice@example.com'),
    ('bob', 'bob@example.com'),
    ('charlie', 'charlie@example.com')
ON CONFLICT (username) DO NOTHING;

INSERT INTO orders (user_id, amount, status) VALUES
    (1, 150.00, 'completed'),
    (1, 75.50, 'pending'),
    (2, 200.00, 'completed'),
    (2, 300.00, 'failed'),
    (3, 50.00, 'pending')
ON CONFLICT DO NOTHING;
