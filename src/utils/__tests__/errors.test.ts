import { describe, it, expect } from "vitest";

import { isErrorWithCode, isErrorWithMessage } from "../error";

describe("isErrorWithMessage", () => {
  it("returns true for matching error message", () => {
    const err = new Error("USER_NOT_FOUND");
    expect(isErrorWithMessage(err, "USER_NOT_FOUND")).toBe(true);
  });

  it("returns false for non-matching message", () => {
    const err = new Error("SOMETHING_ELSE");
    expect(isErrorWithMessage(err, "USER_NOT_FOUND")).toBe(false);
  });

  it("returns false for non-object", () => {
    expect(isErrorWithMessage("not-an-error", "USER_NOT_FOUND")).toBe(false);
  });
});

describe("isErrorWithCode", () => {
  it("returns true for matching error code", () => {
    const err = { code: "23505" };
    expect(isErrorWithCode(err, "23505")).toBe(true);
  });

  it("returns false for non-matching code", () => {
    const err = { code: "12345" };
    expect(isErrorWithCode(err, "23505")).toBe(false);
  });

  it("returns false for non-object", () => {
    expect(isErrorWithCode("not-an-error", "23505")).toBe(false);
  });
});

describe("isErrorWithMessage and isErrorWithCode", () => {
  it("returns false for null or undefined", () => {
    expect(isErrorWithMessage(null, "USER_NOT_FOUND")).toBe(false);
    expect(isErrorWithCode(undefined, "23505")).toBe(false);
  });

  it("returns false for empty objects", () => {
    expect(isErrorWithMessage({}, "USER_NOT_FOUND")).toBe(false);
    expect(isErrorWithCode({}, "23505")).toBe(false);
  });
});
