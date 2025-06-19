import { logger } from "@services/logger";
import { isErrorWithCode, isErrorWithMessage } from "@utils/error";
import type { Request, Response } from "express";

import { AUTH_ERRORS } from "../auth.constant";
import { registerUserService } from "../services/registerUser";

export const registerUserAction = async (
  req: Request,
  res: Response
): Promise<void> => {
  logger.info("🔍 Registering user:", {
    email: req.body.email,
    timestamp: new Date().toISOString(),
  });

  try {
    const user = await registerUserService(req.body);
    logger.info("✅ User registered successfully:", {
      email: user.email,
      id: user.id,
      timestamp: new Date().toISOString(),
    });
    res.json({ message: "User registered successfully", data: req.body });
  } catch (error) {
    logger.error("❌ Error during user registration:", {
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });
    if (isErrorWithMessage(error, AUTH_ERRORS.PASSWORD_MISMATCH)) {
      res.status(400).json({ error: AUTH_ERRORS.PASSWORD_MISMATCH });
      return;
    }
    if (isErrorWithCode(error, "23505")) {
      res.status(409).json({ error: AUTH_ERRORS.USER_ALREADY_EXISTS });
      return;
    }

    res.status(500).json({ error: AUTH_ERRORS.INTERNAL_SERVER_ERROR });
    return;
  }
};
