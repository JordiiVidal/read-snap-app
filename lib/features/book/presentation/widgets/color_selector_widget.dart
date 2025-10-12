import 'package:flutter/material.dart';

class ColorSelectorWidget extends StatelessWidget {
  final List<String> availableColors = const [
    '#673AB7',
    '#9C27B0',
    '#E91E63',
    '#FFC107',
    '#4CAF50',
    '#2196F3',
    '#F44336',
    '#00BCD4',
  ];
  final String selectedColor;
  final ValueChanged<String> onColorSelected;

  const ColorSelectorWidget({
    required this.selectedColor,
    required this.onColorSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cover Color',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: availableColors.map((hexColor) {
            final colorValue = Color(
              int.parse(hexColor.replaceFirst('#', '0xFF')),
            );
            final isSelected = hexColor == selectedColor;

            return GestureDetector(
              onTap: () => onColorSelected(hexColor),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: colorValue,
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(color: Colors.black, width: 3)
                      : null,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
