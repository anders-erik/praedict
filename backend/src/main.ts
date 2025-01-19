// import { Application, Router } from "jsr:@oak/oak";
import { Application, Router } from "@oak";

import { db } from "./db.ts";
// init(); // dummy init to make sure the db is created


export function add(a: number, b: number): number {
  return a + b;
}


const PORT = 3000;
const router = new Router();


router.get("/env", (context) => {
  const sqlite_path = Deno.env.get("SQLITE_PATH");
  context.response.body = `sqlite_path = ${sqlite_path} \n `;
});
router.get("/hello", (context) => {
  context.response.body = `Hello there! \n `;
});


// random snippet
router.post("/prediction", async (context) => {
  
  const data = context.request.body;
  const json = await data.json();
  // console.log(json);
  const new_uuid = crypto.randomUUID().replace(/-/g, '').substring(0, 8);  
  const accuracy = json.accuracy, snippet_rank = json.snippet_rank, note = json.note, snippet_uuid = json.snippet_uuid.trim();
  // console.log("asdf", new_uuid, accuracy, snippet_rank, note, snippet_uuid);

  let insert_prediction = db.query(
    "INSERT INTO prediction (uuid, accuracy, snippet_rank, note, snippet_uuid) VALUES (?, ?, ?, ?, ?);",
     [new_uuid, accuracy, snippet_rank, note, snippet_uuid]
  );

  // let x = db.query("Select * FROM code_snippet");
  // console.log(x);
  // let source = db.query('SELECT * FROM source WHERE uuid = ?;', [source_uuid]);
  context.response.body = {result: "success"};
});


// random snippet
router.get("/code_snippet", (context) => {
  console.log(context.request.method);
  let code_snippets = db.queryEntries(`SELECT * FROM code_snippet;`)

  const snippet_count = code_snippets.length;
  const snippet_index = Math.floor(Math.random() * snippet_count);

  const code_snippet = code_snippets[snippet_index];

  context.response.body = {
    code_snippet: code_snippet,
  };

});

router.get("/code_snippet_json", (context) => {
  console.log(context.request.method);
  let code_snippet = db.queryEntries(
`SELECT 
  json_object(
    'id', id, 
    'title', title, 
    'content', content
  ) as obob 
 FROM code_snippet;`
  );

  console.log(code_snippet);

  const snippet_count = code_snippet.length;
  const snippet_index = Math.floor(Math.random() * snippet_count);

  const snippet = code_snippet[snippet_index].snippet;

  context.response.body = code_snippet;
});




// random snippet context
router.get("/snippet_context", (context) => {
  // console.log(context.request.method);
  let code_snippet = db.queryEntries(`SELECT * FROM code_snippet;`)

  const snippet_count = code_snippet.length;
  const snippet_index = Math.floor(Math.random()*snippet_count);
  console.log("snippet_index = ", snippet_index);
  


  let source_uuid: string = code_snippet[snippet_index].source_uuid;
  let environment_uuid: string = code_snippet[snippet_index].environment_uuid;
  // console.log(code_snippet[0].source_uuid);
  
  // let source = db.queryEntries(`SELECT * FROM source WHERE uuid = ${code_snippet[0].source_uuid};`)
  let source = db.query('SELECT * FROM source WHERE uuid = ?;', [source_uuid]);
  let environment = db.queryEntries('SELECT * FROM environment WHERE uuid = ?;', [environment_uuid]);
  
  // console.log(source);
  
  // let environment = db.queryEntries(`SELECT * FROM environment;`)
  context.response.body = {
    code_snippet: code_snippet[snippet_index],
    source: source,
    environment: environment,
  };
});



router.get("/", (context) => {
  console.log(context.request.method);
  context.response.body = "Welcome to Deno with Oak!";
});

router.get("/hello/:name", (context) => {
  
  const name = context.params.name || "World";
  context.response.body = `Hello, ${name}!`;
});

const app = new Application();



app.addEventListener("error", (evt) => {
  // Will log the thrown error to the console.
  console.log("DIPSHIT");
  
  console.log(evt.error);
});

// Logger
app.use(async (ctx, next) => {
  await next();
  const rt = ctx.response.headers.get("X-Response-Time");
  console.log(`${ctx.request.method} ${ctx.request.url} - ${rt}`);
});

// Timing
app.use(async (ctx, next) => {
  const start = Date.now();
  await next();
  const ms = Date.now() - start;
  ctx.response.headers.set("X-Response-Time", `${ms}ms`);
});


app.use(router.routes());
app.use(router.allowedMethods());


console.log(`Server running on http://localhost:${PORT}`);
await app.listen({ port: PORT });


Deno.addSignalListener("SIGINT", () => {
  console.log("interrupted!");
  Deno.exit();
});


// Learn more at https://docs.deno.com/runtime/manual/examples/module_metadata#concepts
if (import.meta.main) {
  console.log("main module!");
}