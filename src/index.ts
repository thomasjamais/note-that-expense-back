import dotenv from "dotenv";

import initialize from "./services/api";

dotenv.config();

initialize(3000, "0.0.0.0");
