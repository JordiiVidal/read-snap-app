import 'package:read_snap/features/book/domain/repositories/book_repository.dart';

class DeleteBookUseCase {
  final BookRepository _bookRepository;

  DeleteBookUseCase(this._bookRepository);

  Future<void> call(String id) async {
    await _bookRepository.deleteBook(id);
  }
}
