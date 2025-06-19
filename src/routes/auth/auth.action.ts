import { logger } from "@services/logger";
import { isErrorWithCode, isErrorWithMessage } from "@utils/error";
import type { Request, Response } from "express";

import { AUTH_ERRORS } from "./auth.constant";
import { registerUser, loginUser } from "./auth.service";

export const registerUserAction = async (
  req: Request,
  res: Response
): Promise<void> => {
  logger.info("🔍 Registering user:", {
    email: req.body.email,
    timestamp: new Date().toISOString(),
  });

  try {
    const user = await registerUser(req.body);
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

export const loginUserAction = async (
  req: Request,
  res: Response
): Promise<void> => {
  logger.info("🔍 Logging in user:", {
    email: req.body.email,
  });

  try {
    const user = await loginUser(req.body);

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
