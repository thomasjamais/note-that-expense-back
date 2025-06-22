import { logRequests } from "@middlewares/logger";
import { createRouter } from "@routes/index";
import cors from "cors";
import express from "express";

// const cookieParser = require("cookie-parser");
// const helmet = require("helmet");
// const cors = require("cors");
// const passport = require("passport");
// const passportHttpBearer = require("passport-http-bearer");
// const connectTimeout = require("connect-timeout");
// const maintenance = require("../../services/api/middlewares/maintenance");

// const logger = require("../logger");

// const publicRoutes = require("#constants/publicRoutes");
// const {
//   passportHttpBearerAuthentication,
//   passportHttpBearerHandler,
// } = require("../../routes/users/auth/auth.middleware");
// const catchAllErrors = require("../../services/api/middlewares/catchAllErrors");
// const pinoExpressLogger = require("../../services/api/middlewares/logger");
// const addRequestId = require("../../services/api/middlewares/requestId");
// const httpContext = require("../../services/api/middlewares/httpContext");
// const features = require("../../services/api/middlewares/features");

// const { router: mainRouter } = require("../../routes");
// const config = require("../../../config");

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
    // .use(helmet())
    // .use(addRequestId())
    // .use(pinoExpressLogger)
    // .use(httpContext.middleware)
    // .use(connectTimeout(timeout, { respond: true }))
    .use(
      cors({
        credentials: true,
        methods: ["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"],
        allowedHeaders: ["Content-Type", "Authorization"],
        origin: true,
      })
    );
  // .use(cookieParser())
  // .use(passport.initialize());

  //   passport.use(
  //     new passportHttpBearer.Strategy(
  //       {
  //         passReqToCallback: true,
  //       },
  //       passportHttpBearerHandler,
  //     ),
  //   );

  // Authentication
  //   app.use(
  //     passportHttpBearerAuthentication.unless({
  //       path: publicRoutes,
  //     }),
  //   );

  // For Node instance health-check
  app.get("/health-check", (req, res) => {
    res.sendStatus(200);
  });

  // activate maintenance
  //   app.use(maintenance);

  // check activeFeatures for the user
  //   app.use(features);

  const router = await createRouter();
  // Routes
  logger.info("🔍 Initializing routes...");
  app.use(router);

  logger.info("✅ Routes initialized");

  // 404 - Not found
  //   app.all("*", (req, res) => {
  //     res.sendStatus(404);
  //   });

  // Error handler middleware
  //   app.use(catchAllErrors);

  app.listen(port, host, () => {
    logger.info("✅ Express server initialized");
    logger.info(`✅ Server is listening on ${host}:${port}`);
  });

  return app;
};

// async function close() {
//   logger.debug("Closing express server instance...");

//   if (!server) {
//     logger.debug("There was no express server instance to close");

//     return Promise.resolve();
//   }

//   return new Promise((resolve, reject) => {
//     server.close(function (err) {
//       if (err) {
//         logger.error(
//           err,
//           "An error occured while closing the express server instance",
//         );
//         reject(err);

//         return;
//       }

//       logger.debug("Express server closed");
//       resolve();
//     });
//   });
// }

export default initialize;

module.exports.initialize = initialize;
// module.exports.close = close;
