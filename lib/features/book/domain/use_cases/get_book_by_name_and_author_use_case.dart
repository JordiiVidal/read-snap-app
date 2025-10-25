import 'package:read_snap/features/book/domain/domain.dart';

class GetBookByNameAndAuthorUseCase {
  final BookRepository _repository;

  GetBookByNameAndAuthorUseCase(this._repository);

  Future<BookEntity?> call(String name, String author) async {
    return await _repository.getBookByNameAndAuthor(name, author);
  }
}
