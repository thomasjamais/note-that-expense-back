export const CATEGORIES_DAL = {
  getCategories: "categories/getCategories",
  addCategory: "categories/addCategory",
  deleteCategory: "categories/deleteCategory",
};

export const CATEGORIES_ERRORS = {
  INTERNAL_SERVER_ERROR: "Internal server error",
  CATEGORY_NOT_FOUND: "Category not found",
} as const;
