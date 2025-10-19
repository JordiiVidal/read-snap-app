import 'package:read_snap/features/session/dominio/domain.dart';

class GetSessionsByBookUseCase {
  final SessionRepository _repository;

  GetSessionsByBookUseCase(this._repository);

  Future<List<SessionEntity>> call(String bookId) async {
    return _repository.getSessionsByBook(bookId);
  }
}
