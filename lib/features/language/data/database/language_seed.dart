import 'package:read_snap/features/language/domain/domain.dart';
import 'package:uuid/uuid.dart';

class LanguageSeed {
  static const _uuid = Uuid();

  static final List<LanguageEntity> defaultLanguages = [
    // Idiomas principales
    LanguageEntity(
      id: _uuid.v4(),
      code: 'en',
      name: 'English',
      nativeName: 'English',
      flag: '🇺🇸',
      selectedByUser: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    LanguageEntity(
      id: _uuid.v4(),
      code: 'es',
      name: 'Spanish',
      nativeName: 'Español',
      flag: '🇪🇸',
      selectedByUser: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),

    // Idiomas península ibérica
    LanguageEntity(
      id: _uuid.v4(),
      code: 'ca',
      name: 'Catalan',
      nativeName: 'Català',
      flag: '🇪🇸',
      selectedByUser: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    LanguageEntity(
      id: _uuid.v4(),
      code: 'eu',
      name: 'Basque',
      nativeName: 'Euskara',
      flag: '🇪🇸',
      selectedByUser: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    LanguageEntity(
      id: _uuid.v4(),
      code: 'gl',
      name: 'Galician',
      nativeName: 'Galego',
      flag: '🇪🇸',
      selectedByUser: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),

    // Idiomas europeos
    LanguageEntity(
      id: _uuid.v4(),
      code: 'fr',
      name: 'French',
      nativeName: 'Français',
      flag: '🇫🇷',
      selectedByUser: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    LanguageEntity(
      id: _uuid.v4(),
      code: 'de',
      name: 'German',
      nativeName: 'Deutsch',
      flag: '🇩🇪',
      selectedByUser: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    LanguageEntity(
      id: _uuid.v4(),
      code: 'it',
      name: 'Italian',
      nativeName: 'Italiano',
      flag: '🇮🇹',
      selectedByUser: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    LanguageEntity(
      id: _uuid.v4(),
      code: 'pt',
      name: 'Portuguese',
      nativeName: 'Português',
      flag: '🇵🇹',
      selectedByUser: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),

    // Idiomas nórdicos
    LanguageEntity(
      id: _uuid.v4(),
      code: 'nl',
      name: 'Dutch',
      nativeName: 'Nederlands',
      flag: '🇳🇱',
      selectedByUser: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    LanguageEntity(
      id: _uuid.v4(),
      code: 'da',
      name: 'Danish',
      nativeName: 'Dansk',
      flag: '🇩🇰',
      selectedByUser: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    LanguageEntity(
      id: _uuid.v4(),
      code: 'fi',
      name: 'Finnish',
      nativeName: 'Suomi',
      flag: '🇫🇮',
      selectedByUser: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    LanguageEntity(
      id: _uuid.v4(),
      code: 'sv',
      name: 'Swedish',
      nativeName: 'Svenska',
      flag: '🇸🇪',
      selectedByUser: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    LanguageEntity(
      id: _uuid.v4(),
      code: 'no',
      name: 'Norwegian',
      nativeName: 'Norsk',
      flag: '🇳🇴',
      selectedByUser: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),

    // Otros idiomas importantes
    LanguageEntity(
      id: _uuid.v4(),
      code: 'ru',
      name: 'Russian',
      nativeName: 'Русский',
      flag: '🇷🇺',
      selectedByUser: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    LanguageEntity(
      id: _uuid.v4(),
      code: 'zh',
      name: 'Chinese',
      nativeName: '中文',
      flag: '🇨🇳',
      selectedByUser: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    LanguageEntity(
      id: _uuid.v4(),
      code: 'ja',
      name: 'Japanese',
      nativeName: '日本語',
      flag: '🇯🇵',
      selectedByUser: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
    LanguageEntity(
      id: _uuid.v4(),
      code: 'ko',
      name: 'Korean',
      nativeName: '한국어',
      flag: '🇰🇷',
      selectedByUser: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ),
  ];

  static Future<void> seedLanguages(LanguageRepository repository) async {
    final existingLanguages = await repository.getLanguages();

    if (existingLanguages.isEmpty) {
      for (final language in defaultLanguages) {
        await repository.addLanguage(language);
      }
    }
  }
}
