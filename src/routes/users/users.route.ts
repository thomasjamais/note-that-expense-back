import { requireAuth } from "@middlewares/auth";
import { validateData } from "@services/validation";
import express from "express";

import { getUserByIdAction, updateUserByIdAction } from "./users.action";
import { getUserById, updateUserBody } from "./users.validator";

const router = express.Router();

router
  .route("/users/:id")
  .get(requireAuth, validateData({ params: getUserById }), getUserByIdAction)
  .patch(
    requireAuth,
    validateData({ params: getUserById, body: updateUserBody }),
    updateUserByIdAction
  );

export { router };
