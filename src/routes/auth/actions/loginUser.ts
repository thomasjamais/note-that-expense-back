import { logger } from "@services/logger";
import { isErrorWithMessage } from "@utils/error";
import type { Request, Response } from "express";

import { AUTH_ERRORS } from "../auth.constant";
import { loginUserService } from "../services/loginUser";

export const loginUserAction = async (
  req: Request,
  res: Response
): Promise<void> => {
  logger.info("🔍 Logging in user:", {
    email: req.body.email,
  });

  try {
    const user = await loginUserService(req.body);

    logger.info("✅ User logged in successfully:", {
      email: user.email,
      id: user.id,
      timestamp: new Date().toISOString(),
    });

    res.json(user);
  } catch (error) {
    logger.error("❌ Error during user login:", {
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    if (isErrorWithMessage(error, AUTH_ERRORS.USER_NOT_FOUND)) {
      res.status(404).json({ error: AUTH_ERRORS.USER_NOT_FOUND });
      return;
    }
    if (isErrorWithMessage(error, AUTH_ERRORS.INVALID_PASSWORD)) {
      res.status(401).json({ error: AUTH_ERRORS.INVALID_PASSWORD });
      return;
    }

    res.status(500).json({ error: AUTH_ERRORS.INTERNAL_SERVER_ERROR });
  }
};
