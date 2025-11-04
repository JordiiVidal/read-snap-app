import 'package:read_snap/features/book/domain/domain.dart';
import 'package:uuid/uuid.dart';

class CreateBookUseCase {
  final BookRepository _repository;
  final BookValidatorService _validator;
  final CheckReadingLimitUseCase _checkLimitUseCase;
  final CheckBookUniquenessUseCase _checkUniquenessUseCase;

  CreateBookUseCase(
    this._repository,
    this._validator,
    this._checkLimitUseCase,
    this._checkUniquenessUseCase,
  );

  Future<BookEntity> call(BookEntity book) async {
    // 1.Business logic
    BookEntity bookToSave = _applyBusinessLogic(book);

    // 2.Validations
    if (book.status == BookStatus.reading) {
      await _checkLimitUseCase.call();
    }
    _validator.validateCreationFields(bookToSave);
    await _checkUniquenessUseCase.call(book.title, book.author);

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
