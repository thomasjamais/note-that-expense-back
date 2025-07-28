import type { AuthenticatedRequest } from "@middlewares/auth";
import { logger } from "@services/logger";
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

    res.status(500).json({ error: CURRENCIES_ERRORS.INTERNAL_SERVER_ERROR });
  }
};
