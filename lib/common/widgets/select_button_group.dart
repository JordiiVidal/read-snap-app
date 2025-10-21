import 'package:flutter/material.dart';

class SelectButtonGroup extends StatelessWidget {
  final Map<String, String> options;
  final List<String> selectedValues;
  final bool isMultiSelect;
  final ValueChanged<List<String>> onSelectionChanged;
  final double height;

  const SelectButtonGroup({
    required this.options,
    required this.selectedValues,
    required this.onSelectionChanged,
    this.isMultiSelect = false,
    this.height = 48.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonKeys = options.keys.toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final buttonWidth = constraints.maxWidth / options.length;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: buttonKeys.map((value) {
            final isSelected = selectedValues.contains(value);
            final label = options[value]!;

            return SizedBox(
              width: buttonWidth,
              height: height,
              child: Material(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8.0),
                elevation: isSelected ? 4 : 0,
                shadowColor: theme.colorScheme.primary.withValues(alpha: 0.5),

                child: InkWell(
                  onTap: () {
                    List<String> newSelection;

                    if (isMultiSelect) {
                      newSelection = List.from(selectedValues);
                      if (isSelected) {
                        newSelection.remove(value);
                      } else {
                        newSelection.add(value);
                      }
                    } else {
                      newSelection = [value];
                    }

                    onSelectionChanged(newSelection);
                  },
                  borderRadius: BorderRadius.circular(8.0),
                  child: Center(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected
                            ? theme.colorScheme.onPrimary
                            : theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
