export const BUDGETS_DAL = {
  getBudgetsByTripId: "budgets/getBudgetsByTripId",
  addBudgetForTrip: "budgets/addBudgetForTrip",
  updateBudgetById: "budgets/updateBudgetById",
  deleteBudgetById: "budgets/deleteBudgetById",
  getCurrentBudgetUsageByTripId: "budgets/getCurrentBudgetUsageByTripId",
  updateBudgetByTripId: "budgets/updateBudgetByTripId",
};

export const BUDGETS_ERRORS = {
  INTERNAL_SERVER_ERROR: "INTERNAL_SERVER_ERROR",
  BUDGET_NOT_FOUND: "BUDGET_NOT_FOUND",
  BUDGET_TRIP_NOT_FOUND: "BUDGET_TRIP_NOT_FOUND",
  NOT_AUTHORIZED: "NOT_AUTHORIZED",
};
