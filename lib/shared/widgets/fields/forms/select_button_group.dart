import 'package:flutter/material.dart';
import 'package:read_snap/shared/widgets/fields/fields.dart';

class SelectButtonGroup extends StatelessWidget {
  final Map<String, String> options;
  final List<String> selectedValues;
  final bool isMultiSelect;
  final ValueChanged<List<String>> onSelectionChanged;
  final String label;
  final bool showCheckmark;
  final bool required;

  const SelectButtonGroup({
    required this.options,
    required this.selectedValues,
    required this.onSelectionChanged,
    required this.label,
    this.isMultiSelect = false,
    this.showCheckmark = true,
    this.required = true,
    super.key,
  });

  void _handleSelection(String value) {
    List<String> newSelection = List.from(selectedValues);
    final isSelected = selectedValues.contains(value);

    if (isMultiSelect) {
      if (isSelected) {
        newSelection.remove(value);
      } else {
        newSelection.add(value);
      }
    } else {
      if (isSelected && !required) {
        newSelection = [];
      } else {
        newSelection = [value];
      }
    }

    onSelectionChanged(newSelection);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelFormField(label),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: options.entries.map((entry) {
            final value = entry.key;
            final label = entry.value;
            final isSelected = selectedValues.contains(value);

            return FilterChip(
              selected: isSelected,
              showCheckmark: showCheckmark,
              label: Text(label),
              onSelected: (selected) => _handleSelection(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}
