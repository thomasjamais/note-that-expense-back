import type { CATEGORY_CAMEL_DTO, CATEGORY_DTO } from "@models/categories";
import { dal } from "@services/dal";
import { logger } from "@services/logger";
import { safeQuery, safeQueryOne } from "@services/query";

import { CATEGORIES_DAL, CATEGORIES_ERRORS } from "./categories.constant";

export const getCategoriesService = async (
  userId: string
): Promise<CATEGORY_CAMEL_DTO[]> => {
  logger.info("🔍 getCategoriesService called for user", { userId });

  const categories = await safeQuery<CATEGORY_CAMEL_DTO>(
    dal[CATEGORIES_DAL.getCategories],
    [userId]
  );

  if (!categories?.rowCount || categories.rowCount === 0) {
    logger.warn("No categories found");
    return [];
  }

  logger.info("✅ Categories retrieved successfully:", { categories });
  return categories.rows;
};

export const addCategoryService = async (
  userId: string,
  categoryData: { label: string; color: string }
): Promise<CATEGORY_CAMEL_DTO> => {
  logger.info("🔍 addCategoryService called:", { userId, categoryData });

  const result = await safeQueryOne<CATEGORY_DTO>(
    dal[CATEGORIES_DAL.addCategory],
    [userId, categoryData.label, categoryData.color]
  );

  if (!result) {
    logger.error("❌ addCategoryService failed: No category created");
    throw new Error(CATEGORIES_ERRORS.INTERNAL_SERVER_ERROR);
  }

  logger.info("✅ Category added successfully:", { category: result });
  return result;
};

export const deleteCategoryService = async (
  userId: string,
  categoryId: string
): Promise<void> => {
  logger.info("🔍 deleteCategoryService called:", { userId, categoryId });

  const result = await safeQueryOne(dal[CATEGORIES_DAL.deleteCategory], [
    categoryId,
    userId,
  ]);

  if (!result) {
    logger.error("❌ deleteCategoryService failed: No category deleted");
    throw new Error(CATEGORIES_ERRORS.CATEGORY_NOT_FOUND);
  }

  logger.info("✅ Category deleted successfully:", { categoryId });
};
