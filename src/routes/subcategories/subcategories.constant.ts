export const SUBCATEGORIES_DAL = {
  getSubcategoriesByCategoryId: "subcategories/getSubcategoriesByCategoryId",
};

export const SUBCATEGORIES_ERRORS = {
  CATEGORY_NOT_FOUND: "Category not found",
  INTERNAL_SERVER_ERROR: "Internal server error",
} as const;
export type SubcategoriesErrors = typeof SUBCATEGORIES_ERRORS;
