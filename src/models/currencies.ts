import type { CamelCasedProperties } from "@services/query";

export type CURRENCIES_DTO = {
  id: string;
  code: string;
  symbol: string;
  name: string;
  created_at: Date;
  updated_at: Date;
};

export type CURRENCIES_CAMEL_DTO = CamelCasedProperties<CURRENCIES_DTO>;
