CREATE TABLE IF NOT EXISTS todo (
    todo_id SERIAL PRIMARY KEY NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    title TEXT NOT NULL,
    is_done BOOLEAN NOT NULL DEFAULT false
);

INSERT INTO todo (title) VALUES ('do that thing');
