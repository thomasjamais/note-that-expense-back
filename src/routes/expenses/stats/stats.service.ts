import type {
  DAILY_STATS_CAMEL_DTO,
  DAILY_STATS_DTO,
  TRIP_STATS_CAMEL_DTO,
  TRIP_STATS_DTO,
} from "@models/stats";
import type { TRIPS_DTO } from "@models/trips";
import { TRIPS_DAL } from "@routes/trips/trips.constant";
import { dal } from "@services/dal";
import { logger } from "@services/logger";
import { safeQueryOne } from "@services/query";

import { STATS_DAL, STATS_ERRORS } from "./stats.constant";

export const getDailyStatsByTripIdService = async (
  userId: string,
  tripId: string,
  customDate?: Date
): Promise<DAILY_STATS_CAMEL_DTO> => {
  logger.info("🔍 Fetching daily stats for tripId:", {
    tripId,
    userId,
    customDate,
  });

  const trip = await safeQueryOne<TRIPS_DTO>(dal[TRIPS_DAL.getTripById], [
    tripId,
  ]);

  if (!trip || trip.userId !== userId) {
    logger.error(
      "User try to fetch a trip that doesn't exist or doesn't belong to this user"
    );
    throw new Error(STATS_ERRORS.NOT_AUTHORIZED);
  }

  const dailyStats = await safeQueryOne<DAILY_STATS_DTO>(
    dal[STATS_DAL.getDailyStatsByTripId],
    [tripId, customDate || new Date()]
  );

  if (!dailyStats) {
    logger.warn("⚠️ No daily stats found for trip:", {
      tripId,
      userId,
      customDate,
    });
    throw new Error(STATS_ERRORS.STATS_NOT_FOUND);
  }

  return dailyStats;
};

export const getSummaryStatsByTripIdService = async (
  userId: string,
  tripId: string,
  startDate?: Date,
  endDate?: Date
): Promise<TRIP_STATS_CAMEL_DTO> => {
  logger.info("🔍 Fetching summary stats for tripId:", {
    tripId,
    userId,
    startDate,
    endDate,
  });

  const trip = await safeQueryOne<TRIPS_DTO>(dal[TRIPS_DAL.getTripById], [
    tripId,
  ]);

  if (!trip || trip.userId !== userId) {
    logger.error(
      "User try to fetch a trip that doesn't exist or doesn't belong to this user"
    );
    throw new Error(STATS_ERRORS.NOT_AUTHORIZED);
  }

  // Pour l'instant, utiliser les stats globales du voyage
  const summaryStats = await safeQueryOne<TRIP_STATS_DTO>(
    dal[STATS_DAL.getSummaryStatsByTripId],
    [tripId]
  );

  if (!summaryStats) {
    logger.warn("⚠️ No summary stats found for trip:", { tripId, userId });
    throw new Error(STATS_ERRORS.STATS_NOT_FOUND);
  }

  return summaryStats;
};
