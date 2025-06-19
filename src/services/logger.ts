import path from "path";

import pino from "pino";

const rootPath = process.cwd();

function getCallerLocation(): string {
  const stack = new Error().stack?.split("\n") || [];

  for (const line of stack) {
    if (line.includes("node_modules")) continue;
    if (!line.includes("at")) continue;
    if (line.includes("/logger.js")) continue;

    const match = line.match(/\((.*):(\d+):\d+\)$/);
    if (match) {
      const filePath = path.relative(rootPath, match[1]);
      const lineNumber = match[2];
      return `${filePath}:${lineNumber}`;
    }
  }

  return "";
}

const baseLogger = pino({
  transport:
    process.env.NODE_ENV === "production"
      ? undefined
      : {
          target: "pino-pretty",
          options: {
            colorize: true,
            translateTime: "SYS:standard",
            ignore: "pid,hostname",
          },
        },
});

type LogLevel = "info" | "warn" | "error" | "debug";

function log(level: LogLevel, msg: string, data?: object): void {
  const location = getCallerLocation();
  baseLogger[level](data ? { ...data, location } : { location }, msg);
}

export const logger = {
  info: (msg: string, data?: object) => log("info", msg, data),
  warn: (msg: string, data?: object) => log("warn", msg, data),
  error: (msg: string, data?: object) => log("error", msg, data),
  debug: (msg: string, data?: object) => log("debug", msg, data),
};
