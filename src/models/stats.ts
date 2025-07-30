import type { CamelCasedProperties } from "@services/query";

export type DAILY_STATS_DTO = {
  trip_id: string;
  day: Date;
  expense_count: number;
  total_spent_original: number;
  total_spent_converted: number;
  avg_spent_original: number;
  avg_spent_converted: number;
  max_spent_original: number;
  max_spent_converted: number;
  top_category: string;
};

export type DAILY_STATS_CAMEL_DTO = CamelCasedProperties<DAILY_STATS_DTO>;

export type TRIP_STATS_DTO = {
  trip_id: string;
  day_count: number;
  total_spent_original: number;
  total_spent_converted: number;
  avg_daily_spent_original: number;
  avg_daily_spent_converted: number;
  max_daily_spent_original: number;
  max_daily_spent_converted: number;
};

export type TRIP_STATS_CAMEL_DTO = CamelCasedProperties<TRIP_STATS_DTO>;
