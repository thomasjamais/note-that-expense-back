import { readdirSync, readFileSync, statSync } from "fs";
import { join, relative } from "path";

import { logger } from "./logger";

type SQLMap = Record<string, string>;

export const dal: SQLMap = {};

export function loadAllSQLFromRoutes(): SQLMap {
  const baseDir = join(__dirname, "..", "routes");
  logger.info(`🔍 Loading SQL files from: ${baseDir}`);

  function walk(dir: string): void {
    const entries = readdirSync(dir);
    for (const entry of entries) {
      const fullPath = join(dir, entry);
      const stats = statSync(fullPath);

      if (stats.isDirectory()) {
        walk(fullPath);
      } else if (entry.endsWith(".sql")) {
        const key = relative(baseDir, fullPath)
          .replace(/\\/g, "/")
          .replace(/\.sql$/, "")
          .replace(/repositories\//, "");
        dal[key] = readFileSync(fullPath, "utf-8");
      }
    }
  }

  walk(baseDir);
  return dal;
}
