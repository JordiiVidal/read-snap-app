import 'package:read_snap/features/category/domain/domain.dart';

class GetCategoriesUseCase {
  final CategoryRepository _repository;

  GetCategoriesUseCase(this._repository);

  Future<List<CategoryEntity>> call() async {
    return await _repository.getCategories();
  }
}
