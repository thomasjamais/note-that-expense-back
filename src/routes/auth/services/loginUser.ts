import type { USER_CAMEL_DTO, USER_CAMEL_DTO_WITH_TOKEN } from "@models/users";
import { dal } from "@services/dal";
import { logger } from "@services/logger";
import { safeQuery } from "@services/query";
import * as bcrypt from "bcrypt";
import jwt from "jsonwebtoken";

import { AUTH_DAL, AUTH_ERRORS } from "../auth.constant";
import type { LoginUserInput } from "../auth.validator";

const loginUserService = async (
  user: LoginUserInput
): Promise<USER_CAMEL_DTO_WITH_TOKEN> => {
  const values = [user.email];
  const result = await safeQuery<USER_CAMEL_DTO>(
    dal[AUTH_DAL.loginUser],
    values
  );

  if (!result) {
    throw new Error("Query result is null");
  }
  if (result.rowCount === 0) {
    logger.error("❌ User not found:", {
      email: user.email,
    });
    throw new Error(AUTH_ERRORS.USER_NOT_FOUND);
  }

  const valid = await bcrypt.compare(
    user.password,
    result.rows[0].passwordHash
  );
  if (!valid) {
    logger.error("❌ Invalid password for user:", {
      email: user.email,
    });
    throw new Error(AUTH_ERRORS.INVALID_PASSWORD);
  }

  const token = jwt.sign(
    { sub: result.rows[0].id },
    `${process.env.JWT_SECRET}`,
    {
      expiresIn: Number(process.env.JWT_EXPIRES_IN),
    }
  );

  return { ...result.rows[0], token };
};

export { loginUserService };
