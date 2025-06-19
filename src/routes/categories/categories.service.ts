import type { CATEGORY_DTO } from "@models/categories";
import { dal } from "@services/dal";
import { logger } from "@services/logger";
import { safeQuery } from "@services/query";

import { CATEGORIES_DAL } from "./categories.constant";

export const getCategoriesService = async (): Promise<CATEGORY_DTO[]> => {
  logger.info("🔍 getCategoriesService called");

  const categories = await safeQuery<CATEGORY_DTO>(
    dal[CATEGORIES_DAL.getCategories],
    []
  );

  if (!categories?.rowCount || categories.rowCount === 0) {
    logger.warn("No categories found");
    return [];
  }

  logger.info("✅ Categories retrieved successfully:", { categories });
  return categories.rows;
};
