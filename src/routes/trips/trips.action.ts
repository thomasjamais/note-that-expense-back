import type { AuthenticatedRequest } from "@middlewares/auth";
import { logger } from "@services/logger";
import { isErrorWithMessage } from "@utils/error";
import type { Response } from "express";

import { TRIPS_ERRORS } from "./trips.constant";
import {
  addTripService,
  getUserActiveTripService,
  getUserTripsService,
} from "./trips.service";

export const addTripAction = async (
  req: AuthenticatedRequest,
  res: Response
): Promise<void> => {
  logger.info("🔍 Add trip for user:", {
    user: req.userId,
    trip: req.body,
  });

  try {
    const user = await addTripService(req.userId!, req.body);

    logger.info("✅ Trip added successfully:", {
      id: user.id,
      timestamp: new Date().toISOString(),
    });

    res.json(user);
  } catch (error) {
    logger.error("❌ Error during add trip:", {
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    if (isErrorWithMessage(error, TRIPS_ERRORS.TRIP_NOT_FOUND)) {
      res.status(404).json({ error: TRIPS_ERRORS.TRIP_NOT_FOUND });
      return;
    }
    if (isErrorWithMessage(error, TRIPS_ERRORS.UNAUTHORIZED)) {
      res.status(401).json({ error: TRIPS_ERRORS.UNAUTHORIZED });
      return;
    }

    res.status(500).json({ error: TRIPS_ERRORS.INTERNAL_SERVER_ERROR });
  }
};

export const getUserTripsAction = async (
  req: AuthenticatedRequest,
  res: Response
): Promise<void> => {
  logger.info("🔍 Fetching trips for user:", {
    user: req.userId,
  });

  try {
    const trips = await getUserTripsService(req.userId!);

    logger.info("✅ Trips fetched successfully:", {
      count: trips.length,
      timestamp: new Date().toISOString(),
    });

    res.json(trips);
  } catch (error) {
    logger.error("❌ Error during fetching trips:", {
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    if (isErrorWithMessage(error, TRIPS_ERRORS.USER_NOT_FOUND)) {
      res.status(404).json({ error: TRIPS_ERRORS.USER_NOT_FOUND });
      return;
    }

    res.status(500).json({ error: TRIPS_ERRORS.INTERNAL_SERVER_ERROR });
  }
};

export const getUserActiveTripAction = async (
  req: AuthenticatedRequest,
  res: Response
): Promise<void> => {
  logger.info("🔍 Fetching active trip for user:", {
    user: req.userId,
  });

  try {
    const trip = await getUserActiveTripService(req.userId!);

    logger.info("✅ Active trip fetched successfully:", {
      id: trip.id,
      timestamp: new Date().toISOString(),
    });

    res.json(trip);
  } catch (error) {
    logger.error("❌ Error during fetching active trip:", {
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    if (isErrorWithMessage(error, TRIPS_ERRORS.USER_NOT_FOUND)) {
      res.status(404).json({ error: TRIPS_ERRORS.USER_NOT_FOUND });
      return;
    }

    res.status(500).json({ error: TRIPS_ERRORS.INTERNAL_SERVER_ERROR });
  }
};
