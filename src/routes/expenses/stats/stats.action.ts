import type { AuthenticatedRequest } from "@middlewares/auth";
import { logger } from "@services/logger";
import { isErrorWithMessage } from "@utils/error";
import type { Response } from "express";

import { EXPENSES_ERRORS } from "../expenses.constant";

import { STATS_ERRORS } from "./stats.constant";
import {
  getDailyStatsByTripIdService,
  getSummaryStatsByTripIdService,
} from "./stats.service";

export const getDailyStatsByTripIdAction = async (
  req: AuthenticatedRequest,
  res: Response
): Promise<void> => {
  logger.info("🔍 Retrieving daily stats for tripId and userId", {
    tripId: req.params.tripId,
    userId: req.userId,
    day: req.query.day,
  });

  try {
    const dailyStats = await getDailyStatsByTripIdService(
      req.userId!,
      req.params.tripId,
      req.query.day ? new Date(req.query.day as string) : undefined
    );
    logger.info("✅ Trip daily stats retrieved successfully:", {
      length: dailyStats,
    });
    res.json(dailyStats);
  } catch (error) {
    logger.error("❌ Error while retrieving daily stats:", {
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    if (isErrorWithMessage(error, STATS_ERRORS.STATS_NOT_FOUND)) {
      res.status(404).json({ error: STATS_ERRORS.STATS_NOT_FOUND });
      return;
    }
    if (isErrorWithMessage(error, STATS_ERRORS.NOT_AUTHORIZED)) {
      res.status(403).json({ error: STATS_ERRORS.NOT_AUTHORIZED });
      return;
    }

    res.status(500).json({ error: EXPENSES_ERRORS.INTERNAL_SERVER_ERROR });
  }
};

export const getSummaryStatsByTripIdAction = async (
  req: AuthenticatedRequest,
  res: Response
): Promise<void> => {
  logger.info("🔍 Retrieving summary stats for tripId and userId", {
    tripId: req.params.tripId,
    userId: req.userId,
  });

  try {
    const summaryStats = await getSummaryStatsByTripIdService(
      req.userId!,
      req.params.tripId
    );
    logger.info("✅ Trip summary stats retrieved successfully:", {
      length: summaryStats,
    });
    res.json(summaryStats);
  } catch (error) {
    logger.error("❌ Error while retrieving summary stats:", {
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    if (isErrorWithMessage(error, STATS_ERRORS.STATS_NOT_FOUND)) {
      res.status(404).json({ error: STATS_ERRORS.STATS_NOT_FOUND });
      return;
    }
    if (isErrorWithMessage(error, STATS_ERRORS.NOT_AUTHORIZED)) {
      res.status(403).json({ error: STATS_ERRORS.NOT_AUTHORIZED });
      return;
    }

    res.status(500).json({ error: EXPENSES_ERRORS.INTERNAL_SERVER_ERROR });
  }
};
