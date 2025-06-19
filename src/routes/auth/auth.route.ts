import { validateData } from "@services/validation";
import express from "express";

import { loginUserAction } from "./actions/loginUser";
import { registerUserAction } from "./actions/registerUser";
import { loginUser, registerUser } from "./auth.validator";

const router = express.Router();

router
  .route("/auth/register")
  .post(validateData({ body: registerUser }), registerUserAction);

router
  .route("/auth/login")
  .post(validateData({ body: loginUser }), loginUserAction);

export { router };
