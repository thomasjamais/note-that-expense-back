import express from "express";

import { getCategoriesAction } from "./categories.action";

const router = express.Router();
router.route("/categories").get(getCategoriesAction);

export { router };
