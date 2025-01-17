import { DB } from "https://deno.land/x/sqlite@v3.9.1/mod.ts";

const SQLITE_PATH = Deno.env.get("SQLITE_PATH");

// console.warn(SQLITE_PATH);

export function init() {
    console.log("DUMMY DB INIT");
}

if (SQLITE_PATH === undefined) {
    console.error("Unable to find the SQLITE_PATH environment variable. Exiting.");
    Deno.exit(1);
}

// If file doesn't exist we need to make sure all directories exists first
try {
    await Deno.lstat(SQLITE_PATH);
} catch (_err) {
    console.warn("Unable to find the sqlite database. Creating new @ ", SQLITE_PATH);
    // Make sure the directories exists
    const db_dir = SQLITE_PATH.substring(0, SQLITE_PATH.lastIndexOf("/"));
    Deno.mkdir(db_dir, { recursive: true });
}

const db = new DB(SQLITE_PATH);

db.execute(`
CREATE TABLE IF NOT EXISTS people (
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT
)
`);
