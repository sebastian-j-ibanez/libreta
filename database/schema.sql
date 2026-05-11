PRAGMA foreign_keys = ON;

CREATE TABLE boards (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

CREATE TABLE tasks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT,
    complete INTEGER NOT NULL
);

CREATE TABLE subtasks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    body TEXT NOT NULL,
    task_id INTEGER REFERENCES tasks(id),
    complete INTEGER NOT NULL
);

CREATE TABLE columns (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    col_order INTEGER UNIQUE NOT NULL,
    board_id INTEGER REFERENCES boards(id)
);

-- Tags are a future feature.
-- CREATE TABLE tags (
--     id INTEGER PRIMARY KEY AUTOINCREMENT,
--     name TEXT NOT NULL,
--     colour TEXT NOT NULL,
--     task_id INTEGER REFERENCES tasks(id)
-- );
