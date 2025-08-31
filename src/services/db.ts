import dotenv from "dotenv";
import { Pool } from "pg";

import { loadAllSQLFromRoutes } from "./dal";
import { logger } from "./logger";

dotenv.config();
logger.info("🌱 NoteThatExpense Backend - Database Configuration Loaded", {
  port: Number(process.env.DB_PORT),
});

const db = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: Number(process.env.DB_PORT),
  ssl: {
    rejectUnauthorized: false,
  },
});

loadAllSQLFromRoutes();

async function verifyConnection(): Promise<void> {
  try {
    const client = await db.connect();
    logger.info("✅ Connected to PostgreSQL database");
    client.release();
  } catch (error) {
    logger.error("❌ Error connecting to the database:", { error });
  }
}

verifyConnection();

export default db;
export type QueryResultRow = Record<string, unknown>;
