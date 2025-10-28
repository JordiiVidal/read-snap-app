import 'package:read_snap/features/book/domain/domain.dart';

class UpdateBookUseCase {
  final BookRepository _repository;
  final BookValidatorService _validator;

  UpdateBookUseCase(this._repository, this._validator);

  Future<void> call(BookEntity book) async {
    // 2.Validations
    _validator.validateUpdateFields(book);
    if (book.id.isEmpty) {
      throw ArgumentError('Book ID is required for update.');
    }

    // 3.Persistence
    book = book.copyWith(updatedAt: DateTime.now());
    await _repository.updateBook(book);
  }
}
