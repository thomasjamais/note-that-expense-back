// src/middleware/validationMiddleware.ts
import type { Request, Response, NextFunction } from "express";
import { StatusCodes } from "http-status-codes";
import type { z, ZodIssue } from "zod";
import { ZodError } from "zod";

type ValidationSchema = {
  body?: z.ZodObject<z.ZodRawShape, z.UnknownKeysParam>;
  query?: z.ZodObject<z.ZodRawShape, z.UnknownKeysParam>;
  params?: z.ZodObject<z.ZodRawShape, z.UnknownKeysParam>;
};

export function validateData(schema: ValidationSchema) {
  return (req: Request, res: Response, next: NextFunction) => {
    try {
      schema.body && schema.body.parse(req.body);
      schema.query && schema.query.parse(req.query);
      schema.params && schema.params.parse(req.params);
      next();
    } catch (error) {
      if (error instanceof ZodError) {
        const errorMessages = error.errors.map((issue: unknown) => {
          const zodIssue = issue as ZodIssue;
          return {
            message: `${zodIssue.path.join(".")} is ${zodIssue.message}`,
          };
        });
        res
          .status(StatusCodes.BAD_REQUEST)
          .json({ error: "Invalid data", details: errorMessages });
      } else {
        res
          .status(StatusCodes.INTERNAL_SERVER_ERROR)
          .json({ error: "Internal Server Error" });
      }
    }
  };
}
