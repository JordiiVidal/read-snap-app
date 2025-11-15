import 'package:read_snap/features/category/domain/domain.dart';

class CategoryValidatorService {
  static String? validateCategoryName(
    String name,
    List<CategoryEntity> existingCategories,
  ) {
    final trimmedName = name.trim();

    if (trimmedName.isEmpty) {
      return 'Category name cannot be empty';
    }

    if (trimmedName.length < 2) {
      return 'Category name must be at least 2 characters';
    }

    if (trimmedName.length > 50) {
      return 'Category name cannot exceed 50 characters';
    }

    final normalizedName = trimmedName.toLowerCase();
    final isDuplicate = existingCategories.any(
      (category) => category.name.toLowerCase() == normalizedName,
    );

    if (isDuplicate) {
      return 'Category "$trimmedName" already exists';
    }

    return null; // Valid
  }
}
