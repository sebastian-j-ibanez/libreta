-- Populate database with test data.
BEGIN;
    INSERT INTO boards (id, name) VALUES (1, 'Main');

    INSERT INTO
        tasks (title, complete, description)
    VALUES
        ('Finish writing libreta schema', 0, ''),
        ('Learn how use SolidJS signals', 0, '');

    INSERT INTO
        columns (name, col_order, board_id)
    VALUES
        ('Backlog', 1, 1),
        ('Started', 2, 1),
        ('Finished', 3, 1);
COMMIT;