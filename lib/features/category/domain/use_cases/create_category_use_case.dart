import 'package:read_snap/features/category/domain/domain.dart';

class CreateCategoryUseCase {
  final CategoryRepository _repository;

  CreateCategoryUseCase(this._repository);

  Future<void> call(CategoryEntity category) async {
    await _repository.addCategory(category);
  }
}
