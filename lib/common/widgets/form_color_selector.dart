import 'package:flutter/material.dart';

class FormColorSelector extends StatelessWidget {
  final List<String> availableColors = const [
    '#673AB7', // Morado principal
    '#E91E63', // Rosa/Rojo
    '#4CAF50', // Verde
    '#2196F3', // Azul
    '#FFC107', // Ámbar
    '#00BCD4', // Cyan
  ];

  final String selectedColor;
  final ValueChanged<String> onColorSelected;

  const FormColorSelector({
    required this.selectedColor,
    required this.onColorSelected,
    super.key,
  });

  Color _hexToColor(String hexCode) {
    return Color(int.parse(hexCode.replaceFirst('#', '0xFF')));
  }

  @override
  Widget build(BuildContext context) {
    const double size = 38.0;
    const double borderRadius = 8.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cover Color',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: availableColors.map((hexColor) {
            final colorValue = _hexToColor(hexColor);
            final isSelected = hexColor == selectedColor;

            return GestureDetector(
              onTap: () => onColorSelected(hexColor),
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: colorValue,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: isSelected
                      ? Border.all(
                          color: colorValue.computeLuminance() > 0.5
                              ? Colors.black54
                              : Colors.white,
                          width: 3.5,
                        )
                      : Border.all(
                          color: Colors.black.withValues(alpha: 0.1),
                          width: 0.5,
                        ),
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        size: 22,
                        color: colorValue.computeLuminance() > 0.5
                            ? Colors.black87
                            : Colors.white,
                      )
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
