// import { Application, Router } from "jsr:@oak/oak";
import { Application, Router } from "@oak";

import { init } from "./db.ts";
init(); // dummy init to make sure the db is created


export function add(a: number, b: number): number {
  return a + b;
}


const PORT = 3000;
const router = new Router();



router.get("/hello", (context) => {
  const sqlite_path = Deno.env.get("SQLITE_PATH");
  context.response.body = `sqlite_path = ${sqlite_path} \n `;
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