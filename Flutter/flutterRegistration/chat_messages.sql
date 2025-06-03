-- Таблица пользователей
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Таблица сообщений
CREATE TABLE chat_messages (
    id SERIAL PRIMARY KEY,
    from_user INT NOT NULL,
    to_user INT NOT NULL,
    message TEXT NOT NULL,
    time TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (from_user) REFERENCES users(id),
    FOREIGN KEY (to_user) REFERENCES users(id)
);
