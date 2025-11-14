import 'package:flutter/material.dart';

class BookStepHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;
  final CrossAxisAlignment alignment;

  const BookStepHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.alignment = CrossAxisAlignment.start,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        spacing: 18,
        crossAxisAlignment: alignment,
        children: [
          if (icon != null)
            Icon(icon, size: 64, color: Theme.of(context).colorScheme.primary),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            textAlign: alignment == CrossAxisAlignment.center
                ? TextAlign.center
                : TextAlign.start,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
