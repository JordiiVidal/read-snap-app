import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:read_snap/features/category/presentation/notifiers/category_list_notifier.dart';
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

  void _showAddCustomCategoryDialog(BuildContext context, WidgetRef ref) {
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Custom Category'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            labelText: 'Category name',
            hintText: 'Enter category name',
          ),
          textCapitalization: TextCapitalization.words,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final name = textController.text.trim();
              if (name.isEmpty) return;

              try {
                await ref
                    .read(categoryListNotifierProvider.notifier)
                    .addCustomCategory(name);

                final newCategories = List<String>.from(
                  selectedCategories ?? [],
                );
                if (!newCategories.contains(name)) {
                  newCategories.add(name);
                  onCategoriesChanged(newCategories);
                }

                if (context.mounted) {
                  Navigator.pop(context);
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoryListNotifierProvider);

    return categoriesAsync.when(
      data: (categories) {
        final categoryNames = categories.map((cat) => cat.name).toList();

        return MultiSelector(
          label: 'Categories',
          items: categoryNames,
          selectedItems: selectedCategories ?? [],
          onSelectionChanged: onCategoriesChanged,
          allowCustom: allowCustom,
          onAddCustom: allowCustom
              ? () => _showAddCustomCategoryDialog(context, ref)
              : null,
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Text('Error loading categories: $error'),
    );
  }
}
