import type { CamelCasedProperties } from "@services/query";

export type CATEGORY_DTO = {
  id: string;
  user_id: string;
  label: string;
  color: string;
  created_at: Date;
  updated_at: Date;
};

export type CATEGORY_CAMEL_DTO = CamelCasedProperties<CATEGORY_DTO>;
