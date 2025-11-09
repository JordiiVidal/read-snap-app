import 'package:read_snap/features/language/domain/domain.dart';

abstract class LanguageRepository {
  Future<List<LanguageEntity>> getLanguages();

  Future<void> addLanguage(LanguageEntity language);
}
