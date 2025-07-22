import type { AuthenticatedRequest } from "@middlewares/auth";
import { logger } from "@services/logger";
import { isErrorWithMessage } from "@utils/error";
import type { Response } from "express";

import { CURRENCIES_ERRORS } from "./currencies.constants";
import { getCurrenciesService } from "./currencies.service";

export const getCurrenciesAction = async (
  req: AuthenticatedRequest,
  res: Response
): Promise<void> => {
  logger.info("🔍 Requesting getCurrenciesAction:");

  try {
    const currencies = await getCurrenciesService();

    logger.info("✅ Currencies retrieved successfully:", {
      currencies,
    });

    res.json(currencies);
  } catch (error) {
    logger.error("❌ Error during get currencies:", {
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    if (isErrorWithMessage(error, CURRENCIES_ERRORS.CURRENCIES_NOT_FOUND)) {
      res.status(404).json({ error: CURRENCIES_ERRORS.CURRENCIES_NOT_FOUND });
      return;
    }
    if (isErrorWithMessage(error, CURRENCIES_ERRORS.UNAUTHORIZED)) {
      res.status(401).json({ error: CURRENCIES_ERRORS.UNAUTHORIZED });
      return;
    }

    res.status(500).json({ error: CURRENCIES_ERRORS.INTERNAL_SERVER_ERROR });
  }
};
