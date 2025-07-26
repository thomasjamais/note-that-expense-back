import { z } from "zod";

const addTripBody = z.object({
  label: z.string(),
  localCurrencyId: z.string(),
  homeCurrencyId: z.string(),
  startDate: z.coerce.date(),
  endDate: z.coerce.date().optional(),
  isActive: z.boolean(),
});

const tripIdParam = z.object({
  tripId: z.string(),
});

export { addTripBody, tripIdParam };
export type AddTripBodyInput = z.infer<typeof addTripBody>;
export type TripIdParamInput = z.infer<typeof tripIdParam>;
