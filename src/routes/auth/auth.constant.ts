export const AUTH_DAL = {
  registerUser: "auth/registerUser",
  loginUser: "auth/loginUser",
  getUserByEmail: "auth/getUserByEmail",
  getUserById: "auth/getUserById",
  updateUser: "auth/updateUser",
  deleteUser: "auth/deleteUser",
  getAllUsers: "auth/getAllUsers",
  getUserByUsername: "auth/getUserByUsername",
  getUserByEmailOrUsername: "auth/getUserByEmailOrUsername",
  getUserByEmailOrUsernameWithPassword:
    "auth/getUserByEmailOrUsernameWithPassword",
  getUserByEmailWithPassword: "auth/getUserByEmailWithPassword",
} as const;
export type AuthDAL = typeof AUTH_DAL;

export const AUTH_ERRORS = {
  USER_NOT_FOUND: "User not found",
  INVALID_CREDENTIALS: "Invalid credentials",
  USER_ALREADY_EXISTS: "User already exists",
  USERNAME_ALREADY_EXISTS: "Username already exists",
  INVALID_PASSWORD: "Invalid password",
  PASSWORD_MISMATCH: "Passwords do not match",
  UNAUTHORIZED: "Unauthorized",
  FORBIDDEN: "Forbidden",
  INTERNAL_SERVER_ERROR: "Internal server error",
} as const;
export type AuthErrors = typeof AUTH_ERRORS;
