import 'package:read_snap/features/language/domain/domain.dart';

class GetLanguagesUseCase {
  final LanguageRepository _repository;

  GetLanguagesUseCase(this._repository);

  Future<List<LanguageEntity>> call() async {
    return await _repository.getLanguages();
  }
}

