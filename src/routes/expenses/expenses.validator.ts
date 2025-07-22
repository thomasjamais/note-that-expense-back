import { z } from "zod";

const tripIdParams = z.object({
  tripId: z.string().min(1, "Trip ID is required"),
});

const tripIdAndExpenseIdParams = z.object({
  tripId: z.string().min(1, "Trip ID is required"),
  expenseId: z.string().min(1, "Expense ID is required"),
});

const expenseBody = z.object({
  categoryId: z.string().min(1, "Category ID is required"),
  label: z.string().min(1, "Label is required"),
  originalAmount: z
    .number()
    .min(0, "Original amount must be a positive number"),
  date: z.coerce.date().optional(),
});

export { expenseBody, tripIdAndExpenseIdParams, tripIdParams };
