import { requireAuth } from "@middlewares/auth";
import { validateData } from "@services/validation";
import express from "express";

import {
  getLineChartForTripIdAction,
  getPieChartForTripIdAction,
} from "./charts.action";
import { chartQuerySchema, tripIdParams } from "./charts.validator";

const router = express.Router();

router
  .route("/charts/pie/trip/:tripId")
  .get(
    requireAuth,
    validateData({ params: tripIdParams, query: chartQuerySchema }),
    getPieChartForTripIdAction
  );

router
  .route("/charts/line/trip/:tripId")
  .get(
    requireAuth,
    validateData({ params: tripIdParams, query: chartQuerySchema }),
    getLineChartForTripIdAction
  );

export { router };
