import type { CamelCasedProperties } from "@services/query";

export type EXPENSES_DTO = {
  id: string;
  user_id: string;
  category_id: string;
  trip_id: string;
  original_amount: number;
  converted_amount: number;
  label: string;
  date: Date;
  created_at: Date;
  updated_at: Date;
};

export type EXPENSES_CAMEL_DTO = CamelCasedProperties<EXPENSES_DTO>;
