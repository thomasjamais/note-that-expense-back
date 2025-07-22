import type { CURRENCIES_CAMEL_DTO } from "@models/currencies";
import { dal } from "@services/dal";
import { logger } from "@services/logger";
import { safeQuery } from "@services/query";

import { CURRENCIES_DAL } from "./currencies.constants";

export const getCurrenciesService = async (): Promise<
  CURRENCIES_CAMEL_DTO[]
> => {
  logger.info("🛫 getCurrenciesService called");
  const result = await safeQuery<CURRENCIES_CAMEL_DTO>(
    dal[CURRENCIES_DAL.getCurrencies],
    []
  );
  if (!result?.rowCount) {
    logger.warn("❌ getCurrenciesService failed");
    return [];
  }
  return result.rows;
};
