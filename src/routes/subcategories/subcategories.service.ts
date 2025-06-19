import type { SUBGATEGORIES_DTO } from "@models/subcategories";
import { dal } from "@services/dal";
import { logger } from "@services/logger";
import { safeQuery } from "@services/query";

import {
  SUBCATEGORIES_DAL,
  SUBCATEGORIES_ERRORS,
} from "./subcategories.constant";

export const getSubcategoriesByCategoryId = async (
  categoryId: string
): Promise<SUBGATEGORIES_DTO[]> => {
  logger.info("🔍 getSubcategoriesByCategoryId called", { categoryId });

  const subcategories = await safeQuery<SUBGATEGORIES_DTO>(
    dal[SUBCATEGORIES_DAL.getSubcategoriesByCategoryId],
    [categoryId]
  );

  if (!subcategories?.rowCount || subcategories.rowCount === 0) {
    logger.warn("No subcategories found for categoryId:", { categoryId });
    throw new Error(SUBCATEGORIES_ERRORS.CATEGORY_NOT_FOUND);
  }
  logger.info("✅ Subcategories retrieved successfully:", { subcategories });
  return subcategories.rows;
};
