import { z } from "zod";

const addTripBody = z.object({
  label: z.string(),
  localCurrencyId: z.string(),
  homeCurrencyId: z.string(),
  startDate: z.coerce.date(),
  endDate: z.coerce.date().optional(),
  isActive: z.boolean(),
});

const loginUser = z.object({
  email: z.string().email(),
  password: z.string().min(8, "Password must be at least 8 characters long"),
});

export { addTripBody, loginUser };
export type AddTripBodyInput = z.infer<typeof addTripBody>;
export type LoginUserInput = z.infer<typeof loginUser>;
