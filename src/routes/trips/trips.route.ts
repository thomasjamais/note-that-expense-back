import { requireAuth } from "@middlewares/auth";
import { validateData } from "@services/validation";
import express from "express";

import {
  addTripAction,
  getUserActiveTripAction,
  getUserTripsAction,
} from "./trips.action";
import { addTripBody } from "./trips.validator";

const router = express.Router();

router
  .route("/trips")
  .post(requireAuth, validateData({ body: addTripBody }), addTripAction);

router.route("/trips/list").get(requireAuth, getUserTripsAction);

router.route("/trips/active").get(requireAuth, getUserActiveTripAction);

export { router };
