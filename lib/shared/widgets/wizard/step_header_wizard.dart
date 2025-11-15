import 'package:flutter/material.dart';

enum StepHeaderAlignment { start, center }

class StepHeaderWizard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;
  final String? iconSemanticLabel;
  final StepHeaderAlignment alignment;

  const StepHeaderWizard({
    super.key,
    required this.title,
    required this.subtitle,
    this.alignment = StepHeaderAlignment.start,
    this.icon,
    this.iconSemanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final crossAxisAlignment = _getCrossAxisAlignment();
    final textAlign = _getTextAlign();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        spacing: 12,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          if (icon != null)
            Semantics(
              label: iconSemanticLabel ?? 'Step icon',
              child: Icon(icon, size: 64, color: theme.colorScheme.primary),
            ),
          Text(
            title,
            style: theme.textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            textAlign: textAlign,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }

  CrossAxisAlignment _getCrossAxisAlignment() {
    return alignment == StepHeaderAlignment.center
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
  }

  TextAlign _getTextAlign() {
    return alignment == StepHeaderAlignment.center
        ? TextAlign.center
        : TextAlign.start;
  }
}
