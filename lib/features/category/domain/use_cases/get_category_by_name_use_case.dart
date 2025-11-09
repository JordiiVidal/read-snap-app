import 'package:read_snap/features/category/domain/domain.dart';

class GetCategoryByNameUseCase {
  final CategoryRepository _repository;

  GetCategoryByNameUseCase(this._repository);

  Future<CategoryEntity?> call(String name) async {
    return await _repository.getCategoryByName(name);
  }
}
