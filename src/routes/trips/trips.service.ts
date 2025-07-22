import type { TRIPS_CAMEL_DTO, TRIPS_DTO } from "@models/trips";
import { dal } from "@services/dal";
import { logger } from "@services/logger";
import { safeQuery, safeQueryOne } from "@services/query";

import { TRIPS_DAL, TRIPS_ERRORS } from "./trips.constant";
import type { AddTripBodyInput } from "./trips.validator";

export const addTripService = async (
  userId: string,
  data: AddTripBodyInput
): Promise<TRIPS_CAMEL_DTO> => {
  logger.info("🛫 addTripService called:", { userId, data });
  const result = await safeQueryOne<TRIPS_DTO>(dal[TRIPS_DAL.addTrip], [
    userId,
    data.label,
    data.localCurrencyId,
    data.homeCurrencyId,
    data.isActive,
    data.startDate,
    data.endDate || null,
  ]);
  if (!result) {
    logger.error("❌ addTripService failed: No trip created");
    throw new Error(TRIPS_ERRORS.USER_NOT_FOUND);
  }
  return result;
};

export const getUserTripsService = async (
  userId: string
): Promise<TRIPS_CAMEL_DTO[]> => {
  logger.info("🔍 getUserTripsService called:", { userId });
  const result = await safeQuery<TRIPS_CAMEL_DTO>(dal[TRIPS_DAL.getUserTrips], [
    userId,
  ]);
  if (!result || result.rowCount === 0) {
    logger.error("❌ getUserTripsService failed: No trips found");
    throw new Error(TRIPS_ERRORS.USER_NOT_FOUND);
  }
  return result.rows;
};

export const getUserActiveTripService = async (
  userId: string
): Promise<TRIPS_CAMEL_DTO> => {
  logger.info("🔍 getUserActiveTripService called:", { userId });
  const result = await safeQueryOne<TRIPS_CAMEL_DTO>(
    dal[TRIPS_DAL.getUserActiveTrip],
    [userId]
  );
  console.log("Active trip result:", result);
  if (!result) {
    logger.error("❌ getUserActiveTripService failed: No active trip found");
    throw new Error(TRIPS_ERRORS.TRIP_NOT_FOUND);
  }
  return result;
};
