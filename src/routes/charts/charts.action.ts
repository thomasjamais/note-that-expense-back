import type { AuthenticatedRequest } from "@middlewares/auth";
import { logger } from "@services/logger";
import type { Response } from "express";

import { CHARTS_ERRORS } from "./charts.constant";
import {
  getLineChartForTripIdService,
  getPieChartForTripIdService,
} from "./charts.service";

export const getPieChartForTripIdAction = async (
  req: AuthenticatedRequest,
  res: Response
): Promise<void> => {
  logger.info("🔍 Fetching pie chart for trip:", {
    user: req.userId,
    tripId: req.params.tripId,
    range: req.query.range,
    start: req.query.start,
    end: req.query.end,
  });
  try {
    const pieChartData = await getPieChartForTripIdService(
      req.userId!,
      req.params.tripId,
      req.query.range as "week" | "month" | "total" | "custom",
      req.query.start ? new Date(req.query.start as string) : undefined,
      req.query.end ? new Date(req.query.end as string) : undefined
    );
    logger.info("✅ Pie chart data fetched successfully:", {
      tripId: req.params.tripId,
      timestamp: new Date().toISOString(),
    });
    res.json(pieChartData);
  } catch (error) {
    logger.error("❌ Error during fetch pie chart:", {
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    res.status(500).json({ error: CHARTS_ERRORS.INTERNAL_SERVER_ERROR });
  }
};

export const getLineChartForTripIdAction = async (
  req: AuthenticatedRequest,
  res: Response
): Promise<void> => {
  logger.info("🔍 Fetching line chart for trip:", {
    user: req.userId,
    tripId: req.params.tripId,
    range: req.query.range,
    start: req.query.start,
    end: req.query.end,
  });
  try {
    const lineChartData = await getLineChartForTripIdService(
      req.userId!,
      req.params.tripId,
      req.query.range as "week" | "month" | "total" | "custom",
      req.query.start ? new Date(req.query.start as string) : undefined,
      req.query.end ? new Date(req.query.end as string) : undefined
    );
    logger.info("✅ Line chart data fetched successfully:", {
      tripId: req.params.tripId,
      timestamp: new Date().toISOString(),
    });
    res.json(lineChartData);
  } catch (error) {
    logger.error("❌ Error during fetch line chart:", {
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    res.status(500).json({ error: CHARTS_ERRORS.INTERNAL_SERVER_ERROR });
  }
};
