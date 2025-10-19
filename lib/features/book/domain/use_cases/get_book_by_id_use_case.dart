import 'package:read_snap/features/book/domain/domain.dart';

class GetBookByIdUseCase {
  final BookRepository _repository;

  GetBookByIdUseCase(this._repository);

  Future<BookEntity> call(String id) async {
    return await _repository.getBookById(id);
  }
}
