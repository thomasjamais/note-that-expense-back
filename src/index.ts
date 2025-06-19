import dotenv from "dotenv";

import initialize from "./services/api";

dotenv.config();
// const app = express();

// const PORT = process.env.PORT;

// app.get("/", (request: Request, response: Response) => {
//   response.status(200).send("Hello World");
// });

initialize(3000, "127.0.0.1");

// app
//   .listen(PORT, () => {
//     console.log("Server running at PORT: ", PORT);
//     initialize(3000, "127.0.0.1", 50000);
//   })
//   .on("error", (error) => {
//     // gracefully handle error
//     throw new Error(error.message);
//   });
