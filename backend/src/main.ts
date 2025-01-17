// import { Application, Router } from "jsr:@oak/oak";
import { Application, Router } from "@oak";

export function add(a: number, b: number): number {
  return a + b;
}


const PORT = 3000;
const router = new Router();

router.get("/", (context) => {
  console.log(context.request.method);
  context.response.body = "Welcome to Deno with Oak!";
});

router.get("/hello/:name", (context) => {
  
  const name = context.params.name || "World";
  context.response.body = `Hello, ${name}!`;
});

const app = new Application();

app.use(router.routes());
app.use(router.allowedMethods());

console.log(`Server running on http://localhost:${PORT}`);
await app.listen({ port: PORT });





// Learn more at https://docs.deno.com/runtime/manual/examples/module_metadata#concepts
if (import.meta.main) {
  console.log("main module!");
}