import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final CrossAxisAlignment alignment;

  const SectionHeader({
    required this.title,
    required this.subtitle,
    this.alignment = CrossAxisAlignment.start,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
