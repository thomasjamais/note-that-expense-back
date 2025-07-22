import { logRequests } from "@middlewares/logger";
import { createRouter } from "@routes/index";
import cors from "cors";
import express from "express";

import { logger } from "./logger";

const initialize = async (
  port: number,
  host: string
): Promise<express.Express> => {
  const app = express();
  logger.info("🔍 Initializing express server...");

  app
    .use(express.json({ limit: "50mb" }))
    .use(express.urlencoded({ limit: "50mb", extended: true }))
    .use(logRequests)
    .use(
      cors({
        credentials: true,
        methods: ["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"],
        allowedHeaders: ["Content-Type", "Authorization"],
        origin: true,
      })
    );

  app.get("/health-check", (req, res) => {
    res.sendStatus(200);
  });

  const router = await createRouter();
  // Routes
  logger.info("🔍 Initializing routes...");
  app.use(router);

  logger.info("✅ Routes initialized");

  app.listen(port, host, () => {
    logger.info("✅ Express server initialized");
    logger.info(`✅ Server is listening on ${host}:${port}`);
  });

  return app;
};

export default initialize;

module.exports.initialize = initialize;
