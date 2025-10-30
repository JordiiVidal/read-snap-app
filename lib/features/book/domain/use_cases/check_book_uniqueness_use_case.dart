import 'package:read_snap/features/book/domain/domain.dart';

class CheckBookUniquenessUseCase {
  final BookRepository _repository;

  CheckBookUniquenessUseCase(this._repository);

  Future<void> call(String name, String author) async {
    final existingBook = await _repository.getBookByNameAndAuthor(name, author);

    if (existingBook != null) {
      throw BookAlreadyExistsException(name, author);
    }
  }
}
