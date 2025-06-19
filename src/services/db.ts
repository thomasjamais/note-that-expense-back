/**
 * Database Configuration Module
 *
 * This module sets up and manages a PostgreSQL connection pool using the `pg` library.
 * It leverages environment variables for secure configuration and includes an asynchronous
 * verification function to confirm connectivity at startup.
 */

import dotenv from "dotenv";
import { Pool } from "pg";

import { loadAllSQLFromRoutes } from "./dal";
import { logger } from "./logger";

// Load environment variables from .env file
dotenv.config();

// PostgreSQL connection pool configuration using environment variables
const db = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: Number(process.env.DB_PORT),
});

loadAllSQLFromRoutes();

/**
 * Asynchronously verifies the PostgreSQL connection.
 * Ensures that any issues are logged immediately at application startup.
 */
async function verifyConnection(): Promise<void> {
  try {
    // Attempt to acquire a client from the db
    const client = await db.connect();
    logger.info("✅ Connected to PostgreSQL database");
    client.release(); // Release the client back to the db
  } catch (error) {
    logger.error("❌ Error connecting to the database:", { error });
  }
}

// Immediately verify connection upon module load.
verifyConnection();

// Export the db to be used across the application.
export default db;
export type QueryResultRow = Record<string, unknown>; // Generic type for query result rows
