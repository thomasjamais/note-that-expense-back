import { requireAuth } from "@middlewares/auth";
import { validateData } from "@services/validation";
import express from "express";

import {
  addTripAction,
  deleteTripByIdAction,
  getUserActiveTripAction,
  getUserTripsAction,
  updateTripByIdAction,
} from "./trips.action";
import { addTripBody, tripIdParam } from "./trips.validator";

const router = express.Router();

router
  .route("/trips")
  .post(requireAuth, validateData({ body: addTripBody }), addTripAction);

router
  .route("/trips/:tripId")
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

router.route("/trips/list").get(requireAuth, getUserTripsAction);

router.route("/trips/active").get(requireAuth, getUserActiveTripAction);

export { router };
