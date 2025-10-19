import 'package:read_snap/features/book/domain/entities/book_entity.dart';
import 'package:read_snap/features/book/domain/repositories/book_repository.dart';

class GetBooksUseCase {
  final BookRepository _repository;

  GetBooksUseCase(this._repository);

  Future<List<BookEntity>> call() async {
    final books = await _repository.getBooks();
    books.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return books;
  }
}
