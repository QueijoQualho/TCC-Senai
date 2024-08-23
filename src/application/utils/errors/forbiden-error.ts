export class ForbiddenError extends Error {
  public details: { field: string; message: string }[] = [];

  constructor(message: string, details?: { field: string; message: string }[]) {
    super(message);
    this.details = details || [];
  }
}