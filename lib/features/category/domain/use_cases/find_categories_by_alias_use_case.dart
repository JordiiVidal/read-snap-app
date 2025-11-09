import 'package:read_snap/features/category/domain/domain.dart';

class FindCategoriesByAliasUseCase {
  final CategoryRepository _repository;

  FindCategoriesByAliasUseCase(this._repository);

  Future<List<String>> call(List<String> externalCategories) async {
    final allCategories = await _repository.getCategories();
    final matched = <String>{};

    for (final externalCategory in externalCategories) {
      final matchedCategory = allCategories.firstWhere(
        (cat) => cat.matches(externalCategory),
        orElse: () => allCategories.first,
      );

      matched.add(matchedCategory.name);
    }

    return matched.toList();
  }

  Future<List<String>> matchToIds(List<String> externalCategories) async {
    final allCategories = await _repository.getCategories();
    final matched = <String>{};

    for (final externalCategory in externalCategories) {
      final matchedCategory = allCategories.firstWhere(
        (cat) => cat.matches(externalCategory),
        orElse: () => allCategories.first,
      );

      matched.add(matchedCategory.id);
    }

    return matched.toList();
  }
}
