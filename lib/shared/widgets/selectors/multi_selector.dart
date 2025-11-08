import 'package:flutter/material.dart';
import 'package:read_snap/shared/widgets/forms/forms.dart';

class MultiSelector extends StatelessWidget {
  final String label;
  final List<String> items;
  final List<String> selectedItems;
  final ValueChanged<List<String>> onSelectionChanged;
  final VoidCallback? onAddCustom;
  final bool allowCustom;

  const MultiSelector({
    required this.label,
    required this.items,
    required this.selectedItems,
    required this.onSelectionChanged,
    this.onAddCustom,
    this.allowCustom = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LabelFormField(label, marginBottom: 0),
            if (allowCustom)
              TextButton.icon(
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add Custom'),
                onPressed: onAddCustom,
              ),
          ],
        ),
        Wrap(
          spacing: 8,
          runSpacing: 0,
          children: items.map((item) {
            final isSelected = selectedItems.contains(item);
            return FilterChip(
              label: Text(
                item,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                final newSelection = List<String>.from(selectedItems);
                if (selected) {
                  newSelection.add(item);
                } else {
                  newSelection.remove(item);
                }
                onSelectionChanged(newSelection);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
