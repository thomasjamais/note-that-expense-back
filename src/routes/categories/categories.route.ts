import { requireAuth } from "@middlewares/auth";
import { validateData } from "@services/validation";
import express from "express";

import {
  addCategoryAction,
  deleteCategoryAction,
  getCategoriesAction,
} from "./categories.action";
import { categoryIdParams } from "./categories.validator";

const router = express.Router();
router
  .route("/categories")
  .get(requireAuth, getCategoriesAction)
  .post(requireAuth, addCategoryAction);

router
  .route("/categories/:categoryId")
  .delete(
    requireAuth,
    validateData({ params: categoryIdParams }),
    deleteCategoryAction
  );

export { router };
