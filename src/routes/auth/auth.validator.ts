import { z } from "zod";

const registerUser = z.object({
  email: z.string().email(),
  password: z.string().min(8, "Password must be at least 8 characters long"),
  confirmPassword: z
    .string()
    .min(8, "Confirm password must be at least 8 characters long"),
});

const loginUser = z.object({
  email: z.string().email(),
  password: z.string().min(8, "Password must be at least 8 characters long"),
});

export { registerUser, loginUser };
export type RegisterUserInput = z.infer<typeof registerUser>;
export type LoginUserInput = z.infer<typeof loginUser>;
