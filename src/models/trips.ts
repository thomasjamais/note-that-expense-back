import type { CamelCasedProperties } from "@services/query";

export type TRIPS_DTO = {
  id: string;
  user_id: string;
  label: string;
  local_currency_id: string;
  home_currency_id: string;
  start_date: Date;
  end_date: Date | null;
  is_active: boolean;
  created_at: Date;
  updated_at: Date;
};

export type TRIPS_CAMEL_DTO = CamelCasedProperties<TRIPS_DTO>;
