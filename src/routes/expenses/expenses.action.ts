import type { AuthenticatedRequest } from "@middlewares/auth";
import { logger } from "@services/logger";
import { isErrorWithCode, isErrorWithMessage } from "@utils/error";
import type { Response } from "express";

import { EXPENSES_ERRORS } from "./expenses.constant";
import {
  addExpenseForTripService,
  deleteExpenseForTripService,
  getExpensesByTripIdService,
  updateExpenseForTripService,
} from "./expenses.service";

export const getExpensesByTripIdAction = async (
  req: AuthenticatedRequest,
  res: Response
): Promise<void> => {
  logger.info("🔍 Retrieving expenses");

  try {
    const expenses = await getExpensesByTripIdService(
      req.userId!,
      req.params.tripId
    );
    logger.info("✅ Expenses retrieved successfully:", {
      length: expenses.length,
    });
    res.json(expenses);
  } catch (error) {
    logger.error("❌ Error while retrieving expenses:", {
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    res.status(500).json({ error: EXPENSES_ERRORS.INTERNAL_SERVER_ERROR });
  }
};

export const addExpenseForTripAction = async (
  req: AuthenticatedRequest,
  res: Response
): Promise<void> => {
  logger.info("🔍 Adding expense for trip:", {
    user: req.userId,
    tripId: req.params.tripId,
    expense: req.body,
  });
  try {
    const expense = await addExpenseForTripService(
      req.userId!,
      req.params.tripId,
      req.body
    );
    logger.info("✅ Expense added successfully:", {
      id: expense.id,
      timestamp: new Date().toISOString(),
    });
    res.json(expense);
  } catch (error) {
    logger.error("❌ Error during add expense:", {
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    res.status(500).json({ error: EXPENSES_ERRORS.INTERNAL_SERVER_ERROR });
  }
};

export const deleteExpenseForTripAction = async (
  req: AuthenticatedRequest,
  res: Response
): Promise<void> => {
  logger.info("🔍 Deleting expense for trip:", {
    user: req.userId,
    tripId: req.params.tripId,
    expenseId: req.params.expenseId,
  });
  try {
    await deleteExpenseForTripService(
      req.userId!,
      req.params.tripId,
      req.params.expenseId
    );
    logger.info("✅ Expense deleted successfully:", {
      tripId: req.params.tripId,
      expenseId: req.params.expenseId,
      timestamp: new Date().toISOString(),
    });
    res.status(204).send();
  } catch (error) {
    logger.error("❌ Error during delete expense:", {
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    if (isErrorWithMessage(error, EXPENSES_ERRORS.EXPENSES_NOT_FOUND)) {
      res.status(404).json({ error: EXPENSES_ERRORS.EXPENSES_NOT_FOUND });
      return;
    }
    if (isErrorWithCode(error, EXPENSES_ERRORS.UNAUTHORIZED)) {
      res.status(403).json({ error: EXPENSES_ERRORS.UNAUTHORIZED });
      return;
    }

    res.status(500).json({ error: EXPENSES_ERRORS.INTERNAL_SERVER_ERROR });
  }
};

export const updateExpenseForTripAction = async (
  req: AuthenticatedRequest,
  res: Response
): Promise<void> => {
  logger.info("🔍 Updating expense for trip:", {
    user: req.userId,
    tripId: req.params.tripId,
    id: req.params.expenseId,
    expense: req.body,
  });
  try {
    const updatedExpense = await updateExpenseForTripService(
      req.userId!,
      req.params.tripId,
      req.params.expenseId,
      { ...req.body }
    );
    logger.info("✅ Expense updated successfully:", {
      id: updatedExpense.id,
      timestamp: new Date().toISOString(),
    });
    res.json(updatedExpense);
  } catch (error) {
    logger.error("❌ Error during update expense:", {
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    if (isErrorWithMessage(error, EXPENSES_ERRORS.EXPENSES_NOT_FOUND)) {
      res.status(404).json({ error: EXPENSES_ERRORS.EXPENSES_NOT_FOUND });
      return;
    }
    if (isErrorWithCode(error, EXPENSES_ERRORS.UNAUTHORIZED)) {
      res.status(403).json({ error: EXPENSES_ERRORS.UNAUTHORIZED });
      return;
    }

    res.status(500).json({ error: EXPENSES_ERRORS.INTERNAL_SERVER_ERROR });
  }
};
