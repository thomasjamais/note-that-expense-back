import { z } from "zod";

const dailyStatsQuery = z.object({
  day: z.string().optional(),
});

export { dailyStatsQuery };
