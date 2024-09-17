export interface PaginationParams {
  page: number;
  limit: number;
}

export interface Pageable<T> {
  data: T[],
  totalItems: number,
  totalPages: number,
  currentPage: number,
}