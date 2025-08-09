import { z } from "zod";

const tripIdParams = z.object({
  tripId: z.string().uuid(),
});

const budgetBody = z.object({
  name: z.string(),
  amount: z.number().positive(),
  scope: z.enum(["total", "monthly"]),
});

export { budgetBody, tripIdParams };
