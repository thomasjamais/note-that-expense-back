import type { CamelCasedProperties } from "@services/query";

export type CHARTS_DTO = {
  user_id: string;
  trip_id: string;
  category_id: string;
  category_label: string;
  category_color: string;
  total_amount: number;
};

export type CHARTS_CAMEL_DTO = CamelCasedProperties<CHARTS_DTO>;
