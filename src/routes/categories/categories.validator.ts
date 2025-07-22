import { z } from "zod";

const categoryIdParams = z.object({
  categoryId: z.string().min(1, "Product ID is required"),
});

export { categoryIdParams };
