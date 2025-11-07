import 'package:read_snap/features/book/domain/domain.dart';

class GetBooksUseCase {
  final BookRepository _repository;

  GetBooksUseCase(this._repository);

  Future<List<BookEntity>> call() async {
    // Business Logic
    final books = await _repository.getBooks();
    final sortedBooks = List<BookEntity>.from(books);
    sortedBooks.sort((a, b) {
      final priorityA = _getStatusPriority(a.status);
      final priorityB = _getStatusPriority(b.status);

      final statusComparison = priorityA.compareTo(priorityB);

      if (statusComparison != 0) {
        return statusComparison;
      }

      return b.updatedAt.compareTo(a.updatedAt);
    });

    return sortedBooks;
  }

  int _getStatusPriority(BookStatus status) {
    switch (status) {
      case BookStatus.reading:
        return 1;
      case BookStatus.toRead:
        return 2;
      case BookStatus.completed:
        return 3;
    }
  }
}
