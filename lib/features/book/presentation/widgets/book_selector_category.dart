import 'package:flutter/material.dart';
import 'package:read_snap/shared/widgets/chips/chips.dart';

class BookSelectorCategory extends StatelessWidget {
  final List<String>? selectedCategories;
  final ValueChanged<List<String>> onCategoriesChanged;

  static const List<String> commonBookCategories = [
    'Fiction',
    'Non-Fiction',
    'Mystery',
    'Romance',
    'Science Fiction',
    'Fantasy',
    'Biography',
    'History',
    'Self-Help',
    'Business',
  ];

  const BookSelectorCategory({
    super.key,
    required this.selectedCategories,
    required this.onCategoriesChanged,
  });

  void _showAddCustomCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Custom Category'),
        content: TextField(
          decoration: const InputDecoration(
            labelText: 'Category name',
            hintText: 'Enter category name',
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              final newCategories = List<String>.from(selectedCategories ?? []);
              if (!newCategories.contains(value)) {
                newCategories.add(value);
                onCategoriesChanged(newCategories);
              }
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Combinar categorías comunes con las seleccionadas personalizadas
    final allCategories = <String>{
      ...commonBookCategories,
      ...(selectedCategories ?? []),
    }.toList();

    return ChipMultiSelectGroup(
      label: 'Categories',
      items: allCategories,
      selectedItems: selectedCategories ?? [],
      onSelectionChanged: onCategoriesChanged,
      allowCustom: true,
      onAddCustom: () => _showAddCustomCategoryDialog(context),
    );
  }
}
