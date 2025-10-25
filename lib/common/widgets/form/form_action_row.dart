import 'package:flutter/material.dart';

typedef QuickActions = Map<String, VoidCallback>;

class FormActionRow extends StatelessWidget {
  final Widget inputField;
  final QuickActions quickActions;
  final double horizontalSpacing;

  const FormActionRow({
    required this.inputField,
    required this.quickActions,
    this.horizontalSpacing = 8.0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> actionWidgets = [];

    quickActions.forEach((label, onPressed) {
      actionWidgets.add(
        ActionChip(
          label: Text(label),
          onPressed: onPressed,
          visualDensity: VisualDensity.compact,
        ),
      );
    });

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: horizontalSpacing,
      children: [
        Expanded(child: inputField),
        ...actionWidgets,
      ],
    );
  }
}
