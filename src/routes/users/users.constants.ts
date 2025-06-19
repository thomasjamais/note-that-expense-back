export const USERS_DAL = {
  getUserByEmail: "users/getUserByEmail",
  getUserById: "users/getUserById",
  updateUserById: "users/updateUserById",
  deleteUser: "users/deleteUser",
  getAllUsers: "users/getAllUsers",
  getUserByUsername: "users/getUserByUsername",
  getUserByEmailOrUsername: "users/getUserByEmailOrUsername",
  getUserByEmailOrUsernameWithPassword:
    "users/getUserByEmailOrUsernameWithPassword",
  getUserByEmailWithPassword: "users/getUserByEmailWithPassword",
} as const;
export type UsersDAL = typeof USERS_DAL;

export const USERS_ERRORS = {
  USER_NOT_FOUND: "User not found",
  FORBIDDEN: "Forbidden",
  UNAUTHORIZED: "Unauthorized",
  INTERNAL_SERVER_ERROR: "Internal server error",
} as const;
export type UsersErrors = typeof USERS_ERRORS;

export const USER_UPDATE_FIELDS = [
  "email",
  "firstname",
  "lastname",
  "phoneNumber",
  "addressLine1",
  "addressLine2",
  "city",
  "zipcode",
  "country",
] as const;
export type UserUpdateFields = (typeof USER_UPDATE_FIELDS)[number];
