import type { CamelCasedProperties } from "@services/query";

export type BUDGETS_DTO = {
  id: string;
  trip_id: string;
  name: string;
  amount: string;
  currency_id: string;
  scope: "total" | "monthly";
  start_date?: Date;
  end_date?: Date;
  created_at: Date;
  updated_at: Date;
};

export type BUDGETS_CAMEL_DTO = CamelCasedProperties<BUDGETS_DTO>;
