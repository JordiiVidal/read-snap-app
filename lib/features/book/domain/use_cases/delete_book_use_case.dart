import 'package:read_snap/features/book/domain/repositories/book_repository.dart';

class DeleteBookUseCase {
  final BookRepository _repository;

  DeleteBookUseCase(this._repository);

  Future<void> call(String id) async {
    await _repository.deleteBook(id);
  }
}
