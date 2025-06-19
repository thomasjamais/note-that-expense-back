export function isErrorWithMessage(
  error: unknown,
  message: string
): error is { message: string } {
  return (
    typeof error === "object" &&
    error !== null &&
    "message" in error &&
    error.message === message
  );
}

export function isErrorWithCode(
  error: unknown,
  code: string
): error is { code: string } {
  return (
    typeof error === "object" &&
    error !== null &&
    "code" in error &&
    error.code === code
  );
}
