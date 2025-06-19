import path from "path";

import type { Router } from "express";
import express from "express";
import { glob } from "glob";

const routesDir = path.join(__dirname, "./**/*.route{s,}.{js,ts}");
const ignoreTestDirs = path.join(__dirname, "./**/__tests__/*");

export const createRouter = async (): Promise<Router> => {
  const router = express.Router();

  const files = await glob(routesDir, {
    ignore: [ignoreTestDirs],
  });

  files.forEach((file: string) => {
    const { router: subRouter } = require(path.resolve(file));

    if (!subRouter) {
      throw new Error(`export Router on your route for ${file}`);
    }

    router.use(subRouter);
  });
  return router;
};
