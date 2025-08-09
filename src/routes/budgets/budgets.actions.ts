import type { AuthenticatedRequest } from "@middlewares/auth";
import { logger } from "@services/logger";
import { isErrorWithMessage } from "@utils/error";
import type { Response } from "express";

import { BUDGETS_ERRORS } from "./budgets.constant";
import {
  addBudgetForTripService,
  getBudgetsByTripIdService,
  getCurrentBudgetUsageByTripIdService,
  updateBudgetByTripIdService,
} from "./budgets.service";

export const addBudgetForTripAction = async (
  req: AuthenticatedRequest,
  res: Response
): Promise<void> => {
  logger.info("🔍 Adding budget for tripId and userId", {
    tripId: req.params.tripId,
    userId: req.userId,
  });

  try {
    const budget = await addBudgetForTripService(
      req.userId!,
      req.params.tripId,
      req.body
    );
    logger.info("✅ Budget added successfully:", budget);
    res.status(201).json(budget);
  } catch (error) {
    logger.error("❌ Error while adding budget:", {
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    if (isErrorWithMessage(error, BUDGETS_ERRORS.BUDGET_TRIP_NOT_FOUND)) {
      res.status(404).json({ error: BUDGETS_ERRORS.BUDGET_TRIP_NOT_FOUND });
      return;
    }
    if (isErrorWithMessage(error, BUDGETS_ERRORS.NOT_AUTHORIZED)) {
      res.status(403).json({ error: BUDGETS_ERRORS.NOT_AUTHORIZED });
      return;
    }

    res.status(500).json({ error: BUDGETS_ERRORS.INTERNAL_SERVER_ERROR });
  }
};

export const updateBudgetByTripIdAction = async (
  req: AuthenticatedRequest,
  res: Response
): Promise<void> => {
  logger.info("🔍 Updating budget for tripId and userId", {
    tripId: req.params.tripId,
    userId: req.userId,
  });

  try {
    const updatedBudget = await updateBudgetByTripIdService(
      req.userId!,
      req.params.tripId,
      req.body
    );
    logger.info("✅ Budget updated successfully:", updatedBudget);
    res.json(updatedBudget);
  } catch (error) {
    logger.error("❌ Error while updating budget:", {
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    if (isErrorWithMessage(error, BUDGETS_ERRORS.BUDGET_NOT_FOUND)) {
      res.status(404).json({ error: BUDGETS_ERRORS.BUDGET_NOT_FOUND });
      return;
    }
    if (isErrorWithMessage(error, BUDGETS_ERRORS.NOT_AUTHORIZED)) {
      res.status(403).json({ error: BUDGETS_ERRORS.NOT_AUTHORIZED });
      return;
    }

    res.status(500).json({ error: BUDGETS_ERRORS.INTERNAL_SERVER_ERROR });
  }
};

export const getBudgetsByTripIdAction = async (
  req: AuthenticatedRequest,
  res: Response
): Promise<void> => {
  logger.info("🔍 Retrieving budgets for tripId and userId", {
    tripId: req.params.tripId,
    userId: req.userId,
  });

  try {
    const budgets = await getBudgetsByTripIdService(
      req.userId!,
      req.params.tripId
    );
    logger.info("✅ Budgets retrieved successfully:", {
      length: budgets.length,
    });
    res.json(budgets);
  } catch (error) {
    logger.error("❌ Error while retrieving budgets:", {
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    if (isErrorWithMessage(error, BUDGETS_ERRORS.BUDGET_TRIP_NOT_FOUND)) {
      res.status(404).json({ error: BUDGETS_ERRORS.BUDGET_TRIP_NOT_FOUND });
      return;
    }
    if (isErrorWithMessage(error, BUDGETS_ERRORS.NOT_AUTHORIZED)) {
      res.status(403).json({ error: BUDGETS_ERRORS.NOT_AUTHORIZED });
      return;
    }

    res.status(500).json({ error: BUDGETS_ERRORS.INTERNAL_SERVER_ERROR });
  }
};

export const getCurrentBudgetUsageByTripIdAction = async (
  req: AuthenticatedRequest,
  res: Response
): Promise<void> => {
  logger.info("🔍 Retrieving current budget usage for tripId and userId", {
    tripId: req.params.tripId,
    userId: req.userId,
  });

  try {
    const budgetUsage = await getCurrentBudgetUsageByTripIdService(
      req.userId!,
      req.params.tripId
    );
    logger.info("✅ Current budget usage retrieved successfully:", {
      budgetUsage,
    });
    res.json(budgetUsage);
  } catch (error) {
    logger.error("❌ Error while retrieving current budget usage:", {
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    if (isErrorWithMessage(error, BUDGETS_ERRORS.BUDGET_TRIP_NOT_FOUND)) {
      res.status(404).json({ error: BUDGETS_ERRORS.BUDGET_TRIP_NOT_FOUND });
      return;
    }
    if (isErrorWithMessage(error, BUDGETS_ERRORS.NOT_AUTHORIZED)) {
      res.status(403).json({ error: BUDGETS_ERRORS.NOT_AUTHORIZED });
      return;
    }

    res.status(500).json({ error: BUDGETS_ERRORS.INTERNAL_SERVER_ERROR });
  }
};
