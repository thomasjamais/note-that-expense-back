import type { BUDGETS_CAMEL_DTO, BUDGETS_DTO } from "@models/budgets";
import { getTripByIdService } from "@routes/trips/trips.service";
import { dal } from "@services/dal";
import { logger } from "@services/logger";
import { safeQuery, safeQueryOne } from "@services/query";

import { BUDGETS_DAL, BUDGETS_ERRORS } from "./budgets.constant";

export const addBudgetForTripService = async (
  userId: string,
  tripId: string,
  budgetData: {
    name: string;
    amount: number;
    scope?: string;
  }
): Promise<BUDGETS_CAMEL_DTO> => {
  logger.info("🔍 Adding budget for tripId:", { tripId, userId, budgetData });

  const trip = await getTripByIdService(tripId);

  if (!trip || trip.userId !== userId) {
    logger.error(
      "User tried to add a budget for a trip that doesn't exist or doesn't belong to this user"
    );
    throw new Error(BUDGETS_ERRORS.NOT_AUTHORIZED);
  }

  const result = await safeQueryOne<BUDGETS_CAMEL_DTO>(
    dal[BUDGETS_DAL.addBudgetForTrip],
    [
      tripId,
      budgetData.name,
      budgetData.amount,
      trip.homeCurrencyId,
      budgetData.scope,
    ]
  );

  if (!result) {
    logger.error("❌ addBudgetForTripService failed: No budget created");
    throw new Error(BUDGETS_ERRORS.INTERNAL_SERVER_ERROR);
  }

  logger.info("✅ Budget added successfully:", { budget: result });
  return result;
};

export const updateBudgetByTripIdService = async (
  userId: string,
  tripId: string,
  budgetData: {
    name: string;
    amount: number;
    scope?: string;
  }
): Promise<BUDGETS_CAMEL_DTO> => {
  logger.info("🔍 Updating budget for tripId:", {
    tripId,
    userId,
    budgetData,
  });

  const trip = await getTripByIdService(tripId);
  if (!trip || trip.userId !== userId) {
    logger.error(
      "User tried to update a budget for a trip that doesn't exist or doesn't belong to this user"
    );
    throw new Error(BUDGETS_ERRORS.NOT_AUTHORIZED);
  }

  const result = await safeQueryOne<BUDGETS_CAMEL_DTO>(
    dal[BUDGETS_DAL.updateBudgetByTripId],
    [tripId, budgetData.name, budgetData.amount, budgetData.scope]
  );

  if (!result) {
    logger.error("❌ updateBudgetByTripIdService failed: No budget updated");
    throw new Error(BUDGETS_ERRORS.INTERNAL_SERVER_ERROR);
  }

  logger.info("✅ Budget updated successfully:", { budget: result });
  return result;
};

export const getBudgetsByTripIdService = async (
  userId: string,
  tripId: string
): Promise<BUDGETS_CAMEL_DTO[]> => {
  logger.info("🔍 Retrieving budgets for tripId:", { tripId, userId });
  const trip = await getTripByIdService(tripId);
  if (!trip || trip.userId !== userId) {
    logger.error(
      "User tried to fetch budgets for a trip that doesn't exist or doesn't belong to this user"
    );
    throw new Error(BUDGETS_ERRORS.NOT_AUTHORIZED);
  }

  const budgets = await safeQuery<BUDGETS_DTO>(
    dal[BUDGETS_DAL.getBudgetsByTripId],
    [tripId]
  );

  if (!budgets || budgets.rowCount === 0) {
    logger.warn("⚠️ No budgets found for trip:", { tripId, userId });
    return [];
  }

  logger.info("✅ Budgets retrieved successfully:", {
    length: budgets.rowCount,
  });
  return budgets.rows;
};

export const getCurrentBudgetUsageByTripIdService = async (
  userId: string,
  tripId: string
): Promise<BUDGETS_CAMEL_DTO> => {
  logger.info("🔍 Retrieving current budget usage for tripId:", {
    tripId,
    userId,
  });
  const trip = await getTripByIdService(tripId);
  if (!trip || trip.userId !== userId) {
    logger.error(
      "User tried to fetch current budget usage for a trip that doesn't exist or doesn't belong to this user"
    );
    throw new Error(BUDGETS_ERRORS.NOT_AUTHORIZED);
  }

  const budgets = await safeQueryOne<BUDGETS_DTO>(
    dal[BUDGETS_DAL.getCurrentBudgetUsageByTripId],
    [tripId]
  );

  if (!budgets) {
    logger.warn("⚠️ No current budget usage found for trip:", {
      tripId,
      userId,
    });
    throw new Error(BUDGETS_ERRORS.BUDGET_TRIP_NOT_FOUND);
  }

  logger.info("✅ Current budget usage retrieved successfully:", {
    budgets,
  });
  return budgets;
};
