import { z } from "zod";

const getUserById = z.object({
  id: z.string(),
});

const updateUserBody = z.object({
  email: z.string().email().optional(),
  firstname: z.string().min(1).max(50).optional(),
  lastname: z.string().min(1).max(50).optional(),
  phoneNumber: z.string().optional(),
  address_line1: z.string().min(1).max(255).optional(),
  address_line2: z.string().max(255).optional(),
  city: z.string().min(1).max(100).optional(),
  zipcode: z.string().min(1).max(20).optional(),
  country: z.string().min(1).max(100).optional(),
});

export { getUserById, updateUserBody };
export type GetUserByIdInput = z.infer<typeof getUserById>;
export type UpdateUserBodyInput = z.infer<typeof updateUserBody>;
