import { z } from "zod";

const getSubcategoriesByCategoryIdParams = z.object({
  categoryId: z.string().uuid(),
});

export { getSubcategoriesByCategoryIdParams };
