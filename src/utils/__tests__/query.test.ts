import { describe, it, expect } from "vitest";

import { partialUpdateForQuery } from "../query";

describe("partialUpdateForQuery", () => {
  it("returns values for fields that exist in the update data", () => {
    const fields = ["name", "age", "email"];
    const dataToUpdate = { name: "John", age: 30 };
    const result = partialUpdateForQuery(fields, dataToUpdate);
    expect(result).toEqual(["John", 30, null]);
  });

  it("returns null for fields that do not exist in the update data", () => {
    const fields = ["name", "age", "email"];
    const dataToUpdate = { name: "Jane" };
    const result = partialUpdateForQuery(fields, dataToUpdate);
    expect(result).toEqual(["Jane", null, null]);
  });
  it("returns all nulls if no fields match", () => {
    const fields = ["name", "age", "email"];
    const dataToUpdate = { address: "123 Main St" };
    const result = partialUpdateForQuery(fields, dataToUpdate);
    expect(result).toEqual([null, null, null]);
  });

  it("handles empty fields array", () => {
    const fields: string[] = [];
    const dataToUpdate = { name: "John" };
    const result = partialUpdateForQuery(fields, dataToUpdate);
    expect(result).toEqual([]);
  });

  it("handles empty update data", () => {
    const fields = ["name", "age"];
    const dataToUpdate: Record<string, string | number | Date | null> = {};
    const result = partialUpdateForQuery(fields, dataToUpdate);
    expect(result).toEqual([null, null]);
  });
});
