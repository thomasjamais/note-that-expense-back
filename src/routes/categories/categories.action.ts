import type { AuthenticatedRequest } from "@middlewares/auth";
import { logger } from "@services/logger";
import type { Response } from "express";

import { CATEGORIES_ERRORS } from "./categories.constant";
import {
  addCategoryService,
  deleteCategoryService,
  getCategoriesService,
} from "./categories.service";

export const getCategoriesAction = async (
  req: AuthenticatedRequest,
  res: Response
): Promise<void> => {
  logger.info("🔍 Retrieving categories");

  try {
    const categories = await getCategoriesService(req.userId!);
    logger.info("✅ Categories retrieved successfully:", categories);
    res.json(categories);
  } catch (error) {
    logger.error("❌ Error while retrieving categories:", {
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    res.status(500).json({ error: CATEGORIES_ERRORS.INTERNAL_SERVER_ERROR });
  }
};

export const addCategoryAction = async (
  req: AuthenticatedRequest,
  res: Response
): Promise<void> => {
  logger.info("🔍 Adding category for user:", {
    user: req.userId,
    category: req.body,
  });

  try {
    const category = await addCategoryService(req.userId!, req.body);
    logger.info("✅ Category added successfully:", {
      id: category.id,
      timestamp: new Date().toISOString(),
    });
    res.json(category);
  } catch (error) {
    logger.error("❌ Error during add category:", {
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    res.status(500).json({ error: CATEGORIES_ERRORS.INTERNAL_SERVER_ERROR });
  }
};

export const deleteCategoryAction = async (
  req: AuthenticatedRequest,
  res: Response
): Promise<void> => {
  logger.info("🔍 Deleting category for user:", {
    user: req.userId,
    categoryId: req.params.categoryId,
  });

  try {
    await deleteCategoryService(req.userId!, req.params.categoryId);
    logger.info("✅ Category deleted successfully:", {
      id: req.params.categoryId,
      timestamp: new Date().toISOString(),
    });
    res.status(204).send();
  } catch (error) {
    logger.error("❌ Error during delete category:", {
      error: error instanceof Error ? error.message : String(error),
      stack: error instanceof Error ? error.stack : undefined,
    });

    res.status(500).json({ error: CATEGORIES_ERRORS.INTERNAL_SERVER_ERROR });
  }
};
