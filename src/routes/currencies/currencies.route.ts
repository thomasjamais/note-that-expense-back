import express from "express";

import { getCurrenciesAction } from "./currencies.action";

const router = express.Router();

router.route("/currencies").get(getCurrenciesAction);

export { router };
