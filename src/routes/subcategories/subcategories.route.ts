import { validateData } from "@services/validation";
import express from "express";

import { getSubcategoriesAction } from "./subcategories.action";
import { getSubcategoriesByCategoryIdParams } from "./subcategories.validator";

const router = express.Router();
router.route("/subcategories/:categoryId").get(
  validateData({
    params: getSubcategoriesByCategoryIdParams,
  }),
  getSubcategoriesAction
);

export { router };
