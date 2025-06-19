import { readFile, readdir } from "fs/promises";
import { join } from "path";

import pool from "./db";
import { logger } from "./logger";

const MIGRATIONS_DIR = join(__dirname, "../..", "migrations");

const runMigrations = async (direction: "up" | "down"): Promise<void> => {
  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    await client.query(`
      CREATE TABLE IF NOT EXISTS migrations (
        name TEXT PRIMARY KEY,
        run_at TIMESTAMPTZ DEFAULT now()
      );
    `);

    const files = await readdir(MIGRATIONS_DIR);
    logger.info(`🔍 Found ${files.length} migration files.`, files);
    const migrationNames = [
      ...new Set(
        files
          .filter((f) => f.endsWith(`_${direction}.sql`))
          .map((f) => f.split(".")[0])
      ),
    ].sort();

    if (direction === "up") {
      for (const name of migrationNames) {
        logger.info(`🔍 Checking migration: ${name}`);
        const nameWithoutUp = name.replace(/_up/, "");
        const res = await client.query(
          "SELECT 1 FROM migrations WHERE name = $1",
          [nameWithoutUp]
        );
        if (res.rowCount && res.rowCount > 0) {
          logger.info(`⏭  Skipping already applied: ${nameWithoutUp}`);
          continue;
        }

        const sql = await readFile(
          join(MIGRATIONS_DIR, `${name}.sql`),
          "utf-8"
        );
        await client.query(sql);
        await client.query("INSERT INTO migrations (name) VALUES ($1)", [
          nameWithoutUp,
        ]);
        logger.info(`✅ Applied: ${nameWithoutUp}`);
      }
    } else if (direction === "down") {
      // Rollback last migration only
      const { rows } = await client.query(
        "SELECT name FROM migrations ORDER BY name DESC LIMIT 1"
      );
      const last = rows[0]?.name.replace(/_up/, "") || null;
      if (!last) {
        logger.info("ℹ️  No migrations to rollback.");
      } else {
        const sql = await readFile(
          join(MIGRATIONS_DIR, `${last}_down.sql`),
          "utf-8"
        );
        logger.info(`🔄 Rolling back migration: ${last}`, { sql });
        await client.query(sql);
        await client.query("DELETE FROM migrations WHERE name = $1", [last]);
        logger.info(`↩️  Rolled back: ${last}`);
      }
    }

    await client.query("COMMIT");
  } catch (err) {
    await client.query("ROLLBACK");
    logger.error(`❌ Migration ${direction} failed:`, { err });
  } finally {
    client.release();
    await pool.end();
  }
};

const direction = process.argv[2] as "up" | "down";

if (!["up", "down"].includes(direction)) {
  logger.error("Usage: migrate.ts <up|down>");
  process.exit(1);
}

runMigrations(direction);
