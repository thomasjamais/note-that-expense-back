import { requireAuth } from "@middlewares/auth";
import { validateData } from "@services/validation";
import express from "express";

import {
  addBudgetForTripAction,
  getBudgetsByTripIdAction,
  getCurrentBudgetUsageByTripIdAction,
  updateBudgetByTripIdAction,
} from "./budgets.actions";
import { budgetBody, tripIdParams } from "./budgets.validator";

const router = express.Router();

router
  .route("/budgets/trip/:tripId")
  .get(
    requireAuth,
    validateData({ params: tripIdParams }),
    getBudgetsByTripIdAction
  )
  .post(
    requireAuth,
    validateData({ params: tripIdParams, body: budgetBody }),
    addBudgetForTripAction
  )
  .patch(
    requireAuth,
    validateData({ params: tripIdParams, body: budgetBody }),
    updateBudgetByTripIdAction
  );

router
  .route("/budgets/trip/:tripId/usage")
  .get(
    requireAuth,
    validateData({ params: tripIdParams }),
    getCurrentBudgetUsageByTripIdAction
  );

export { router };
