// Oak (HTTP server framework)
export { Application, Router } from "https://deno.land/x/oak/mod.ts";

// Denodb (ORM for SQLite)
export { Database, SQLite3Connector, Model } from "https://deno.land/x/denodb/mod.ts";


// Set up the database
const connector = new SQLite3Connector({
    filepath: "./database.sqlite",
});
const db = new Database(connector);

// Define models
class CodeSnippet extends db.Model {
    static table = "code_snippet";
    static fields = {
        id: { primaryKey: true, autoIncrement: true },
        title: String,
        content: String,
    };
}

class Guess extends db.Model {
    static table = "guess";
    static fields = {
        id: { primaryKey: true, autoIncrement: true },
        snippet_id: Number,
        guess_text: String,
        is_correct: Boolean,
    };
}

db.link([CodeSnippet, Guess]);

// Set up the API
const router = new Router();

router
    .get("/snippets", async (ctx) => {
        const snippets = await CodeSnippet.all();
        ctx.response.body = snippets;
    })
    .get("/snippets/:id/guesses", async (ctx) => {
        const id = ctx.params.id;
        const guesses = await Guess.where("snippet_id", id).all();
        ctx.response.body = guesses;
    });

const app = new Application();
app.use(router.routes());
app.use(router.allowedMethods());

// Start the server
console.log("Server running on http://localhost:3000");
await app.listen({ port: 3000 });
