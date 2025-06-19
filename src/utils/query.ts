export function partialUpdateForQuery(
  fields: string[],
  datasToUpdate: Record<string, string | number | Date | boolean | null>
): (string | number | Date | boolean | null)[] {
  const valuesToUpdate = fields.map((fieldToUpdate) => {
    if (fieldToUpdate in datasToUpdate) {
      return datasToUpdate[fieldToUpdate];
    }
    return null;
  });
  return valuesToUpdate;
}
