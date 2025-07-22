import { z } from "zod";

const tripIdParams = z.object({
  tripId: z.string().min(1, "Trip ID is required"),
});

const chartQuerySchema = z
  .object({
    range: z.enum(["week", "month", "total", "custom"]).default("week"),
    start: z.string().optional(),
    end: z.string().optional(),
  })
  .refine((data) => data.range !== "custom" || (data.start && data.end), {
    message: "Start and end dates are required when range is custom",
    path: ["start"],
  });

export { chartQuerySchema, tripIdParams };
