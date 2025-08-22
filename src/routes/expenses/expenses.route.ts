import { requireAuth } from "@middlewares/auth";
import { validateData } from "@services/validation";
import express from "express";

import {
  addExpenseForTripAction,
  deleteExpenseForTripAction,
  getExpensesByTripIdAction,
  updateExpenseForTripAction,
} from "./expenses.action";
import {
  expenseBody,
  tripIdAndExpenseIdParams,
  tripIdParams,
} from "./expenses.validator";
import {
  getDailyStatsByTripIdAction,
  getSummaryStatsByTripIdAction,
} from "./stats/stats.action";
import { dailyStatsQuery } from "./stats/stats.validator";

const router = express.Router();

router
  .route("/expenses/trip/:tripId")
  .get(
    requireAuth,
    validateData({ params: tripIdParams }),
    getExpensesByTripIdAction
  )
  .post(
    requireAuth,
    validateData({ params: tripIdParams, body: expenseBody }),
    addExpenseForTripAction
  );

router
  .route("/expenses/trip/:tripId/expenses/:expenseId")
  .delete(
    requireAuth,
    validateData({ params: tripIdAndExpenseIdParams }),
    deleteExpenseForTripAction
  )
  .patch(
    requireAuth,
    validateData({ params: tripIdAndExpenseIdParams, body: expenseBody }),
    updateExpenseForTripAction
  );

router
  .route("/expenses/trip/:tripId/stats/daily")
  .get(
    requireAuth,
    validateData({ params: tripIdParams, query: dailyStatsQuery }),
    getDailyStatsByTripIdAction
  );

router
  .route("/expenses/trip/:tripId/stats/summary")
  .get(
    requireAuth,
    validateData({ params: tripIdParams }),
    getSummaryStatsByTripIdAction
  );

export { router };
