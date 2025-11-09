import 'package:read_snap/features/category/domain/domain.dart';

abstract class CategoryRepository {
  Future<List<CategoryEntity>> getCategories();

  Future<CategoryEntity?> getCategoryByName(String name);

  Future<void> addCategory(CategoryEntity category);

  Future<void> deleteCategory(String id);
}
