import 'package:read_snap/features/category/domain/domain.dart';

class DeleteCategoryUseCase {
  final CategoryRepository _repository;

  DeleteCategoryUseCase(this._repository);

  Future<void> call(String id) async {
    await _repository.deleteCategory(id);
  }
}
