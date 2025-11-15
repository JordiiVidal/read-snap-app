import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/category/domain/domain.dart';
import 'package:read_snap/features/category/presentation/notifiers/category_list_notifier.dart';
import 'package:read_snap/features/category/presentation/widgets/modals/category_create_modal.dart';
import 'package:read_snap/shared/widgets/selectors/selectors.dart';

class CategorySelector extends ConsumerWidget {
  final List<String>? selectedCategories;
  final ValueChanged<List<String>> onCategoriesChanged;
  final bool allowCustom;
  final String? label;

  const CategorySelector({
    super.key,
    required this.selectedCategories,
    required this.onCategoriesChanged,
    this.allowCustom = true,
    this.label = 'Categories',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncDataSelector<List<CategoryEntity>>(
      provider: categoryListNotifierProvider,
      loadingWidget: const Center(
        child: SizedBox(height: 10, child: CircularProgressIndicator()),
      ),
      builder: (context, categories) {
        return MultiSelector(
          label: label ?? 'Categories',
          items: categories.map((cat) => cat.name).toList(),
          selectedItems: selectedCategories ?? [],
          onSelectionChanged: onCategoriesChanged,
          allowCustom: allowCustom,
          onAddCustom: allowCustom
              ? () => _showAddCustomCategoryDialog(context, ref, categories)
              : null,
        );
      },
    );
  }
}

void _showAddCustomCategoryDialog(
  BuildContext context,
  WidgetRef ref,
  List<CategoryEntity> categories,
) async {
  try {
    final result = await CategoryCreateModal.show(context, categories);

    if (!context.mounted) return;

    if (result != null) {
      await ref
          .read(categoryListNotifierProvider.notifier)
          .addCustomCategory(result);
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
