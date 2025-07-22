export const EXPENSES_ERRORS = {
  EXPENSES_NOT_FOUND: "EXPENSES_NOT_FOUND",
  UNAUTHORIZED: "UNAUTHORIZED",
  INTERNAL_SERVER_ERROR: "INTERNAL_SERVER_ERROR",
} as const;

export const EXPENSES_DAL = {
  getExpensesByTripId: "expenses/getExpensesByTripId",
  addExpenseForTrip: "expenses/addExpenseForTrip",
  deleteExpenseForTrip: "expenses/deleteExpenseForTrip",
  updateExpenseForTrip: "expenses/updateExpenseForTrip",
} as const;
