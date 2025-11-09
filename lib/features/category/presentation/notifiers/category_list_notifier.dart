import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/core/di/injection_container.dart';
import 'package:read_snap/features/category/data/data.dart';
import 'package:read_snap/features/category/domain/domain.dart';
import 'package:uuid/uuid.dart';

final categoryListNotifierProvider =
    AsyncNotifierProvider<CategoryListNotifier, List<CategoryEntity>>(
      CategoryListNotifier.new,
    );

class CategoryListNotifier extends AsyncNotifier<List<CategoryEntity>> {
  late final GetCategoriesUseCase _getCategoriesUseCase;
  late final CreateCategoryUseCase _createCategoryUseCase;
  late final CategoryRepository _categoryRepository;

  @override
  Future<List<CategoryEntity>> build() async {
    _getCategoriesUseCase = ref.read(getCategoriesUseCaseProvider);
    _createCategoryUseCase = ref.read(createCategoryUseCaseProvider);
    _categoryRepository = ref.read(categoryRepositoryProvider);

    await CategorySeed.seedCategories(_categoryRepository);

    return await _getCategoriesUseCase.call();
  }

  List<String> get allCategoryNames {
    return state.valueOrNull?.map((cat) => cat.name).toList() ?? [];
  }

  Future<void> addCustomCategory(String name, {String? iconEmoji}) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final existing = await _categoryRepository.getCategoryByName(name);
      if (existing != null) {
        throw Exception('Category "$name" already exists');
      }

      final newCategory = CategoryEntity(
        id: const Uuid().v4(),
        name: name,
        selectedByUser: false,
        iconEmoji: iconEmoji,
        aliases: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _createCategoryUseCase.call(newCategory);
      return await _getCategoriesUseCase.call();
    });
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _getCategoriesUseCase.call());
  }
}
