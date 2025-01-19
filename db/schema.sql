-- Create table for guesses
CREATE TABLE IF NOT EXISTS source (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    uuid TEXT NOT NULL,
    type TEXT NOT NULL DEFAULT "",
    url TEXT NOT NULL DEFAULT "",
    author TEXT NOT NULL DEFAULT "",
    read_date TEXT NOT NULL DEFAULT "",

    created_at_unix INTEGER DEFAULT (unixepoch()),
    modified_at_unix INTEGER DEFAULT (unixepoch())

);



-- Envirnment in which the snippets run
CREATE TABLE IF NOT EXISTS environment (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    uuid TEXT NOT NULL,
    image_name TEXT NOT NULL, -- e.g. anderserik/rust-docker-1.84
    type TEXT NOT NULL DEFAULT "", -- e.g. docker, virtualbox, etc.

    created_at_unix INTEGER DEFAULT (unixepoch()),
    modified_at_unix INTEGER DEFAULT (unixepoch())
);


-- Create table for code snippets
CREATE TABLE IF NOT EXISTS code_snippet (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    uuid TEXT NOT NULL,
    title TEXT NOT NULL,
    content TEXT NOT NULL,
    run_command TEXT NOT NULL,
    std_out TEXT NOT NULL,
    std_err TEXT NOT NULL,
    note TEXT NOT NULL,
    quality_rank INTEGER NOT NULL,

    created_at_unix INTEGER DEFAULT (unixepoch()),
    modified_at_unix INTEGER DEFAULT (unixepoch()),

    environment_uuid TEXT,
    source_uuid INTEGER,
    FOREIGN KEY (environment_uuid) REFERENCES environment (uuid),
    FOREIGN KEY (source_uuid) REFERENCES source (uuid)
);



-- Source of the code_snippets
CREATE TABLE IF NOT EXISTS prediction (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    uuid TEXT NOT NULL,
    accuracy BOOLEAN NOT NULL,
    snippet_rank TEXT NOT NULL,
    note TEXT NOT NULL DEFAULT "",

    created_at_unix INTEGER DEFAULT (unixepoch()),
    modified_at_unix INTEGER DEFAULT (unixepoch()),

    snippet_uuid TEXT--,
    -- FOREIGN KEY (snippet_uuid) REFERENCES code_snippet (uuid)
);

