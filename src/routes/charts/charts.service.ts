/* eslint-disable @typescript-eslint/no-explicit-any */
/* eslint-disable @typescript-eslint/explicit-function-return-type */
import type { CHARTS_CAMEL_DTO, CHARTS_DTO } from "@models/charts";
import { dal } from "@services/dal";
import { logger } from "@services/logger";
import { safeQuery } from "@services/query";

import { CHARTS_DAL, CHARTS_ERRORS } from "./charts.constant";

const groupDataForStackedChart = (rows: any[]) => {
  const categories = Array.from(new Set(rows.map((r) => r.categoryLabel)));

  const uniqueDates = Array.from(
    new Set(rows.map((r) => new Date(r.day).toISOString().split("T")[0]))
  ).sort((a, b) => new Date(a).getTime() - new Date(b).getTime());

  const data = uniqueDates.map((day) => {
    return categories.map((cat) => {
      const row = rows.find(
        (r) =>
          new Date(r.day).toISOString().split("T")[0] === day &&
          r.categoryLabel === cat
      );
      return row ? parseFloat(row.total) : 0;
    });
  });

  const barColors = categories.map((cat) => {
    const colorRow = rows.find((r) => r.categoryLabel === cat);
    return colorRow?.categoryColor || "#ccc";
  });

  return {
    labels: uniqueDates.map((d) =>
      new Date(d).toLocaleDateString("fr-FR", {
        day: "2-digit",
        month: "2-digit",
      })
    ),
    legend: categories,
    data,
    barColors,
  };
};

export const getPieChartForTripIdService = async (
  userId: string,
  tripId: string,
  range: "week" | "month" | "total" | "custom",
  start?: Date,
  end?: Date
): Promise<CHARTS_CAMEL_DTO[]> => {
  logger.info("🔍 Fetching pie chart for trip:", { userId, tripId });

  const pieChartData = await safeQuery<CHARTS_DTO>(
    dal[CHARTS_DAL.getPieChartForTripId],
    [userId, tripId, range, start, end]
  );

  if (!pieChartData || pieChartData.rowCount === 0) {
    logger.warn("⚠️ No pie chart data found for trip:", { tripId });
    throw new Error(CHARTS_ERRORS.CHARTS_NOT_FOUND);
  }

  logger.info("✅ Pie chart data retrieved successfully for trip:", { tripId });
  return pieChartData.rows;
};

export const getLineChartForTripIdService = async (
  userId: string,
  tripId: string,
  range: "week" | "month" | "total" | "custom",
  start?: Date,
  end?: Date
): Promise<any> => {
  logger.info("🔍 Fetching line chart for trip:", { userId, tripId });

  const lineChartData = await safeQuery<any>(
    dal[CHARTS_DAL.getLineChartForTripId],
    [userId, tripId, range, start, end]
  );

  if (!lineChartData || lineChartData.rowCount === 0) {
    logger.warn("⚠️ No line chart data found for trip:", { tripId });
    throw new Error(CHARTS_ERRORS.CHARTS_NOT_FOUND);
  }

  const formatedData = groupDataForStackedChart(lineChartData.rows);

  console.log(formatedData, "Formatted Line Chart Data");

  logger.info("✅ Line chart data retrieved successfully for trip:", {
    tripId,
  });
  return formatedData;
};
