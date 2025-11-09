import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/core/di/injection_container.dart';
import 'package:read_snap/features/language/data/data.dart';
import 'package:read_snap/features/language/domain/domain.dart';

final languageListNotifierProvider =
    AsyncNotifierProvider<LanguageListNotifier, List<LanguageEntity>>(
      LanguageListNotifier.new,
    );

class LanguageListNotifier extends AsyncNotifier<List<LanguageEntity>> {
  late final GetLanguagesUseCase _getLanguagesUseCase;
  late final LanguageRepository _languageRepository;

  @override
  Future<List<LanguageEntity>> build() async {
    _getLanguagesUseCase = ref.read(getLanguagesUseCaseProvider);
    _languageRepository = ref.read(languageRepositoryProvider);

    await LanguageSeed.seedLanguages(_languageRepository);

    return await _getLanguagesUseCase.call();
  }

  List<String> get allLanguageCodes {
    return state.valueOrNull?.map((lang) => lang.code).toList() ?? [];
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _getLanguagesUseCase.call());
  }
}
