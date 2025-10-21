import 'package:read_snap/features/book/domain/domain.dart';

class GetBookByNameUseCase {
  final BookRepository _repository;

  GetBookByNameUseCase(this._repository);

  Future<BookEntity?> call(String name) async {
    return await _repository.getBookByName(name);
  }
}
