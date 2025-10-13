import 'package:read_snap/features/book/domain/domain.dart';

class GetBookByIdUseCase {
  final BookRepository _bookRepository;

  GetBookByIdUseCase(this._bookRepository);

  Future<BookEntity> call(String id) async {
    return await _bookRepository.getBookById(id);
  }
}
