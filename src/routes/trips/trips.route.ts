import { requireAuth } from "@middlewares/auth";
import { validateData } from "@services/validation";
import express from "express";

import {
  addTripAction,
  deleteTripByIdAction,
  getTripByIdAction,
  getUserActiveTripAction,
  getUserTripsAction,
  updateTripByIdAction,
} from "./trips.action";
import { addTripBody, tripIdParam } from "./trips.validator";

const router = express.Router();

router
  .route("/trips")
  .post(requireAuth, validateData({ body: addTripBody }), addTripAction)
  .get(requireAuth, getUserTripsAction);

router.route("/trips/active").get(requireAuth, getUserActiveTripAction);

router
  .route("/trips/:tripId")
  .get(requireAuth, validateData({ params: tripIdParam }), getTripByIdAction)
  .patch(
    requireAuth,
    validateData({ body: addTripBody, params: tripIdParam }),
    updateTripByIdAction
  )
  .delete(
    requireAuth,
    validateData({ params: tripIdParam }),
    deleteTripByIdAction
  );

export { router };
