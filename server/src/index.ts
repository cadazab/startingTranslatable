import { Hono } from "hono";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

const test = new Hono().post("/", async (c) => {
  const body = await c.req.json();
  console.log(body);

  const response = await prisma.test.create({
    data: {
      ...body,
    },
  });
  return c.json({ response, test: "hello world" }, 201);
});

const app = new Hono().route("test", test);

export default {
  port: 3000,
  fetch: app.fetch,
};
