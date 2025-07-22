import type { EXPENSES_CAMEL_DTO } from "@models/expenses";
import { dal } from "@services/dal";
import { logger } from "@services/logger";
import { safeQuery, safeQueryOne } from "@services/query";

import { EXPENSES_DAL, EXPENSES_ERRORS } from "./expenses.constant";

type EXPENSES_WITH_CATEGORY_DTO = EXPENSES_CAMEL_DTO & {
  categoryName: string;
  categoryColor: string;
};

export const getExpensesByTripIdService = async (
  userId: string,
  tripId: string
): Promise<EXPENSES_WITH_CATEGORY_DTO[]> => {
  logger.info("🔍 Fetching expenses for trip:", { userId, tripId });

  const expenses = await safeQuery<EXPENSES_WITH_CATEGORY_DTO>(
    dal[EXPENSES_DAL.getExpensesByTripId],
    [userId, tripId]
  );

  if (!expenses || expenses.rowCount === 0) {
    logger.warn("⚠️ No expenses found for trip:", { tripId });
    throw new Error(EXPENSES_ERRORS.EXPENSES_NOT_FOUND);
  }

  logger.info("✅ Expenses retrieved successfully for trip:", { tripId });
  return expenses.rows;
};

export const addExpenseForTripService = async (
  userId: string,
  tripId: string,
  expenseData: {
    label: string;
    originalAmount: number;
    categoryId: string;
    date: Date;
  }
): Promise<EXPENSES_CAMEL_DTO> => {
  logger.info("🔍 Adding expense for trip:", { userId, tripId, expenseData });

  const result = await safeQueryOne<EXPENSES_CAMEL_DTO>(
    dal[EXPENSES_DAL.addExpenseForTrip],
    [
      userId,
      expenseData.categoryId,
      tripId,
      expenseData.originalAmount,
      expenseData.label,
      expenseData.date,
    ]
  );

  if (!result) {
    logger.error("❌ addExpenseForTripService failed: No expense created");
    throw new Error(EXPENSES_ERRORS.INTERNAL_SERVER_ERROR);
  }

  logger.info("✅ Expense added successfully for trip:", {
    tripId,
    expense: result,
  });
  return result;
};

export const deleteExpenseForTripService = async (
  userId: string,
  tripId: string,
  expenseId: string
): Promise<void> => {
  logger.info("🔍 Deleting expense for trip:", { userId, tripId, expenseId });

  const result = await safeQueryOne(dal[EXPENSES_DAL.deleteExpenseForTrip], [
    userId,
    tripId,
    expenseId,
  ]);

  if (!result) {
    logger.warn("⚠️ No expense found to delete:", { tripId, expenseId });
    throw new Error(EXPENSES_ERRORS.EXPENSES_NOT_FOUND);
  }

  logger.info("✅ Expense deleted successfully for trip:", {
    tripId,
    expenseId,
  });

  return;
};

export const updateExpenseForTripService = async (
  userId: string,
  tripId: string,
  expenseId: string,
  expenseData: {
    label: string;
    originalAmount: number;
    categoryId: string;
    date: Date;
  }
): Promise<EXPENSES_CAMEL_DTO> => {
  logger.info("🔍 Updating expense for trip:", {
    userId,
    tripId,
    expenseId,
    expenseData,
  });

  const result = await safeQueryOne<EXPENSES_CAMEL_DTO>(
    dal[EXPENSES_DAL.updateExpenseForTrip],
    [
      expenseId,
      tripId,
      userId,
      expenseData.label,
      expenseData.originalAmount,
      expenseData.date,
      expenseData.categoryId,
    ]
  );

  if (!result) {
    logger.error("❌ updateExpenseForTripService failed: No expense updated");
    throw new Error(EXPENSES_ERRORS.INTERNAL_SERVER_ERROR);
  }

  logger.info("✅ Expense updated successfully for trip:", {
    tripId,
    expense: result,
  });
  return result;
};
