import 'package:read_snap/features/book/domain/domain.dart';
import 'package:uuid/uuid.dart';

class CreateBookUseCase {
  final BookRepository _repository;
  final BookValidatorService _validator;

  CreateBookUseCase(this._repository, this._validator);

  Future<BookEntity> call(BookEntity book) async {
    // 1.Business logic
    BookEntity bookToSave = _applyBusinessLogic(book);

    // 2.Validations
    _validator.validateCreationFields(bookToSave);
    final existingBook = await _repository.getBookByNameAndAuthor(
      book.name,
      book.author,
    );
    if (existingBook != null) {
      throw ArgumentError(
        'A book with the name "${book.name}" and author "${book.author}" already exists.',
      );
    }

    // 3.Persistence
    final now = DateTime.now();
    bookToSave = bookToSave.copyWith(
      id: const Uuid().v4(),
      createdAt: now,
      updatedAt: now,
    );

    await _repository.addBook(bookToSave);

    return bookToSave;
  }

  BookEntity _applyBusinessLogic(BookEntity book) {
    switch (book.status) {
      case BookStatus.toRead:
        return book.copyWith(currentPage: 0);
      case BookStatus.completed:
        return book.copyWith(currentPage: book.totalPages);
      case BookStatus.reading:
        return book.copyWith(currentPage: 0);
    }
  }
}
