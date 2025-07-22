import type { CamelCasedProperties } from "@services/query";

export type USER_DTO = {
  id: string;
  email: string;
  password_hash: string;
  firstname: string;
  lastname: string;
  last_login: Date | null;
  created_at: Date;
  updated_at: Date;
};

export type USER_CAMEL_DTO = CamelCasedProperties<USER_DTO>;

export type USER_CAMEL_DTO_WITH_TOKEN = USER_CAMEL_DTO & {
  token: string;
};
